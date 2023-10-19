/* sim_video.c: Bitmap video output

Copyright (c) 2011-2013, Matt Burke
Copyright (c) 2018, Ian Schofield

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the author shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the author.

08-Nov-2013  MB      Added globals for current mouse status
11-Jun-2013  MB      First version
01-Jan-2018  ISS     Major changes to the structure of the video system. Functionality unchanged.
This module is now used by all simulators requiring display services.
SDL (Simple Direct Media Layer) version 2.x is now the default as this
is supported by many operating systems.

*/
#include <stdio.h>
#include <stdlib.h>
#include "sim_defs.h"
#include "sim_video.h"
#include "scp.h"
#if defined(HAVE_LIBPNG)
#include <png.h>
#endif
// Global video system flgs/variables

uint32 vid_mono_palette[2];                         /* Monochrome Color Map */
double *colmap;										/* Parameter used by Refresh and vid_setpixel in sim_video.c */
int32 pxval;										/* Also referenced in display.c */
int nostore=0;							            /* Enables storage display. Always defined. */
int alias;                                          /* Aliasing active flag. Required to set correct pixel intensity */
int vt_status;                                      /* VT11 run/stop flag */

char vid_release_key[64] = "Ctrl-Right-Shift";
char bfr[128];
int dflag;

// Only include SDL code if specified. See end of this module for stubbed code.

#if defined(USE_SIM_VIDEO) && defined(HAVE_LIBSDL)

#define CUR_SIZE		5
#define EVENT_EXIT      8                              /* program exit */
#define EVENT_BEEP      10                              /* audio beep */
#define OFSET_X_VR17     340
#define OFSET_Y_VR17     290
#define OFSET_X_VR14     240
#define OFSET_Y_VR14     186
#define LED_X 124-12
#define LED_Y 849-8
#define LED_STEP 37.86
#define RUN_X 915-12
#define BSet1_X         745                       /* 5 paddle block */
#define BSet1_Y         886
#define BSet1_W         38
#define BSet1_H         50
#define Dep_X           973
#define Dep_Y           919-40
#define BSet2_X         101
#define BSet2_Y         919-37
#define BPTN            0161616                   /* Paddle color pattern */

extern void write_console_input(unsigned char *msg, int len);
extern void run_cmd_message (const char *unechoed_cmdline, t_stat r);
extern int SR,R[8];
extern int DR;                     // Display register
static int iwd,iht,told,tnew,tvl,hpc;
static const int MAXFONTPATH = 500;
static int init_x = 0;		// Initial window position and size
static int init_y = 0;
static unsigned int init_w = 0;
static unsigned int init_h = 0;
static int32 lcurr_x = 0;
static int32 lcurr_y = 0;
static char vid_title[128];
static int screen_num,xloc,yloc;
static uint32 lstst=0,lstcd=0;
static unsigned char *pixels;
static int pitch,surlen;
SIM_MOUSE_EVENT *xmev = 0,*xhev = 0;
SIM_KEY_EVENT *xkev = 0;
static enum vid_stat{STOPPED,WINDOW_OK,RUNNING,CLOSING,CLOSED}vid_init;
static int init_flags;
unsigned int pixelval;					// 24 bit RGB value
struct display *dp;
static int Refresh(void *info);
static int MLoop();
static void vid_close_window(void);
void vid_beep (void);
static void vid_beep_setup (int duration_ms, int tone_frequency);
static void vid_beep_cleanup (void);
static void vid_beep_event (void);
static int mouse_flag=0;                          // Use to determine mouse button transitions
static SDL_Window *window = 0;                    // Declare some pointers
static SDL_Surface *surface = 0;
static SDL_Cursor *cursor = 0;
static SDL_Surface *img = 0;
static SDL_Surface *img32 = 0;
static SDL_Surface *img_led,*img_led_src,*img_led_off;
static SDL_Surface *bset1_down,*bset1_up;
static SDL_Surface *dep_down,*dep_up;
static SDL_Surface *bset2_down,*bset2_up,*bset3_down,*bset3_up;

static SDL_Rect led_dst,pdl_dst;
int32 vid_flags;                                                 /* Open Flags */
static int bgnd_x=0,bgnd_y=0,ofset_x=0,ofset_y;                  /* Image info */
int led_bright[16];                                              /* Led brighness codes from pdp11_cpu.c */
static int key_value;                                            /* Current key */
static uint16 key_rsl[32];
static uint16 bset1_state;
static uint16 bset2_state;

t_stat vid_set_release_key (FILE* st, UNIT* uptr, int32 val, CONST void* desc)
{
    return SCPE_NOFNC;
}

t_stat vid_show_release_key (FILE* st, UNIT* uptr, int32 val, CONST void* desc)
{
    if (vid_flags & SIM_VID_INPUTCAPTURED)
        fprintf (st, "ReleaseKey=%s", vid_release_key);
    else
        fprintf (st, "Not captured");
    return SCPE_OK;
}

t_stat vid_show_video (FILE* st, UNIT* uptr, int32 val, CONST void* desc)
{
    int i;

    fprintf (st, "Video support using SDL: %s\n", vid_version());
#if defined (SDL_MAIN_AVAILABLE)
    fprintf (st, "  SDL Events being processed on the main process thread\n");
#endif
    if (window) {
        fprintf (st, "  Currently Active Video Window: (%d by %d pixels)\n", init_w, init_h);
        fprintf (st, "  ");
        vid_show_release_key (st, uptr, val, desc);
        fprintf (st, "\n");
    }
    for (i = 0; i < SDL_GetNumVideoDisplays(); ++i) {
        SDL_DisplayMode display;

        if (SDL_GetCurrentDisplayMode(i, &display)) {
            fprintf (st, "Could not get display mode for video display #%d: %s", i, SDL_GetError());
        }
        else {
            fprintf (st, "  Display %s(#%d): current display mode is %dx%dpx @ %dhz. \n", SDL_GetDisplayName(i), i, display.w, display.h, display.refresh_rate);
        }
    }
    fprintf (st, "  Available SDL Renderers:\n");
    for (i = 0; i < SDL_GetNumRenderDrivers(); ++i) {
        SDL_RendererInfo info;

        if (SDL_GetRenderDriverInfo (i, &info)) {
            fprintf (st, "Could not get render driver info for driver #%d: %s", i, SDL_GetError());
        }
        else {
            uint32 j, k;
            static struct {uint32 format; const char *name;} PixelFormats[] = {
                {SDL_PIXELFORMAT_INDEX1LSB,     "Index1LSB"},
                {SDL_PIXELFORMAT_INDEX1MSB,     "Index1MSB"},
                {SDL_PIXELFORMAT_INDEX4LSB,     "Index4LSB"},
                {SDL_PIXELFORMAT_INDEX4MSB,     "Index4MSB"},
                {SDL_PIXELFORMAT_INDEX8,        "Index8"},
                {SDL_PIXELFORMAT_RGB332,        "RGB332"},
                {SDL_PIXELFORMAT_RGB444,        "RGB444"},
                {SDL_PIXELFORMAT_RGB555,        "RGB555"},
                {SDL_PIXELFORMAT_BGR555,        "BGR555"},
                {SDL_PIXELFORMAT_ARGB4444,      "ARGB4444"},
                {SDL_PIXELFORMAT_RGBA4444,      "RGBA4444"},
                {SDL_PIXELFORMAT_ABGR4444,      "ABGR4444"},
                {SDL_PIXELFORMAT_BGRA4444,      "BGRA4444"},
                {SDL_PIXELFORMAT_ARGB1555,      "ARGB1555"},
                {SDL_PIXELFORMAT_RGBA5551,      "RGBA5551"},
                {SDL_PIXELFORMAT_ABGR1555,      "ABGR1555"},
                {SDL_PIXELFORMAT_BGRA5551,      "BGRA5551"},
                {SDL_PIXELFORMAT_RGB565,        "RGB565"},
                {SDL_PIXELFORMAT_BGR565,        "BGR565"},
                {SDL_PIXELFORMAT_RGB24,         "RGB24"},
                {SDL_PIXELFORMAT_BGR24,         "BGR24"},
                {SDL_PIXELFORMAT_RGB888,        "RGB888"},
                {SDL_PIXELFORMAT_RGBX8888,      "RGBX8888"},
                {SDL_PIXELFORMAT_BGR888,        "BGR888"},
                {SDL_PIXELFORMAT_BGRX8888,      "BGRX8888"},
                {SDL_PIXELFORMAT_ARGB8888,      "ARGB8888"},
                {SDL_PIXELFORMAT_RGBA8888,      "RGBA8888"},
                {SDL_PIXELFORMAT_ABGR8888,      "ABGR8888"},
                {SDL_PIXELFORMAT_BGRA8888,      "BGRA8888"},
                {SDL_PIXELFORMAT_ARGB2101010,   "ARGB2101010"},
                {SDL_PIXELFORMAT_YV12,          "YV12"},
                {SDL_PIXELFORMAT_IYUV,          "IYUV"},
                {SDL_PIXELFORMAT_YUY2,          "YUY2"},
                {SDL_PIXELFORMAT_UYVY,          "UYVY"},
                {SDL_PIXELFORMAT_YVYU,          "YVYU"},
                {SDL_PIXELFORMAT_UNKNOWN,       "Unknown"}};

                fprintf (st, "     Render #%d - %s\n", i, info.name);
                fprintf (st, "        Flags: 0x%X - ", info.flags);
                if (info.flags & SDL_RENDERER_SOFTWARE)
                    fprintf (st, "Software|");
                if (info.flags & SDL_RENDERER_ACCELERATED)
                    fprintf (st, "Accelerated|");
                if (info.flags & SDL_RENDERER_PRESENTVSYNC)
                    fprintf (st, "PresentVSync|");
                if (info.flags & SDL_RENDERER_TARGETTEXTURE)
                    fprintf (st, "TargetTexture|");
                fprintf (st, "\n");
                if ((info.max_texture_height != 0) || (info.max_texture_width != 0))
                    fprintf (st, "        Max Texture: %d by %d\n", info.max_texture_height, info.max_texture_width);
                fprintf (st, "        Pixel Formats:\n");
                for (j=0; j<info.num_texture_formats; j++) {
                    for (k=0; 1; k++) {
                        if (PixelFormats[k].format == info.texture_formats[j]) {
                            fprintf (st, "            %s\n", PixelFormats[k].name);
                            break;
                        }
                        if (PixelFormats[k].format == SDL_PIXELFORMAT_UNKNOWN) {
                            fprintf (st, "            %s - 0x%X\n", PixelFormats[k].name, info.texture_formats[j]);
                            break;
                        }
                    }
                }
        }
    }

    if (window)
        fprintf (st, "  Currently Active Renderer: System default\n");

    if (1) {
        static const char *hints[] = {
#if defined (SDL_HINT_FRAMEBUFFER_ACCELERATION)
            SDL_HINT_FRAMEBUFFER_ACCELERATION   ,
#endif
#if defined (SDL_HINT_RENDER_DRIVER)
            SDL_HINT_RENDER_DRIVER              ,
#endif
#if defined (SDL_HINT_RENDER_OPENGL_SHADERS)
            SDL_HINT_RENDER_OPENGL_SHADERS      ,
#endif
#if defined (SDL_HINT_RENDER_DIRECT3D_THREADSAFE)
            SDL_HINT_RENDER_DIRECT3D_THREADSAFE ,
#endif
#if defined (SDL_HINT_RENDER_DIRECT3D11_DEBUG)
            SDL_HINT_RENDER_DIRECT3D11_DEBUG    ,
#endif
#if defined (SDL_HINT_RENDER_SCALE_QUALITY)
            SDL_HINT_RENDER_SCALE_QUALITY       ,
#endif
#if defined (SDL_HINT_RENDER_VSYNC)
            SDL_HINT_RENDER_VSYNC               ,
#endif
#if defined (SDL_HINT_VIDEO_ALLOW_SCREENSAVER)
            SDL_HINT_VIDEO_ALLOW_SCREENSAVER    ,
#endif
#if defined (SDL_HINT_VIDEO_X11_XVIDMODE)
            SDL_HINT_VIDEO_X11_XVIDMODE         ,
#endif
#if defined (SDL_HINT_VIDEO_X11_XINERAMA)
            SDL_HINT_VIDEO_X11_XINERAMA         ,
#endif
#if defined (SDL_HINT_VIDEO_X11_XRANDR)
            SDL_HINT_VIDEO_X11_XRANDR           ,
#endif
#if defined (SDL_HINT_GRAB_KEYBOARD)
            SDL_HINT_GRAB_KEYBOARD              ,
#endif
#if defined (SDL_HINT_MOUSE_RELATIVE_MODE_WARP)
            SDL_HINT_MOUSE_RELATIVE_MODE_WARP    ,
#endif
#if defined (SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS)
            SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS   ,
#endif
#if defined (SDL_HINT_IDLE_TIMER_DISABLED)
            SDL_HINT_IDLE_TIMER_DISABLED ,
#endif
#if defined (SDL_HINT_ORIENTATIONS)
            SDL_HINT_ORIENTATIONS ,
#endif
#if defined (SDL_HINT_ACCELEROMETER_AS_JOYSTICK)
            SDL_HINT_ACCELEROMETER_AS_JOYSTICK ,
#endif
#if defined (SDL_HINT_XINPUT_ENABLED)
            SDL_HINT_XINPUT_ENABLED ,
#endif
#if defined (SDL_HINT_GAMECONTROLLERCONFIG)
            SDL_HINT_GAMECONTROLLERCONFIG ,
#endif
#if defined (SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS)
            SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS ,
#endif
#if defined (SDL_HINT_ALLOW_TOPMOST)
            SDL_HINT_ALLOW_TOPMOST ,
#endif
#if defined (SDL_HINT_TIMER_RESOLUTION)
            SDL_HINT_TIMER_RESOLUTION ,
#endif
#if defined (SDL_HINT_VIDEO_HIGHDPI_DISABLED)
            SDL_HINT_VIDEO_HIGHDPI_DISABLED ,
#endif
#if defined (SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK)
            SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK ,
#endif
#if defined (SDL_HINT_VIDEO_WIN_D3DCOMPILER)
            SDL_HINT_VIDEO_WIN_D3DCOMPILER              ,
#endif
#if defined (SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT)
            SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT    ,
#endif
#if defined (SDL_HINT_WINRT_PRIVACY_POLICY_URL)
            SDL_HINT_WINRT_PRIVACY_POLICY_URL ,
#endif
#if defined (SDL_HINT_WINRT_PRIVACY_POLICY_LABEL)
            SDL_HINT_WINRT_PRIVACY_POLICY_LABEL ,
#endif
#if defined (SDL_HINT_WINRT_HANDLE_BACK_BUTTON)
            SDL_HINT_WINRT_HANDLE_BACK_BUTTON ,
#endif
#if defined (SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES)
            SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES,
#endif
            NULL};
            fprintf (st, "  Currently Active SDL Hints:\n");
            for (i=0; hints[i]; i++) {
                if (SDL_GetHint (hints[i]))
                    fprintf (st, "      %s = %s\n", hints[i], SDL_GetHint (hints[i]));
            }
    }
    return SCPE_OK;
}

t_stat vid_show (FILE* st, DEVICE *dptr,  UNIT* uptr, int32 val, CONST char* desc)
{
    return vid_show_video (st, uptr, val, desc);
}
/* This function sets the alpha of the LED image background
to transparent. (Required, as the SDL2 default image loaders do not all for an alpha channel.)
It also, creates an 'Off' led using arbitrary RGB values from the background of GT40.bmp
*/

int img_setalpha(unsigned char alpha)
{
    int ix;

    unsigned char *p=(char *)img_led->pixels+2;
    Uint32 *q=(Uint32 *)img_led_off->pixels;

    for (ix=0;ix<img_led->w*img_led->h;ix++,p+=3,q++)
        if (*p++ > 0x50) {
            *p = alpha;
            *q = 0xff222720;
        }
        else {
            *p = 0;
            *q = 0x222220;;
        }
        return 0;
}

/* Turn run led on and off */

void run_led(int flg)
{
    led_dst.y=LED_Y;
    led_dst.h=img_led->h;
    led_dst.w=img_led->w;
    img_setalpha(255);
    led_dst.x=RUN_X;
    led_dst.y=LED_Y-4;
    SDL_SetSurfaceColorMod(img_led,255,255,255);
    if (flg)
        SDL_BlitSurface(img_led,NULL,surface,&led_dst);
    else
        SDL_BlitSurface(img_led_off,NULL,surface,&led_dst);

}

/*	This section ensures that the window creation and message loop run on the main thread.
This is specifically required by OSX die to the requirement of the Cocoa graphics system.
The method applied here is derived from the SDL specification.
*/

#if defined (main)
#undef main
#endif

static int main_argc;
static char **main_argv;
static SDL_Thread *vid_main_thread_handle;

int main_thread (void *arg)
{
    int stat;

    stat = SDL_main (main_argc, main_argv);	// Actually calls the main(...) function in scp.c
    vid_init = CLOSING;								// Will close MLoop
    return stat;
}

// THis is the entry point called if the graphics system is enabled.

int main (int argc, char *argv[])
{
    int status;

    main_argc = argc;
    main_argv = argv;

    vid_main_thread_handle = SDL_CreateThread (main_thread , "simh-main", NULL);

    sim_os_set_thread_priority (PRIORITY_ABOVE_NORMAL);

    while (!MLoop())
        SDL_Delay(10);								// Transiently de-schedule this thread.

    SDL_WaitThread (vid_main_thread_handle, &status);
    vid_close();
    SDL_Quit();
    return status;
}

t_stat vid_close (void){

    // Close and destroy the window if open
    if (vid_init != RUNNING)
        return 0;
    if (cursor)
        SDL_FreeCursor(cursor);
    vid_beep_cleanup();
    vid_init = CLOSED;
    while (vid_init != STOPPED)
        SDL_Delay(100);			// Wait for MLoop to complete window close.

    // Clean up
    cursor = 0;
    nostore = 0;
    surface = 0;
    if (xmev) {
        free(xmev);
        free(xhev);
        free(xkev);
    }
    return 0;
}


/* Create a window that will report various events on the main thread ... required for OSX. */
/* For the QVSS display, set nostore such that the window will merely be refreshed */
/* Also, if QVSS, pixel data arrives from vax_vc.c already formatted. Using vid_draw instead. */
/* In the event that this function is called with a NULL title, storage mode (no fade) is assumed */
/* vid_init states as follows:
STOPPED. Initial state, no window, no message loop.
WINDOW_OK. Set by vid_open. MLoop will then call vid_create_window on main thread. -> RUNNING
RUNNING. Running state. Window open, message loop active.
CLOSING. Set by exit from main simh thread ... inititate shutdown. Exit from MLoop in main.
CLOSED. Set by vid_close. MLoop will close the window and move to state STOPPED.

At present init_flags may only contain SIM_VID_INPUTCATUED or SIM_OWN_CURSOR.

Comment: Some if the above could have been achieved using the SDL messaging system.
*/


t_stat vid_open (DEVICE *dptr, const char *title, uint32 width, uint32 height, int flags)
{
    init_w = width;
    init_h = height;
    init_flags = flags;
    if ((strlen(sim_name) + 7 + (dptr ? strlen (dptr->name) : 0) + (title ? strlen (title) : 0)) < sizeof (vid_title))
        sprintf (vid_title, "%s%s%s%s%s", sim_name, dptr ? " - " : "", dptr ? dptr->name : "", title ? " - " : "", title ? title : "");
    else
        sprintf (vid_title, "%s", sim_name);

    if (init_flags & SIM_VID_INPUTCAPTURED)
        strcat(vid_title, "               Captured input mode: ReleaseKey is Right-Ctrl+Right-Shift");


    if (!title) 
        nostore++;

    vid_mono_palette[0] = sim_end ? 0xFF000000 : 0x000000FF;        /* Black */
    vid_mono_palette[1] = 0xFFFFFFFF;                               /* White */
    vid_beep_setup(100, 660);
    xmev=(struct mouse_event *)calloc(1,sizeof(SIM_MOUSE_EVENT));
    xhev=(struct mouse_event *)calloc(1,sizeof(SIM_MOUSE_EVENT));
    xkev=(struct key_event *)calloc(1,sizeof(SIM_KEY_EVENT));

    vid_init = WINDOW_OK;										    // Flag such that MLoop can call vid_create_window
    alias = 0;                                                      // No aliasing.

    return 0;
}

/*	This function creates the actual window and is called from MLoop on the main thread.
The expcted pixel format is 4x8 bytes. Any other format will result in an error exit.
This may seem rather limiting. However, modern hardware generally provides this format.
In the event that errors are reported, this function wil be updated.
NB. This function creates a renderer which is not used. The display system directly
manipulates the pixels in the surface buffer. This buffer is then written to the screen in Refresh().
In the event that a background image is loaded, the pixel offset used for refresh is recalculated.
For the GT40 build, the paddles are initialised here....
*/


t_stat vid_create_window(void)
{
    Uint32 rsl;
    int i,j,msk;

    // Load background image if required
    img = SDL_LoadBMP("GT40-New-Sized.bmp");
    img_led_src = SDL_LoadBMP("NewLED.bmp");
    img_led = SDL_ConvertSurfaceFormat(img_led_src,SDL_PIXELFORMAT_ARGB8888,0);
    img_led_off = SDL_ConvertSurfaceFormat(img_led_src,SDL_PIXELFORMAT_ARGB8888,0);
    bgnd_x = img->w;
    bgnd_y = img->h;
    ofset_x = OFSET_X_VR14;
    ofset_y = OFSET_Y_VR14;
    bset1_down = SDL_LoadBMP("Bset1_Down.bmp");
    bset1_up = SDL_LoadBMP("Bset1_Up.bmp");
    bset2_down = SDL_LoadBMP("Bset2_Down_1.bmp");
    bset2_up = SDL_LoadBMP("Bset2_Up_1.bmp");
    bset3_down = SDL_LoadBMP("Bset2_Down_2.bmp");
    bset3_up = SDL_LoadBMP("Bset2_Up_2.bmp");
    dep_down = SDL_LoadBMP("Dep_Down.bmp");
    dep_up = SDL_LoadBMP("Dep_Up.bmp");
    dflag = 0;
    // Create an application window with the following settings:
    SDL_Init (SDL_INIT_VIDEO);
    window = SDL_CreateWindow(
        vid_title,							// window title
        SDL_WINDOWPOS_UNDEFINED,			// initial x position
        SDL_WINDOWPOS_UNDEFINED,			// initial y position
        bgnd_x,                             // width, in pixels
        bgnd_y,                             // height, in pixels
        SDL_WINDOW_SHOWN					// flags
        );

    // Check that the window was successfully created
    if (window == NULL) {
        // In the case that the window could not be made...
        printf("Could not create SDL window: %s\n", SDL_GetError());
        exit(-1);
    }    
    img32 = SDL_ConvertSurfaceFormat(img,SDL_PIXELFORMAT_ARGB8888,0);
    surface = SDL_GetWindowSurface(window);
    /* Check the bitdepth of the surface */
    if(surface->format->BitsPerPixel != 32){
        fprintf(stderr, "Not an 32-bit SDL surface.\n");
        exit(-1);
    }
    /* Check the byes count of the surface */
    if(surface->format->BytesPerPixel != 4){
        fprintf(stderr, "Invalid pixel format.\n");
        exit(-1);
    }
    rsl=SDL_BlitSurface(img32, NULL, surface, NULL);
    pixels = (unsigned char *)surface->pixels;
    pixels += 4*(ofset_y*bgnd_x+ofset_x);
    surlen = (init_h * init_w * 4);
    vid_erase_win();
    SDL_SetSurfaceBlendMode(img_led, SDL_BLENDMODE_BLEND);
    SDL_SetSurfaceBlendMode(img_led_off, SDL_BLENDMODE_BLEND);
    SDL_CreateThread(Refresh,"Refresh",(void *)NULL);
    if (!(init_flags & SIM_VID_INPUTCAPTURED))
        if (!(init_flags & SIM_OWN_CURSOR))
            SDL_ShowCursor(SDL_DISABLE);			        /* Make host OS cursor invisible in non-capture mode or */
    /* for all other system that use their own cursor (see sim_ws.c:vid_open) */
    vid_init = RUNNING;  								    /* Init OK continue to next state */
    run_led(1);

    memset(led_bright,0,sizeof(led_bright));
    led_dst.y=LED_Y;

    SDL_StartTextInput();

    pdl_dst.w=BSet1_W;
    pdl_dst.h=BSet1_H;
    pdl_dst.y=BSet1_Y;
    for (i=0;i<5;i++) {
        pdl_dst.x=BSet1_X+i*BSet1_W;
        SDL_BlitSurface(bset1_up,NULL,surface,&pdl_dst);
    }
    bset1_state=0x1f;                                   /* All paddles up */

    j=BPTN;                                             /* SR color pattern */
    pdl_dst.w=bset1_down->w;
    pdl_dst.h=bset1_down->h;
    pdl_dst.y=BSet2_Y;
    msk=bset2_state=SR=0166000;                                         /* Default SR setting */
    for (i=0;i<16;i++,j>>=1,msk<<=1) {
        pdl_dst.x=BSet2_X+i*pdl_dst.w;
        if (msk & 0100000)                                        /* Default SR pattern */
            if (j&1)
                SDL_BlitSurface(bset2_up,NULL,surface,&pdl_dst);
            else
                SDL_BlitSurface(bset3_up,NULL,surface,&pdl_dst);
        else
            if (j&1)
                SDL_BlitSurface(bset2_down,NULL,surface,&pdl_dst);
            else
                SDL_BlitSurface(bset3_down,NULL,surface,&pdl_dst);
    }
    return SCPE_OK;
}

#if defined(HAVE_LIBPNG)

/*
This function coverts the default ARGB surface pixel format to ABGR (RGBA) which is the
only 32 bit format that is managed by libpng. Not very tidy!
Also, set A to 0xff.
*/

t_stat write_png_file(char *filename) {
    int i;
    Uint8 *p,*buffer,tm;
    png_bytep *row_pointers;
    Uint8 *pixels;

    FILE *fp = fopen(filename, "wb");

    png_structp png = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

    png_infop info = png_create_info_struct(png);

    png_init_io(png, fp);

    buffer = (Uint8 *)malloc(surlen);
    pixels = (Uint8 *)surface->pixels;
    memcpy(buffer, pixels, surlen);
    for (i=0,p=buffer;i<surlen/4;i++,p+=4) {
        tm = p[0];
        p[0] = p[2];
        p[2] = tm;
        p[3] = 0xff;
    }

    row_pointers = (png_bytep *)malloc(sizeof(png_bytep)*init_h);
    for (i = 0; i < surface->h; i++)
        row_pointers[i] = (png_bytep)(Uint8 *)buffer + i * surface->pitch;

    // Output is 8bit depth, RGBA format.

    png_set_IHDR(
        png,
        info,
        init_w, init_h,
        8,
        PNG_COLOR_TYPE_RGBA,
        PNG_INTERLACE_NONE,
        PNG_COMPRESSION_TYPE_DEFAULT,
        PNG_FILTER_TYPE_DEFAULT
        );
    png_write_info(png, info);

    png_write_image(png, row_pointers);
    png_write_end(png, NULL);

    free(row_pointers);

    fclose(fp);
    return 0;
}
#else
t_stat write_png_file(char *filename) {
    printf("PNG library not available\n");
    return 1;								/* Always return an error */
}
#endif

t_stat vid_screenshot (const char *filename)
{
    int stat;
    char *fullname = NULL;

    if (!surface) {
        sim_printf ("No video display is active\n");
        return SCPE_UDIS | SCPE_NOMESSAGE;
    }
    fullname = (char *)malloc (strlen(filename) + 5);
    if (!filename)
        return SCPE_MEM;
    if (1) {
#if defined(HAVE_LIBPNG)
        if (!match_ext (filename, "bmp")) {
            sprintf (fullname, "%s%s", filename, match_ext (filename, "png") ? "" : ".png");
            stat = write_png_file(fullname);
        }
        else {
            sprintf (fullname, "%s", filename);
            stat = SDL_SaveBMP(surface, fullname);
        }
#else
        sprintf (fullname, "%s%s", filename, match_ext (filename, "bmp") ? "" : ".bmp");
        stat = SDL_SaveBMP(surface, fullname);
#endif /* defined(HAVE_LIBPNG) */
    }
    if (stat) {
        sim_printf ("Error saving screenshot to %s: %s\n", fullname, SDL_GetError());
        free (fullname);
        return SCPE_IOERR | SCPE_NOMESSAGE;
    }
    else {
        if (!sim_quiet)
            sim_printf ("Screenshot saved to %s\n", fullname);
        free (fullname);
        return SCPE_OK;
    }
}

void vid_set_cursor_position (int32 x, int32 y) {

    lcurr_x = x;
    lcurr_y = y;
}


t_stat vid_set_cursor (t_bool visible, uint32 width, uint32 height, uint8 *data, uint8 *mask, uint32 hot_x, uint32 hot_y)
{

    if (!cursor) {
        while (vid_init != RUNNING)         /* Wait for Window to be created */
            SDL_Delay(10);
        cursor = SDL_CreateCursor (data, mask, width, height, hot_x, hot_y);
        SDL_SetCursor(cursor);
        SDL_ShowCursor(SDL_ENABLE);			/* Make new cursor visible */
        return SCPE_OK;
    }
    return SCPE_NOFNC;
}


t_stat vid_erase_win()
{
    unsigned int i,pxstp=bgnd_x*4;
    unsigned char *p;

    p=pixels;
    for (i=0;i<init_h;i++,p+=pxstp)
        memset(p, 0, init_w * 4);
    SDL_UpdateWindowSurface(window);				/* Write black surface to the host system window */
    return 0;
}

/*	
vid_draw. Similar to bitblt (Win.GDI) simply copies a pre-formatted buffer into the current surface.
The surface is then copied to the screen every 20 mS. in Refresh() as below.
*/

void vid_draw (int32 x, int32 y, int32 w, int32 h, uint32 *buf)
{

    int32 i;
    uint32* pixels;

    if (vid_init != RUNNING)
        return;

    pixels = (uint32 *)surface->pixels;
    for (i = 0; i < h; i++)
        memcpy (pixels + ((i + y) * init_w) + x, buf + w*i, w*sizeof(*pixels));

    return;
}

void vid_blur(unsigned char *dst,unsigned char *src,int h,int w,int step)
{
    unsigned char *p,*a,*b,*c;
    int x,y,i,j,px,vl,pxstp=(bgnd_x-init_w)*4;

    p=src+w*4+5;
    a=dst+1;
    b=dst+w*4+1;
    c=dst+w*8+1;
    for (i=1;i<w-1;i++,p+=8+step,a+=8,b+=8,c+=8) {
        for (j=1;j<h-1;j++,p+=4,a+=4,b+=4,c+=4) {
            if ((vl=*p>>2)) {
                for (x=0;x<3;x++,a+=4,b+=4,c+=4)
                {
                    *a=*a+vl<0xff?*a+vl:0xff;
                    *b=*b+vl<0xff?*b+vl:0xff;
                    *c=*c+vl<0xff?*c+vl:0xff;
                    if (x==1)
                        *b=*p;
                }
                a-=12;b-=12;c-=12;
            }
        }
    }
}


/*
The function is central to all display system. Firstly, the current surface (effectively a back buffer)
is copied to the screen surface by SDL_UpdateWindowSurface. This function (hopefully) calls a GPU
bitblt process and with modern hardware is extremely fast (1 mS.).
The next section su responsible for gradually fading the image in the window. This is achieved using an RGB time
constant sequence in colmap such that the phosphor fade constant for each color can be different. This loop is also very fast
typically 10-15 mS. on recent X86 family processors clocked at >1.5 GHz. The final part of the loop ensure that the
entire cycle takes almost 20 mS. with due allowance for scheduling  etc. In this case, the fade constants can be preset and
no matter what is on screen, the fading will be constant.
As the fade constants are set by color, some interesting effects can be obtained. See display.c for examples where the pixels
can start of as blue/white and then have a yellow fade effect. Eg P40 used in the VS60 system.
Howvwer, for some displays eg QVSS, a fade is not required so this function is disabled by nostore. In this case, the system
emeulates a standard RGB bitmap display in framebuffer mode.
The nostore function can also be used for a storage scope display eg the Tektronix 611 XY display. (See pdp8_vc8.c).
This module also contains an offset option to define a sub region of the window to refresh.
*/

static int Refresh(void *info) {
    unsigned int i,j,k,pxstp=(bgnd_x-init_w)*4;
    unsigned char *p, lo;
    Uint8 b;
    double *d;
    static int led_cntr,tlast;
    unsigned char *buf=calloc(init_w*init_h, 4);

    while (window && vid_init != STOPPED) {
        told=sim_os_msec();
        tlast=told;
        lo = tekout?200:0;                                  // When in tek mode, fade to 200 rather than 0
        if (vid_init == RUNNING) {				            // If halted ... freeze display and, display valid

            if (!nostore && sim_is_running)                 // Only decay the pixels in store mode and if the simulator is running
                for (k=0,p=(unsigned char *)pixels;k<init_h;k++,p+=pxstp)
                    for (i = 0;i < init_w; i++, p++)
                        for (j = 0,d = colmap;j < 3;j++, p++, d++)
                            if (*p > lo)
                                *p = (unsigned char)(*p * (*d) - 1);	// Decay pixels>lo only
        }


        if (vid_init == RUNNING) {
            if (!sim_is_running) {
                run_led(0);
                for (i=DR,led_cntr=0;led_cntr<16;led_cntr++,i<<=1)
                    led_bright[led_cntr]=i&0100000?0xffff:0;
            }
            else
                run_led(1);

            for (led_cntr=0;led_cntr<16;led_cntr++) {
                led_dst.x=(int)((double)led_cntr*LED_STEP+LED_X);
                led_dst.y=LED_Y;
                led_dst.h=img_led->h;
                led_dst.w=img_led->w;
                b=led_bright[led_cntr] >> 8;
                SDL_SetSurfaceColorMod(img_led,b,b,b);
                if (b>5)
                    SDL_BlitSurface(img_led,NULL,surface,&led_dst);
                else
                    SDL_BlitSurface(img_led_off,NULL,surface,&led_dst);
            }
        }

        tnew = sim_os_msec();
        tvl = 18 - tnew + told;				// Calculate delay required for a constant update time of 20mSec. 
        if (tvl < 0)						// System not fast enough so just continue with no delay.
            tvl = 0;
        SDL_Delay(tvl);                     // This delay is required here to allow SDL to update the window
        dflag++;
    }
    free(buf);
    return 0;							// The window has been closed by vid_close ... exit thread
}


/*	The Mouse system.

The following function is central to the mouse implementation for the QVSS (VCB01) Q-bus card.
The intention of this function is to provide seamless enrty and exit of the mouse pointer
from within the host window system. The first 6 lines of code relate to window initialisation.
This could equally have been achived using messages but a state machine is more convenient.
The next 6 lines constitute a system that generates the required relative motion data so that the
QVSS mouse location generated by the OS ruunning on the simh client eg VMS is matched to the
location of the (actaully invisible) cursor managed by the host OS. The is achived by calculating
the X and Y pointing errors and generating a sequence of relative movements until the location of
the client cursor matches that of the host. The conditional expression reduces the 'gain' of this
servo loop for relative errors > 8. This is required because the client OS response to a given
relative move is non-linear due to a degree of mouse acceleration implemented by the client. THis
non linear response is implemented in both DEC Windows under VMS and Ultrix.
The overall efect of this process is that when the host cursor enter the QVSS window, the client
OS is sent a number of move messages to move the client cursor to the same location as the
now invisible host cursor.
This interface is also used by all systems with a light pen (VT11/VT60/PDP1/TX-0).
Similarly, the keyboard data is made available to all systems (QVSS only at present).

*/

static void vid_close_window(void)
{
    stop_cpu = 1;								// Stop simulation
    vid_init = STOPPED;							// Reset vid_init state
    SDL_DestroyWindow(window);					// Close this window and renderer.
    window = 0;									// Invalidate handle
}

static int MLoop() {
    SDL_Event event;
    int rel_x,rel_y;

    switch (vid_init) {
        case STOPPED:
            return 0;				// Wait until window has been initialised
        case WINDOW_OK:
            vid_create_window();	// Create window and begin receiving events
            break;
        case RUNNING:               // No action.
            if (dflag) {
                SDL_UpdateWindowSurface(window);
                dflag = 0;
            }
            break;
        case CLOSING:
            return -1;				// Exit message loop and start shutdown
        case CLOSED:
            vid_close_window();		// Close window continue receiving events until SDL_Quit
            break;
    }

    rel_x = xmev->x_pos - lcurr_x;
    rel_y = xmev->y_pos - lcurr_y;
    rel_x = (abs(rel_x) > 9)?rel_x/2:rel_x;
    rel_y = (abs(rel_y) > 9)?rel_y/2:rel_y;

    xmev->x_rel = rel_x;
    xmev->y_rel = rel_y;

    if (SDL_PollEvent(&event)) {
        switch (event.type) {
                case SDL_QUIT:
                    return 0;
                case SDL_MOUSEMOTION:
                    xmev->x_pos = event.motion.x-ofset_x;
                    xmev->y_pos = event.motion.y-ofset_y;
                    break;
                case SDL_MOUSEBUTTONDOWN:
                    xmev->b1_state = (event.button.button==SDL_BUTTON_LEFT);
                    xmev->b2_state = (event.button.button==SDL_BUTTON_RIGHT);
                    xmev->b3_state = (event.button.button==SDL_BUTTON_MIDDLE);
                    xmev->x_pos = event.button.x-ofset_x;
                    xmev->y_pos = event.button.y-ofset_y;
                    break;
                case SDL_MOUSEBUTTONUP:
                    if (event.button.button == SDL_BUTTON_LEFT) xmev->b1_state = 0;
                    if (event.button.button == SDL_BUTTON_RIGHT) xmev->b2_state = 0;
                    if (event.button.button == SDL_BUTTON_MIDDLE) xmev->b3_state = 0;
                    xmev->x_pos = event.button.x - ofset_x;
                    xmev->y_pos = event.button.y - ofset_y;
                    break;
                case SDL_KEYDOWN:
                    xkev->key = event.key.keysym.sym;
                    xkev->state = SIM_KEYPRESS_DOWN;
                    xkev->mod = event.key.keysym.mod;
                    key_value = event.key.keysym.scancode;
                    break;
                case SDL_KEYUP:
                    xkev->key = event.key.keysym.sym;
                    xkev->state = SIM_KEYPRESS_UP;
                    xkev->mod = event.key.keysym.mod;
                    break;
                case SDL_WINDOWEVENT:
                    if (event.window.event == SDL_WINDOWEVENT_CLOSE)
                        stop_cpu = 1;								// Stop simulation
                    break;
                case SDL_USEREVENT:
                    if (event.window.event == EVENT_BEEP)
                        vid_beep_event();
                    break;
                case SDL_TEXTINPUT:
                    write_console_input(event.text.text,1);
                    break;

        }
        if (!sim_is_running || !vt_status)
            vid_poll_mouse(xmev);                               // When VT11 or sim are stopped, still allow mouse events
        vt_status = 0; 
    }
    return 0;
}

/* Only return SCPE_OK if there is a change in the mouse or keyboard data */
/* Also deal with paddle hits */

int vid_poll_mouse (SIM_MOUSE_EVENT *mev)
{
    int i,j,msk,xpos,ypos;
    char stp=5;  /* stp = ^e */
    char cbf[32];

    if (!xmev)
        return SCPE_EOF;
    memcpy(mev,xmev,sizeof(SIM_MOUSE_EVENT));
    if ( !memcmp(xhev,xmev,sizeof(SIM_MOUSE_EVENT)) && !(mev->x_rel | xmev->y_rel) ) 
        return SCPE_EOF;							/* Only report changes */
    memcpy(xhev,xmev,sizeof(SIM_MOUSE_EVENT));		/* Keep local copy */

    if (xmev->b1_state == mouse_flag)
        return SCPE_OK;

    mouse_flag=xmev->b1_state;
    xpos=xmev->x_pos+ofset_x;
    ypos=xmev->y_pos+ofset_y;

    /* Process DEP paddle */

    if (xpos > Dep_X && xpos < Dep_X+38)    // Dep key (spring loaded)
        if (ypos > Dep_Y && ypos < Dep_Y+50) {
            pdl_dst.w=dep_down->w;
            pdl_dst.h=dep_down->h;
            pdl_dst.y=Dep_Y;
            pdl_dst.x=Dep_X;
            if (mouse_flag) {
                SDL_BlitSurface(dep_up,NULL,surface,&pdl_dst);
                sprintf(cbf,"d %o %o\r",R[7],SR=DR=bset2_state);
                R[7]+=2;
                write_console_input(cbf,strlen(cbf));
           }
            else {
                DR=R[7];
                SDL_BlitSurface(dep_down,NULL,surface,&pdl_dst);
            }
        }

        /* Process 5 control paddles run/halt is toggle */

        if (xpos > BSet1_X && xpos < (BSet1_X+5*BSet1_W))    // Block of 5 paddles (toggle run/halt)
            if (ypos > BSet1_Y && ypos < (BSet1_Y+BSet1_H)) {
                i=(xpos - BSet1_X)/BSet1_W;
                msk=1<<i;
                pdl_dst.w=bset1_down->w;
                pdl_dst.h=bset1_down->h;
                pdl_dst.y=BSet1_Y;
                pdl_dst.x=BSet1_X+i*BSet1_W;
                if (i!=3) {
                    if (mouse_flag) {
                        SDL_BlitSurface(bset1_down,NULL,surface,&pdl_dst);
                        if (!sim_is_running)
                            switch (i) {
case 0:
    sprintf(cbf,"d PC %o\r",SR=R[7]=DR=(bset2_state & 0177776));
    write_console_input(cbf,strlen(cbf));
    break;
case 1:
    sprintf(cbf,"e %o\r",DR=SR);
    write_console_input(cbf,strlen(cbf));
    SR+=2;
    break;
case 2: if (bset1_state & 8)
            write_console_input("cont\r",5);
        else
            write_console_input("step\r",5);
    break;
case 3:
    break;
case 4: if (bset1_state & 8)
            write_console_input("run\r",5);
    break;
                        }
                    }
                    else {
                        SDL_BlitSurface(bset1_up,NULL,surface,&pdl_dst);
                        if (!sim_is_running)
                            switch (i) {
case 1:
    if (sim_eval)
        DR=sim_eval[0];
    break;
                        }
                    }
                    bset1_state ^= msk;
                    return SCPE_OK;
                }
                if (!mouse_flag)
                    return SCPE_OK;
                if ((bset1_state & 8)) {
                    SDL_BlitSurface(bset1_down,NULL,surface,&pdl_dst);
                    if (sim_is_running)
                        write_console_input(&stp,1);
                }
                else
                    SDL_BlitSurface(bset1_up,NULL,surface,&pdl_dst);
                bset1_state ^= msk;
                return SCPE_OK;
            }

            /* Process SR, all are toggle */
            /* SR color pattern */
            if (xpos > BSet2_X && xpos < (BSet2_X+16*bset2_down->w))    // Block of 16 paddles all toggle
                if (ypos > BSet2_Y && ypos < (BSet2_Y+bset2_down->h)) {
                    i=(xpos - BSet2_X)/bset2_down->w;
                    j=BPTN>>i;
                    msk=0100000>>i;
                    if (!mouse_flag)
                        return SCPE_OK;
                    pdl_dst.w=bset2_down->w;
                    pdl_dst.h=bset2_down->h;
                    pdl_dst.y=BSet2_Y;
                    pdl_dst.x=BSet2_X+i*bset2_down->w;
                    if (bset2_state&msk)                               
                        if (j&1)
                            SDL_BlitSurface(bset2_down,NULL,surface,&pdl_dst);
                        else
                            SDL_BlitSurface(bset3_down,NULL,surface,&pdl_dst);
                    else
                        if (j&1)
                            SDL_BlitSurface(bset2_up,NULL,surface,&pdl_dst);
                        else
                            SDL_BlitSurface(bset3_up,NULL,surface,&pdl_dst);
                    bset2_state ^= msk;
                    SR = bset2_state;
                }

                return SCPE_OK;
}

t_stat vid_poll_kb (SIM_KEY_EVENT *ev) {

    uint32 kval;

    if (!xkev)
        return SCPE_EOF;
    if (xkev->state == lstst && lstcd == xkev->key)
        return SCPE_EOF;								/* Single events only */
    memcpy(ev,xkev,sizeof(SIM_KEY_EVENT));
    lstst = xkev->state;
    kval = lstcd = xkev->key;
    if (!xkev->state) {
        if (kval<32)
            write_console_input((char *)&kval,1);
        kval &= 31;
        if (xkev->mod & KMOD_CTRL)
            write_console_input((char *)&kval,1);
    }
    return SCPE_OK;
}

/*	
This function draws a pixel on the current surface if the graphics system is in state 2.
The surface is written to the screen (blit) in Refresh() above. ALL display systems use this
function. At present, level and color are ignored.
*/

t_stat vid_setpixel(int ix,int iy,int level,int color) {
    Uint32 *p;

    if (vid_init == RUNNING) {
        p=(Uint32 *)(pixels + (iy * surface->pitch) + (ix * sizeof(Uint32)));
        if (alias)
            *p = (alias << 8) & 0xff00;      // Level is 0-255 of green only
        else
            *p = ((128 << 8) + (level << 12)) & pxval;     // Level is 0-7;
//            *p = pxval;
    }
    return SCPE_OK;
}

t_stat vid_lock_cursor()
{
    SDL_ShowCursor(SDL_DISABLE);		   /* Make host OS cursor invisible in non-capture/default mode */
    SDL_SetWindowGrab(window, SDL_TRUE);   /* Lock mouse to this window */
#ifdef __APPLE__
    SDL_SetRelativeMouseMode(SDL_TRUE);
#endif
    return SCPE_OK;
}

t_stat vid_unlock_cursor()
{
    if (SDL_GetWindowGrab(window) == SDL_TRUE) {
        SDL_SetWindowGrab(window, SDL_FALSE);							/* Unlock mouse for this window */
        SDL_SetRelativeMouseMode(SDL_FALSE);
        SDL_ShowCursor(SDL_ENABLE);										/* Make host OS cursor visible in non-capture/default mode */
        SDL_WarpMouseInWindow(window, xmev->x_pos + 1, xmev->y_pos );	/* This is required to redraw the host cursor */
        return 1;
    }
    return 0;
}

const char *vid_version(void)
{
    static char SDLVersion[80];
    SDL_version compiled, running;

    SDL_GetVersion(&running);
    SDL_VERSION(&compiled);

    if ((compiled.major == running.major) &&
        (compiled.minor == running.minor) &&
        (compiled.patch == running.patch))
        sprintf(SDLVersion, "SDL Version %d.%d.%d", 
        compiled.major, compiled.minor, compiled.patch);
    else
        sprintf(SDLVersion, "SDL Version (Compiled: %d.%d.%d, Runtime: %d.%d.%d)", 
        compiled.major, compiled.minor, compiled.patch,
        running.major, running.minor, running.patch);
    return (const char *)SDLVersion;
}


/*	Original beep code from Matt Burke's code */


#include <SDL_audio.h>
#include <math.h>

const int AMPLITUDE = 20000;
const int SAMPLE_FREQUENCY = 11025;
static int16 *vid_beep_data;
static int vid_beep_offset;
static int vid_beep_duration;
static int vid_beep_samples;

static void vid_audio_callback(void *ctx, Uint8 *stream, int length)
{
    int16 *data = (int16 *)stream;
    int i, sum, remnant = ((vid_beep_samples - vid_beep_offset) * sizeof (*vid_beep_data));

    if (length > remnant) {
        memset (stream + remnant, 0, length - remnant);
        length = remnant;
        if (remnant == 0) {
            SDL_PauseAudio(1);
            return;
        }
    }
    memcpy (stream, &vid_beep_data[vid_beep_offset], length);
    for (i=sum=0; i<length; i++)
        sum += stream[i];
    vid_beep_offset += length / sizeof(*vid_beep_data);
}

static void vid_beep_setup (int duration_ms, int tone_frequency)
{
    if (!vid_beep_data) {
        int i;
        SDL_AudioSpec desiredSpec;

        memset (&desiredSpec, 0, sizeof(desiredSpec));
        desiredSpec.freq = SAMPLE_FREQUENCY;
        desiredSpec.format = AUDIO_S16SYS;
        desiredSpec.channels = 1;
        desiredSpec.samples = 2048;
        desiredSpec.callback = vid_audio_callback;

        //SDL_OpenAudio(&desiredSpec, NULL);

        vid_beep_samples = (int)((SAMPLE_FREQUENCY * duration_ms) / 1000.0);
        vid_beep_duration = duration_ms;
        vid_beep_data = (int16 *)malloc (sizeof(*vid_beep_data) * vid_beep_samples);
        for (i=0; i<vid_beep_samples; i++)
            vid_beep_data[i] = (int16)(AMPLITUDE * sin(((double)(i * M_PI * tone_frequency)) / SAMPLE_FREQUENCY));
    }
}

static void vid_beep_cleanup (void)
{
    SDL_CloseAudio();
    free (vid_beep_data);
    vid_beep_data = NULL;
}

void vid_beep_event (void)
{
    vid_beep_offset = 0;                /* reset to beginning of sample set */
    SDL_PauseAudio (0);                 /* Play sound */
}

void vid_beep (void)
{
    SDL_Event user_event;

    user_event.type = SDL_USEREVENT;
    user_event.user.code = EVENT_BEEP;
    user_event.user.data1 = NULL;
    user_event.user.data2 = NULL;
#if defined (SDL_MAIN_AVAILABLE)
    while (SDL_PushEvent (&user_event) < 0)
        sim_os_ms_sleep (10);
#else
    vid_beep_event ();
#endif
    //	SDL_Delay (vid_beep_duration + 100);/* Wait for sound to finnish */
}


/*
Translate SDL Keyboard codes to SIMH internal codes for use by any simulator
requiring keyboard data from a window.
*/

int vid_map_key (int key)
{
    switch (key) {

case SDLK_BACKSPACE:
    return SIM_KEY_BACKSPACE;

case SDLK_TAB:
    return SIM_KEY_TAB;

case SDLK_RETURN:
    return SIM_KEY_ENTER;

case SDLK_ESCAPE:
    return SIM_KEY_ESC;

case SDLK_SPACE:
    return SIM_KEY_SPACE;

case SDLK_QUOTE:
    return SIM_KEY_SINGLE_QUOTE;

case SDLK_COMMA:
    return SIM_KEY_COMMA;

case SDLK_MINUS:
    return SIM_KEY_MINUS;

case SDLK_PERIOD:
    return SIM_KEY_PERIOD;

case SDLK_SLASH:
    return SIM_KEY_SLASH;

case SDLK_0:
    return SIM_KEY_0;

case SDLK_1:
    return SIM_KEY_1;

case SDLK_2:
    return SIM_KEY_2;

case SDLK_3:
    return SIM_KEY_3;

case SDLK_4:
    return SIM_KEY_4;

case SDLK_5:
    return SIM_KEY_5;

case SDLK_6:
    return SIM_KEY_6;

case SDLK_7:
    return SIM_KEY_7;

case SDLK_8:
    return SIM_KEY_8;

case SDLK_9:
    return SIM_KEY_9;

case SDLK_SEMICOLON:
    return SIM_KEY_SEMICOLON;

case SDLK_EQUALS:
    return SIM_KEY_EQUALS;

case SDLK_LEFTBRACKET:
    return SIM_KEY_LEFT_BRACKET;

case SDLK_BACKSLASH:
    return SIM_KEY_BACKSLASH;

case SDLK_RIGHTBRACKET:
    return SIM_KEY_RIGHT_BRACKET;

case SDLK_BACKQUOTE:
    return SIM_KEY_BACKQUOTE;

case SDLK_a:
    return SIM_KEY_A;

case SDLK_b:
    return SIM_KEY_B;

case SDLK_c:
    return SIM_KEY_C;

case SDLK_d:
    return SIM_KEY_D;

case SDLK_e:
    return SIM_KEY_E;

case SDLK_f:
    return SIM_KEY_F;

case SDLK_g:
    return SIM_KEY_G;

case SDLK_h:
    return SIM_KEY_H;

case SDLK_i:
    return SIM_KEY_I;

case SDLK_j:
    return SIM_KEY_J;

case SDLK_k:
    return SIM_KEY_K;

case SDLK_l:
    return SIM_KEY_L;

case SDLK_m:
    return SIM_KEY_M;

case SDLK_n:
    return SIM_KEY_N;

case SDLK_o:
    return SIM_KEY_O;

case SDLK_p:
    return SIM_KEY_P;

case SDLK_q:
    return SIM_KEY_Q;

case SDLK_r:
    return SIM_KEY_R;

case SDLK_s:
    return SIM_KEY_S;

case SDLK_t:
    return SIM_KEY_T;

case SDLK_u:
    return SIM_KEY_U;

case SDLK_v:
    return SIM_KEY_V;

case SDLK_w:
    return SIM_KEY_W;

case SDLK_x:
    return SIM_KEY_X;

case SDLK_y:
    return SIM_KEY_Y;

case SDLK_z:
    return SIM_KEY_Z;

case SDLK_DELETE:
    return SIM_KEY_DELETE;

case SDLK_KP_0:
    return SIM_KEY_KP_INSERT;

case SDLK_KP_1:
    return SIM_KEY_KP_END;

case SDLK_KP_2:
    return SIM_KEY_KP_DOWN;

case SDLK_KP_3:
    return SIM_KEY_KP_PAGE_DOWN;

case SDLK_KP_4:
    return SIM_KEY_KP_LEFT;

case SDLK_KP_5:
    return SIM_KEY_KP_5;

case SDLK_KP_6:
    return SIM_KEY_KP_RIGHT;

case SDLK_KP_7:
    return SIM_KEY_KP_HOME;

case SDLK_KP_8:
    return SIM_KEY_KP_UP;

case SDLK_KP_9:
    return SIM_KEY_KP_PAGE_UP;

case SDLK_KP_PERIOD:
    return SIM_KEY_KP_DELETE;

case SDLK_KP_DIVIDE:
    return SIM_KEY_KP_DIVIDE;

case SDLK_KP_MULTIPLY:
    return SIM_KEY_KP_MULTIPLY;

case SDLK_KP_MINUS:
    return SIM_KEY_KP_SUBTRACT;

case SDLK_KP_PLUS:
    return SIM_KEY_KP_ADD;

case SDLK_KP_ENTER:
    return SIM_KEY_KP_ENTER;

case SDLK_UP:
    return SIM_KEY_UP;

case SDLK_DOWN:
    return SIM_KEY_DOWN;

case SDLK_RIGHT:
    return SIM_KEY_RIGHT;

case SDLK_LEFT:
    return SIM_KEY_LEFT;

case SDLK_INSERT:
    return SIM_KEY_INSERT;

case SDLK_HOME:
    return SIM_KEY_HOME;

case SDLK_END:
    return SIM_KEY_END;

case SDLK_PAGEUP:
    return SIM_KEY_PAGE_UP;

case SDLK_PAGEDOWN:
    return SIM_KEY_PAGE_DOWN;

case SDLK_F1:
    return SIM_KEY_F1;

case SDLK_F2:
    return SIM_KEY_F2;

case SDLK_F3:
    return SIM_KEY_F3;

case SDLK_F4:
    return SIM_KEY_F4;

case SDLK_F5:
    return SIM_KEY_F5;

case SDLK_F6:
    return SIM_KEY_F6;

case SDLK_F7:
    return SIM_KEY_F7;

case SDLK_F8:
    return SIM_KEY_F8;

case SDLK_F9:
    return SIM_KEY_F9;

case SDLK_F10:
    return SIM_KEY_F10;

case SDLK_F11:
    return SIM_KEY_F11;

case SDLK_F12:
    return SIM_KEY_F12;

case SDLK_NUMLOCKCLEAR:
    return SIM_KEY_NUM_LOCK;

case SDLK_CAPSLOCK:
    return SIM_KEY_CAPS_LOCK;

case SDLK_SCROLLLOCK:
    return SIM_KEY_SCRL_LOCK;

case SDLK_RSHIFT:
    return SIM_KEY_SHIFT_R;

case SDLK_LSHIFT:
    return SIM_KEY_SHIFT_L;

case SDLK_RCTRL:
    return SIM_KEY_CTRL_R;

case SDLK_LCTRL:
    return SIM_KEY_CTRL_L;

case SDLK_RALT:
    return SIM_KEY_ALT_R;

case SDLK_LALT:
    return SIM_KEY_ALT_L;

case SDLK_LGUI:
    return SIM_KEY_WIN_L;

case SDLK_RGUI:
    return SIM_KEY_WIN_R;

case SDLK_PRINTSCREEN:
    return SIM_KEY_PRINT;

case SDLK_PAUSE:
    return SIM_KEY_PAUSE;

case SDLK_MENU:
    return SIM_KEY_MENU;

default:
    return SIM_KEY_UNKNOWN;
    }
}


#else /* !(defined(USE_SIM_VIDEO) && defined(HAVE_LIBSDL)) */
/* Non-implemented versions */

t_stat vid_open (DEVICE *dptr, const char *title, uint32 width, uint32 height, int flags)
{
    printf("SDL graphics services are not avaiable.\nTo use a graphics device, please verify the build environment.\n");
    return SCPE_NOFNC;
}

t_stat vid_close (void)
{
    return SCPE_OK;
}

t_stat vid_poll_kb (SIM_KEY_EVENT *ev)
{
    return SCPE_EOF;
}

t_stat vid_poll_mouse (SIM_MOUSE_EVENT *ev)
{
    return SCPE_EOF;
}

void vid_draw (int32 x, int32 y, int32 w, int32 h, uint32 *buf)
{
    return;
}

t_stat vid_erase_win(void)
{
    return SCPE_NOFNC;
}

t_stat vid_setpixel(ix, iy, level, color)
{
    return SCPE_NOFNC;
}

t_stat vid_set_cursor (t_bool visible, uint32 width, uint32 height, uint8 *data, uint8 *mask, uint32 hot_x, uint32 hot_y)
{
    return SCPE_NOFNC;
}

void vid_set_cursor_position (int32 x, int32 y)
{
    return;
}

void vid_refresh (void)
{
    return;
}

void vid_beep (void)
{
    return;
}

t_stat vid_lock_cursor()
{
    return SCPE_EOF;
}

t_stat vid_unlock_cursor()
{
    return SCPE_EOF;
}

int vid_map_key(int key)
{
    return 0;
}

t_stat vid_show_video (FILE* st, UNIT* uptr, int32 val, CONST void* desc)
{

    fprintf (st, "No video support. If required, please install SDL2\n");
    return SCPE_OK;
}

const char *vid_version (void)
{
    return "No Video Support";
}

t_stat vid_screenshot (const char *filename)
{
    sim_printf ("video support unavailable\n");
    return SCPE_NOFNC|SCPE_NOMESSAGE;
}
#endif /* defined(USE_SIM_VIDEO) */

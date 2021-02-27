##
## Auto Generated makefile by CodeLite IDE
## any manual changes will be erased      
##
## Release
ProjectName            :=GT40
ConfigurationName      :=Release
WorkspacePath          := "."
ProjectPath            := "."
IntermediateDirectory  :=./BIN
OutDir                 := $(IntermediateDirectory)
CurrentFileName        :=
CurrentFilePath        :=
CurrentFileFullPath    :=
User                   :=
Date                   :=01/24/21
CodeLitePath           :="/home/pi/.codelite"
LinkerName             :=/usr/bin/g++ 
SharedObjectLinkerName :=/usr/bin/g++ -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.i
DebugSwitch            :=-g 
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
OutputFile             :=./BIN/gt40
Preprocessors          :=$(PreprocessorSwitch)NDEBUG 
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E
ObjectsFileList        :="GT40.txt"
PCHCompileFlags        :=
MakeDirCommand         :=mkdir -p
LinkOptions            :=  -L/opt/vc/lib -lSDL2 -lEGL -lGLESv2 -ljpeg  -lm -lrt -lpthread -lpcreposix -ldl -lpng -lX11 -lreadline
IncludePath            :=  $(IncludeSwitch). $(IncludeSwitch). $(IncludeSwitch)/opt/vc/include $(IncludeSwitch)/usr/include/SDL2 $(IncludeSwitch)./REALCONS 
IncludePCH             := 
RcIncludePath          := 
Libs                   := 
ArLibs                 :=  
LibPath                := $(LibraryPathSwitch). 

##
## Common variables
## AR, CXX, CC, AS, CXXFLAGS and CFLAGS can be overriden using an environment variables
##
AR       := /usr/bin/ar rcu
CXX      := /usr/bin/g++ 
CC       := /usr/bin/gcc 
CXXFLAGS :=  -O2 -Wall $(Preprocessors)
CFLAGS   :=  -O2 -std=gnu99 -U__STRICT_ANSI__ -DDONT_DO_LARGEFILE -DUSE_READER_THREAD -DSIM_ASYNCH_IO -DHAVE_PCREPOSIX_H -DHAVE_LIBPNG -DHAVE_GLOB -DHAVE_SLIRP_NETWORK -DUSE_SIMH_SLIRP_DEBUG -DUSE_DISPLAY -DVM_PDP11 -DHAVE_LIBSDL -DUSE_SIM_VIDEO -DSDL_MAIN_AVAILABLE -DHAVE_DLOPEN=so  $(Preprocessors)
ASFLAGS  := 
AS       := /usr/bin/as 


##
## User defined environment variables
##
CodeLiteDir:=/usr/share/codelite
Objects0=$(IntermediateDirectory)/scp.c$(ObjectSuffix) $(IntermediateDirectory)/sim_card.c$(ObjectSuffix) $(IntermediateDirectory)/sim_console.c$(ObjectSuffix) $(IntermediateDirectory)/sim_disk.c$(ObjectSuffix) $(IntermediateDirectory)/sim_ether.c$(ObjectSuffix) $(IntermediateDirectory)/sim_fio.c$(ObjectSuffix) $(IntermediateDirectory)/sim_frontpanel.c$(ObjectSuffix) $(IntermediateDirectory)/sim_imd.c$(ObjectSuffix) $(IntermediateDirectory)/sim_serial.c$(ObjectSuffix) $(IntermediateDirectory)/sim_sock.c$(ObjectSuffix) \
	$(IntermediateDirectory)/sim_tape.c$(ObjectSuffix) $(IntermediateDirectory)/sim_timer.c$(ObjectSuffix) $(IntermediateDirectory)/sim_tmxr.c$(ObjectSuffix) $(IntermediateDirectory)/sim_video_gt40.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_cis.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_cpu.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_cr.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_dc.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_dl.c$(ObjectSuffix) \
	$(IntermediateDirectory)/PDP11_pdp11_dmc.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_dup.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_dz.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_fp.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_hk.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_io.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_ke.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_kg.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_kmc.c$(ObjectSuffix) \
	$(IntermediateDirectory)/PDP11_pdp11_lk.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_lp.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_pclk.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_pt.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rc.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rf.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rh.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rk.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rl.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rp.c$(ObjectSuffix) \
	$(IntermediateDirectory)/PDP11_pdp11_rq.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rs.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_rx.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_ry.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_stddev.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_sys.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_ta.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_tc.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_td.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_tm.c$(ObjectSuffix) \
	$(IntermediateDirectory)/PDP11_pdp11_tq.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_ts.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_tu.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_vh.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_vt.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_xq.c$(ObjectSuffix) $(IntermediateDirectory)/PDP11_pdp11_xu.c$(ObjectSuffix) $(IntermediateDirectory)/display_display.c$(ObjectSuffix) $(IntermediateDirectory)/display_sim_ws.c$(ObjectSuffix) $(IntermediateDirectory)/display_vt11.c$(ObjectSuffix) \
	$(IntermediateDirectory)/PDP11_pdp11_rom.c$(ObjectSuffix) 



Objects=$(Objects0) 

##
## Main Build Targets 
##
.PHONY: all clean PreBuild PrePreBuild PostBuild
all: $(OutputFile)

$(OutputFile): $(IntermediateDirectory)/.d $(Objects) 
	@$(MakeDirCommand) $(@D)
	@echo "" > $(IntermediateDirectory)/.d
	@echo $(Objects0)  > $(ObjectsFileList)
	$(LinkerName) $(OutputSwitch)$(OutputFile) @$(ObjectsFileList) $(LibPath) $(Libs) $(LinkOptions)

PostBuild:
	@echo Executing Post Build commands ...
	@echo Done

$(IntermediateDirectory)/.d:
	@test -d ./BIN || $(MakeDirCommand) ./BIN

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/scp.c$(ObjectSuffix): scp.c $(IntermediateDirectory)/scp.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./scp.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/scp.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/scp.c$(DependSuffix): scp.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/scp.c$(ObjectSuffix) -MF$(IntermediateDirectory)/scp.c$(DependSuffix) -MM "scp.c"

$(IntermediateDirectory)/scp.c$(PreprocessSuffix): scp.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/scp.c$(PreprocessSuffix) "scp.c"

$(IntermediateDirectory)/sim_card.c$(ObjectSuffix): sim_card.c $(IntermediateDirectory)/sim_card.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_card.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_card.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_card.c$(DependSuffix): sim_card.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_card.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_card.c$(DependSuffix) -MM "sim_card.c"

$(IntermediateDirectory)/sim_card.c$(PreprocessSuffix): sim_card.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_card.c$(PreprocessSuffix) "sim_card.c"

$(IntermediateDirectory)/sim_console.c$(ObjectSuffix): sim_console.c $(IntermediateDirectory)/sim_console.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_console.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_console.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_console.c$(DependSuffix): sim_console.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_console.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_console.c$(DependSuffix) -MM "sim_console.c"

$(IntermediateDirectory)/sim_console.c$(PreprocessSuffix): sim_console.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_console.c$(PreprocessSuffix) "sim_console.c"

$(IntermediateDirectory)/sim_disk.c$(ObjectSuffix): sim_disk.c $(IntermediateDirectory)/sim_disk.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_disk.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_disk.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_disk.c$(DependSuffix): sim_disk.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_disk.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_disk.c$(DependSuffix) -MM "sim_disk.c"

$(IntermediateDirectory)/sim_disk.c$(PreprocessSuffix): sim_disk.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_disk.c$(PreprocessSuffix) "sim_disk.c"

$(IntermediateDirectory)/sim_ether.c$(ObjectSuffix): sim_ether.c $(IntermediateDirectory)/sim_ether.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_ether.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_ether.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_ether.c$(DependSuffix): sim_ether.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_ether.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_ether.c$(DependSuffix) -MM "sim_ether.c"

$(IntermediateDirectory)/sim_ether.c$(PreprocessSuffix): sim_ether.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_ether.c$(PreprocessSuffix) "sim_ether.c"

$(IntermediateDirectory)/sim_fio.c$(ObjectSuffix): sim_fio.c $(IntermediateDirectory)/sim_fio.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_fio.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_fio.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_fio.c$(DependSuffix): sim_fio.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_fio.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_fio.c$(DependSuffix) -MM "sim_fio.c"

$(IntermediateDirectory)/sim_fio.c$(PreprocessSuffix): sim_fio.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_fio.c$(PreprocessSuffix) "sim_fio.c"

$(IntermediateDirectory)/sim_frontpanel.c$(ObjectSuffix): sim_frontpanel.c $(IntermediateDirectory)/sim_frontpanel.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_frontpanel.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_frontpanel.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_frontpanel.c$(DependSuffix): sim_frontpanel.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_frontpanel.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_frontpanel.c$(DependSuffix) -MM "sim_frontpanel.c"

$(IntermediateDirectory)/sim_frontpanel.c$(PreprocessSuffix): sim_frontpanel.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_frontpanel.c$(PreprocessSuffix) "sim_frontpanel.c"

$(IntermediateDirectory)/sim_imd.c$(ObjectSuffix): sim_imd.c $(IntermediateDirectory)/sim_imd.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_imd.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_imd.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_imd.c$(DependSuffix): sim_imd.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_imd.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_imd.c$(DependSuffix) -MM "sim_imd.c"

$(IntermediateDirectory)/sim_imd.c$(PreprocessSuffix): sim_imd.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_imd.c$(PreprocessSuffix) "sim_imd.c"

$(IntermediateDirectory)/sim_serial.c$(ObjectSuffix): sim_serial.c $(IntermediateDirectory)/sim_serial.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_serial.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_serial.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_serial.c$(DependSuffix): sim_serial.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_serial.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_serial.c$(DependSuffix) -MM "sim_serial.c"

$(IntermediateDirectory)/sim_serial.c$(PreprocessSuffix): sim_serial.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_serial.c$(PreprocessSuffix) "sim_serial.c"

$(IntermediateDirectory)/sim_sock.c$(ObjectSuffix): sim_sock.c $(IntermediateDirectory)/sim_sock.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_sock.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_sock.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_sock.c$(DependSuffix): sim_sock.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_sock.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_sock.c$(DependSuffix) -MM "sim_sock.c"

$(IntermediateDirectory)/sim_sock.c$(PreprocessSuffix): sim_sock.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_sock.c$(PreprocessSuffix) "sim_sock.c"

$(IntermediateDirectory)/sim_tape.c$(ObjectSuffix): sim_tape.c $(IntermediateDirectory)/sim_tape.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_tape.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_tape.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_tape.c$(DependSuffix): sim_tape.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_tape.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_tape.c$(DependSuffix) -MM "sim_tape.c"

$(IntermediateDirectory)/sim_tape.c$(PreprocessSuffix): sim_tape.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_tape.c$(PreprocessSuffix) "sim_tape.c"

$(IntermediateDirectory)/sim_timer.c$(ObjectSuffix): sim_timer.c $(IntermediateDirectory)/sim_timer.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_timer.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_timer.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_timer.c$(DependSuffix): sim_timer.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_timer.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_timer.c$(DependSuffix) -MM "sim_timer.c"

$(IntermediateDirectory)/sim_timer.c$(PreprocessSuffix): sim_timer.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_timer.c$(PreprocessSuffix) "sim_timer.c"

$(IntermediateDirectory)/sim_tmxr.c$(ObjectSuffix): sim_tmxr.c $(IntermediateDirectory)/sim_tmxr.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_tmxr.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_tmxr.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_tmxr.c$(DependSuffix): sim_tmxr.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_tmxr.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_tmxr.c$(DependSuffix) -MM "sim_tmxr.c"

$(IntermediateDirectory)/sim_tmxr.c$(PreprocessSuffix): sim_tmxr.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_tmxr.c$(PreprocessSuffix) "sim_tmxr.c"

$(IntermediateDirectory)/sim_video_gt40.c$(ObjectSuffix): sim_video_gt40.c $(IntermediateDirectory)/sim_video_gt40.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./sim_video_gt40.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/sim_video_gt40.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sim_video_gt40.c$(DependSuffix): sim_video_gt40.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/sim_video_gt40.c$(ObjectSuffix) -MF$(IntermediateDirectory)/sim_video_gt40.c$(DependSuffix) -MM "sim_video_gt40.c"

$(IntermediateDirectory)/sim_video_gt40.c$(PreprocessSuffix): sim_video_gt40.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sim_video_gt40.c$(PreprocessSuffix) "sim_video_gt40.c"

$(IntermediateDirectory)/PDP11_pdp11_cis.c$(ObjectSuffix): PDP11/pdp11_cis.c $(IntermediateDirectory)/PDP11_pdp11_cis.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_cis.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_cis.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_cis.c$(DependSuffix): PDP11/pdp11_cis.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_cis.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_cis.c$(DependSuffix) -MM "PDP11/pdp11_cis.c"

$(IntermediateDirectory)/PDP11_pdp11_cis.c$(PreprocessSuffix): PDP11/pdp11_cis.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_cis.c$(PreprocessSuffix) "PDP11/pdp11_cis.c"

$(IntermediateDirectory)/PDP11_pdp11_cpu.c$(ObjectSuffix): PDP11/pdp11_cpu.c $(IntermediateDirectory)/PDP11_pdp11_cpu.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_cpu.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_cpu.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_cpu.c$(DependSuffix): PDP11/pdp11_cpu.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_cpu.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_cpu.c$(DependSuffix) -MM "PDP11/pdp11_cpu.c"

$(IntermediateDirectory)/PDP11_pdp11_cpu.c$(PreprocessSuffix): PDP11/pdp11_cpu.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_cpu.c$(PreprocessSuffix) "PDP11/pdp11_cpu.c"

$(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(ObjectSuffix): PDP11/pdp11_cpumod.c $(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_cpumod.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(DependSuffix): PDP11/pdp11_cpumod.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(DependSuffix) -MM "PDP11/pdp11_cpumod.c"

$(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(PreprocessSuffix): PDP11/pdp11_cpumod.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_cpumod.c$(PreprocessSuffix) "PDP11/pdp11_cpumod.c"

$(IntermediateDirectory)/PDP11_pdp11_cr.c$(ObjectSuffix): PDP11/pdp11_cr.c $(IntermediateDirectory)/PDP11_pdp11_cr.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_cr.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_cr.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_cr.c$(DependSuffix): PDP11/pdp11_cr.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_cr.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_cr.c$(DependSuffix) -MM "PDP11/pdp11_cr.c"

$(IntermediateDirectory)/PDP11_pdp11_cr.c$(PreprocessSuffix): PDP11/pdp11_cr.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_cr.c$(PreprocessSuffix) "PDP11/pdp11_cr.c"

$(IntermediateDirectory)/PDP11_pdp11_dc.c$(ObjectSuffix): PDP11/pdp11_dc.c $(IntermediateDirectory)/PDP11_pdp11_dc.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_dc.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_dc.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_dc.c$(DependSuffix): PDP11/pdp11_dc.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_dc.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_dc.c$(DependSuffix) -MM "PDP11/pdp11_dc.c"

$(IntermediateDirectory)/PDP11_pdp11_dc.c$(PreprocessSuffix): PDP11/pdp11_dc.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_dc.c$(PreprocessSuffix) "PDP11/pdp11_dc.c"

$(IntermediateDirectory)/PDP11_pdp11_dl.c$(ObjectSuffix): PDP11/pdp11_dl.c $(IntermediateDirectory)/PDP11_pdp11_dl.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_dl.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_dl.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_dl.c$(DependSuffix): PDP11/pdp11_dl.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_dl.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_dl.c$(DependSuffix) -MM "PDP11/pdp11_dl.c"

$(IntermediateDirectory)/PDP11_pdp11_dl.c$(PreprocessSuffix): PDP11/pdp11_dl.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_dl.c$(PreprocessSuffix) "PDP11/pdp11_dl.c"

$(IntermediateDirectory)/PDP11_pdp11_dmc.c$(ObjectSuffix): PDP11/pdp11_dmc.c $(IntermediateDirectory)/PDP11_pdp11_dmc.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_dmc.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_dmc.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_dmc.c$(DependSuffix): PDP11/pdp11_dmc.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_dmc.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_dmc.c$(DependSuffix) -MM "PDP11/pdp11_dmc.c"

$(IntermediateDirectory)/PDP11_pdp11_dmc.c$(PreprocessSuffix): PDP11/pdp11_dmc.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_dmc.c$(PreprocessSuffix) "PDP11/pdp11_dmc.c"

$(IntermediateDirectory)/PDP11_pdp11_dup.c$(ObjectSuffix): PDP11/pdp11_dup.c $(IntermediateDirectory)/PDP11_pdp11_dup.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_dup.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_dup.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_dup.c$(DependSuffix): PDP11/pdp11_dup.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_dup.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_dup.c$(DependSuffix) -MM "PDP11/pdp11_dup.c"

$(IntermediateDirectory)/PDP11_pdp11_dup.c$(PreprocessSuffix): PDP11/pdp11_dup.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_dup.c$(PreprocessSuffix) "PDP11/pdp11_dup.c"

$(IntermediateDirectory)/PDP11_pdp11_dz.c$(ObjectSuffix): PDP11/pdp11_dz.c $(IntermediateDirectory)/PDP11_pdp11_dz.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_dz.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_dz.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_dz.c$(DependSuffix): PDP11/pdp11_dz.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_dz.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_dz.c$(DependSuffix) -MM "PDP11/pdp11_dz.c"

$(IntermediateDirectory)/PDP11_pdp11_dz.c$(PreprocessSuffix): PDP11/pdp11_dz.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_dz.c$(PreprocessSuffix) "PDP11/pdp11_dz.c"

$(IntermediateDirectory)/PDP11_pdp11_fp.c$(ObjectSuffix): PDP11/pdp11_fp.c $(IntermediateDirectory)/PDP11_pdp11_fp.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_fp.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_fp.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_fp.c$(DependSuffix): PDP11/pdp11_fp.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_fp.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_fp.c$(DependSuffix) -MM "PDP11/pdp11_fp.c"

$(IntermediateDirectory)/PDP11_pdp11_fp.c$(PreprocessSuffix): PDP11/pdp11_fp.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_fp.c$(PreprocessSuffix) "PDP11/pdp11_fp.c"

$(IntermediateDirectory)/PDP11_pdp11_hk.c$(ObjectSuffix): PDP11/pdp11_hk.c $(IntermediateDirectory)/PDP11_pdp11_hk.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_hk.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_hk.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_hk.c$(DependSuffix): PDP11/pdp11_hk.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_hk.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_hk.c$(DependSuffix) -MM "PDP11/pdp11_hk.c"

$(IntermediateDirectory)/PDP11_pdp11_hk.c$(PreprocessSuffix): PDP11/pdp11_hk.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_hk.c$(PreprocessSuffix) "PDP11/pdp11_hk.c"

$(IntermediateDirectory)/PDP11_pdp11_io.c$(ObjectSuffix): PDP11/pdp11_io.c $(IntermediateDirectory)/PDP11_pdp11_io.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_io.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_io.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_io.c$(DependSuffix): PDP11/pdp11_io.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_io.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_io.c$(DependSuffix) -MM "PDP11/pdp11_io.c"

$(IntermediateDirectory)/PDP11_pdp11_io.c$(PreprocessSuffix): PDP11/pdp11_io.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_io.c$(PreprocessSuffix) "PDP11/pdp11_io.c"

$(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(ObjectSuffix): PDP11/pdp11_io_lib.c $(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_io_lib.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(DependSuffix): PDP11/pdp11_io_lib.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(DependSuffix) -MM "PDP11/pdp11_io_lib.c"

$(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(PreprocessSuffix): PDP11/pdp11_io_lib.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_io_lib.c$(PreprocessSuffix) "PDP11/pdp11_io_lib.c"

$(IntermediateDirectory)/PDP11_pdp11_ke.c$(ObjectSuffix): PDP11/pdp11_ke.c $(IntermediateDirectory)/PDP11_pdp11_ke.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_ke.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_ke.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_ke.c$(DependSuffix): PDP11/pdp11_ke.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_ke.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_ke.c$(DependSuffix) -MM "PDP11/pdp11_ke.c"

$(IntermediateDirectory)/PDP11_pdp11_ke.c$(PreprocessSuffix): PDP11/pdp11_ke.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_ke.c$(PreprocessSuffix) "PDP11/pdp11_ke.c"

$(IntermediateDirectory)/PDP11_pdp11_kg.c$(ObjectSuffix): PDP11/pdp11_kg.c $(IntermediateDirectory)/PDP11_pdp11_kg.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_kg.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_kg.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_kg.c$(DependSuffix): PDP11/pdp11_kg.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_kg.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_kg.c$(DependSuffix) -MM "PDP11/pdp11_kg.c"

$(IntermediateDirectory)/PDP11_pdp11_kg.c$(PreprocessSuffix): PDP11/pdp11_kg.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_kg.c$(PreprocessSuffix) "PDP11/pdp11_kg.c"

$(IntermediateDirectory)/PDP11_pdp11_kmc.c$(ObjectSuffix): PDP11/pdp11_kmc.c $(IntermediateDirectory)/PDP11_pdp11_kmc.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_kmc.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_kmc.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_kmc.c$(DependSuffix): PDP11/pdp11_kmc.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_kmc.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_kmc.c$(DependSuffix) -MM "PDP11/pdp11_kmc.c"

$(IntermediateDirectory)/PDP11_pdp11_kmc.c$(PreprocessSuffix): PDP11/pdp11_kmc.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_kmc.c$(PreprocessSuffix) "PDP11/pdp11_kmc.c"

$(IntermediateDirectory)/PDP11_pdp11_lk.c$(ObjectSuffix): PDP11/pdp11_lk.c $(IntermediateDirectory)/PDP11_pdp11_lk.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_lk.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_lk.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_lk.c$(DependSuffix): PDP11/pdp11_lk.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_lk.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_lk.c$(DependSuffix) -MM "PDP11/pdp11_lk.c"

$(IntermediateDirectory)/PDP11_pdp11_lk.c$(PreprocessSuffix): PDP11/pdp11_lk.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_lk.c$(PreprocessSuffix) "PDP11/pdp11_lk.c"

$(IntermediateDirectory)/PDP11_pdp11_lp.c$(ObjectSuffix): PDP11/pdp11_lp.c $(IntermediateDirectory)/PDP11_pdp11_lp.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_lp.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_lp.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_lp.c$(DependSuffix): PDP11/pdp11_lp.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_lp.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_lp.c$(DependSuffix) -MM "PDP11/pdp11_lp.c"

$(IntermediateDirectory)/PDP11_pdp11_lp.c$(PreprocessSuffix): PDP11/pdp11_lp.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_lp.c$(PreprocessSuffix) "PDP11/pdp11_lp.c"

$(IntermediateDirectory)/PDP11_pdp11_pclk.c$(ObjectSuffix): PDP11/pdp11_pclk.c $(IntermediateDirectory)/PDP11_pdp11_pclk.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_pclk.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_pclk.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_pclk.c$(DependSuffix): PDP11/pdp11_pclk.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_pclk.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_pclk.c$(DependSuffix) -MM "PDP11/pdp11_pclk.c"

$(IntermediateDirectory)/PDP11_pdp11_pclk.c$(PreprocessSuffix): PDP11/pdp11_pclk.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_pclk.c$(PreprocessSuffix) "PDP11/pdp11_pclk.c"

$(IntermediateDirectory)/PDP11_pdp11_pt.c$(ObjectSuffix): PDP11/pdp11_pt.c $(IntermediateDirectory)/PDP11_pdp11_pt.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_pt.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_pt.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_pt.c$(DependSuffix): PDP11/pdp11_pt.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_pt.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_pt.c$(DependSuffix) -MM "PDP11/pdp11_pt.c"

$(IntermediateDirectory)/PDP11_pdp11_pt.c$(PreprocessSuffix): PDP11/pdp11_pt.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_pt.c$(PreprocessSuffix) "PDP11/pdp11_pt.c"

$(IntermediateDirectory)/PDP11_pdp11_rc.c$(ObjectSuffix): PDP11/pdp11_rc.c $(IntermediateDirectory)/PDP11_pdp11_rc.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rc.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rc.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rc.c$(DependSuffix): PDP11/pdp11_rc.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rc.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rc.c$(DependSuffix) -MM "PDP11/pdp11_rc.c"

$(IntermediateDirectory)/PDP11_pdp11_rc.c$(PreprocessSuffix): PDP11/pdp11_rc.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rc.c$(PreprocessSuffix) "PDP11/pdp11_rc.c"

$(IntermediateDirectory)/PDP11_pdp11_rf.c$(ObjectSuffix): PDP11/pdp11_rf.c $(IntermediateDirectory)/PDP11_pdp11_rf.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rf.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rf.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rf.c$(DependSuffix): PDP11/pdp11_rf.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rf.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rf.c$(DependSuffix) -MM "PDP11/pdp11_rf.c"

$(IntermediateDirectory)/PDP11_pdp11_rf.c$(PreprocessSuffix): PDP11/pdp11_rf.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rf.c$(PreprocessSuffix) "PDP11/pdp11_rf.c"

$(IntermediateDirectory)/PDP11_pdp11_rh.c$(ObjectSuffix): PDP11/pdp11_rh.c $(IntermediateDirectory)/PDP11_pdp11_rh.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rh.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rh.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rh.c$(DependSuffix): PDP11/pdp11_rh.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rh.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rh.c$(DependSuffix) -MM "PDP11/pdp11_rh.c"

$(IntermediateDirectory)/PDP11_pdp11_rh.c$(PreprocessSuffix): PDP11/pdp11_rh.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rh.c$(PreprocessSuffix) "PDP11/pdp11_rh.c"

$(IntermediateDirectory)/PDP11_pdp11_rk.c$(ObjectSuffix): PDP11/pdp11_rk.c $(IntermediateDirectory)/PDP11_pdp11_rk.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rk.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rk.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rk.c$(DependSuffix): PDP11/pdp11_rk.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rk.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rk.c$(DependSuffix) -MM "PDP11/pdp11_rk.c"

$(IntermediateDirectory)/PDP11_pdp11_rk.c$(PreprocessSuffix): PDP11/pdp11_rk.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rk.c$(PreprocessSuffix) "PDP11/pdp11_rk.c"

$(IntermediateDirectory)/PDP11_pdp11_rl.c$(ObjectSuffix): PDP11/pdp11_rl.c $(IntermediateDirectory)/PDP11_pdp11_rl.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rl.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rl.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rl.c$(DependSuffix): PDP11/pdp11_rl.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rl.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rl.c$(DependSuffix) -MM "PDP11/pdp11_rl.c"

$(IntermediateDirectory)/PDP11_pdp11_rl.c$(PreprocessSuffix): PDP11/pdp11_rl.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rl.c$(PreprocessSuffix) "PDP11/pdp11_rl.c"

$(IntermediateDirectory)/PDP11_pdp11_rp.c$(ObjectSuffix): PDP11/pdp11_rp.c $(IntermediateDirectory)/PDP11_pdp11_rp.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rp.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rp.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rp.c$(DependSuffix): PDP11/pdp11_rp.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rp.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rp.c$(DependSuffix) -MM "PDP11/pdp11_rp.c"

$(IntermediateDirectory)/PDP11_pdp11_rp.c$(PreprocessSuffix): PDP11/pdp11_rp.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rp.c$(PreprocessSuffix) "PDP11/pdp11_rp.c"

$(IntermediateDirectory)/PDP11_pdp11_rq.c$(ObjectSuffix): PDP11/pdp11_rq.c $(IntermediateDirectory)/PDP11_pdp11_rq.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rq.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rq.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rq.c$(DependSuffix): PDP11/pdp11_rq.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rq.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rq.c$(DependSuffix) -MM "PDP11/pdp11_rq.c"

$(IntermediateDirectory)/PDP11_pdp11_rq.c$(PreprocessSuffix): PDP11/pdp11_rq.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rq.c$(PreprocessSuffix) "PDP11/pdp11_rq.c"

$(IntermediateDirectory)/PDP11_pdp11_rs.c$(ObjectSuffix): PDP11/pdp11_rs.c $(IntermediateDirectory)/PDP11_pdp11_rs.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rs.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rs.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rs.c$(DependSuffix): PDP11/pdp11_rs.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rs.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rs.c$(DependSuffix) -MM "PDP11/pdp11_rs.c"

$(IntermediateDirectory)/PDP11_pdp11_rs.c$(PreprocessSuffix): PDP11/pdp11_rs.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rs.c$(PreprocessSuffix) "PDP11/pdp11_rs.c"

$(IntermediateDirectory)/PDP11_pdp11_rx.c$(ObjectSuffix): PDP11/pdp11_rx.c $(IntermediateDirectory)/PDP11_pdp11_rx.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rx.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rx.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rx.c$(DependSuffix): PDP11/pdp11_rx.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rx.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rx.c$(DependSuffix) -MM "PDP11/pdp11_rx.c"

$(IntermediateDirectory)/PDP11_pdp11_rx.c$(PreprocessSuffix): PDP11/pdp11_rx.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rx.c$(PreprocessSuffix) "PDP11/pdp11_rx.c"

$(IntermediateDirectory)/PDP11_pdp11_ry.c$(ObjectSuffix): PDP11/pdp11_ry.c $(IntermediateDirectory)/PDP11_pdp11_ry.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_ry.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_ry.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_ry.c$(DependSuffix): PDP11/pdp11_ry.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_ry.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_ry.c$(DependSuffix) -MM "PDP11/pdp11_ry.c"

$(IntermediateDirectory)/PDP11_pdp11_ry.c$(PreprocessSuffix): PDP11/pdp11_ry.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_ry.c$(PreprocessSuffix) "PDP11/pdp11_ry.c"

$(IntermediateDirectory)/PDP11_pdp11_stddev.c$(ObjectSuffix): PDP11/pdp11_stddev.c $(IntermediateDirectory)/PDP11_pdp11_stddev.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_stddev.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_stddev.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_stddev.c$(DependSuffix): PDP11/pdp11_stddev.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_stddev.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_stddev.c$(DependSuffix) -MM "PDP11/pdp11_stddev.c"

$(IntermediateDirectory)/PDP11_pdp11_stddev.c$(PreprocessSuffix): PDP11/pdp11_stddev.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_stddev.c$(PreprocessSuffix) "PDP11/pdp11_stddev.c"

$(IntermediateDirectory)/PDP11_pdp11_sys.c$(ObjectSuffix): PDP11/pdp11_sys.c $(IntermediateDirectory)/PDP11_pdp11_sys.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_sys.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_sys.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_sys.c$(DependSuffix): PDP11/pdp11_sys.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_sys.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_sys.c$(DependSuffix) -MM "PDP11/pdp11_sys.c"

$(IntermediateDirectory)/PDP11_pdp11_sys.c$(PreprocessSuffix): PDP11/pdp11_sys.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_sys.c$(PreprocessSuffix) "PDP11/pdp11_sys.c"

$(IntermediateDirectory)/PDP11_pdp11_ta.c$(ObjectSuffix): PDP11/pdp11_ta.c $(IntermediateDirectory)/PDP11_pdp11_ta.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_ta.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_ta.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_ta.c$(DependSuffix): PDP11/pdp11_ta.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_ta.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_ta.c$(DependSuffix) -MM "PDP11/pdp11_ta.c"

$(IntermediateDirectory)/PDP11_pdp11_ta.c$(PreprocessSuffix): PDP11/pdp11_ta.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_ta.c$(PreprocessSuffix) "PDP11/pdp11_ta.c"

$(IntermediateDirectory)/PDP11_pdp11_tc.c$(ObjectSuffix): PDP11/pdp11_tc.c $(IntermediateDirectory)/PDP11_pdp11_tc.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_tc.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_tc.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_tc.c$(DependSuffix): PDP11/pdp11_tc.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_tc.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_tc.c$(DependSuffix) -MM "PDP11/pdp11_tc.c"

$(IntermediateDirectory)/PDP11_pdp11_tc.c$(PreprocessSuffix): PDP11/pdp11_tc.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_tc.c$(PreprocessSuffix) "PDP11/pdp11_tc.c"

$(IntermediateDirectory)/PDP11_pdp11_td.c$(ObjectSuffix): PDP11/pdp11_td.c $(IntermediateDirectory)/PDP11_pdp11_td.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_td.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_td.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_td.c$(DependSuffix): PDP11/pdp11_td.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_td.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_td.c$(DependSuffix) -MM "PDP11/pdp11_td.c"

$(IntermediateDirectory)/PDP11_pdp11_td.c$(PreprocessSuffix): PDP11/pdp11_td.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_td.c$(PreprocessSuffix) "PDP11/pdp11_td.c"

$(IntermediateDirectory)/PDP11_pdp11_tm.c$(ObjectSuffix): PDP11/pdp11_tm.c $(IntermediateDirectory)/PDP11_pdp11_tm.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_tm.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_tm.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_tm.c$(DependSuffix): PDP11/pdp11_tm.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_tm.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_tm.c$(DependSuffix) -MM "PDP11/pdp11_tm.c"

$(IntermediateDirectory)/PDP11_pdp11_tm.c$(PreprocessSuffix): PDP11/pdp11_tm.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_tm.c$(PreprocessSuffix) "PDP11/pdp11_tm.c"

$(IntermediateDirectory)/PDP11_pdp11_tq.c$(ObjectSuffix): PDP11/pdp11_tq.c $(IntermediateDirectory)/PDP11_pdp11_tq.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_tq.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_tq.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_tq.c$(DependSuffix): PDP11/pdp11_tq.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_tq.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_tq.c$(DependSuffix) -MM "PDP11/pdp11_tq.c"

$(IntermediateDirectory)/PDP11_pdp11_tq.c$(PreprocessSuffix): PDP11/pdp11_tq.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_tq.c$(PreprocessSuffix) "PDP11/pdp11_tq.c"

$(IntermediateDirectory)/PDP11_pdp11_ts.c$(ObjectSuffix): PDP11/pdp11_ts.c $(IntermediateDirectory)/PDP11_pdp11_ts.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_ts.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_ts.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_ts.c$(DependSuffix): PDP11/pdp11_ts.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_ts.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_ts.c$(DependSuffix) -MM "PDP11/pdp11_ts.c"

$(IntermediateDirectory)/PDP11_pdp11_ts.c$(PreprocessSuffix): PDP11/pdp11_ts.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_ts.c$(PreprocessSuffix) "PDP11/pdp11_ts.c"

$(IntermediateDirectory)/PDP11_pdp11_tu.c$(ObjectSuffix): PDP11/pdp11_tu.c $(IntermediateDirectory)/PDP11_pdp11_tu.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_tu.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_tu.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_tu.c$(DependSuffix): PDP11/pdp11_tu.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_tu.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_tu.c$(DependSuffix) -MM "PDP11/pdp11_tu.c"

$(IntermediateDirectory)/PDP11_pdp11_tu.c$(PreprocessSuffix): PDP11/pdp11_tu.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_tu.c$(PreprocessSuffix) "PDP11/pdp11_tu.c"

$(IntermediateDirectory)/PDP11_pdp11_vh.c$(ObjectSuffix): PDP11/pdp11_vh.c $(IntermediateDirectory)/PDP11_pdp11_vh.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_vh.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_vh.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_vh.c$(DependSuffix): PDP11/pdp11_vh.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_vh.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_vh.c$(DependSuffix) -MM "PDP11/pdp11_vh.c"

$(IntermediateDirectory)/PDP11_pdp11_vh.c$(PreprocessSuffix): PDP11/pdp11_vh.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_vh.c$(PreprocessSuffix) "PDP11/pdp11_vh.c"

$(IntermediateDirectory)/PDP11_pdp11_vt.c$(ObjectSuffix): PDP11/pdp11_vt.c $(IntermediateDirectory)/PDP11_pdp11_vt.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_vt.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_vt.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_vt.c$(DependSuffix): PDP11/pdp11_vt.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_vt.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_vt.c$(DependSuffix) -MM "PDP11/pdp11_vt.c"

$(IntermediateDirectory)/PDP11_pdp11_vt.c$(PreprocessSuffix): PDP11/pdp11_vt.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_vt.c$(PreprocessSuffix) "PDP11/pdp11_vt.c"

$(IntermediateDirectory)/PDP11_pdp11_xq.c$(ObjectSuffix): PDP11/pdp11_xq.c $(IntermediateDirectory)/PDP11_pdp11_xq.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_xq.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_xq.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_xq.c$(DependSuffix): PDP11/pdp11_xq.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_xq.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_xq.c$(DependSuffix) -MM "PDP11/pdp11_xq.c"

$(IntermediateDirectory)/PDP11_pdp11_xq.c$(PreprocessSuffix): PDP11/pdp11_xq.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_xq.c$(PreprocessSuffix) "PDP11/pdp11_xq.c"

$(IntermediateDirectory)/PDP11_pdp11_xu.c$(ObjectSuffix): PDP11/pdp11_xu.c $(IntermediateDirectory)/PDP11_pdp11_xu.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_xu.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_xu.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_xu.c$(DependSuffix): PDP11/pdp11_xu.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_xu.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_xu.c$(DependSuffix) -MM "PDP11/pdp11_xu.c"

$(IntermediateDirectory)/PDP11_pdp11_xu.c$(PreprocessSuffix): PDP11/pdp11_xu.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_xu.c$(PreprocessSuffix) "PDP11/pdp11_xu.c"

$(IntermediateDirectory)/display_display.c$(ObjectSuffix): display/display.c $(IntermediateDirectory)/display_display.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./display/display.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/display_display.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/display_display.c$(DependSuffix): display/display.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/display_display.c$(ObjectSuffix) -MF$(IntermediateDirectory)/display_display.c$(DependSuffix) -MM "display/display.c"

$(IntermediateDirectory)/display_display.c$(PreprocessSuffix): display/display.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/display_display.c$(PreprocessSuffix) "display/display.c"

$(IntermediateDirectory)/display_sim_ws.c$(ObjectSuffix): display/sim_ws.c $(IntermediateDirectory)/display_sim_ws.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./display/sim_ws.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/display_sim_ws.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/display_sim_ws.c$(DependSuffix): display/sim_ws.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/display_sim_ws.c$(ObjectSuffix) -MF$(IntermediateDirectory)/display_sim_ws.c$(DependSuffix) -MM "display/sim_ws.c"

$(IntermediateDirectory)/display_sim_ws.c$(PreprocessSuffix): display/sim_ws.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/display_sim_ws.c$(PreprocessSuffix) "display/sim_ws.c"

$(IntermediateDirectory)/display_vt11.c$(ObjectSuffix): display/vt11.c $(IntermediateDirectory)/display_vt11.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./display/vt11.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/display_vt11.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/display_vt11.c$(DependSuffix): display/vt11.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/display_vt11.c$(ObjectSuffix) -MF$(IntermediateDirectory)/display_vt11.c$(DependSuffix) -MM "display/vt11.c"

$(IntermediateDirectory)/display_vt11.c$(PreprocessSuffix): display/vt11.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/display_vt11.c$(PreprocessSuffix) "display/vt11.c"

$(IntermediateDirectory)/PDP11_pdp11_rom.c$(ObjectSuffix): PDP11/pdp11_rom.c $(IntermediateDirectory)/PDP11_pdp11_rom.c$(DependSuffix)
	$(CC) $(SourceSwitch) "./PDP11/pdp11_rom.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/PDP11_pdp11_rom.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/PDP11_pdp11_rom.c$(DependSuffix): PDP11/pdp11_rom.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/PDP11_pdp11_rom.c$(ObjectSuffix) -MF$(IntermediateDirectory)/PDP11_pdp11_rom.c$(DependSuffix) -MM "PDP11/pdp11_rom.c"

$(IntermediateDirectory)/PDP11_pdp11_rom.c$(PreprocessSuffix): PDP11/pdp11_rom.c
	@$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/PDP11_pdp11_rom.c$(PreprocessSuffix) "PDP11/pdp11_rom.c"


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) ./BIN/*$(ObjectSuffix)
	$(RM) ./BIN/*$(DependSuffix)
	$(RM) $(OutputFile)
	$(RM) ".build-release/GT40"



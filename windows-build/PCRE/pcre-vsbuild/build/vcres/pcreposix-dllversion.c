/* Sed: http://msdn.microsoft.com/library/en-us/shellcc/platform/shell/programmersguide/versions.asp */
#include <windows.h>
#include <shlwapi.h>
#include <pcre.h>
#include <stdio.h>
#ifdef __cplusplus
extern "C" {
#endif
__declspec(dllexport) HRESULT DllGetVersion (DLLVERSIONINFO2 *pdvi);
#ifdef __cplusplus
}
#endif

#define STRING(a)  # a
#define XSTRING(s) STRING(s)

HRESULT DllGetVersion (DLLVERSIONINFO2 *pdvi)
{
    char pcre_date[] = XSTRING(PCRE_DATE);
    int year, month, day;

    if ( !pdvi || (pdvi->info1.cbSize != sizeof (*pdvi)) )
		return (E_INVALIDARG);
	pdvi->info1.dwMajorVersion = PCRE_MAJOR;
	pdvi->info1.dwMinorVersion = PCRE_MINOR;
    sscanf (pcre_date, "%d-%d-%d", &year, &month, &day);
	pdvi->info1.dwBuildNumber = year*10000+month*100+day; /* Produce YYYYMMDD */
	pdvi->info1.dwPlatformID = DLLVER_PLATFORM_WINDOWS;
	if (pdvi->info1.cbSize == sizeof (DLLVERSIONINFO2))
		pdvi->ullVersion = MAKEDLLVERULL (PCRE_MAJOR, PCRE_MINOR, ((year%100)*10000+month*100+day), 0);
	return S_OK;
}

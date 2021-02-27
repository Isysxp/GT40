The visual studio build components contained here started from the 
projects contributed to the PCRE project by Vincent Richomme 
(Email local part: richom.v, Email domain: free.fr) and found at:

ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/Contrib/pcre-vsbuild.zip

Parts of these seemed to have been working with version 7.8 of PCRE 
and used pieces of the Win32 PCRE package found at: 

http://gnuwin32.sourceforge.net/packages/pcre.htm

I have updated the VS2008 projects to build the PCRE vesion 8.36 
binaries and added new project definitions to produce static libraries 
and statically built pcregrep and pcretest.

I have removed the VS2005 projects since they haven't been updated to 
the same functionality as the VS2008 projects.
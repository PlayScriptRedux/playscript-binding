SUBDIRS = .

include $(top_srcdir)/xbuild.include

TESTFILES =  

TESTDLLS = \
	$(NUNIT_LIBS)

TESTASSEMBLY = $(top_builddir)/build/bin/ICSharpCode.NRefactory.PlayScript.Test.dll

$(TESTASSEMBLY) : $(build_test_sources) $(build_resources)
	$(CSC) $(CSC_FLAGS) -debug "-define:GMCS_SOURCE;NET_2_0;MS_COMPATIBLE;FULL_AST;BOOTSTRAP_BASIC" -unsafe  -codepage:utf8 -out:$@ -target:library $(DLLS) $(TESTDLLS) $(REFS) /r:$(ASSEMBLY) \
	$(monodoc_libflags) $(build_resources:%=/resource:%) $(build_test_sources)

CLEANFILES = $(PARSE) $(PARSE).mdb

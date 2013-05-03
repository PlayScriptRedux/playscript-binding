echo "Updates the patch files applied to the .csproj projects to make them point to MonoDevelop .dll assemblies."

diff -u ../playscript-monodevelop/main/src/addins/ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.PlayScript.csproj ./ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.PlayScript.csproj > ICSharpCode.NRefactory.PlayScript.csproj.patch
diff -u ../playscript-monodevelop/main/src/addins/PlayScriptBinding/PlayScriptBinding.csproj ./PlayScriptBinding/PlayScriptBinding.csproj > PlayScriptBinding.csproj.patch

echo "Patch files created."

echo "Creating patch files PlayScriptBinding.patch and ICSharpCode.NRefactory.PlayScript.patch from CSharp projects..."

# ------------  PlayScriptBinding --------------

rm PlayScriptBinding.patch
rm ICSharpCode.NRefactory.PlayScript.patch

rm -rf ../CSharpBinding/obj
rm -rf ../CSharpBinding/Makefile
rm -rf ../CSharpBinding/AspNet/obj
rm -rf ../CSharpBinding/AspNet/Makefile
rm -rf ../CSharpBinding/Autotools/obj
rm -rf ../CSharpBinding/Autotools/Makefile

rm -rf ../PlayScriptBinding/obj
rm -rf ../PlayScriptBinding/Makefile
rm -rf ../PlayScriptBinding/AspNet/obj
rm -rf ../PlayScriptBinding/AspNet/Makefile
rm -rf ../PlayScriptBinding/Autotools/obj
rm -rf ../PlayScriptBinding/Autotools/Makefile

# Change names of project and plugin back to C#
mv ../PlayScriptBinding/PlayScriptBinding.csproj ../PlayScriptBinding/CSharpBinding.csproj
mv ../PlayScriptBinding/PlayScriptBinding.addin.xml ../PlayScriptBinding/CSharpBinding.addin.xml

# Copy language binding files for PlayScript
cp ../CSharpBinding/MonoDevelop.CSharp/CSharpLanguageBinding.cs ../CSharpBinding/MonoDevelop.CSharp/ActionScriptLanguageBinding.cs
cp ../CSharpBinding/MonoDevelop.CSharp/CSharpLanguageBinding.cs ../CSharpBinding/MonoDevelop.CSharp/PlayScriptLanguageBinding.cs

# Generate patch
find ../PlaySCriptBinding -exec touch {} \;
pushd ../../../..
diff -rupN -x '.DS_Store' -x '*.png' -x '*.FileIcon' -x '*.in' ./main/src/addins/CSharpBinding/ ./main/src/addins/PlayScriptBinding/ > ./main/src/addins/PlayScriptPatches/PlayScriptBinding.patch
popd

# Restore project and plugin names
mv ../PlayScriptBinding/CSharpBinding.csproj ../PlayScriptBinding/PlayScriptBinding.csproj
mv ../PlayScriptBinding/CSharpBinding.addin.xml ../PlayScriptBinding/PlayScriptBinding.addin.xml

# Remove language binding files for PlayScript
rm ../CSharpBinding/MonoDevelop.CSharp/ActionScriptLanguageBinding.cs
rm ../CSharpBinding/MonoDevelop.CSharp/PlayScriptLanguageBinding.cs

# ------------  NRefactory --------------

# Change names of project to C#
mv ../ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.PlayScript.csproj ../ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.CSharp.csproj

# Make patch of NRefactory.CSharp
find ../ICSharpCode.NRefactory.PlayScript -exec touch {} \;
pushd ../../../..
diff -rupN -x '.DS_Store' -x '*.snk' ./main/external/nrefactory/ICSharpCode.NRefactory.CSharp/ ./main/src/addins/ICSharpCode.NRefactory.PlayScript/ > ./main/src/addins/PlayScriptPatches/ICSharpCode.NRefactory.PlayScript.patch
popd

# Restore project names
mv ../ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.CSharp.csproj ../ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.PlayScript.csproj

echo "Done creating patch files."


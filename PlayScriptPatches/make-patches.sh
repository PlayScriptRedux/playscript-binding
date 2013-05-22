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

# Copy syntax mode files for PlayScript
rm -rf ../CSharpBinding/SyntaxMode
mkdir ../CSharpBinding/SyntaxMode
cp ../../core/Mono.Texteditor/SyntaxModes/CSharpSyntaxMode.xml ../CSharpBinding/SyntaxMode/ActionScriptSyntaxMode.xml
cp ../../core/Mono.Texteditor/SyntaxModes/CSharpSyntaxMode.xml ../CSharpBinding/SyntaxMode/PlayScriptSyntaxMode.xml

# Change names of all the policy XML files
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsAllmanCSharpPolicy.xml        ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/AllmanCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsGNUCSharpPolicy.xml           ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/GNUCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsGNUTextStylePolicy.xml        ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/GNUTextStylePolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsInvariantTextStylePolicy.xml  ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/InvariantTextStylePolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsKRCSharpPolicy.xml            ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/KRCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsMonoCSharpPolicy.xml          ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/MonoCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsSharpDevelopCSharpPolicy.xml  ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/SharpDevelopCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsWhitesmithsCSharpPolicy.xml   ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/WhitesmithsCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Refactoring.CodeIssues/NamingInspection/PsMonoNameConventionPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Refactoring.CodeIssues/NamingInspection/MonoNameConventionPolicy.xml


# Generate patch
find ../PlaySCriptBinding -exec touch {} \;
pushd ../../../..
diff -rupN -x '.DS_Store' -x '*.png' -x '*.FileIcon' -x '*.in' ./main/src/addins/CSharpBinding/ ./main/src/addins/PlayScriptBinding/ > ./main/src/addins/PlayScriptPatches/PlayScriptBinding.patch
popd

# Restore project and plugin names
mv ../PlayScriptBinding/CSharpBinding.csproj ../PlayScriptBinding/PlayScriptBinding.csproj
mv ../PlayScriptBinding/CSharpBinding.addin.xml ../PlayScriptBinding/PlayScriptBinding.addin.xml

# Restore names for policy XML files
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/AllmanCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsAllmanCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/GNUCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsGNUCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/GNUTextStylePolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsGNUTextStylePolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/InvariantTextStylePolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsInvariantTextStylePolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/KRCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsKRCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/MonoCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsMonoCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/SharpDevelopCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsSharpDevelopCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/WhitesmithsCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsWhitesmithsCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Refactoring.CodeIssues/NamingInspection/MonoNameConventionPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Refactoring.CodeIssues/NamingInspection/PsMonoNameConventionPolicy.xml

# Remove language binding files for PlayScript
rm ../CSharpBinding/MonoDevelop.CSharp/ActionScriptLanguageBinding.cs
rm ../CSharpBinding/MonoDevelop.CSharp/PlayScriptLanguageBinding.cs

# Remove syntax mode files for PlayScript
rm -rf ../CSharpBinding/SyntaxMode

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


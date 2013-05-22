echo "Applying patch files PlayScriptBinding.patch and ICSharpCode.NRefactory.PlayScript.patch to CSharp projects..."

# ------------  PlayScriptBinding --------------

rm ../CSharpBinding/.DS_Store
rm -rf ../CSharpBinding/obj
rm -rf ../CSharpBinding/Makefile
rm -rf ../CSharpBinding/AspNet/obj
rm -rf ../CSharpBinding/AspNet/Makefile
rm -rf ../CSharpBinding/Autotools/obj
rm -rf ../CSharpBinding/Autotools/Makefile

# Copy language binding files for PlayScript
cp ../CSharpBinding/MonoDevelop.CSharp/CSharpLanguageBinding.cs ../CSharpBinding/MonoDevelop.CSharp/ActionScriptLanguageBinding.cs
cp ../CSharpBinding/MonoDevelop.CSharp/CSharpLanguageBinding.cs ../CSharpBinding/MonoDevelop.CSharp/PlayScriptLanguageBinding.cs

# Copy syntax mode files for PlayScript
rm -rf ../CSharpBinding/SyntaxMode
mkdir ../CSharpBinding/SyntaxMode
cp ../../core/Mono.Texteditor/SyntaxModes/CSharpSyntaxMode.xml ../CSharpBinding/SyntaxMode/ActionScriptSyntaxMode.xml
cp ../../core/Mono.Texteditor/SyntaxModes/CSharpSyntaxMode.xml ../CSharpBinding/SyntaxMode/PlayScriptSyntaxMode.xml

# Make the new PlayScriptBinding folder
mv ../PlayScriptBinding ../PlayScriptBinding_save
cp -R ../CSharpBinding ../PlayScriptBinding/

# Apply patch
pushd ../../../..
patch -p0 -u < ./main/src/addins/PlayScriptPatches/PlayScriptBinding.patch
popd

# For some reason this patch is always applied reverse, just swap the folders.
mv ../CSharpBinding ../CSharpBinding_xxx
mv ../PlayScriptBinding ../CSharpBinding
mv ../CSharpBinding_xxx ../PlayScriptBinding

# Restore project and plugin names
mv ../PlayScriptBinding/CSharpBinding.csproj ../PlayScriptBinding/PlayScriptBinding.csproj
mv ../PlayScriptBinding/CSharpBinding.addin.xml ../PlayScriptBinding/PlayScriptBinding.addin.xml

# Remove language binding files for PlayScript
rm ../CSharpBinding/MonoDevelop.CSharp/ActionScriptLanguageBinding.cs
rm ../CSharpBinding/MonoDevelop.CSharp/PlayScriptLanguageBinding.cs

# Remove syntax mode files for PlayScript
rm -rf ../CSharpBinding/SyntaxMode

# Restore names for policy XML files
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/AllmapCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsAllmapCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/GNUCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsGNUCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/GNUTextStylePolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsGNUTextStylePolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/InvariantTextStylePolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsInvariantTextStylePolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/KRCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsKRCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/MonoCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsMonoCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/SharpDevelopCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsSharpDevelopCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/WhitesmithsCSharpPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Formatting/policies/PsWhitesmithsCSharpPolicy.xml
mv ../PlayScriptBinding/MonoDevelop.CSharp.Refactoring.CodeIssues/NamingInspection/MonoNameConventionPolicy.xml ../PlayScriptBinding/MonoDevelop.CSharp.Refactoring.CodeIssues/NamingInspection/PsMonoNameConventionPolicy.xml

# Restore missing files
git checkout ../PlayScriptBinding/icons

# ------------  NRefactory --------------

rm -rf ../CSharpBinding/Autotools/Makefile
rm -rf ../../../external/nrefactory/ICSharpCode.NRefactory.CSharp/obj

mv ../ICSharpCode.NRefactory.PlayScript ../ICSharpCode.NRefactory.PlayScript_save
cp -R ../../../external/nrefactory/ICSharpCode.NRefactory.CSharp ../ICSharpCode.NRefactory.PlayScript/

# Make patch of NRefactory.CSharp
pushd ../../../..
patch -p0 -u < ./main/src/addins/PlayScriptPatches/ICSharpCode.NRefactory.PlayScript.patch
popd

# Restore project names
mv ../ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.CSharp.csproj ../ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.PlayScript.csproj

# Restore missing files
git checkout ../ICSharpCode.NRefactory.PlayScript/ICSharpCode.NRefactory.snk
git checkout ../ICSharpCode.NRefactory.PlayScript/Parser/mcs/build-psparser.sh

echo "Done applying patch files."


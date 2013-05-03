echo "Updating the PlayScript binding by copying binding files from the playscript-monodevelop fork"

echo "--- Copying folders from ../playscript-monodevelop/main/src/addins"

rm -rf ICSharpCode.NRefactory.PlayScript
rm -rf PlayScriptBinding
rm -rf PlayScriptPatches

cp -R ../playscript-monodevelop/main/src/addins/ICSharpCode.NRefactory.PlayScript .
cp -R ../playscript-monodevelop/main/src/addins/PlayScriptBinding .
cp -R ../playscript-monodevelop/main/src/addins/PlayScriptPatches .

echo "--- Patching references in project files"

patch -p0 -u < ./ICSharpCode.NRefactory.PlayScript.csproj.patch
patch -p0 -u < ./PlayScriptBinding.csproj.patch

echo "All PlayScript binding folders updated and projects patched."

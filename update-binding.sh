echo "Updating the PlayScript binding by copying binding files from the playscript-monodevelop fork"

rm -rf ICSharpCode.NRefactory.PlayScript
rm -rf PlayScriptBinding
rm -rf PlayScriptPatches

cp -R ../playscript-monodevelop/main/src/addins/ICSharpCode.NRefactory.PlayScript .
cp -R ../playscript-monodevelop/main/src/addins/PlayScriptBinding .
cp -R ../playscript-monodevelop/main/src/addins/PlayScriptPatches .

echo "All PlayScript binding folders updated."

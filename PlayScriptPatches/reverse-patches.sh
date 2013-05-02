echo "Reversing patch"
rm -rf ../CSharpBinding
git checkout ../CSharpBinding
rm -rf ../PlayScriptBinding
git checkout ../PlayScriptBinding
rm -rf ../PlayScriptBinding_save
rm -rf ../ICSharpCode.NRefactory.PlayScript
git checkout ../ICSharpCode.NRefactory.PlayScript
rm -rf ../ICSharpCode.NRefactory.PlayScript_save
echo "Done reversing patches."

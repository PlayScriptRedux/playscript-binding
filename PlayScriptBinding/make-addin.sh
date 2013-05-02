# Builds the MD addin for the PlayScript binding
echo "Building the playscript addin and placing in obj/PlayScriptBinding.mpack"
if [ ! -d "./obj" ]; then
  mkdir ./obj
fi
if [ -d "./obj/PlayScriptBinding.mpack.image" ]; then
  rm -rf ./obj/PlayScriptBinding.mpack.image
fi
mkdir ./obj/PlayScriptBinding.mpack.image
cp ../../../build/AddIns/BackendBindings/ICSharpCode.NRefactory.PlayScript.dll ./obj/PlayScriptBinding.mpack.image
cp ../../../build/AddIns/BackendBindings/MonoDevelop.PlayScriptBinding.dll ./obj/PlayScriptBinding.mpack.image
cp ./addin.info ./obj/PlayScriptBinding.mpack.image
rm ./obj/PlayScriptBinding.mpack.zip
zip -j ./obj/PlayScriptBinding.mpack.zip ./obj/PlayScriptBinding.mpack.image/*
cp ./obj/PlayScriptBinding.mpack.zip ./obj/PlayScriptBinding.mpack
echo "Finished creating /obj/PlayScriptBinding.mpack MonoDevelop addin."

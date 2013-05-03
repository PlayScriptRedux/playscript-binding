# Builds the MD addin for the PlayScript binding
echo "Building the playscript addin and placing in obj/PlayScriptBinding.mpack"
OBJ=./obj
IMAGE=$OBJ/PlayScriptBinding.mpack.image
BUILD="../../../build"
SRC="../../../../../playscript-mono"
INST="../../../../../playscript-mono-inst"
if [ ! -d "$OBJ" ]; then
  mkdir $OBJ
fi
if [ -d "$OBJ/PlayScriptBinding.mpack.image" ]; then
  rm -rf $OBJ/PlayScriptBinding.mpack.image
fi
mkdir $OBJ/PlayScriptBinding.mpack.image
cp $BUILD/AddIns/BackendBindings/ICSharpCode.NRefactory.PlayScript.dll $IMAGE
cp $BUILD/AddIns/BackendBindings/MonoDevelop.PlayScriptBinding.dll $IMAGE
cp $BUILD/AddIns/BackendBindings/MonoDevelop.PlayScriptBinding.dll $IMAGE
cp $INST/lib/mono/4.0/pscorlib.dll $IMAGE
cp $INST/lib/mono/4.0/pscorlib_aot.dll $IMAGE
cp $INST/lib/mono/4.0/PlayScript.Dynamic.dll $IMAGE
cp $INST/lib/mono/4.0/PlayScript.Dynamic_aot.dll $IMAGE
cp $INST/lib/mono/4.5/mcs.exe $IMAGE/playc.exe
cp $SRC/playscript/template_osx/bin/playc $IMAGE
cp ./addin.info $IMAGE
rm $OBJ/PlayScriptBinding.mpack.zip
zip -j $OBJ/PlayScriptBinding.mpack.zip $OBJ/PlayScriptBinding.mpack.image/*
cp $OBJ/PlayScriptBinding.mpack.zip $OBJ/PlayScriptBinding.mpack
echo "Finished creating /obj/PlayScriptBinding.mpack MonoDevelop addin."

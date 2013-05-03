echo "Build script which rebuilds the binding .dll files, then runs mpack to test packing the binding"

echo "Rebuilding the binding .dll files"

xbuild PlayScriptBinding.sln /property:Configuration=Debug

# Builds the MD addin for the PlayScript binding
echo "Copying all additional files and building the PlayScriptBinding.mpack file in the addin-build folder"

BUILD="./addin-build"
SRC="../playscript-mono"
INST="../playscript-mono-inst"

cp $INST/lib/mono/4.0/pscorlib.dll $BUILD
cp $INST/lib/mono/4.0/pscorlib_aot.dll $BUILD
cp $INST/lib/mono/4.0/PlayScript.Dynamic.dll $BUILD
cp $INST/lib/mono/4.0/PlayScript.Dynamic_aot.dll $BUILD
cp $INST/lib/mono/4.0/Mono.PlayScript.dll $BUILD
cp $INST/lib/mono/4.5/mcs.exe $BUILD/playc.exe
cp ../package-osx/template_osx/bin/playc $BUILD
cp ./PlayScriptBinding/addin.info $BUILD
pushd $BUILD
/Applications/Xamarin\ Studio.app/Contents/MacOS/mdtool setup pack addin.info
popd

echo "Build complete - PlayScriptBinding.mpack in addin."

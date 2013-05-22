echo "Updating dependencies from monodevelop install in /Applications/Xamarin Studio.app"

SRC_FOLDER=/Applications/Xamarin\ Studio/Contents/MacOS/lib/monodevelop

rm -rf dependencies
mkdir dependencies
cp -r /Applications/Xamarin\ Studio.app/Contents/MacOS/lib/monodevelop dependencies

echo "Finished copying dependencies"

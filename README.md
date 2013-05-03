PlayScript MonoDevelop Binding
==============================

This repository contains the binding projects and manifest required by the MonoDevelop AddIns repository to build and deploy the PlayScript binding for MonoDevelop and Xamarin Studio.

It's assumed that this repository is used as a submodule of the "playscript-dist" repository, which includes submodules for all other playscript build components (MonoDevelop, Mono, etc.).

Since the PlayScript binding is merely a patch of the CSharp binding, this repository is actually a copy of the current /main/src/addins/PlayScriptBinding and /main/src/addins/ICSharpCode.NRefactory.PlayScript 
project folders in the "playscript-monodevelop" fork.   These folders themselves are created/updated by applying the patches in /main/src/addins/PlayScriptPatches to the CSharp binding in MonoDevelop.  In this
way, the PlayScriptBinding is always kept in perfect sync with the current feature set and capabilities of the C# binding as changes are made to the IDE.

The folders are:

PlayScriptBinding - The copy of the playscript-monodevelop /main/src/addins/PlayScriptBinding with patches applied to update the MonoDevelop dll references.
ICSharpCode.NRefactory.PlayScript - The copy of the playscript-monodevelop /main/src/addins/ICSharpCode.NRefactory.PlayScript with patches applied to update the MonoDevelop dll references.
PlayScriptPatches - An archive copy of the playscript-monodevelop /main/src/addins/PlayScriptPatches folder which hold the current patches to the CSharpBinding and the scripts which update, apply and revert the patches.

The scripts are:

update-binding.sh - Copies the current binding projects from the ../playscript-monodevelop submodule folder in the parent folder (we assume we're running from the playscript-dist folder).
update-project-patches.sh - Updates the project patches from the current projects in this folder (these are applied every time update-bindings.sh are run to fix the project references and ouput folder).
rebuild-binding.sh - Runs xbuild to rebuild the binding solution, copies the various sidecar files (compiler, dlls, etc) to the addin-build folder, then runs a test build with mdtool setup pack to test building the addin (in case there are missing files).



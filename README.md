# Snailiad Mod Archive
Welcome to the Snailiad Mod Archive, a collection of various mods and old versions of the 2011 Flash game [Snailiad](https://www.snailiad.com/)!  
The intent of this repository is to provide an easily accessible way of seeing what was changed in different mods and versions, or to let people easily obtain various 
assets from a mod(including those that aren't present in the .swf directly, like the map file).  
If you want a mod added or removed, or have any other questions or suggestions, contact me on Discord at Dimuslv#2635.
# Navigating the repository
There are two ways in which you can access the mods: through **pull requests** or through **branches**.  
## Pull requests  
**Pull requests** are better for seeing the changes made in each mod because
they have more advanced filtering options, such as filtering changes by file type, which let you filter out potentially unwanted changes like the p-codes.  
Pull requests also only show the commits made in the specific mod, not including commits made in the version of the game the mod was based on prior to the mod,
which oftentimes is better than the alternative.  
To find a mod through pull requests, go to the [main page](https://github.com/dimuslv/Snailiad-Mod-Archive), press
the [Pull requests](https://github.com/dimuslv/Snailiad-Mod-Archive/pulls) button at the top, find a mod you
want to check out, click on the mod, click on "Commits" right below the title, choose and click on one of the specific versions of the mod and see the changes.
If you want to filter out files by extension, you can do it from the "File filter" button near the top.  
## Branches  
**Branches** are ideal for obtaining various assets from a specific mod. You can also view changes made in a mod through branches, but here you won't have the
option to filter files, so it's better to do that through pull requests.  
Please note that through branches, you will see all commits from the first version of Snailiad up to the mod, which can be useful in some cases, like for seeing
which version of the game the mod was based on, while confusing in others.  
To find a mod through branches, go to the [main page](https://github.com/dimuslv/Snailiad-Mod-Archive),
click on the [branches](https://github.com/dimuslv/Snailiad-Mod-Archive/branches) button near the top,
select [All branches](https://github.com/dimuslv/Snailiad-Mod-Archive/branches/all) and then choose and click on a mod you'd like to examine. From there, you
can browse the files of the latest version of the mod, or click on "commits" on the top right corner to check out the changes made in any version.  
If you want to get the files of an earlier version, simply choose that version from the commits and press the "Browse files" button on top right.  
# Sources of the .swf files  
All the mod .swf files were obtained from the [public Snailiad Discord server](https://discord.gg/pCYNfmDCZQ), including mods I made myself. However, this
repository contains not only Snailiad mods – it also has several old versions of the original game. Basically, one night at like 1am I decided it was a good idea
to just search "Snailiad" on the internet, go through all the random sites where the game was hosted, try to find the source .swf file, which most of the time
involved some page inspect search stuff, download the .swf file and categorize it by the date it was made in, which can be found in the .swf file. This resulted in
me finding nine different Snailiad versions – six "normal ones", two which included code for Kongregate(note that I didn't actually find the .swf file
on Kongregate itself) and one for Armorgames.  
Why didn't I ask for old versions from Auriplane herself? The answer is twofold. First of all, I didn't want to bother her. Secondly, I wanted this repository to only
include public mods and versions, as hosting secretly obtained files that might have never been public before would have been a bit weird.  
# The obtaining of the contents  
How did I export all the assets? The majority of the work was done by the [FFDec](https://github.com/jindrapetrik/jpexs-decompiler) asset export feature.
Opening .swf files in FFDec every time to export their contents would be a bit exhausting though, but luckily, FFDec has commandline support, which is what
I used for this project.  
However, it wasn't as simple as just exporting assets with FFDec. Firstly, I realized that FFDec didn't export a few mostly metadata-related files, changes in
which can be important sometimes. Luckily, these files are included in the xml file that FFDec produces from its "swf to xml" function. However, this file
also contains all the information about the rest of the assets in a bloated and inaccessible format, taking up a lot of space and duplicate changes,
so I switched from command prompt to Powershell so I could edit the xml and delete all the binary and code-related data after each export.  
Another problem I had was that font files showed changes after each export, even when nothing was changed in them – as it turns out, FFDec likes to set the
"time created" and "time modified" variables of the font files to like 17 days before the export, thus making them change every time(I'm pretty sure the .swf
files themselves have no information about these properties). To fix this, I used the python
program [TTX](https://github.com/fonttools/fonttools) to export the font as an XML, change the necessary properties and convert it back to .ttf.  
However, my troubles hadn't nearly ended. I soon realized that, if enough was changed in a version of Snailiad, a huge amount of "filler changes" would appear,
which I wanted to avoid. Basically, there are a few places where the assets FFDec exports contain incremental IDs, which can change drastically for a
large amount of files even if a single file gets added or removed.  
Firstly, FFDec inserts a numerical ID in the name of basically every asset that isn't a script, which makes sense, as some
items are only identified by this ID. However, these numbers can create the aforementioned "filler changes", so I made a script that removes these IDs from the
names and adds incremental IDs from 1 in each separate folder for files that need them, while logging all the changes in asset_renames.log to still keep the
information, just tucked away in a single file.  
But by far the biggest problems were the p-codes: they have incremental private namespace and class numbers without any alternative static names as for most of
the assets. To fix this, I had to spend a while learning how the FFDec-provided xml file contains all its information on namespaces, but I finally succeeded and
managed to make a script that replaces these numerical IDs with the name of the class associated with each ID, which should be static between changes. However,
for private namespaces, there were quite often extra IDs that I couldn't assign to a class through the xml, so I simply assigned them to the first script
they appear in, which sometimes leads to small artefacts in some mods.  
There were two other changes I had to do for the p-codes: replacing the hexadecimal offset labels to more stable incremental IDs and dealing with a weird thing
were a specific line in script initializer p-codes would randomly switch between two variants that are equivalent in .as code, which I fixed by changing all of
them to one of the variants. All of these changes are kept track of in the "script_ID_renames" logs.  
After all that, I also wanted to output an image of the map so you could more easily compare changes in the map, which I did pretty easily with
[Tmxrasterizer](https://www.mankier.com/1/tmxrasterizer), a commandline program that comes with Tiled. It took a bit of effort to convert all the binary data files
into a .tmx file, as they don't quite match, but I managed it all-right. I'm planning to add all the Powershell scripts I used for the export to this repository.  
# The accuracy of the contents  
Despite all the changes described in the previous section, I would say all the contents with the exception of asset names and p-codes are still just as accurate
to the original
content in the .swf as the basic FFDec exports, and all the possible inaccuracies with the asset names can be resolved by finding the original name from the
"asset_renames" log. For p-codes, label-wise(when reading them just to understand what they're doing) they should still be completely accurate to the originals,
but function-wise(when using them directly in code) they sometimes are not. Here are the things you need to be aware of if you want to use any p-code from here
directly in the .swf it comes from:
- if the section of the p-code includes any references to a private namespace, you need to replace the "#label" in the quotes with the number associated with that
label from the "script_ID_renames" "PrivateNamespace IDs" section;
- much more rarely, if the section of the p-code includes the "newclass" command, you need to replace the #label after it with the number associated with that
label from the "script_ID_renames" "Class IDs" section;
- if the section of the p-code includes offset labels, if the label is entirely self-contained(doesn't appear anywhere outside the section), it should be fine
to keep it, otherwise you have to change it to match the pre-existing label in the code you want to use the p-code section in.

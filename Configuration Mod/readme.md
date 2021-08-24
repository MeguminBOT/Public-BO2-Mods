Public BO2 Mods For Plutonium T6

THIS IS A FORK OF https://github.com/JezuzLizard/Public-BO2-Mods/tree/master/Configuration%20Mod

Main goal of this fork is to make a mega script compilation that's easy to tweak or to help inexperienced people host their own server with ZERO scripting knowledge

Added some additional scripts, tweaked values and added more comments to the Classic Zombie gamemodes to enhance player experience without removing the BO1/BO2 zombie feeling.

Added features and include (Works directly after download if downloading pre-compiled GSC and dedicated_zm.cfg files)

    HUD: Zombie Counter -- //Credits ?? Not sure where I got it from in the first place.

    HUD: Shield Durability -- //Credits to teh-bandit and TomasFreeman15 for the script and tweaked HUD icons. https://forum.plutonium.pw/topic/12990/release-shield-durability-in-hud

    HUD: Timers showing Total Time spent and Round Time. -- //Credits to Jbleezy: https://github.com/Jbleezy/BO2-Reimagined

    HUD: Names for different locations on the map. -- //Credits to Jbleezy: https://github.com/Jbleezy/BO2-Reimagined

    HUD: Hitmarkers -- //Credits to mjkzy: https://github.com/mjkzy/BO2-ZM-Hitmarkers

    Visual: Remove FOG and Depth of Field from the map. -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scripts 

    Tweaks: Quick Revive gives a small boost to Health Regeneration -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scriptsa

    Tweaks: Black Ops 4 Zombie Health values (Health doesn't increase after round 35) -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scripts

NOTE: I won't add any scripts that will auto build easter egg stuff for you or grant mod menu hack commands since I consider these cheating

Future goals:
Make every script toggle-able through dedicated_zm.cfg without making the server unstable.
If you want FOG enabled, you'll currently have to disable them inside _clientids.gsc and compile it yourself. Will be toggle-able inside dedicated_zm.cfg soon

Quick Credits:

    JezuzLizard - The configuration mod

    teh-bandit - Shield Durability / BO4 Health Values / FOG and DOF Removal / Quick Revive HP Regen Boost scripts

    Jbleezy - Current zone / Timer scripts

    mjkzy - Hitmarkers script

    TomasFreeman15 - For improving the Shield Durability by adding correct shield icons to the HUD

For the source code of the scripts I've taken, check the features list.
If these aren't the original credits for each script function, do a push request with the correct credits, thanks!

When if you're new and find all the text overwhelming when opening up the cfg file or decompiled gsc. Then download and use Notepad++ instead and hover over the language tab inside the program, navigate to C and select C# or C++. Now most functions should be colour coded and easier to lookthrough. 

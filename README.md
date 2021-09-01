Want to test all the features added here? Then open Plutonium BO2 and join the following server: 
***EU Nordic | PotHouse Public [MapRotate/NO BANK]


THIS IS A FORK OF https://github.com/JezuzLizard/Public-BO2-Mods/tree/master/Configuration%20Mod

**NOTE: Pre-compiled folder contains several required dependencies that you'll need even if you decide to compile it by yourself.**
Drag 'N' Drop install available here: https://github.com/MeguminBOT/Public-BO2-Mods/releases


Main goal of this fork is to make a script compilation that's easy to tweak or to help inexperienced people host their own server with ZERO scripting knowledge

Added some additional scripts, tweaked values and added more comments to the Classic Zombie gamemodes to enhance player experience without removing the BO1/BO2 zombie feeling.

**Added GSC features/Tweaks List** (Works directly after download if downloading pre-compiled GSC and dedicated_zm.cfg files)

    HUD: Zombie Counter -- //Credits ?? Not sure where I got it from in the first place.

    HUD: Shield Durability -- //Credits to teh-bandit and TomasFreeman15 for the script and tweaked HUD icons. https://forum.plutonium.pw/topic/12990/release-shield-durability-in-hud

    HUD: Timers showing Total Time spent and Round Time. -- //Credits to Jbleezy: https://github.com/Jbleezy/BO2-Reimagined

    HUD: Names for different locations on the map. -- //Credits to Jbleezy: https://github.com/Jbleezy/BO2-Reimagined
    
    HUD: Health Bar. -- //Credits to Jbleezy: https://github.com/Jbleezy/BO2-Reimagined

    HUD: Hitmarkers -- //Credits to mjkzy: https://github.com/mjkzy/BO2-ZM-Hitmarkers
    
    HUD: Highest Round Tracker -- //Credits to Cahz: https://forum.plutonium.pw/topic/3649/release-zm-highest-round-tracker-updated-3-13-2020

    Visual: Remove FOG and Depth of Field from the map. -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scripts 

    Tweaks: Quick Revive gives a small boost to Health Regeneration -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scripts
    
    Tweaks: Melee Lunging disabled. -- //Credits to Jbleezy: https://github.com/Jbleezy/BO2-Reimagined
    
    Tweaks: Friendly Fire enabled. (Doesn't damage your allies) -- //Credits to Jbleezy: https://github.com/Jbleezy/BO2-Reimagined

    Tweaks: Black Ops 4 Zombie Health values (Health doesn't increase after round 35) -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scripts
    
    Tweaks: Players joining late gain some bonus points -- //Credits to Ashton Biehl: https://forum.plutonium.pw/topic/1061/release-set-money-for-late-people-joining
    
    Feature: Drop your weapon on the ground by holding down the "Melee" button for few seconds -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scripts
    
    **Currently disabled** Feature: Inspect your weapon by holding down the "Use" button for few seconds -- //Credits to teh-bandit: https://github.com/teh-bandit/bo2-scripts

NOTE: I won't add any scripts that will auto build easter egg stuff for you or grant mod menu hack commands since I consider these cheating

Future goals:
Make every script toggle-able through dedicated_zm.cfg without making the server unstable.
If you want FOG enabled, you'll currently have to disable them inside _clientids.gsc and compile it yourself. Will be toggle-able inside dedicated_zm.cfg soon

Quick Credits:

    JezuzLizard - The configuration mod

    teh-bandit - Shield Durability / BO4 Health Values / FOG and DOF Removal / Quick Revive HP Regen Boost / Drop and Inspect Weapon scripts

    Jbleezy - Current zone / Timer scripts

    mjkzy - Hitmarkers script

    TomasFreeman15 - For improving the Shield Durability by adding correct shield icons to the HUD
    
    Cahz - Highest Round Tracker
    
    Ashton Biehl - Set Money For Late People Joining

For the source code of the scripts I've taken, check the features list.
If these aren't the original credits for each script function, do a push request with the correct credits, thanks!

When if you're new and find all the text overwhelming when opening up the cfg file or decompiled gsc. Then download and use Notepad++ instead and hover over the language tab inside the program, navigate to C and select C# or C++. Now most functions should be colour coded and easier to lookthrough. 

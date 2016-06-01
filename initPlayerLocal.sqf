mcd_fnc_upgradeWeapon = compile preprocessFileLineNumbers "functions\fn_upgradeWeapon.sqf";
mcd_fnc_teleport = compile preprocessFileLineNumbers "functions\fn_teleport.sqf";
mcd_fnc_endMission = compile preprocessFileLineNumbers "functions\fn_endMission.sqf";
mcd_fnc_findSoloPosition = compile preprocessFileLineNumbers "functions\fn_findSoloPosition.sqf";
mcd_fnc_formattedHint = compile preprocessFileLineNumbers "functions\fn_formattedHint.sqf";

joinTime = serverTime;
currentScore = 0;
iJustSpawned = false;

[] execVM "player\setup\mapStartPos.sqf";
[] execVM "player\setup\votePlayzone.sqf";
[] execVM "player\setup\handleJIP.sqf";
[] execVM "player\setup\upgradeWeaponEH.sqf";
[] execVM "player\setup\startGame.sqf";
[] execVm "player\setup\startLoadout.sqf";
[] execVM "player\punishPlayer.sqf";

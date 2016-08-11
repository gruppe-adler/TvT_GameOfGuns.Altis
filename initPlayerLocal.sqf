mcd_fnc_upgradeWeapon = compile preprocessFileLineNumbers "functions\fn_upgradeWeapon.sqf";
mcd_fnc_teleport = compile preprocessFileLineNumbers "functions\fn_teleport.sqf";
mcd_fnc_endMission = compile preprocessFileLineNumbers "functions\fn_endMission.sqf";
mcd_fnc_findSoloPosition = compile preprocessFileLineNumbers "functions\fn_findSoloPosition.sqf";
mcd_fnc_formattedHint = compile preprocessFileLineNumbers "functions\fn_formattedHint.sqf";
mcd_fnc_addGear = compile preprocessFileLineNumbers "functions\fn_addGear.sqf";
mcd_fnc_upgradeWeaponTitle = compile preprocessFileLineNumbers "functions\fn_upgradeWeaponTitle.sqf";
mcd_fnc_formattedLog = compile preprocessFileLineNumbers "functions\fn_formattedLog.sqf";
mcd_fnc_showCamper = compile preprocessFileLineNumbers "functions\fn_showCamper.sqf";
mcd_fnc_hideCamper = compile preprocessFileLineNumbers "functions\fn_hideCamper.sqf";
mcd_fnc_scoreBoard = compile preprocessFileLineNumbers "functions\fn_scoreBoard.sqf";
mcd_fnc_endingCeremony = compile preprocessFileLineNumbers "functions\fn_endingCeremony.sqf";

joinTime = serverTime;
currentScore = 0;
iJustSpawned = false;

[] execVM "player\setup\mapStartPos.sqf";
[] execVM "player\setup\handleJIP.sqf";
[] execVM "player\setup\votePlayzone.sqf";
[] execVM "player\setup\upgradeWeaponEH.sqf";
[] execVM "player\setup\startGame.sqf";
[] execVM "player\setup\startLoadout.sqf";
[] execVM "player\punishPlayer.sqf";
[] execVM "player\recordDistance.sqf";
[] execVM "player\scoreBoard.sqf";

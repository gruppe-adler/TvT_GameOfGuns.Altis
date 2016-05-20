mcd_fnc_upgradeWeapon = compile preprocessFileLineNumbers "functions\fn_upgradeWeapon.sqf";
mcd_fnc_findGroupPosition = compile preprocessFileLineNumbers "functions\fn_findGroupPosition.sqf";
mcd_fnc_teleport = compile preprocessFileLineNumbers "functions\fn_teleport.sqf";
mcd_fnc_endMission = compile preprocessFileLineNumbers "functions\fn_endMission.sqf";

currentScore = 0;

[] execVM "player\setup\upgradeWeaponEH.sqf";
[] execVM "player\setup\startGame.sqf";

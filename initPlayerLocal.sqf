call compile preprocessfile "SHK_pos\shk_pos_init.sqf";

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

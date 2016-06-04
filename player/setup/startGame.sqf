/*  Starts the game for player
*
*   executed via initPlayerLocal on player
*/

waitUntil {!isNil "STARTPOSDONE"};
waitUntil {STARTPOSDONE};

_spawnpos = player getVariable "spawnpos";
_groupname = player getVariable "groupname";

call compile format ["[%1,0] call mcd_fnc_upgradeWeapon;", _groupname];
[player, _spawnpos] spawn mcd_fnc_teleport;

GAMESTARTED = true;

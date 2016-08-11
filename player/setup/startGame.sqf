/*  Starts the game for player
*
*   executed via initPlayerLocal on player
*/

waitUntil {!isNil "isSpectator"};
if (isSpectator) exitWith {};

waitUntil {!isNil "STARTPOSDONE"};
waitUntil {STARTPOSDONE};

_spawnpos = player getVariable "spawnpos";
_groupname = player getVariable "groupname";

[0] call mcd_fnc_upgradeWeapon;
[player, _spawnpos] spawn mcd_fnc_teleport;

GAMESTARTED = true;

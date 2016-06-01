//check JIP player is spawning for the first time
if (serverTime-joinTime < 20 && didJIP) exitWith {diag_log "Player is JIP, not executing onPlayerRespawn.sqf"};
if (isNil "STARTPOSDONE") exitWith {};

_pos = player getVariable "spawnpos";
[player, _pos] call mcd_fnc_teleport;

sleep 1;
iJustSpawned = false;

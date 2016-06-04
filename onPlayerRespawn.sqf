//check JIP player is spawning for the first time
if (serverTime-joinTime < 20 && didJIP) exitWith {diag_log "Player is JIP, not executing onPlayerRespawn.sqf"};
if (isNil "STARTPOSDONE") exitWith {};

[] call mcd_fnc_addGear;
_groupname = player getVariable "groupname";
_score = call compile _groupname;

call compile format ["[%1,%2] call mcd_fnc_upgradeWeapon", _groupname, _score];

player setVariable ["ACE_medical_lastDamageSource",player];

_pos = player getVariable "spawnpos";
[player, _pos] call mcd_fnc_teleport;

sleep 1;
iJustSpawned = false;

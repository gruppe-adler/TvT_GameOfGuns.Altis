//check JIP player is spawning for the first time
if (serverTime-joinTime < 20 && didJIP) exitWith {diag_log "Player is JIP, not executing onPlayerRespawn.sqf"};
if (isNil "STARTPOSDONE") exitWith {};

[] call mcd_fnc_addGear;
if (GAMEENDED) exitWith {};

_groupname = player getVariable "groupname";
_score = call compile _groupname;

call compile format ["[%1] call mcd_fnc_upgradeWeapon", _score];

player setVariable ["ACE_medical_lastDamageSource",player];

_pos = player getVariable "spawnpos";
[player, _pos] call mcd_fnc_teleport;
waitUntil {(getPos player) distance2D _pos < 20};
player setVariable ["lastPosition", getPos player];
player setVariable ["recentDistance", 0];
player setVariable ["isCamping", false];

sleep 1;
iJustSpawned = false;
[] call mcd_fnc_scoreBoard;

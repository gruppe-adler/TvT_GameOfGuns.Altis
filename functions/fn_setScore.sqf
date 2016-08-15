/*  Adds score points to group
*
*   remote executed by killed player (onPlayerKilled.sqf)
*/

/*_victim = (_this select 0) select 0;*/
params ["_victim", "_shooter", ["_victimPos", [0,0,0]], ["_victimName", "Someone"]];

//get shooter
/*_shooter = _victim getVariable ["ACE_medical_lastDamageSource",_victim];*/
diag_log format ["fnc_setScore - %1 killed by %2",_victim,_shooter];

//exit if self-kill
if (_victim == _shooter) exitWith {};

//update kills, deaths and longest kill
_victim setVariable ["deaths",(_victim getVariable ["deaths", 0]) + 1, true];
_shooter setVariable ["kills",(_shooter getVariable ["kills", 0]) + 1, true];
_shotDistance = (getPos _shooter) distance2D _victimPos;
if (_shotDistance > (_shooter getVariable ["longestKill", 0])) then {
  _shooter setVariable ["longestKill", _shotDistance, true];
};

//get groupnames
_vgroup = _victim getVariable "groupname";
_sgroup = _shooter getVariable "groupname";
if (isNil "_vgroup") exitWith {diag_log format ["fnc_setScore - Victim %1 does not have a groupname.", _victim]};
if (isNil "_sgroup") exitWith {diag_log format ["fnc_setScore - Shooter %1 does not have a groupname.", _shooter]};

//teamkill
_teamkill = (_vgroup == _sgroup);
if (_teamkill) then {
  diag_log format ["fnc_setScore - %1 teamkilled %2.", name _shooter, name _victim];
};

//add score
_group = _shooter getVariable "groupname";
_score = call compile (format ["%1", _group]);
if (_teamkill) then {
  if (_score > 0) then {
    _score = call compile (format ["%1 = %1 - 1; publicVariable '%1'; %1", _group]);
  };
} else {
  _score = call compile (format ["%1 = %1 + 1; publicVariable '%1'; %1", _group]);
};

//update ranking
_groupDisplayName = _shooter getVariable "groupdisplayname";
_rankID = [CURRENTRANKING, _groupDisplayName, 1] call mcd_fnc_findStringInArray;
if (_rankID != -1) then {
  _rankArray = (CURRENTRANKING select _rankID);
  _rankArray set [0, _score];
} else {
  diag_log format ["fn_setScore - ERROR: COULT NOT FIND %1 in CURRENTRANKING ARRAY.", _group];
};
CURRENTRANKING sort false;
publicVariable "CURRENTRANKING";


diag_log format ["fnc_setScore - %1 now has %2 points.", _group, _score];


if (_score >= KILLSFORWIN) then {
  [_shooter] execVM "server\endGame.sqf";
};

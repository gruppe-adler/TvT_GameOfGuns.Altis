/*  Adds score points to group
*
*   used in functions\fn_addKilledEH.sqf
*/

/*_victim = (_this select 0) select 0;*/
params ["_victim", "_shooter"];

//get shooter
/*_shooter = _victim getVariable ["ACE_medical_lastDamageSource",_victim];*/
diag_log format ["fnc_setScore - %1 killed by %2",_victim,_shooter];

//exit if self-kill
if (_victim == _shooter) exitWith {};

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
_groupDisplayName = _shooter getVariable "groupdisplayname";
_score = call compile (format ["%1", _group]);
_rankID = CURRENTRANKING find [_score, _groupDisplayName];
if (_teamkill) then {
  if (_score > 0) then {
    _score = call compile (format ["%1 = %1 - 1; publicVariable '%1'; %1", _group]);
  };
} else {
  _score = call compile (format ["%1 = %1 + 1; publicVariable '%1'; %1", _group]);
};

//update ranking
if (_rankdID != -1) then {
  _rankArray = (CURRENTRANKING select _rankID);
  _rankArray set [0, _score];
} else {
  diag_log format ["fn_setScore - ERROR: COULT NOT FIND %1 in CURRENTRANKING ARRAY.", _group];
};
CURRENTRANKING sort false;
publicVariable "CURRENTRANKING";


diag_log format ["fnc_setScore - %1 now has %2 points.", _group, _score];


if (_score >= KILLSFORWIN) then {
  [_shooter] remoteExec ["mcd_fnc_endMission",0,false];
};

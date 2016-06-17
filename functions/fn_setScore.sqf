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

//teamkill
_teamkill = (_victim getVariable "groupname") == (_shooter getVariable "groupname");
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

diag_log format ["fnc_setScore - %1 now has %2 points.", _group, _score];

if (_score >= KILLSFORWIN) then {
  [_shooter] remoteExec ["mcd_fnc_endMission",0,false];
};
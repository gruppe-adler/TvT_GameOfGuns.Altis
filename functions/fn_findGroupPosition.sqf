/*  Finds spawnposition for one or multiple groups with min distance
*
*   Params:
*   0:  Teamlead
*/

params ["_teamleadUID"];
private ["_teamleadpos"];

_teamlead = [_teamleadUID] call BIS_fnc_getUnitByUid;

diag_log format ["fnc_findGroupPosition - Finding positions for %1's team.", _teamlead];

//find position for teamlead ===================================================
_repetitions = 0;
_tooCloseFound = true;
while {_tooCloseFound} do {

  //find position that is not over water
  _isWater = true;
  _isEmpty = true
  while {_isWater || _isEmpty} do {
    /*_teamleadpos = [PLAYAREACENTER, [0, PLAYAREASIZE-10], [0,360], 1] call SHK_pos;*/
    _randomPos = PLAYAREACENTER getPos [random (PLAYAREASIZE-40), random 360];
    _teamleadpos = _randomPos findEmptyPosition [0,30];
    _isWater = surfaceIsWater _teamleadpos;
    _isEmpty = ((str _teamleadpos) == "[]");
  };

  //check min distance
  _tooCloseFound = false;
  {
    if (_x distance2D _teamleadpos < SPAWNGROUPMINDIST) then {
      _tooCloseFound = true;
    };
  } forEach playableUnits;

  //unless this has been repeated too often -> use position anyway
  if (_repetitions >= 10) then {
    _tooCloseFound = false;
    diag_log format ["fnc_findGroupPosition - Could not find a position for %1's team that is more than %2m away from enemy players.", _teamlead, SPAWNGROUPMINDIST];
  };

  _repetitions = _repetitions +1;
};
_teamlead setVariable ["spawnpos", _teamleadpos, true];


//find positions for groupmembers ==============================================
_teammateUIDs = (_teamlead getVariable "teammates");
_teammates = [];
{
  _unit = [_x] call BIS_fnc_getUnitByUid;
  _teammates pushBack _unit;
} forEach _teammateUIDs;
_teammates = _teammates - [_teamlead];

{
  _isWater = true;
  _isEmpty = true
  while {_isWater || _isEmpty} do {
    /*_matepos = [_teamleadpos, [0, STARTDISTTOLEADER], [0,360], 1] call SHK_pos;*/
    _randomPos = _teamleadPos getPos [random STARTDISTTOLEADER, random 360];
    _matePos = _randomPos findEmptyPosition [0,30];
    _isWater = surfaceIsWater _matepos;
  };

  _x setVariable ["spawnpos", _matepos, true];
} forEach _teammates;

/*  Finds spawnposition for one or multiple groups with min distance
*
*   Params:
*   0:  Teamlead
*/

params ["_teamlead"];
private ["_teamleadpos"];

//find position for teamlead ===================================================
_repetitions = 0;
_tooCloseFound = true;
while {_tooCloseFound} do {

  //find position that is not over water
  _isWater = true;
  while {_isWater} do {
    _teamleadpos = [PLAYAREACENTER, [0, PLAYAREASIZE], [0,360], 1] call SHK_pos;
    _isWater = surfaceIsWater _teamleadpos;
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
  };

  _repetitions = _repetitions +1;
};
_teamlead setVariable ["spawnpos", _teamleadpos, true];


//find positions for groupmembers ==============================================
_teammates = (_teamlead getVariable "TEAMMEMBERS") - [_teamlead];
{
  _isWater = true;
  while {_isWater} do {
    _matepos = [_teamleadpos, [0, STARTDISTTOLEADER], [0,360], 1] call SHK_pos;
    _isWater = surfaceIsWater _matepos;
  };

  _x setVariable ["spawnpos", _matepos, true];
} forEach _teammates;

private ["_mostUpvotedIDs"];

//DEFINE PLAY AREA SIZE ========================================================
//get param
PLAYAREASIZE = "PlayAreaSize" call BIS_fnc_getParamValue;

//automatic size
if (PLAYAREASIZE == -1) then {
  _playerAmount = count playableUnits;
  PLAYAREASIZE = (_playerAmount ^ 0.4) * 500 - 400;
};
publicVariable "PLAYAREASIZE";

//wait for players to pick center
waitUntil {!isNil "VOTINGDONE"};
waitUntil {VOTINGDONE};

//SELECT PLAYAREACENTER ========================================================
_mostUpvotedID = [MARKERVOTES] call mcd_fnc_findGreatestNum;

//no areas --> random center
if (count AREAMARKERS == 0) then {
  PLAYAREACENTER = [[worldSize/2, worldSize/2, 0], [0, 1000], [0,360], 1] call SHK_pos;
  diag_log format ["playAreaSetup.sqf - No play areas proposed. Selecting at random."];
} else {

  //no single most upvoted
  if (_mostUpvotedID == -1) then {
    diag_log format ["playAreaSetup.sqf - No single most upvoted play area. Selecting at random from most upvoted."];

    _mostUpvotedIDs = [];
    _max = -999999;
    for [{_i=0}, {_i<(count MARKERVOTES)}, {_i=_i+1}] do {
      _element = MARKERVOTES select _i;
      if (_element == _max) then {
        _mostUpvotedIDs pushBack _i;
      };

      if (_element > _max) then {
        _max = _element;
        _mostUpvotedIDs = [];
        _mostUpvotedIDs pushBack _i;
      };
    };

    _randomID = selectRandom _mostUpvotedIDs;
    _selectedMarker = AREAMARKERS select _randomID;
    PLAYAREACENTER = getMarkerPos _selectedMarker;

  //most upvoted
  } else {
    _selectedMarker = AREAMARKERS select _mostUpvotedID;
    PLAYAREACENTER = getMarkerPos _selectedMarker;
    diag_log format ["playAreaSetup.sqf - Most upvoted playarea is %1", _selectedMarker];
  };
};

publicVariable "PLAYAREACENTER";

//DELETE VOTING MARKERS ========================================================
{
  //delete voter markers
  _allfound = false;
  _i = 0;
  while {!_allFound} do {
    _oldVoterMarkerName = format ["%1_%2", _x, _i];
    if (str getMarkerPos _oldVoterMarkerName != "[0,0,0]") then {
      deleteMarker _oldVoterMarkerName;
    } else {
      _allFound = true;
    };
    _i = _i + 1;
  };

  deleteMarker _x;
} forEach VOTEMARKERS;

{
  deleteMarker _x;
} forEach AREAMARKERS;

//CREATE PLAY AREA MARKERS =====================================================
_marker = createMarker ["PLAYAREAMARKER", PLAYAREACENTER];
_marker setMarkerColor "COLORWEST";
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "Border";
_marker setMarkerSize [PLAYAREASIZE, PLAYAREASIZE];


//BUILD WALL ===================================================================
_flag = createVehicle ["Flag_Blue_F", PLAYAREACENTER,[],0, "CAN_COLLIDE"];
waitUntil {!isNull _flag};
_wallCounter = 0;
_pi = 3.1415;
_wallX = 4;
_step = (360*_wallX) / (2*_pi*PLAYAREASIZE);
_maxDegree = (360+_step*(PLAYAREASIZE/230));
for [{_i=1},{_i<=_maxDegree},{_i=_i+_step}] do {
  _pos = _flag getRelPos [PLAYAREASIZE, _i];
  _wall = createVehicle ["Land_Mil_WallBig_4m_F", _pos,[],0,"CAN_COLLIDE"];
  _wall setDir _i;
  _wall enableSimulationGlobal false;
  _wallCounter = _wallCounter + 1;
};
deleteVehicle _flag;


diag_log format ["playAreaSetup.sqf - Playareasize is %1. %2 wall segments created.", PLAYAREASIZE, _wallCounter];

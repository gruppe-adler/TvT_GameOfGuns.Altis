params ["_clickPos", "_player", "_size"];
private ["_closestMarker"];

//make sure only one instance of function runs at a time
if (!isNil "fnc_receiveVoteRunning") then {
  waitUntil {!fnc_receiveVoteRunning};
};
fnc_receiveVoteRunning = true;

//player specific marker name
_markerName = format ["areamarker_%1", [name _player] call mcd_fnc_strToVar];
_votesMarkerName = _markerName + "_votes";

//delete old markers ===========================================================
if (str getMarkerSize _markerName != "[0,0]") then {

  deleteMarker _markerName;
  deleteMarker _votesMarkerName;
  _markerID = AREAMARKERS find _markerName;

  //delete old voter variables
  _oldVoters = VOTERS select _markerID;
  {
    _x setVariable ["playerVote", ""];
  } forEach _oldVoters;

  //delete old markers
  _allfound = false;
  _i = 0;
  while {!_allFound} do {
    _oldVoterMarkerName = format ["%1_%2", _votesMarkerName, _i];
    if (str getMarkerPos _oldVoterMarkerName != "[0,0,0]") then {
      deleteMarker _oldVoterMarkerName;
    } else {
      _allFound = true;
    };
    _i = _i + 1;
  };

  AREAMARKERS deleteAt _markerID;
  MARKERVOTES deleteAt _markerID;
  VOTEMARKERS deleteAt _markerID;
  VOTERS deleteAt _markerID;
};


//detract old vote =============================================================
_oldVote = _player getVariable ["playerVote", ""];
if (_oldVote != "") then {
  _markerID = AREAMARKERS find _oldVote;
  _oldVoteNumber = MARKERVOTES select _markerID;
  MARKERVOTES set [_markerID, _oldVoteNumber-1];
  _oldVoters = VOTERS select _markerID;
  _newVoters = _oldVoters - [_player];
  VOTERS set [_markerID, _newVoters];

  [_oldVote] call mcd_fnc_updateVotesMarker;
};


//check if vote or proposal ====================================================
_isVote = false;
_closestDistance = 9999999;
{
  _markerPos = getMarkerPos _x;
  _markerSize = (getMarkerSize _x) select 0;
  _distance = _clickPos distance2D _markerPos;
  if (_distance < _markerSize) then {
    _isVote = true;
    if (_distance < _closestDistance) then {
      _closestMarker = _x;
      _closestDistance = _distance;
    };
  };
} forEach AREAMARKERS;


//update vote if isvote ========================================================
if (_isVote) then {
  //add new vote
  _player setVariable ["playerVote", _closestMarker];
  _markerID = AREAMARKERS find _closestMarker;
  _oldVoteNumber = MARKERVOTES select _markerID;
  MARKERVOTES set [_markerID, _oldVoteNumber+1];
  _oldVoters = VOTERS select _markerID;
  _newVoters = _oldVoters + [_player];
  VOTERS set [_markerID, _newVoters];
  [_closestMarker] call mcd_fnc_updateVotesMarker;
  diag_log format ["fnc_receiveVote - Player %1 voted for %2.", name _player, _closestMarker];
};


//create marker if proposal ====================================================
if (!_isVote) then {

  if (_size < PLAYAREAMINSIZE) then {_size = PLAYAREAMINSIZE};
  if (_size > PLAYAREAMAXSIZE) then {_size = PLAYAREAMAXSIZE};

  _areaMarker = createMarker [_markerName, _clickPos];
  _areaMarker setMarkerShape "ELLIPSE";
  _areaMarker setMarkerSize [_size,_size];
  _areaMarker setMarkerBrush "BORDER";
  _areaMarker setMarkerColor "COLORWEST";

  _votesMarker = createMarker [_votesMarkerName, _clickPos];
  _votesMarker setMarkerType "hd_flag";
  _votesMarker setMarkerColor "COLORWEST";

  AREAMARKERS pushBack _areaMarker;
  VOTEMARKERS pushBack _votesMarker;
  MARKERVOTES pushBack 1;
  VOTERS pushBack [_player];

  _player setVariable ["playerVote", _markerName];
  [_areaMarker] call mcd_fnc_updateVotesMarker;
  diag_log format ["fnc_receiveVote - Player %1 proposed play area around %2 with radius %3.", name _player, _clickPos, _size];
};


//update most voted marker
_mostUpvotedID = [MARKERVOTES] call mcd_fnc_findGreatestNum;
for [{_i=0}, {_i<(count AREAMARKERS)}, {_i=_i+1}] do {
  _marker = VOTEMARKERS select _i;
  if (_i == _mostUpvotedID) then {
    _marker setMarkerColor "COLORGREEN";
  } else {
    _marker setMarkerColor "COLORWEST";
  };
};

fnc_receiveVoteRunning = false;

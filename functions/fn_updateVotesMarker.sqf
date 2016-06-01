params ["_areaMarker"];

diag_log format ["fnc_updateVotesMarker - Updating %1.", _areaMarker];

_ySpacing = -100;

_markerID = AREAMARKERS find _areaMarker;
_votes = MARKERVOTES select _markerID;
_voteMarker = VOTEMARKERS select _markerID;
_voters = VOTERS select _markerID;
_pos = getMarkerPos _areaMarker;

//delete old markers
_allfound = false;
_i = 0;
while {!_allFound} do {
  _oldVoterMarkerName = format ["%1_%2", _voteMarker, _i];
  if (str getMarkerPos _oldVoterMarkerName != "[0,0,0]") then {
    deleteMarker _oldVoterMarkerName;
  } else {
    _allFound = true;
  };
  _i = _i + 1;
};

//create new markers
_voteMarker setMarkerText format ["Votes: (%1)", count _voters];
for [{_i=0}, {_i < count _voters}, {_i=_i+1}] do {
  _voterMarkerName = format ["%1_%2", _voteMarker, _i];
  _voterMarkerPos = _pos vectorAdd [0,_ySpacing * (_i+1),0];
  _voterMarker = createMarker [_voterMarkerName, _voterMarkerPos];
  _voterMarker setMarkerType "hd_dot";
  _voterMarker setMarkerColor "COLORWEST";
  _voterMarker setMarkerText (name (_voters select _i));
};

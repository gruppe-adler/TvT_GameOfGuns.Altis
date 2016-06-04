waitUntil {!isNil "PLAYAREASIZE"};
waitUntil {!isNil "VOTESYSTEMINITIALIZED"};
waitUntil {VOTESYSTEMINITIALIZED};
waitUntil {!isNull player};
waitUntil {player == player};
waitUntil {!isNull (findDisplay 46)};
openMap [true, true];

[] execVM "player\setup\voteDialog.sqf";

//MAP CLICK EVENT ==============================================================
mcd_choosePlayzoneClick = [
  "mcd_choosePlayzone",
  "onMapSingleClick",
  {
    [_pos, player] remoteExec ["mcd_fnc_receiveVote", 2, false];
  }
] call BIS_fnc_addStackedEventHandler;

//==============================================================================
waitUntil {!isNil "PLAYAREACENTER"};
["mcd_choosePlayzone", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;

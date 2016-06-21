waitUntil {!isNull player};
waitUntil {player == player};
waitUntil {!isNull (findDisplay 46)};
waitUntil {!isNil "VOTINGTIMELEFT"};

mcd_fnc_voteDialogText = {
  _skipText = if (playzoneSkipVote) then {"READY"} else {"PRESS ENTER TO SKIP"};
  _skipTextColor = if (playzoneSkipVote) then {[0,1,0,1]} else {[1,1,1,1]};
  ((_this select 0) displayCtrl 1402) ctrlSetText format ["TIME REMAINING: %1", ([VOTINGTIMELEFT,"MM:SS"] call BIS_fnc_secondsToString)];
  ((_this select 0) displayCtrl 1403) ctrlSetText _skipText;
  ((_this select 0) displayCtrl 1403) ctrlSetTextColor _skipTextColor;
};

_layer = (["wait1Layer"] call BIS_fnc_rscLayer);
while {VOTINGTIMELEFT > 0} do {
  _layer cutRsc ["voteCountdownTitle", "PLAIN", 0.0001, true];
  sleep 1;
};
player say "taskSucceeded";
_layer cutFadeOut 1;
openMap [false, false];

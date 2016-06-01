AREAMARKERS = [];
VOTEMARKERS = [];
MARKERVOTES = [];
VOTERS = [];

//vote function
[] spawn {
  VOTINGTIMELEFT = VOTINGTIME;
  while {VOTINGTIMELEFT > 0} do {
    sleep 1;
    VOTINGTIMELEFT = VOTINGTIMELEFT - 1;
    publicVariable "VOTINGTIMELEFT";
  };

  VOTINGDONE = true;
  publicVariable "VOTINGDONE";
};

VOTESYSTEMINITIALIZED = true;
publicVariable "VOTESYSTEMINITIALIZED";


[[23114.2,16565.7,0], ts_1] remoteExec ["mcd_fnc_receiveVote", 2, false];
[[23114.2,16565.7,0], ts_2] remoteExec ["mcd_fnc_receiveVote", 2, false];
[[20656.8,16445.6,0], ts_3] remoteExec ["mcd_fnc_receiveVote", 2, false];
[[22225.3,17651.3,0], ts_4] remoteExec ["mcd_fnc_receiveVote", 2, false];
[[22225.3,17651.3,0], ts_5] remoteExec ["mcd_fnc_receiveVote", 2, false];

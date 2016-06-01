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

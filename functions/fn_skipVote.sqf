/*  Saves players who voted to skip playzone voting
*
*   Params:
*   0:  Player who voted
*/

params ["_player","_add"];
if (isNil "skipVotePlayers") then {skipVotePlayers = []};

if (_add) then {
  skipVotePlayers pushBackUnique _player;
} else {
  skipVotePlayers = skipVotePlayers - [_player];
};

if (count skipVotePlayers == count playableUnits) then {
  diag_log format ["fnc_skipVote - All players are ready to skip. skipVotePlayers: %1", skipVotePlayers];
  VOTINGTIMELEFT = 1;
  skipVotePlayers = nil;
};

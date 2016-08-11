/*  Finds player name in stats array
*
*   Params:
*   0:  stats (array)
*   1:  name of player to find
*
*   Returns:
*   index of playername in stats (-1 if not found)
*/

params ["_statsArray", "_playerName"];

_ID = -1;
{
  if (_x select 0 == _playerName) exitWith {_ID = _forEachIndex};
} forEach _statsArray;

_ID

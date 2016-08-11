/*  Finds player name in stats array
*
*   Params:
*   0:  stats (array)
*   1:  name of player to find
*
*   Returns:
*   index of playername in stats (-1 if not found)
*/

params ["_statsArray", "_playerName", ["_searchIndex", 0]];

_ID = -1;
{
  _currentIndex = _forEachIndex;
  _item = _x select _searchIndex;
  if (typeName _item == "STRING") then {
    if (_item == _playerName) then {_ID = _currentIndex};
  };

  if (typeName _item == "ARRAY") then {
    {
      if (_x == _playerName) then {_ID = _currentIndex};
    } forEach _item;
  };
} forEach _statsArray;

_ID

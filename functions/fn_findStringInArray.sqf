/*  Finds player name in subarrays within an array
*
*   Params:
*   0:  array
*   1:  string to find
*   2:  index in subarrays to search
*
*   Returns:
*   index of string in array (-1 if not found)
*/

params ["_array", "_string", ["_searchIndex", 0]];

_ID = -1;
{
  _currentIndex = _forEachIndex;
  if (typeName _x == "ARRAY") then {
    _item = _x select _searchIndex;
    if (typeName _item == "STRING") then {
      if (_item == _string) then {_ID = _currentIndex};
    };

    if (typeName _item == "ARRAY") then {
      {
        if (_x == _string) then {_ID = _currentIndex};
      } forEach _item;
    };
  };
} forEach _array;

_ID

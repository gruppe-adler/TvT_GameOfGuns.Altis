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

private _ID = -1;
{
    _currentIndex = _forEachIndex;
    if (_x isEqualType []) then {
        _item = _x select _searchIndex;

        if (_item isEqualType "") then {
            if (_item == _string) then {_ID = _currentIndex};
        };

        if (_item isEqualType []) then {
            {
                if (_x == _string) then {_ID = _currentIndex};
            } forEach _item;
        };
    };
} forEach _array;

_ID

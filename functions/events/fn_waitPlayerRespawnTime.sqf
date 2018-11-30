#include "component.hpp"

params ["_timeLeft"];

//hint predefine ===============================================================
private _rule = parseText "<t align='center'><t color='#708090'>-----------------------------------------------------<br /></t></t>";
private _lineBreak = parseText "<br />";

[{
    params ["_args","_handle"];
    _args params ["_timeLeft","_rule","_lineBreak"];

    if (_timeLeft <= 0 || missionNamespace getVariable [QGVAR(gameEnded),false]) exitWith {
        _respawning = parseText format ["<t align='center' color='#00ff00' size='1.4'>Respawning...</t>"];
        hint composeText [_rule, _respawning, _lineBreak, _rule];

        [_handle] call CBA_fnc_removePerFrameHandler;
        _respawnPos = [player] call FUNC(findSoloRespawnPosition);
        [_respawnPos] call FUNC(respawnPlayer);
    };

    //check if teammates alive
    _teamMatesAlive = false;
    {
        _unit = [_x] call BIS_fnc_getUnitByUid;
        if (alive _unit) then {_teammatesalive = true};
    } forEach _teammateUIDs;

    if (!_teammatesalive) exitWith {
        [_timeLeft] call FUNC(waitTeamRespawnTime);
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    //hint
    _timestr = [_timeleft, "MM:SS"] call BIS_fnc_secondsToString;
    _respawnIn = parseText format ["<t align='center' size='1.4'>Respawn in: <t color='#ffff00'>%1</t></t>", _timestr];
    hintSilent composeText [_rule,_respawnin,_linebreak,_rule];

    _args set [0,_timeLeft - 1];

},1,[_timeLeft,_rule,_lineBreak]] call CBA_fnc_addPerFrameHandler;

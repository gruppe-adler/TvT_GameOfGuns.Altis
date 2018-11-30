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
        [player getVariable [QEGVAR(missionSetup,teamNamespace),objNull]] remoteExecCall [QFUNC(respawnTeam),2,false];
    };

    //hint
    _timestr = [_timeleft, "MM:SS"] call BIS_fnc_secondsToString;
    _respawnIn = parseText format ["<t align='center' size='1.4'>Team dead. Respawn in max: <t color='#ffff00'>%1</t></t>", _timestr];
    hintSilent composeText [_rule,_respawnin,_linebreak,_rule];

    _args set [0,_timeLeft - 1];

},1,[_timeLeft,_rule,_lineBreak]] call CBA_fnc_addPerFrameHandler;

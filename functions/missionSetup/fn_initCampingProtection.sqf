#include "component.hpp"

#define AREASIZE 20
#define CAMPTIME 60

[{
    params ["_args","_handle"];
    _args params ["_iteration","_currentArea","_lastPos"];

    if (missionNamespace getVariable [QEGVAR(events,gameEnded),false]) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    if (!alive player) exitWith {
        _args set [1,nil];
        _args set [2,nil];
    };

    if (isNil "_lastPos") then {
        _args set [2,getPos player];
    } else {
        _distance = player distance _lastPos;
        _totalDistance = player getVariable [QGVAR(totalDistance),0];
        player setVariable [QGVAR(totalDistance),_totalDistance + _distance];
    };


    // player moved
    if (isNil "_currentArea" || {!(player inArea _currentArea)}) then {
        _currentArea = [getPos player,AREASIZE,AREASIZE,0,false];

        _args set [0,0];
        _args set [1,_currentArea];

    // player didnt move
    } else {
        _args set [0,_iteration + 1];
    };

    // player is camping
    if (_iteration > CAMPTIME) exitWith {

        ["gungame_notification1",["GUNGAME","Looks like you are camping. You better move."]] spawn bis_fnc_showNotification;
        [_handle] call CBA_fnc_removePerFrameHandler;

        [{
            params ["_args","_handle"];
            _args params ["_iteration","_currentArea","_lastPos"];

            _distance = player distance _lastPos;
            _totalDistance = player getVariable [QGVAR(totalDistance),0];
            player setVariable [QGVAR(totalDistance),_totalDistance + _distance];

            // player stopped camping
            if (!(alive player) || !(player inArea _currentArea)) exitWith {
                player setVariable [QGVAR(isCamping),false,true];
                [] call FUNC(initCampingProtection);

                if (alive player) then {
                    ["gungame_notification1",["GUNGAME","Alright, you moved. I'm watching you though."]] spawn bis_fnc_showNotification;
                };

                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            // player is still camping
            if (_iteration > 15 && {!(player getVariable [QGVAR(isCamping),false])}) then {
                player setVariable [QGVAR(isCamping),true,true];
                ["gungame_notification1",["GUNGAME","Other players know where you are, camper!"]] spawn bis_fnc_showNotification;
                [player,profileName] remoteExec [QEFUNC(common,showCamper),0,false];
            };

            _args set [0,_iteration + 1];

        },1,[0,_currentArea,_lastPos]] call CBA_fnc_addPerFrameHandler;
    };
},1,[0]] call CBA_fnc_addPerFrameHandler;

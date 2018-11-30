#include "component.hpp"


[{!isNull player || isDedicated},{

    if (hasInterface) then {
        [] call FUNC(moveToMapStartPos);

        [{!isNull (findDisplay 46)},{
            [] call EFUNC(votePlayzone,initPlayer);
        },[]] call CBA_fnc_waitUntilAndExecute;
    };

    if (isServer) then {
        _timeOfDay = [] call FUNC(setTime);
        [_timeOfDay] call FUNC(setWeather);

        [] call EFUNC(votePlayzone,initServer);

    };

},[]] call CBA_fnc_waitUntilAndExecute;

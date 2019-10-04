#include "component.hpp"

private _allCfgWeapons = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> "cfgWeapons");


private _allAvailableUniforms = (_allCfgWeapons apply {configName _x}) select {
    _x isKindOf ["Uniform_Base",configFile >> "cfgWeapons"] &&
    // filter LOP, because they have no preview pictures -,-
    (_x find "LOP") != 0
};
_allAvailableUniforms

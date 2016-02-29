#include "script_macros.hpp"
params ["_sector"];
private _side = _sector getVariable ["side",sideUnknown];
private _activeSides = [];
private _num = {
        private _s = ([_x] call FUNC(getSector)) getVariable ["side",sideUnknown];
        if (_s != sideUnknown && !(_s in _activeSides )) then {
            _activeSides pushBack _s;
        };
        _side != _s && _s != sideUnknown;
    } count (_sector getVariable ["dependency",[]]);
_sector setVariable ["activeSides",_activeSides];
private _ret = true;

if (!(_num > 0) || {(_sector getVariable ["captureProgress",[]]) >= 1}) exitWith {
    if (isServer) then {
        
        if (_side == sideUnknown && {(_sector getVariable ["captureProgress",[]]) != 0}) then {
            _sector setVariable ["captureProgress",0,true];
        };

        if (_side != sideUnknown && {(_sector getVariable ["captureProgress",[]]) < 1}) then {
            _sector setVariable ["captureProgress",1,true];
        };

        if ((_sector getVariable ["captureRate",0]) != 0) then {
            _sector setVariable ["lastCaptureTick",serverTime,true];
            _sector setVariable ["captureRate",0,true];
        };
    };
    false;
};

_ret;

#include "script_macros.hpp"
params ["_marker", ["_dependency", []],["_ticketBleed", 5],["_minUnits", 1],["_captureTime",60],["_designator","A"]];

private _size = getMarkerSize _marker;

private _logic = (call EFUNC(common,getLogicGroup)) createUnit ["Logic", getMarkerPos _marker, [], 0, "NONE"];
_logic setVehicleVarName _marker;
GVAR(allSectors) setVariable [_marker, _logic, true];
GVAR(allSectorsArray) pushBack _logic;

private _side = switch (markerColor _marker) do {
    case "ColorWEST": {west};
    case "ColorEAST": {east};
    case "ColorGUER": {independent};
    default {sideUnknown};
};
_logic setVariable ["name",_marker,true];
_logic setVariable ["fullName",markerText _marker,true];
_logic setVariable ["designator",_designator,true];
_logic setVariable ["marker",_marker,true];
_logic setVariable ["side",_side,true];
_logic setVariable ["attackerSide",_side,true];
_logic setVariable ["dependency",_dependency,true];
_logic setVariable ["ticketBleed",_ticketBleed,true];
_logic setVariable ["minUnits",_minUnits,true];
_logic setVariable ["captureRate",0, true];
_logic setVariable ["captureTime",_captureTime, true];
if (_side == sideUnknown) then {
    _logic setVariable ["captureProgress",0, true];
} else {
    _logic setVariable ["captureProgress",1, true];
};

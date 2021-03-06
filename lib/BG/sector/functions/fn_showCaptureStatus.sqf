#include "script_macros.hpp"
params ["_show","_sector"];

if (_show) then {
    _sector = [_sector] call FUNC(getSector);
    ([QGVAR(CaptureStatus)] call BIS_fnc_rscLayer) cutRsc [QGVAR(CaptureStatus),"PLAIN"];
    if (GVAR(captureStatusPFH) != -1) then {
        [GVAR(captureStatusPFH)] call CBA_fnc_removePerFrameHandler;
    };

    GVAR(captureStatusPFH) = [{
            disableSerialization;
            params ["_args","_id"];
            _args params ["_sector"];
            private _aside = _sector getVariable ["attackerSide",sideUnknown];
            private _side = _sector getVariable ["side",sideUnknown];
            private _progress = _sector getVariable ["captureProgress",0];
            private _rate = _sector getVariable ["captureRate",0];
            private _lastTick = _sector getVariable ["lastCaptureTick",serverTime];

            private _dialog = uiNamespace getVariable QGVAR(CaptureStatus);

            (_dialog displayCtrl 101) ctrlSetText (missionNamespace getVariable [format ["%1_%2",QGVAR(Flag),_side],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
            (_dialog displayCtrl 102) ctrlSetText (_sector getVariable ["designator",""]);
            (_dialog displayCtrl 103) ctrlSetText (_sector getVariable ["fullName",""]);
            (_dialog displayCtrl 104) ctrlSetTextColor (missionNamespace getVariable [format ["%1_%2",QGVAR(SideColor),_aside],[0,1,0,1]]);
            (_dialog displayCtrl 104) ctrlCommit 0;
            (_dialog displayCtrl 104) progressSetPosition (_progress + (serverTime - _lastTick)*_rate);
        }, 0, [_sector]] call CBA_fnc_addPerFrameHandler;
} else {
    if (GVAR(captureStatusPFH) != -1) then {
        [GVAR(captureStatusPFH)] call CBA_fnc_removePerFrameHandler;
    };
    ([QGVAR(CaptureStatus)] call BIS_fnc_rscLayer) cutFadeOut 1;
};

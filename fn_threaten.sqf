params ["_dog", "_unit"];

_dog setVariable ["grad_dogs_state", "biting"];

_dog setFormDir (_dog getDir _unit);
_dog playMoveNow "Aggresive";

[{
	params ["_dog", "_unit"];

	[_dog, _unit] call grad_dogs_fnc_attack;

}, [_dog, _unit], 1.5] call CBA_fnc_waitAndExecute;

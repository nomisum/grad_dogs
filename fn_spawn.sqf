params ["_classname", "_position"];

private _dog = createUnit [_classname, _position, [], 0, "NONE"];
_dog setVariable ["BIS_fnc_animalBehaviour_disable", true, true];

[_dog] call grad_dogs_fnc_brain;

params ["_dog"];

// looping
[{
	params ["_args", "_handle"];
	_args params ["_dog"];

	if (!alive _dog) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
		diag_log "grad dogs: dog is dead, brain shuts down.";
	};

	private _state = _dog getVariable ["grad_dogs_state", "idle"];

	switch (_state) do {
		
	};

}, 1, [_dog]] call CBA_fnc_addPerFrameHandler;

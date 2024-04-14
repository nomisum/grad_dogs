/*

	server

*/

params ["_unit"];

if (!isServer) exitWith {};

[{
	params ["_args", "_handle"];
	_args params ["_unit"];
	
	private _position = position _unit;
	private _scentNear = _position nearEntities ["Sign_Sphere10cm_F", 5];
	if (count _scentNear > 0) exitWith {
		diag_log "grad dogs drop scent: scent already close by";
	};
	
	private _scent = createSimpleObject ["Sign_Sphere10cm_F", _position];
	_scent hideObjectGlobal true;
	_scent setVariable ["grad_dogs_timestamp", CBA_missionTime, true];

	private _scents = missionNameSpace getVariable ["grad_dogs_allscents", []];
	_scents pushBackUnique _scent;
	missionNameSpace setVariable ["grad_dogs_allscents", _scents];

}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;

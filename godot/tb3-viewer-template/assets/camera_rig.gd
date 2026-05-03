extends Node3D

@export var camera_path: NodePath
@export var target_path: NodePath

@export var rotate_speed := 0.01
@export var zoom_speed := 0.2
@export var pan_speed := 0.003

@export var min_distance := 0.5
@export var max_distance := 10.0
@export var pitch_min := deg_to_rad(-80.0)
@export var pitch_max := deg_to_rad(20.0)

var yaw := 0.0
var pitch := deg_to_rad(-20.0)
var distance := 3.0

var pan_offset := Vector3.ZERO

@onready var camera: Camera3D = get_node(camera_path)

func _ready() -> void:
	camera.current = true
	_update_rig_position()
	_update_camera()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			yaw -= event.relative.x * rotate_speed
			pitch -= event.relative.y * rotate_speed
			pitch = clamp(pitch, pitch_min, pitch_max)
			_update_camera()

		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
			_pan_camera(event.relative)
			_update_camera()

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distance = max(min_distance, distance - zoom_speed)
			_update_camera()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distance = min(max_distance, distance + zoom_speed)
			_update_camera()

func _process(_delta: float) -> void:
	_update_rig_position()
	_update_camera()

func _update_rig_position() -> void:
	if target_path != NodePath():
		var target := get_node_or_null(target_path)
		if target is Node3D:
			global_position = target.global_position + pan_offset
			return

	global_position = pan_offset

func _pan_camera(relative: Vector2) -> void:
	var right := camera.global_transform.basis.x.normalized()
	var up := camera.global_transform.basis.y.normalized()

	var scale := pan_speed * distance

	pan_offset -= right * relative.x * scale
	pan_offset += up * relative.y * scale

func _update_camera() -> void:
	var rot := Basis(Vector3.UP, yaw) * Basis(Vector3.RIGHT, pitch)
	var offset := rot * Vector3(0.0, 0.0, distance)

	camera.global_position = global_position + offset
	camera.look_at(global_position, Vector3.UP)

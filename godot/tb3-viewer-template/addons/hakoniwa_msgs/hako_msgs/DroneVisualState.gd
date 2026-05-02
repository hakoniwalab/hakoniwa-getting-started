class_name HakoPdu_hako_msgs_DroneVisualState
extends RefCounted


var x: float = 0.0
var y: float = 0.0
var z: float = 0.0
var roll: float = 0.0
var pitch: float = 0.0
var yaw: float = 0.0
var pwm_duty: PackedFloat32Array = PackedFloat32Array()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/DroneVisualState.gd").new()
    if d.has("x"):
        obj.x = d["x"]
    if d.has("y"):
        obj.y = d["y"]
    if d.has("z"):
        obj.z = d["z"]
    if d.has("roll"):
        obj.roll = d["roll"]
    if d.has("pitch"):
        obj.pitch = d["pitch"]
    if d.has("yaw"):
        obj.yaw = d["yaw"]
    if d.has("pwm_duty"):
        obj.pwm_duty = d["pwm_duty"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["x"] = x
    d["y"] = y
    d["z"] = z
    d["roll"] = roll
    d["pitch"] = pitch
    d["yaw"] = yaw
    d["pwm_duty"] = pwm_duty
    return d

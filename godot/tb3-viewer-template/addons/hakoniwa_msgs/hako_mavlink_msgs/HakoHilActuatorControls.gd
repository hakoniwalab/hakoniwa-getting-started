class_name HakoPdu_hako_mavlink_msgs_HakoHilActuatorControls
extends RefCounted


var time_usec: int = 0
var controls: PackedFloat32Array = PackedFloat32Array()
var mode: int = 0
var flags: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoHilActuatorControls.gd").new()
    if d.has("time_usec"):
        obj.time_usec = d["time_usec"]
    if d.has("controls"):
        obj.controls = d["controls"]
    if d.has("mode"):
        obj.mode = d["mode"]
    if d.has("flags"):
        obj.flags = d["flags"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_usec"] = time_usec
    d["controls"] = controls
    d["mode"] = mode
    d["flags"] = flags
    return d

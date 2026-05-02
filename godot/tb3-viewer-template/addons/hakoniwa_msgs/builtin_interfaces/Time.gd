class_name HakoPdu_builtin_interfaces_Time
extends RefCounted


var sec: int = 0
var nanosec: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/builtin_interfaces/Time.gd").new()
    if d.has("sec"):
        obj.sec = d["sec"]
    if d.has("nanosec"):
        obj.nanosec = d["nanosec"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["sec"] = sec
    d["nanosec"] = nanosec
    return d

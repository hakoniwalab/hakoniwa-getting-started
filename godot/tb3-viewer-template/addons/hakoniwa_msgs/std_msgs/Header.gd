class_name HakoPdu_std_msgs_Header
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


var stamp = null
var frame_id: String = ""

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/std_msgs/Header.gd").new()
    if d.has("stamp"):
        obj.stamp = TimeScript.from_dict(d["stamp"])
    if d.has("frame_id"):
        obj.frame_id = d["frame_id"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["stamp"] = stamp.to_dict()
    d["frame_id"] = frame_id
    return d

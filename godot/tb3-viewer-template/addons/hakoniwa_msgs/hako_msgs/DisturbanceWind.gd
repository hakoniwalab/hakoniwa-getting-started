class_name HakoPdu_hako_msgs_DisturbanceWind
extends RefCounted


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var value = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/DisturbanceWind.gd").new()
    if d.has("value"):
        obj.value = Vector3Script.from_dict(d["value"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["value"] = value.to_dict()
    return d

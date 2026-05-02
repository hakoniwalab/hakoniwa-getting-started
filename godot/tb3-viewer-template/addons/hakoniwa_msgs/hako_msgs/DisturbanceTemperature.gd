class_name HakoPdu_hako_msgs_DisturbanceTemperature
extends RefCounted


var value: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/DisturbanceTemperature.gd").new()
    if d.has("value"):
        obj.value = d["value"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["value"] = value
    return d

class_name HakoPdu_hako_srv_msgs_AddTwoIntsResponse
extends RefCounted


var sum: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/AddTwoIntsResponse.gd").new()
    if d.has("sum"):
        obj.sum = d["sum"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["sum"] = sum
    return d

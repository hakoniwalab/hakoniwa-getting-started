class_name HakoPdu_hako_srv_msgs_RegisterClientRequest
extends RefCounted


var dummy: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/RegisterClientRequest.gd").new()
    if d.has("dummy"):
        obj.dummy = d["dummy"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["dummy"] = dummy
    return d

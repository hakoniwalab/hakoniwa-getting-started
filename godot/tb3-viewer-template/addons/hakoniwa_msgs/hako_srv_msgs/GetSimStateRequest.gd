class_name HakoPdu_hako_srv_msgs_GetSimStateRequest
extends RefCounted


var name: String = ""

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/GetSimStateRequest.gd").new()
    if d.has("name"):
        obj.name = d["name"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["name"] = name
    return d

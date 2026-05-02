class_name HakoPdu_hako_srv_msgs_GetEventResponse
extends RefCounted


var event_code: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/GetEventResponse.gd").new()
    if d.has("event_code"):
        obj.event_code = d["event_code"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["event_code"] = event_code
    return d

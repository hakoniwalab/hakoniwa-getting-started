class_name HakoPdu_hako_srv_msgs_AckEventResponse
extends RefCounted


var ack_code: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/AckEventResponse.gd").new()
    if d.has("ack_code"):
        obj.ack_code = d["ack_code"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["ack_code"] = ack_code
    return d

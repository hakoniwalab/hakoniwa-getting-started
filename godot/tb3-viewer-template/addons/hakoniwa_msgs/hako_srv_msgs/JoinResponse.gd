class_name HakoPdu_hako_srv_msgs_JoinResponse
extends RefCounted


var status_code: int = 0
var message: String = ""

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/JoinResponse.gd").new()
    if d.has("status_code"):
        obj.status_code = d["status_code"]
    if d.has("message"):
        obj.message = d["message"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["status_code"] = status_code
    d["message"] = message
    return d

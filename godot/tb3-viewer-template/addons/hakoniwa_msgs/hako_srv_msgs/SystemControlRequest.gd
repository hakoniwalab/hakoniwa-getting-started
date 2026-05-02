class_name HakoPdu_hako_srv_msgs_SystemControlRequest
extends RefCounted


var opcode: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/SystemControlRequest.gd").new()
    if d.has("opcode"):
        obj.opcode = d["opcode"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["opcode"] = opcode
    return d

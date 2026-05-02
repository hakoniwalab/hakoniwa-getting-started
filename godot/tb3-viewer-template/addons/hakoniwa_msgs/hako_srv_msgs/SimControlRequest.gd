class_name HakoPdu_hako_srv_msgs_SimControlRequest
extends RefCounted


var name: String = ""
var op: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/SimControlRequest.gd").new()
    if d.has("name"):
        obj.name = d["name"]
    if d.has("op"):
        obj.op = d["op"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["name"] = name
    d["op"] = op
    return d

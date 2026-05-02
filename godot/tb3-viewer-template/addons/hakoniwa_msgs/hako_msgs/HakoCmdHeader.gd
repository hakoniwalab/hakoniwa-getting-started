class_name HakoPdu_hako_msgs_HakoCmdHeader
extends RefCounted


var request: bool = false
var result: bool = false
var result_code: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/HakoCmdHeader.gd").new()
    if d.has("request"):
        obj.request = d["request"]
    if d.has("result"):
        obj.result = d["result"]
    if d.has("result_code"):
        obj.result_code = d["result_code"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["request"] = request
    d["result"] = result
    d["result_code"] = result_code
    return d

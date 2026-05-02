class_name HakoPdu_hako_srv_msgs_AddTwoIntsRequest
extends RefCounted


var a: int = 0
var b: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/AddTwoIntsRequest.gd").new()
    if d.has("a"):
        obj.a = d["a"]
    if d.has("b"):
        obj.b = d["b"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["a"] = a
    d["b"] = b
    return d

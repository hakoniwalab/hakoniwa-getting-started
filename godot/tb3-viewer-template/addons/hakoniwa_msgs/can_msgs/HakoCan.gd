class_name HakoPdu_can_msgs_HakoCan
extends RefCounted


const HakoCanBodyScript = preload("./HakoCanBody.gd")


const HakoCanHeadScript = preload("./HakoCanHead.gd")


var head = null
var body = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/can_msgs/HakoCan.gd").new()
    if d.has("head"):
        obj.head = HakoCanHeadScript.from_dict(d["head"])
    if d.has("body"):
        obj.body = HakoCanBodyScript.from_dict(d["body"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["head"] = head.to_dict()
    d["body"] = body.to_dict()
    return d

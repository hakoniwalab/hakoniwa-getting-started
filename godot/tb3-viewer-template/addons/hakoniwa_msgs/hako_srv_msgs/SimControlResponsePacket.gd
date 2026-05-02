class_name HakoPdu_hako_srv_msgs_SimControlResponsePacket
extends RefCounted


const ServiceResponseHeaderScript = preload("./ServiceResponseHeader.gd")


const SimControlResponseScript = preload("./SimControlResponse.gd")


var header = null
var body = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/SimControlResponsePacket.gd").new()
    if d.has("header"):
        obj.header = ServiceResponseHeaderScript.from_dict(d["header"])
    if d.has("body"):
        obj.body = SimControlResponseScript.from_dict(d["body"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["body"] = body.to_dict()
    return d

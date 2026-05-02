class_name HakoPdu_hako_srv_msgs_AckEventRequestPacket
extends RefCounted


const AckEventRequestScript = preload("./AckEventRequest.gd")


const ServiceRequestHeaderScript = preload("./ServiceRequestHeader.gd")


var header = null
var body = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/AckEventRequestPacket.gd").new()
    if d.has("header"):
        obj.header = ServiceRequestHeaderScript.from_dict(d["header"])
    if d.has("body"):
        obj.body = AckEventRequestScript.from_dict(d["body"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["body"] = body.to_dict()
    return d

class_name HakoPdu_hako_srv_msgs_RegisterClientRequestPacket
extends RefCounted


const RegisterClientRequestScript = preload("./RegisterClientRequest.gd")


const ServiceRequestHeaderScript = preload("./ServiceRequestHeader.gd")


var header = null
var body = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/RegisterClientRequestPacket.gd").new()
    if d.has("header"):
        obj.header = ServiceRequestHeaderScript.from_dict(d["header"])
    if d.has("body"):
        obj.body = RegisterClientRequestScript.from_dict(d["body"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["body"] = body.to_dict()
    return d

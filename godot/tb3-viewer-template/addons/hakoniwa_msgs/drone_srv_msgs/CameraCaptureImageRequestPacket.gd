class_name HakoPdu_drone_srv_msgs_CameraCaptureImageRequestPacket
extends RefCounted


const CameraCaptureImageRequestScript = preload("./CameraCaptureImageRequest.gd")


const ServiceRequestHeaderScript = preload("../hako_srv_msgs/ServiceRequestHeader.gd")


var header = null
var body = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/CameraCaptureImageRequestPacket.gd").new()
    if d.has("header"):
        obj.header = ServiceRequestHeaderScript.from_dict(d["header"])
    if d.has("body"):
        obj.body = CameraCaptureImageRequestScript.from_dict(d["body"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["body"] = body.to_dict()
    return d

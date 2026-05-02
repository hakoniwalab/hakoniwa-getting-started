class_name HakoPdu_drone_srv_msgs_DroneGoToResponsePacket
extends RefCounted


const DroneGoToResponseScript = preload("./DroneGoToResponse.gd")


const ServiceResponseHeaderScript = preload("../hako_srv_msgs/ServiceResponseHeader.gd")


var header = null
var body = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/DroneGoToResponsePacket.gd").new()
    if d.has("header"):
        obj.header = ServiceResponseHeaderScript.from_dict(d["header"])
    if d.has("body"):
        obj.body = DroneGoToResponseScript.from_dict(d["body"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["body"] = body.to_dict()
    return d

class_name HakoPdu_hako_msgs_MonitorCameraCmd
extends RefCounted


const HakoCmdHeaderScript = preload("./HakoCmdHeader.gd")


var header = null
var request_id: int = 0
var encode_type: int = 0
var request_type: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/MonitorCameraCmd.gd").new()
    if d.has("header"):
        obj.header = HakoCmdHeaderScript.from_dict(d["header"])
    if d.has("request_id"):
        obj.request_id = d["request_id"]
    if d.has("encode_type"):
        obj.encode_type = d["encode_type"]
    if d.has("request_type"):
        obj.request_type = d["request_type"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["request_id"] = request_id
    d["encode_type"] = encode_type
    d["request_type"] = request_type
    return d

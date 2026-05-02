class_name HakoPdu_hako_msgs_HakoCmdCameraMove
extends RefCounted


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


const HakoCmdHeaderScript = preload("./HakoCmdHeader.gd")


var header = null
var request_id: int = 0
var angle = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/HakoCmdCameraMove.gd").new()
    if d.has("header"):
        obj.header = HakoCmdHeaderScript.from_dict(d["header"])
    if d.has("request_id"):
        obj.request_id = d["request_id"]
    if d.has("angle"):
        obj.angle = Vector3Script.from_dict(d["angle"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["request_id"] = request_id
    d["angle"] = angle.to_dict()
    return d

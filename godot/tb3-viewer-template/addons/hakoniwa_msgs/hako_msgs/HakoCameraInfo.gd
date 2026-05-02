class_name HakoPdu_hako_msgs_HakoCameraInfo
extends RefCounted


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var request_id: int = 0
var angle = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/HakoCameraInfo.gd").new()
    if d.has("request_id"):
        obj.request_id = d["request_id"]
    if d.has("angle"):
        obj.angle = Vector3Script.from_dict(d["angle"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["request_id"] = request_id
    d["angle"] = angle.to_dict()
    return d

class_name HakoPdu_drone_srv_msgs_CameraCaptureImageRequest
extends RefCounted


var drone_name: String = ""
var image_type: String = ""

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/CameraCaptureImageRequest.gd").new()
    if d.has("drone_name"):
        obj.drone_name = d["drone_name"]
    if d.has("image_type"):
        obj.image_type = d["image_type"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["drone_name"] = drone_name
    d["image_type"] = image_type
    return d

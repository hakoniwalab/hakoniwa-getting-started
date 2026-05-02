class_name HakoPdu_drone_srv_msgs_CameraSetTiltRequest
extends RefCounted


var drone_name: String = ""
var tilt_angle_deg: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/CameraSetTiltRequest.gd").new()
    if d.has("drone_name"):
        obj.drone_name = d["drone_name"]
    if d.has("tilt_angle_deg"):
        obj.tilt_angle_deg = d["tilt_angle_deg"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["drone_name"] = drone_name
    d["tilt_angle_deg"] = tilt_angle_deg
    return d

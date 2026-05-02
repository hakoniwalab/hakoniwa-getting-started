class_name HakoPdu_drone_srv_msgs_MagnetGrabRequest
extends RefCounted


var drone_name: String = ""
var grab_on: bool = false
var timeout_sec: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/MagnetGrabRequest.gd").new()
    if d.has("drone_name"):
        obj.drone_name = d["drone_name"]
    if d.has("grab_on"):
        obj.grab_on = d["grab_on"]
    if d.has("timeout_sec"):
        obj.timeout_sec = d["timeout_sec"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["drone_name"] = drone_name
    d["grab_on"] = grab_on
    d["timeout_sec"] = timeout_sec
    return d

class_name HakoPdu_drone_srv_msgs_DroneTakeOffRequest
extends RefCounted


var alt_m: float = 0.0
var drone_name: String = ""

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/DroneTakeOffRequest.gd").new()
    if d.has("alt_m"):
        obj.alt_m = d["alt_m"]
    if d.has("drone_name"):
        obj.drone_name = d["drone_name"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["alt_m"] = alt_m
    d["drone_name"] = drone_name
    return d

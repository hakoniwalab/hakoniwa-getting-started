class_name HakoPdu_hako_msgs_DroneStatus
extends RefCounted


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var flight_mode: int = 0
var internal_state: int = 0
var propeller_wind = null
var collided_counts: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/DroneStatus.gd").new()
    if d.has("flight_mode"):
        obj.flight_mode = d["flight_mode"]
    if d.has("internal_state"):
        obj.internal_state = d["internal_state"]
    if d.has("propeller_wind"):
        obj.propeller_wind = Vector3Script.from_dict(d["propeller_wind"])
    if d.has("collided_counts"):
        obj.collided_counts = d["collided_counts"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["flight_mode"] = flight_mode
    d["internal_state"] = internal_state
    d["propeller_wind"] = propeller_wind.to_dict()
    d["collided_counts"] = collided_counts
    return d

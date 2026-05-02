class_name HakoPdu_hako_mavlink_msgs_HakoAHRS2
extends RefCounted


var roll: float = 0.0
var pitch: float = 0.0
var yaw: float = 0.0
var altitude: float = 0.0
var lat: int = 0
var lng: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoAHRS2.gd").new()
    if d.has("roll"):
        obj.roll = d["roll"]
    if d.has("pitch"):
        obj.pitch = d["pitch"]
    if d.has("yaw"):
        obj.yaw = d["yaw"]
    if d.has("altitude"):
        obj.altitude = d["altitude"]
    if d.has("lat"):
        obj.lat = d["lat"]
    if d.has("lng"):
        obj.lng = d["lng"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["roll"] = roll
    d["pitch"] = pitch
    d["yaw"] = yaw
    d["altitude"] = altitude
    d["lat"] = lat
    d["lng"] = lng
    return d

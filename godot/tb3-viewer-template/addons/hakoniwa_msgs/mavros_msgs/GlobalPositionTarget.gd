class_name HakoPdu_mavros_msgs_GlobalPositionTarget
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var coordinate_frame: int = 0
var type_mask: int = 0
var latitude: float = 0.0
var longitude: float = 0.0
var altitude: float = 0.0
var velocity = null
var acceleration_or_force = null
var yaw: float = 0.0
var yaw_rate: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/mavros_msgs/GlobalPositionTarget.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("coordinate_frame"):
        obj.coordinate_frame = d["coordinate_frame"]
    if d.has("type_mask"):
        obj.type_mask = d["type_mask"]
    if d.has("latitude"):
        obj.latitude = d["latitude"]
    if d.has("longitude"):
        obj.longitude = d["longitude"]
    if d.has("altitude"):
        obj.altitude = d["altitude"]
    if d.has("velocity"):
        obj.velocity = Vector3Script.from_dict(d["velocity"])
    if d.has("acceleration_or_force"):
        obj.acceleration_or_force = Vector3Script.from_dict(d["acceleration_or_force"])
    if d.has("yaw"):
        obj.yaw = d["yaw"]
    if d.has("yaw_rate"):
        obj.yaw_rate = d["yaw_rate"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["coordinate_frame"] = coordinate_frame
    d["type_mask"] = type_mask
    d["latitude"] = latitude
    d["longitude"] = longitude
    d["altitude"] = altitude
    d["velocity"] = velocity.to_dict()
    d["acceleration_or_force"] = acceleration_or_force.to_dict()
    d["yaw"] = yaw
    d["yaw_rate"] = yaw_rate
    return d

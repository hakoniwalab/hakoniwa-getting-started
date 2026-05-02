class_name HakoPdu_sensor_msgs_LaserScan
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var angle_min: float = 0.0
var angle_max: float = 0.0
var angle_increment: float = 0.0
var time_increment: float = 0.0
var scan_time: float = 0.0
var range_min: float = 0.0
var range_max: float = 0.0
var ranges: PackedFloat32Array = PackedFloat32Array()
var intensities: PackedFloat32Array = PackedFloat32Array()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/sensor_msgs/LaserScan.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("angle_min"):
        obj.angle_min = d["angle_min"]
    if d.has("angle_max"):
        obj.angle_max = d["angle_max"]
    if d.has("angle_increment"):
        obj.angle_increment = d["angle_increment"]
    if d.has("time_increment"):
        obj.time_increment = d["time_increment"]
    if d.has("scan_time"):
        obj.scan_time = d["scan_time"]
    if d.has("range_min"):
        obj.range_min = d["range_min"]
    if d.has("range_max"):
        obj.range_max = d["range_max"]
    if d.has("ranges"):
        obj.ranges = d["ranges"]
    if d.has("intensities"):
        obj.intensities = d["intensities"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["angle_min"] = angle_min
    d["angle_max"] = angle_max
    d["angle_increment"] = angle_increment
    d["time_increment"] = time_increment
    d["scan_time"] = scan_time
    d["range_min"] = range_min
    d["range_max"] = range_max
    d["ranges"] = ranges
    d["intensities"] = intensities
    return d

class_name HakoPdu_hako_mavlink_msgs_HakoGLOBAL_POSITION_INT
extends RefCounted


var time_boot_ms: int = 0
var lat: int = 0
var lon: int = 0
var alt: int = 0
var relative_alt: int = 0
var vx: int = 0
var vy: int = 0
var vz: int = 0
var hdg: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoGLOBAL_POSITION_INT.gd").new()
    if d.has("time_boot_ms"):
        obj.time_boot_ms = d["time_boot_ms"]
    if d.has("lat"):
        obj.lat = d["lat"]
    if d.has("lon"):
        obj.lon = d["lon"]
    if d.has("alt"):
        obj.alt = d["alt"]
    if d.has("relative_alt"):
        obj.relative_alt = d["relative_alt"]
    if d.has("vx"):
        obj.vx = d["vx"]
    if d.has("vy"):
        obj.vy = d["vy"]
    if d.has("vz"):
        obj.vz = d["vz"]
    if d.has("hdg"):
        obj.hdg = d["hdg"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_boot_ms"] = time_boot_ms
    d["lat"] = lat
    d["lon"] = lon
    d["alt"] = alt
    d["relative_alt"] = relative_alt
    d["vx"] = vx
    d["vy"] = vy
    d["vz"] = vz
    d["hdg"] = hdg
    return d

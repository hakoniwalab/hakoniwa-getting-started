class_name HakoPdu_hako_mavlink_msgs_HakoSystemTime
extends RefCounted


var time_unix_usec: int = 0
var time_boot_ms: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoSystemTime.gd").new()
    if d.has("time_unix_usec"):
        obj.time_unix_usec = d["time_unix_usec"]
    if d.has("time_boot_ms"):
        obj.time_boot_ms = d["time_boot_ms"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_unix_usec"] = time_unix_usec
    d["time_boot_ms"] = time_boot_ms
    return d

class_name HakoPdu_hako_mavlink_msgs_HakoHeartbeat
extends RefCounted


var type: int = 0
var autopilot: int = 0
var base_mode: int = 0
var custom_mode: int = 0
var system_status: int = 0
var mavlink_version: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoHeartbeat.gd").new()
    if d.has("type"):
        obj.type = d["type"]
    if d.has("autopilot"):
        obj.autopilot = d["autopilot"]
    if d.has("base_mode"):
        obj.base_mode = d["base_mode"]
    if d.has("custom_mode"):
        obj.custom_mode = d["custom_mode"]
    if d.has("system_status"):
        obj.system_status = d["system_status"]
    if d.has("mavlink_version"):
        obj.mavlink_version = d["mavlink_version"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["type"] = type
    d["autopilot"] = autopilot
    d["base_mode"] = base_mode
    d["custom_mode"] = custom_mode
    d["system_status"] = system_status
    d["mavlink_version"] = mavlink_version
    return d

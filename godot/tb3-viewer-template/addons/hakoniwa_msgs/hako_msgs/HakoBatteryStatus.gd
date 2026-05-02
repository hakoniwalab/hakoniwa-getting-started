class_name HakoPdu_hako_msgs_HakoBatteryStatus
extends RefCounted


var full_voltage: float = 0.0
var curr_voltage: float = 0.0
var curr_temp: float = 0.0
var status: int = 0
var cycles: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/HakoBatteryStatus.gd").new()
    if d.has("full_voltage"):
        obj.full_voltage = d["full_voltage"]
    if d.has("curr_voltage"):
        obj.curr_voltage = d["curr_voltage"]
    if d.has("curr_temp"):
        obj.curr_temp = d["curr_temp"]
    if d.has("status"):
        obj.status = d["status"]
    if d.has("cycles"):
        obj.cycles = d["cycles"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["full_voltage"] = full_voltage
    d["curr_voltage"] = curr_voltage
    d["curr_temp"] = curr_temp
    d["status"] = status
    d["cycles"] = cycles
    return d

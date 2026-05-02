class_name HakoPdu_ev3_msgs_Ev3PduSensorHeader
extends RefCounted


var name: String = ""
var version: int = 0
var hakoniwa_time: int = 0
var ext_off: int = 0
var ext_size: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/ev3_msgs/Ev3PduSensorHeader.gd").new()
    if d.has("name"):
        obj.name = d["name"]
    if d.has("version"):
        obj.version = d["version"]
    if d.has("hakoniwa_time"):
        obj.hakoniwa_time = d["hakoniwa_time"]
    if d.has("ext_off"):
        obj.ext_off = d["ext_off"]
    if d.has("ext_size"):
        obj.ext_size = d["ext_size"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["name"] = name
    d["version"] = version
    d["hakoniwa_time"] = hakoniwa_time
    d["ext_off"] = ext_off
    d["ext_size"] = ext_size
    return d

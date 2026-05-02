class_name HakoPdu_hako_mavlink_msgs_HakoSERVO_OUTPUT_RAW
extends RefCounted


var time_usec: int = 0
var port: int = 0
var servo1_raw: int = 0
var servo2_raw: int = 0
var servo3_raw: int = 0
var servo4_raw: int = 0
var servo5_raw: int = 0
var servo6_raw: int = 0
var servo7_raw: int = 0
var servo8_raw: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoSERVO_OUTPUT_RAW.gd").new()
    if d.has("time_usec"):
        obj.time_usec = d["time_usec"]
    if d.has("port"):
        obj.port = d["port"]
    if d.has("servo1_raw"):
        obj.servo1_raw = d["servo1_raw"]
    if d.has("servo2_raw"):
        obj.servo2_raw = d["servo2_raw"]
    if d.has("servo3_raw"):
        obj.servo3_raw = d["servo3_raw"]
    if d.has("servo4_raw"):
        obj.servo4_raw = d["servo4_raw"]
    if d.has("servo5_raw"):
        obj.servo5_raw = d["servo5_raw"]
    if d.has("servo6_raw"):
        obj.servo6_raw = d["servo6_raw"]
    if d.has("servo7_raw"):
        obj.servo7_raw = d["servo7_raw"]
    if d.has("servo8_raw"):
        obj.servo8_raw = d["servo8_raw"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_usec"] = time_usec
    d["port"] = port
    d["servo1_raw"] = servo1_raw
    d["servo2_raw"] = servo2_raw
    d["servo3_raw"] = servo3_raw
    d["servo4_raw"] = servo4_raw
    d["servo5_raw"] = servo5_raw
    d["servo6_raw"] = servo6_raw
    d["servo7_raw"] = servo7_raw
    d["servo8_raw"] = servo8_raw
    return d

class_name HakoPdu_hako_mavlink2_msgs_HakoSERVO_OUTPUT_RAW
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
var servo9_raw: int = 0
var servo10_raw: int = 0
var servo11_raw: int = 0
var servo12_raw: int = 0
var servo13_raw: int = 0
var servo14_raw: int = 0
var servo15_raw: int = 0
var servo16_raw: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink2_msgs/HakoSERVO_OUTPUT_RAW.gd").new()
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
    if d.has("servo9_raw"):
        obj.servo9_raw = d["servo9_raw"]
    if d.has("servo10_raw"):
        obj.servo10_raw = d["servo10_raw"]
    if d.has("servo11_raw"):
        obj.servo11_raw = d["servo11_raw"]
    if d.has("servo12_raw"):
        obj.servo12_raw = d["servo12_raw"]
    if d.has("servo13_raw"):
        obj.servo13_raw = d["servo13_raw"]
    if d.has("servo14_raw"):
        obj.servo14_raw = d["servo14_raw"]
    if d.has("servo15_raw"):
        obj.servo15_raw = d["servo15_raw"]
    if d.has("servo16_raw"):
        obj.servo16_raw = d["servo16_raw"]
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
    d["servo9_raw"] = servo9_raw
    d["servo10_raw"] = servo10_raw
    d["servo11_raw"] = servo11_raw
    d["servo12_raw"] = servo12_raw
    d["servo13_raw"] = servo13_raw
    d["servo14_raw"] = servo14_raw
    d["servo15_raw"] = servo15_raw
    d["servo16_raw"] = servo16_raw
    return d

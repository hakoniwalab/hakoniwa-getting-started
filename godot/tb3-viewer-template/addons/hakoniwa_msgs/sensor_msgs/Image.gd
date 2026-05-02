class_name HakoPdu_sensor_msgs_Image
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var height: int = 0
var width: int = 0
var encoding: String = ""
var is_bigendian: int = 0
var step: int = 0
var data: PackedByteArray = PackedByteArray()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/sensor_msgs/Image.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("height"):
        obj.height = d["height"]
    if d.has("width"):
        obj.width = d["width"]
    if d.has("encoding"):
        obj.encoding = d["encoding"]
    if d.has("is_bigendian"):
        obj.is_bigendian = d["is_bigendian"]
    if d.has("step"):
        obj.step = d["step"]
    if d.has("data"):
        obj.data = d["data"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["height"] = height
    d["width"] = width
    d["encoding"] = encoding
    d["is_bigendian"] = is_bigendian
    d["step"] = step
    d["data"] = data
    return d

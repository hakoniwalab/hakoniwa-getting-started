class_name HakoPdu_sensor_msgs_PointCloud2
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const PointFieldScript = preload("./PointField.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var height: int = 0
var width: int = 0
var fields: Array = []
var is_bigendian: bool = false
var point_step: int = 0
var row_step: int = 0
var data: PackedByteArray = PackedByteArray()
var is_dense: bool = false

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/sensor_msgs/PointCloud2.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("height"):
        obj.height = d["height"]
    if d.has("width"):
        obj.width = d["width"]
    if d.has("fields"):
        obj.fields = []
        for item in d["fields"]:
            obj.fields.append(PointFieldScript.from_dict(item))
    if d.has("is_bigendian"):
        obj.is_bigendian = d["is_bigendian"]
    if d.has("point_step"):
        obj.point_step = d["point_step"]
    if d.has("row_step"):
        obj.row_step = d["row_step"]
    if d.has("data"):
        obj.data = d["data"]
    if d.has("is_dense"):
        obj.is_dense = d["is_dense"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["height"] = height
    d["width"] = width
    var fields_array: Array = []
    for item in fields:
        fields_array.append(item.to_dict())
    d["fields"] = fields_array
    d["is_bigendian"] = is_bigendian
    d["point_step"] = point_step
    d["row_step"] = row_step
    d["data"] = data
    d["is_dense"] = is_dense
    return d

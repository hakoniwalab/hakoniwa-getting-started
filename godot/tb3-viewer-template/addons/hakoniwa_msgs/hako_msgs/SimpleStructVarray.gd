class_name HakoPdu_hako_msgs_SimpleStructVarray
extends RefCounted


const SimpleVarrayScript = preload("./SimpleVarray.gd")


var aaa: int = 0
var fixed_str: Array[String] = []
var varray_str: Array[String] = []
var fixed_array: Array = []
var data: Array = []

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/SimpleStructVarray.gd").new()
    if d.has("aaa"):
        obj.aaa = d["aaa"]
    if d.has("fixed_str"):
        obj.fixed_str = d["fixed_str"]
    if d.has("varray_str"):
        obj.varray_str = d["varray_str"]
    if d.has("fixed_array"):
        obj.fixed_array = []
        for item in d["fixed_array"]:
            obj.fixed_array.append(SimpleVarrayScript.from_dict(item))
    if d.has("data"):
        obj.data = []
        for item in d["data"]:
            obj.data.append(SimpleVarrayScript.from_dict(item))
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["aaa"] = aaa
    d["fixed_str"] = fixed_str
    d["varray_str"] = varray_str
    var fixed_array_array: Array = []
    for item in fixed_array:
        fixed_array_array.append(item.to_dict())
    d["fixed_array"] = fixed_array_array
    var data_array: Array = []
    for item in data:
        data_array.append(item.to_dict())
    d["data"] = data_array
    return d

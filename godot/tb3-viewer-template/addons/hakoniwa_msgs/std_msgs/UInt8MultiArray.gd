class_name HakoPdu_std_msgs_UInt8MultiArray
extends RefCounted


const MultiArrayDimensionScript = preload("./MultiArrayDimension.gd")


const MultiArrayLayoutScript = preload("./MultiArrayLayout.gd")


var layout = null
var data: PackedByteArray = PackedByteArray()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/std_msgs/UInt8MultiArray.gd").new()
    if d.has("layout"):
        obj.layout = MultiArrayLayoutScript.from_dict(d["layout"])
    if d.has("data"):
        obj.data = d["data"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["layout"] = layout.to_dict()
    d["data"] = data
    return d

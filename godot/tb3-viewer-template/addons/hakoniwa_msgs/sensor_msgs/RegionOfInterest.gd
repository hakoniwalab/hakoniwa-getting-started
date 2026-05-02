class_name HakoPdu_sensor_msgs_RegionOfInterest
extends RefCounted


var x_offset: int = 0
var y_offset: int = 0
var height: int = 0
var width: int = 0
var do_rectify: bool = false

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/sensor_msgs/RegionOfInterest.gd").new()
    if d.has("x_offset"):
        obj.x_offset = d["x_offset"]
    if d.has("y_offset"):
        obj.y_offset = d["y_offset"]
    if d.has("height"):
        obj.height = d["height"]
    if d.has("width"):
        obj.width = d["width"]
    if d.has("do_rectify"):
        obj.do_rectify = d["do_rectify"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["x_offset"] = x_offset
    d["y_offset"] = y_offset
    d["height"] = height
    d["width"] = width
    d["do_rectify"] = do_rectify
    return d

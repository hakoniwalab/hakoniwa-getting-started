class_name HakoPdu_geometry_msgs_Quaternion
extends RefCounted


var x: float = 0.0
var y: float = 0.0
var z: float = 0.0
var w: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/geometry_msgs/Quaternion.gd").new()
    if d.has("x"):
        obj.x = d["x"]
    if d.has("y"):
        obj.y = d["y"]
    if d.has("z"):
        obj.z = d["z"]
    if d.has("w"):
        obj.w = d["w"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["x"] = x
    d["y"] = y
    d["z"] = z
    d["w"] = w
    return d

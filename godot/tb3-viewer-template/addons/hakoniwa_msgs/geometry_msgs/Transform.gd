class_name HakoPdu_geometry_msgs_Transform
extends RefCounted


const QuaternionScript = preload("./Quaternion.gd")


const Vector3Script = preload("./Vector3.gd")


var translation = null
var rotation = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/geometry_msgs/Transform.gd").new()
    if d.has("translation"):
        obj.translation = Vector3Script.from_dict(d["translation"])
    if d.has("rotation"):
        obj.rotation = QuaternionScript.from_dict(d["rotation"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["translation"] = translation.to_dict()
    d["rotation"] = rotation.to_dict()
    return d

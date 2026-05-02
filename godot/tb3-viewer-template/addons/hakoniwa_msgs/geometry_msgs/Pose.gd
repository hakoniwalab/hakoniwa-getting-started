class_name HakoPdu_geometry_msgs_Pose
extends RefCounted


const PointScript = preload("./Point.gd")


const QuaternionScript = preload("./Quaternion.gd")


var position = null
var orientation = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/geometry_msgs/Pose.gd").new()
    if d.has("position"):
        obj.position = PointScript.from_dict(d["position"])
    if d.has("orientation"):
        obj.orientation = QuaternionScript.from_dict(d["orientation"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["position"] = position.to_dict()
    d["orientation"] = orientation.to_dict()
    return d

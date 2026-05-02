class_name HakoPdu_geometry_msgs_Twist
extends RefCounted


const Vector3Script = preload("./Vector3.gd")


var linear = null
var angular = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/geometry_msgs/Twist.gd").new()
    if d.has("linear"):
        obj.linear = Vector3Script.from_dict(d["linear"])
    if d.has("angular"):
        obj.angular = Vector3Script.from_dict(d["angular"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["linear"] = linear.to_dict()
    d["angular"] = angular.to_dict()
    return d

class_name HakoPdu_hako_msgs_DisturbanceBoundary
extends RefCounted


const PointScript = preload("../geometry_msgs/Point.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var boundary_point = null
var boundary_normal = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/DisturbanceBoundary.gd").new()
    if d.has("boundary_point"):
        obj.boundary_point = PointScript.from_dict(d["boundary_point"])
    if d.has("boundary_normal"):
        obj.boundary_normal = Vector3Script.from_dict(d["boundary_normal"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["boundary_point"] = boundary_point.to_dict()
    d["boundary_normal"] = boundary_normal.to_dict()
    return d

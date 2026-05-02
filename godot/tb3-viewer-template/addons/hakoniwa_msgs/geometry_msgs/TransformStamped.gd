class_name HakoPdu_geometry_msgs_TransformStamped
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const QuaternionScript = preload("./Quaternion.gd")


const TransformScript = preload("./Transform.gd")


const Vector3Script = preload("./Vector3.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var child_frame_id: String = ""
var transform = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/geometry_msgs/TransformStamped.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("child_frame_id"):
        obj.child_frame_id = d["child_frame_id"]
    if d.has("transform"):
        obj.transform = TransformScript.from_dict(d["transform"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["child_frame_id"] = child_frame_id
    d["transform"] = transform.to_dict()
    return d

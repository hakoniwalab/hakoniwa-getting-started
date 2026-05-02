class_name HakoPdu_tf2_msgs_TFMessage
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const QuaternionScript = preload("../geometry_msgs/Quaternion.gd")


const TransformScript = preload("../geometry_msgs/Transform.gd")


const TransformStampedScript = preload("../geometry_msgs/TransformStamped.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var transforms: Array = []

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/tf2_msgs/TFMessage.gd").new()
    if d.has("transforms"):
        obj.transforms = []
        for item in d["transforms"]:
            obj.transforms.append(TransformStampedScript.from_dict(item))
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    var transforms_array: Array = []
    for item in transforms:
        transforms_array.append(item.to_dict())
    d["transforms"] = transforms_array
    return d

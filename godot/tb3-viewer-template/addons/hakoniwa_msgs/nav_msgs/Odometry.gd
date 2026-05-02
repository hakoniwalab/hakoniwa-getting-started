class_name HakoPdu_nav_msgs_Odometry
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const PointScript = preload("../geometry_msgs/Point.gd")


const PoseScript = preload("../geometry_msgs/Pose.gd")


const PoseWithCovarianceScript = preload("../geometry_msgs/PoseWithCovariance.gd")


const QuaternionScript = preload("../geometry_msgs/Quaternion.gd")


const TwistScript = preload("../geometry_msgs/Twist.gd")


const TwistWithCovarianceScript = preload("../geometry_msgs/TwistWithCovariance.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var child_frame_id: String = ""
var pose = null
var twist = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/nav_msgs/Odometry.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("child_frame_id"):
        obj.child_frame_id = d["child_frame_id"]
    if d.has("pose"):
        obj.pose = PoseWithCovarianceScript.from_dict(d["pose"])
    if d.has("twist"):
        obj.twist = TwistWithCovarianceScript.from_dict(d["twist"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["child_frame_id"] = child_frame_id
    d["pose"] = pose.to_dict()
    d["twist"] = twist.to_dict()
    return d

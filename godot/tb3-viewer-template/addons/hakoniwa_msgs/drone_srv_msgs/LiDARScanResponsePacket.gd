class_name HakoPdu_drone_srv_msgs_LiDARScanResponsePacket
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const LiDARScanResponseScript = preload("./LiDARScanResponse.gd")


const PointScript = preload("../geometry_msgs/Point.gd")


const PoseScript = preload("../geometry_msgs/Pose.gd")


const QuaternionScript = preload("../geometry_msgs/Quaternion.gd")


const ServiceResponseHeaderScript = preload("../hako_srv_msgs/ServiceResponseHeader.gd")


const PointCloud2Script = preload("../sensor_msgs/PointCloud2.gd")


const PointFieldScript = preload("../sensor_msgs/PointField.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var body = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/LiDARScanResponsePacket.gd").new()
    if d.has("header"):
        obj.header = ServiceResponseHeaderScript.from_dict(d["header"])
    if d.has("body"):
        obj.body = LiDARScanResponseScript.from_dict(d["body"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["body"] = body.to_dict()
    return d

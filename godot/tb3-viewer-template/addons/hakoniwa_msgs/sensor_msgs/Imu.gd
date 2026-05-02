class_name HakoPdu_sensor_msgs_Imu
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const QuaternionScript = preload("../geometry_msgs/Quaternion.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var orientation = null
var orientation_covariance: PackedFloat64Array = PackedFloat64Array()
var angular_velocity = null
var angular_velocity_covariance: PackedFloat64Array = PackedFloat64Array()
var linear_acceleration = null
var linear_acceleration_covariance: PackedFloat64Array = PackedFloat64Array()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/sensor_msgs/Imu.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("orientation"):
        obj.orientation = QuaternionScript.from_dict(d["orientation"])
    if d.has("orientation_covariance"):
        obj.orientation_covariance = d["orientation_covariance"]
    if d.has("angular_velocity"):
        obj.angular_velocity = Vector3Script.from_dict(d["angular_velocity"])
    if d.has("angular_velocity_covariance"):
        obj.angular_velocity_covariance = d["angular_velocity_covariance"]
    if d.has("linear_acceleration"):
        obj.linear_acceleration = Vector3Script.from_dict(d["linear_acceleration"])
    if d.has("linear_acceleration_covariance"):
        obj.linear_acceleration_covariance = d["linear_acceleration_covariance"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["orientation"] = orientation.to_dict()
    d["orientation_covariance"] = orientation_covariance
    d["angular_velocity"] = angular_velocity.to_dict()
    d["angular_velocity_covariance"] = angular_velocity_covariance
    d["linear_acceleration"] = linear_acceleration.to_dict()
    d["linear_acceleration_covariance"] = linear_acceleration_covariance
    return d

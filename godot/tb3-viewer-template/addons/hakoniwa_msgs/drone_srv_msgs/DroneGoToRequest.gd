class_name HakoPdu_drone_srv_msgs_DroneGoToRequest
extends RefCounted


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var drone_name: String = ""
var target_pose = null
var speed_m_s: float = 0.0
var yaw_deg: float = 0.0
var tolerance_m: float = 0.0
var timeout_sec: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/DroneGoToRequest.gd").new()
    if d.has("drone_name"):
        obj.drone_name = d["drone_name"]
    if d.has("target_pose"):
        obj.target_pose = Vector3Script.from_dict(d["target_pose"])
    if d.has("speed_m_s"):
        obj.speed_m_s = d["speed_m_s"]
    if d.has("yaw_deg"):
        obj.yaw_deg = d["yaw_deg"]
    if d.has("tolerance_m"):
        obj.tolerance_m = d["tolerance_m"]
    if d.has("timeout_sec"):
        obj.timeout_sec = d["timeout_sec"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["drone_name"] = drone_name
    d["target_pose"] = target_pose.to_dict()
    d["speed_m_s"] = speed_m_s
    d["yaw_deg"] = yaw_deg
    d["tolerance_m"] = tolerance_m
    d["timeout_sec"] = timeout_sec
    return d

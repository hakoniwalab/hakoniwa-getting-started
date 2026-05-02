class_name HakoPdu_drone_srv_msgs_DroneGetStateResponse
extends RefCounted


const PointScript = preload("../geometry_msgs/Point.gd")


const PoseScript = preload("../geometry_msgs/Pose.gd")


const QuaternionScript = preload("../geometry_msgs/Quaternion.gd")


const HakoBatteryStatusScript = preload("../hako_msgs/HakoBatteryStatus.gd")


var ok: bool = false
var is_ready: bool = false
var current_pose = null
var battery_status = null
var mode: String = ""
var message: String = ""

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/DroneGetStateResponse.gd").new()
    if d.has("ok"):
        obj.ok = d["ok"]
    if d.has("is_ready"):
        obj.is_ready = d["is_ready"]
    if d.has("current_pose"):
        obj.current_pose = PoseScript.from_dict(d["current_pose"])
    if d.has("battery_status"):
        obj.battery_status = HakoBatteryStatusScript.from_dict(d["battery_status"])
    if d.has("mode"):
        obj.mode = d["mode"]
    if d.has("message"):
        obj.message = d["message"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["ok"] = ok
    d["is_ready"] = is_ready
    d["current_pose"] = current_pose.to_dict()
    d["battery_status"] = battery_status.to_dict()
    d["mode"] = mode
    d["message"] = message
    return d

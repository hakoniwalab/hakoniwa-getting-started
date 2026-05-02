class_name HakoPdu_hako_mavlink_msgs_HakoATTITUDE
extends RefCounted


var time_boot_ms: int = 0
var roll: float = 0.0
var pitch: float = 0.0
var yaw: float = 0.0
var rollspeed: float = 0.0
var pitchspeed: float = 0.0
var yawspeed: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoATTITUDE.gd").new()
    if d.has("time_boot_ms"):
        obj.time_boot_ms = d["time_boot_ms"]
    if d.has("roll"):
        obj.roll = d["roll"]
    if d.has("pitch"):
        obj.pitch = d["pitch"]
    if d.has("yaw"):
        obj.yaw = d["yaw"]
    if d.has("rollspeed"):
        obj.rollspeed = d["rollspeed"]
    if d.has("pitchspeed"):
        obj.pitchspeed = d["pitchspeed"]
    if d.has("yawspeed"):
        obj.yawspeed = d["yawspeed"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_boot_ms"] = time_boot_ms
    d["roll"] = roll
    d["pitch"] = pitch
    d["yaw"] = yaw
    d["rollspeed"] = rollspeed
    d["pitchspeed"] = pitchspeed
    d["yawspeed"] = yawspeed
    return d

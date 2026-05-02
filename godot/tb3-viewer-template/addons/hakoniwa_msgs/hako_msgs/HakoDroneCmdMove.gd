class_name HakoPdu_hako_msgs_HakoDroneCmdMove
extends RefCounted


const HakoDroneCmdHeaderScript = preload("./HakoDroneCmdHeader.gd")


var header = null
var x: float = 0.0
var y: float = 0.0
var z: float = 0.0
var speed: float = 0.0
var yaw_deg: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/HakoDroneCmdMove.gd").new()
    if d.has("header"):
        obj.header = HakoDroneCmdHeaderScript.from_dict(d["header"])
    if d.has("x"):
        obj.x = d["x"]
    if d.has("y"):
        obj.y = d["y"]
    if d.has("z"):
        obj.z = d["z"]
    if d.has("speed"):
        obj.speed = d["speed"]
    if d.has("yaw_deg"):
        obj.yaw_deg = d["yaw_deg"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["x"] = x
    d["y"] = y
    d["z"] = z
    d["speed"] = speed
    d["yaw_deg"] = yaw_deg
    return d

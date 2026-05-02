class_name HakoPdu_can_msgs_HakoCanHead
extends RefCounted


var channel: int = 0
var ide: int = 0
var rtr: int = 0
var dlc: int = 0
var canid: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/can_msgs/HakoCanHead.gd").new()
    if d.has("channel"):
        obj.channel = d["channel"]
    if d.has("ide"):
        obj.ide = d["ide"]
    if d.has("rtr"):
        obj.rtr = d["rtr"]
    if d.has("dlc"):
        obj.dlc = d["dlc"]
    if d.has("canid"):
        obj.canid = d["canid"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["channel"] = channel
    d["ide"] = ide
    d["rtr"] = rtr
    d["dlc"] = dlc
    d["canid"] = canid
    return d

class_name HakoPdu_hako_msgs_Disturbance
extends RefCounted


const PointScript = preload("../geometry_msgs/Point.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


const DisturbanceAtmScript = preload("./DisturbanceAtm.gd")


const DisturbanceBoundaryScript = preload("./DisturbanceBoundary.gd")


const DisturbanceTemperatureScript = preload("./DisturbanceTemperature.gd")


const DisturbanceUserCustomScript = preload("./DisturbanceUserCustom.gd")


const DisturbanceWindScript = preload("./DisturbanceWind.gd")


var d_temp = null
var d_wind = null
var d_atm = null
var d_boundary = null
var d_user_custom: Array = []

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/Disturbance.gd").new()
    if d.has("d_temp"):
        obj.d_temp = DisturbanceTemperatureScript.from_dict(d["d_temp"])
    if d.has("d_wind"):
        obj.d_wind = DisturbanceWindScript.from_dict(d["d_wind"])
    if d.has("d_atm"):
        obj.d_atm = DisturbanceAtmScript.from_dict(d["d_atm"])
    if d.has("d_boundary"):
        obj.d_boundary = DisturbanceBoundaryScript.from_dict(d["d_boundary"])
    if d.has("d_user_custom"):
        obj.d_user_custom = []
        for item in d["d_user_custom"]:
            obj.d_user_custom.append(DisturbanceUserCustomScript.from_dict(item))
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["d_temp"] = d_temp.to_dict()
    d["d_wind"] = d_wind.to_dict()
    d["d_atm"] = d_atm.to_dict()
    d["d_boundary"] = d_boundary.to_dict()
    var d_user_custom_array: Array = []
    for item in d_user_custom:
        d_user_custom_array.append(item.to_dict())
    d["d_user_custom"] = d_user_custom_array
    return d

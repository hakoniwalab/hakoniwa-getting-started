class_name HakoPdu_hako_mavlink_msgs_HakoHilStateQuaternion
extends RefCounted


var time_usec: int = 0
var attitude_quaternion: PackedFloat32Array = PackedFloat32Array()
var rollspeed: float = 0.0
var pitchspeed: float = 0.0
var yawspeed: float = 0.0
var lat: int = 0
var lon: int = 0
var alt: int = 0
var vx: int = 0
var vy: int = 0
var vz: int = 0
var ind_airspeed: int = 0
var true_airspeed: int = 0
var xacc: int = 0
var yacc: int = 0
var zacc: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoHilStateQuaternion.gd").new()
    if d.has("time_usec"):
        obj.time_usec = d["time_usec"]
    if d.has("attitude_quaternion"):
        obj.attitude_quaternion = d["attitude_quaternion"]
    if d.has("rollspeed"):
        obj.rollspeed = d["rollspeed"]
    if d.has("pitchspeed"):
        obj.pitchspeed = d["pitchspeed"]
    if d.has("yawspeed"):
        obj.yawspeed = d["yawspeed"]
    if d.has("lat"):
        obj.lat = d["lat"]
    if d.has("lon"):
        obj.lon = d["lon"]
    if d.has("alt"):
        obj.alt = d["alt"]
    if d.has("vx"):
        obj.vx = d["vx"]
    if d.has("vy"):
        obj.vy = d["vy"]
    if d.has("vz"):
        obj.vz = d["vz"]
    if d.has("ind_airspeed"):
        obj.ind_airspeed = d["ind_airspeed"]
    if d.has("true_airspeed"):
        obj.true_airspeed = d["true_airspeed"]
    if d.has("xacc"):
        obj.xacc = d["xacc"]
    if d.has("yacc"):
        obj.yacc = d["yacc"]
    if d.has("zacc"):
        obj.zacc = d["zacc"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_usec"] = time_usec
    d["attitude_quaternion"] = attitude_quaternion
    d["rollspeed"] = rollspeed
    d["pitchspeed"] = pitchspeed
    d["yawspeed"] = yawspeed
    d["lat"] = lat
    d["lon"] = lon
    d["alt"] = alt
    d["vx"] = vx
    d["vy"] = vy
    d["vz"] = vz
    d["ind_airspeed"] = ind_airspeed
    d["true_airspeed"] = true_airspeed
    d["xacc"] = xacc
    d["yacc"] = yacc
    d["zacc"] = zacc
    return d

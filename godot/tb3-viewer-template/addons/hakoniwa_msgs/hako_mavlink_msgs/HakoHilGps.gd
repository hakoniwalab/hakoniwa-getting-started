class_name HakoPdu_hako_mavlink_msgs_HakoHilGps
extends RefCounted


var time_usec: int = 0
var lat: int = 0
var lon: int = 0
var alt: int = 0
var eph: int = 0
var epv: int = 0
var vel: int = 0
var vn: int = 0
var ve: int = 0
var vd: int = 0
var cog: int = 0
var satellites_visible: int = 0
var id: int = 0
var yaw: int = 0
var fix_type: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoHilGps.gd").new()
    if d.has("time_usec"):
        obj.time_usec = d["time_usec"]
    if d.has("lat"):
        obj.lat = d["lat"]
    if d.has("lon"):
        obj.lon = d["lon"]
    if d.has("alt"):
        obj.alt = d["alt"]
    if d.has("eph"):
        obj.eph = d["eph"]
    if d.has("epv"):
        obj.epv = d["epv"]
    if d.has("vel"):
        obj.vel = d["vel"]
    if d.has("vn"):
        obj.vn = d["vn"]
    if d.has("ve"):
        obj.ve = d["ve"]
    if d.has("vd"):
        obj.vd = d["vd"]
    if d.has("cog"):
        obj.cog = d["cog"]
    if d.has("satellites_visible"):
        obj.satellites_visible = d["satellites_visible"]
    if d.has("id"):
        obj.id = d["id"]
    if d.has("yaw"):
        obj.yaw = d["yaw"]
    if d.has("fix_type"):
        obj.fix_type = d["fix_type"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_usec"] = time_usec
    d["lat"] = lat
    d["lon"] = lon
    d["alt"] = alt
    d["eph"] = eph
    d["epv"] = epv
    d["vel"] = vel
    d["vn"] = vn
    d["ve"] = ve
    d["vd"] = vd
    d["cog"] = cog
    d["satellites_visible"] = satellites_visible
    d["id"] = id
    d["yaw"] = yaw
    d["fix_type"] = fix_type
    return d

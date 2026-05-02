class_name HakoPdu_ev3_msgs_Ev3PduSensor
extends RefCounted


const Ev3PduColorSensorScript = preload("./Ev3PduColorSensor.gd")


const Ev3PduSensorHeaderScript = preload("./Ev3PduSensorHeader.gd")


const Ev3PduTouchSensorScript = preload("./Ev3PduTouchSensor.gd")


var head = null
var buttons: PackedByteArray = PackedByteArray()
var color_sensors: Array = []
var touch_sensors: Array = []
var motor_angle: Array = []
var gyro_degree: int = 0
var gyro_degree_rate: int = 0
var sensor_ultrasonic: int = 0
var gps_lat: float = 0.0
var gps_lon: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/ev3_msgs/Ev3PduSensor.gd").new()
    if d.has("head"):
        obj.head = Ev3PduSensorHeaderScript.from_dict(d["head"])
    if d.has("buttons"):
        obj.buttons = d["buttons"]
    if d.has("color_sensors"):
        obj.color_sensors = []
        for item in d["color_sensors"]:
            obj.color_sensors.append(Ev3PduColorSensorScript.from_dict(item))
    if d.has("touch_sensors"):
        obj.touch_sensors = []
        for item in d["touch_sensors"]:
            obj.touch_sensors.append(Ev3PduTouchSensorScript.from_dict(item))
    if d.has("motor_angle"):
        obj.motor_angle = d["motor_angle"]
    if d.has("gyro_degree"):
        obj.gyro_degree = d["gyro_degree"]
    if d.has("gyro_degree_rate"):
        obj.gyro_degree_rate = d["gyro_degree_rate"]
    if d.has("sensor_ultrasonic"):
        obj.sensor_ultrasonic = d["sensor_ultrasonic"]
    if d.has("gps_lat"):
        obj.gps_lat = d["gps_lat"]
    if d.has("gps_lon"):
        obj.gps_lon = d["gps_lon"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["head"] = head.to_dict()
    d["buttons"] = buttons
    var color_sensors_array: Array = []
    for item in color_sensors:
        color_sensors_array.append(item.to_dict())
    d["color_sensors"] = color_sensors_array
    var touch_sensors_array: Array = []
    for item in touch_sensors:
        touch_sensors_array.append(item.to_dict())
    d["touch_sensors"] = touch_sensors_array
    d["motor_angle"] = motor_angle
    d["gyro_degree"] = gyro_degree
    d["gyro_degree_rate"] = gyro_degree_rate
    d["sensor_ultrasonic"] = sensor_ultrasonic
    d["gps_lat"] = gps_lat
    d["gps_lon"] = gps_lon
    return d

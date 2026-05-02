class_name HakoPdu_ev3_msgs_Ev3PduActuator
extends RefCounted


const Ev3PduActuatorHeaderScript = preload("./Ev3PduActuatorHeader.gd")


const Ev3PduMotorScript = preload("./Ev3PduMotor.gd")


var head = null
var leds: PackedByteArray = PackedByteArray()
var motors: Array = []
var gyro_reset: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/ev3_msgs/Ev3PduActuator.gd").new()
    if d.has("head"):
        obj.head = Ev3PduActuatorHeaderScript.from_dict(d["head"])
    if d.has("leds"):
        obj.leds = d["leds"]
    if d.has("motors"):
        obj.motors = []
        for item in d["motors"]:
            obj.motors.append(Ev3PduMotorScript.from_dict(item))
    if d.has("gyro_reset"):
        obj.gyro_reset = d["gyro_reset"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["head"] = head.to_dict()
    d["leds"] = leds
    var motors_array: Array = []
    for item in motors:
        motors_array.append(item.to_dict())
    d["motors"] = motors_array
    d["gyro_reset"] = gyro_reset
    return d

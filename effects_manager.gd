extends Node

signal chaos_activated
signal chaos_deactivated

signal confuse_activated
signal confuse_deactivated

signal increase_activated(increase_by: float)

signal passthrough_activated
signal passthrough_deactivated
var active_passthrough := 0

signal speed_activated(multiplier: float)

signal sticky_activated
signal sticky_deactivated
var active_sticky := 0

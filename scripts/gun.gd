extends Node3D

#this needs to handle noita style sequential projectiles.
#we have a few key things to manage - what projectile is spawned, and when to spawn it.

#listed stats - cast delay(time after every shot), recharge time(time after all shots)
#total mana(pool to draw firing costs), mana recharge rate(time to fill that pool)
#capacity - number of spell slots, accuracy - obvious #also projectile speed multiplier, which is hidden

@export var cast_delay = 0
@export var recharge_time = 0
@export var total_mana = 0
@export var mana_recharge_rate = 0
@export var shot_capacity = 0
@export var base_inaccuracy = 0
@export var projectile_speed_modifier = 0

@export var model = 0 #corresponds to what type of gun or wand this is

# This is just Stefan testing to make sure he can commit and push changes to the repo.

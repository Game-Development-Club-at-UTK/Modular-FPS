extends CharacterBody3D

var timer = 0;
var health = 5
var moveSpeed = 4.5
var InputDirection = Vector2(0,0)
var mouseSensitivity = .1
var gravity = 10
var isGrounded = false
var jumpSpeed = 5

#charge shot that varies in speed, shrapnel floats and slows down, homing that floats then speeds up
#of course hitscans
#old monsterhunted wand styles, pitol-shotgun-dmr-standards. collect runes?
#shot types, accelerators, triggers, etc

func _ready():
	Input.mouse_mode = 2

func _process(delta): 
	
	#horizontal inputs
	InputDirection = Vector2(0,0)
	if Input.is_action_pressed("w"):
		InputDirection.y -= 1
	if Input.is_action_pressed("s"):
		InputDirection.y += 1
	if Input.is_action_pressed("a"):
		InputDirection.x -= 1
	if Input.is_action_pressed("d"):
		InputDirection.x += 1
	#this takes wasd stuff, rotates it so that w moves us the direction we're actually facing
	InputDirection = InputDirection.rotated(-self.rotation.y)
	InputDirection = InputDirection.normalized()
	velocity.x = InputDirection.x * moveSpeed
	velocity.z = InputDirection.y * moveSpeed

	#jump and gravity
	if not $RayCast3D.is_colliding(): #fall if we're not on the ground
		self.velocity.y -= gravity * delta
	else: #if we are on the ground, accept jump inputs
		self.velocity.y = 0.0
		if abs(self.global_position.y - $RayCast3D.get_collision_point().y) < .96:
			self.global_position.y = $RayCast3D.get_collision_point().y + .96
		if Input.is_action_just_pressed("space"):
			self.velocity.y += jumpSpeed

	move_and_slide()


func _input(event):
	#mouse input handling
	if event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)#
		self.rotation_degrees.y -= event.relative.x *  mouseSensitivity
		$camera.rotation_degrees.x -= event.relative.y *  mouseSensitivity

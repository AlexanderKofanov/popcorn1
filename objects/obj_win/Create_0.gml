var camera_width = obs.camera_w
var camera_height = obs.camera_h
x = camera_width / 2
y = camera_height / 2
scale = 0
time = 0
go = false
depth = -100
text_shift = 0
text_shift_time = 0
text_shift_side = false
can_go = false

conf = part_system_create()
part_system_depth(conf, depth + 1)

stars = part_system_create()
part_system_depth(stars, depth)

conf_particle = part_type_create()
part_type_size(conf_particle, 0.4, 0.7, 0, 0.2)
part_type_orientation(conf_particle, 0, 360, 4, 10, 0)
part_type_alpha2(conf_particle, 1, 0.5)
part_type_sprite(conf_particle, spr_conf, 0, 1, 1)
part_type_life(conf_particle, 260, 460)
part_type_gravity(conf_particle, 0.1, 270)
part_type_speed(conf_particle, 3, 8, -0.02, 0)
part_type_color_rgb(conf_particle, 0, 255, 0, 255, 0, 255)

conf_particle1 = part_type_create()
part_type_size(conf_particle1, 0.6, 0.8, 0, 0.2)
part_type_orientation(conf_particle1, 0, 360, 4, 10, 0)
part_type_alpha2(conf_particle1, 1, 0.5)
part_type_sprite(conf_particle1, spr_conf1, 0, 1, 0)
part_type_life(conf_particle1, 260, 460)
part_type_gravity(conf_particle1, 0.1, 270)
part_type_speed(conf_particle1, 3, 8, -0.02, 0)
part_type_color_rgb(conf_particle1, 0, 255, 0, 255, 0, 255)
part_type_size_x(conf_particle1, -1, 1, 0, 1)

star_particle = part_type_create()
part_type_sprite(star_particle, spr_star_particle, 0, 1, 1)
part_type_size(star_particle, 0.2, 0.85, -0.001, 0)
part_type_color1(star_particle, c_white)
part_type_alpha3(star_particle, 0, 1, 0)
part_type_life(star_particle, 160, 220)
part_type_speed(star_particle, 0.7, 2.1, -0.001, 0)
part_type_direction(star_particle, 0, 360, 0, 2)
part_type_orientation(star_particle, 0, 360, 1, 0, 0)
part_type_blend(star_particle, 1)

some_particle = part_type_create()
part_type_sprite(some_particle, spr_some_particle, 0, 1, 1)
part_type_size(some_particle, 0.4, 0.6, -0.001, 0)
part_type_color_rgb(some_particle, 0, 255, 0, 255, 0, 255)
part_type_alpha3(some_particle, 0, 1, 0)
part_type_life(some_particle, 160, 200)
part_type_speed(some_particle, 1.1, 2.1, -0.001, 0)
part_type_direction(some_particle, 0, 360, 0.4, 2)
part_type_orientation(some_particle, 0, 360, 1, 0, 0)
part_type_blend(some_particle, 1)



alarm[0] = 60
alarm[1] = 40
alarm[2] = 60
alarm[3] = 100
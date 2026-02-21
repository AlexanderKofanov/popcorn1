var xxx = camera_get_view_x(view_camera)
var xx = obs.camera_w / 2
var yy = obs.camera_h / 2 - 100

part_particles_create(stars, xxx + xx, yy, star_particle, 10)
part_particles_create(stars, xxx + xx, yy, some_particle, 10)

alarm[2] = 20
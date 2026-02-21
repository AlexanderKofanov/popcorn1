var xx = x
var yy = y

part_type_direction(conf_particle, 45, 90, 0, 20)
part_particles_create(conf, xx, yy + 300, conf_particle, 30)
part_type_direction(conf_particle1, 45, 90, 0, 20)
part_particles_create(conf, xx, yy + 200, conf_particle1, 20)

part_type_direction(conf_particle, 90, 135, 0, 20)
part_particles_create(conf, xx + obs.camera_w, yy + 300, conf_particle, 30)
part_type_direction(conf_particle1, 90, 135, 0, 20)
part_particles_create(conf, xx + obs.camera_w, yy + 200, conf_particle1, 20)

alarm[0] = 100
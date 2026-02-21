if part_system_exists(ps_table)
{
	part_system_destroy(ps_table);
}

part_type_destroy(pt_seed_hit);
part_type_destroy(pt_pop_burst);
part_type_destroy(pt_money);
part_type_destroy(pt_flame);

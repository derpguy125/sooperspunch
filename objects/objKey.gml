#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ds_list_find_index(global.saveroom, id) == -1 {
    for (i = 0; i < 32; i += 1) {
        var part;
        part = instance_create(x,y+16,objParticleParent);

        part.hsp = random_range(-3,3);
        part.vsp = random_range(-4,0);
        part.grv = 0.25;
        part.rot = irandom_range(-15,15);

        part.sprite_index = sprSparkle;
    }

    ds_list_add(global.saveroom, id)
}
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with objPlayer {
    if !global.hasKey then global.hasKey = true;
}

instance_destroy();
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (ds_list_find_index(global.saveroom, id) != -1)
    instance_destroy()

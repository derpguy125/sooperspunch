#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if ds_list_find_index(global.saveroom, id) == -1 {

    for (i = 0; i < 2; i += 1) {
        for (j = 0; j < 2; j += 1) {
            var part;
            part = instance_create((x+8) + (j*16),(y+8) + (i*16),objParticleParent);

            part.hsp = (irandom_range(-2,2));
            part.vsp = (irandom_range(-2,2));
            part.grv = 0.1;

            part.rot = irandom_range(-15,15);
            part.sprite_index = sprDestroyed;
            part.image_index = irandom_range(0,4);
            part.image_speed = 0;
        }
    }

    ds_list_add(global.saveroom, id);
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (ds_list_find_index(global.saveroom, id) != -1)
    instance_destroy()

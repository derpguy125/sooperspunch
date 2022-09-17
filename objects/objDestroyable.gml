#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i = 0; i < 4; i += 1) {
    for (j = 0; j < 4; j += 1) {
        var part;
        part = instance_create((x+4) + (j*8),(y+4) + (i*8),objParticleParent);

        part.hsp = (irandom_range(1,2) * ((j - 2)));
        part.vsp = (irandom_range(1,2) * ((i - 2)));
        part.grv = 0.1;

        part.rot = irandom_range(-15,15);
        part.sprite_index = sprDestroyed;
        part.image_index = irandom_range(0,4);
        part.image_speed = 0;
    }
}

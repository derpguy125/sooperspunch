#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
wave = 0;

wave2 = -320;

scale = 4;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
wave += 0.02;
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background(bgL1Sun,view_xview[0],view_yview[0]);

for (yy = 0; yy < 30; yy += 1) {
    for (xx = 0; xx < 70; xx += 1) {
        draw_background_part(bgSineWave,(xx mod 2)*8,(yy mod 2)*8,8,8,((view_xview[0] - ((view_xview[0]/((yy+1)/1.25))) mod 16)) + (xx*8) + (sin((wave + (yy/8))*2)*scale)-32,(view_yview[0] + view_hview[0]) - (yy*2) + (-cos((wave + (xx/16))*2)*scale)-156);
    }
}

draw_background_tiled(bgL1Sand1,view_xview[0] - ((view_xview[0] / 1.5) mod 480), view_yview[0]);

draw_background_tiled(bgL1Sand2,view_xview[0] - ((view_xview[0] / 1.25) mod 480), view_yview[0]);

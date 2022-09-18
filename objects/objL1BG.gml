#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
wave = 0;

wave2 = -320;

scale = 8;
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
background_index[0] = bgL1Sun;
background_index[1] = bgL1Hills;
background_index[2] = bgL1Sand1;
background_index[3] = bgL1Sand2;

background_x[0] = view_xview[0];
background_x[1] = view_xview[0] / 1.05;
background_x[2] = view_xview[0] / 1.2;
background_x[3] = view_xview[0] / 2;

background_y[0] = view_yview[0];
background_y[1] = view_yview[0];
background_y[2] = view_yview[0];
background_y[3] = view_yview[0];

background_visible[0] = true;
background_visible[1] = true;
background_visible[2] = true;
background_visible[3] = true;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (yy = 0; yy < 30; yy += 1) {
    for (xx = 0; xx < 70; xx += 1) {
        draw_background_part(bgSineWave,(xx mod 2)*8,(yy mod 2)*8,8,8,((view_xview[0] - ((view_xview[0]/((yy+1)/20))) mod 16)) + (xx*8) + (sin((wave + (yy/8))*2)*scale)-32,(view_yview[0] + view_hview[0]) - (yy*4) + (-cos((wave + (xx/16))*2)*scale)+8);
    }
}

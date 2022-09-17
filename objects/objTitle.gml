#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
wave = 0;

wave2 = -320;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
wave += 0.02;

wave2 += 2;
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprSpunchLogo,0,240,140,2,2,sin(wave)*8,c_white,1);
draw_sprite_ext(sprSpunchLogo,1,240,220 + sin(wave)*4,2,2,0,c_white,1);
#define KeyPress_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
room_goto(rmHUB);

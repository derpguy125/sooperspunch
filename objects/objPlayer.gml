#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// init shit

hsp = 0;
vsp = 0;

ground = true;
pound = false;

grv = 0.2;
jmp = -6.5;
mvs = 16;

dir = 1;
acc = 0.25;

top = 4;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///input shit

allow_input = true;
allow_x_movement = true;
allow_y_movement = true;

// input
        key_left                =   0;
        key_right               =   0;
        key_up                  =   0;
        key_down                =   0;
        key_action              =   0;
        key_action2             =   0;

        key_left_pressed        =   0;
        key_right_pressed       =   0;
        key_up_pressed          =   0;
        key_down_pressed        =   0;
        key_action_pressed      =   0;
        key_action2_pressed     =   0;

        key_left_released       =   0;
        key_right_released      =   0;
        key_up_released         =   0;
        key_down_released       =   0;
        key_action_released     =   0;
        key_action2_released    =   0;

        assigned_key_left       = vk_left;
        assigned_key_right      = vk_right;
        assigned_key_up         = vk_up;
        assigned_key_down       = vk_down;
        assigned_key_action     = ord("Z");
        assigned_key_action2    = ord("X");
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// other shit

global.spatulas = 0;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var moveKeys;
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// input shit
/* Hold */
         key_left    =   keyboard_check( assigned_key_left );
         key_right   =   keyboard_check( assigned_key_right );

         key_up      =   keyboard_check( assigned_key_up );
         key_down    =   keyboard_check( assigned_key_down );

         key_action  =   keyboard_check( assigned_key_action );
         key_action2 =   keyboard_check( assigned_key_action2 );

         /* Press */
         key_left_pressed    =   keyboard_check_pressed( assigned_key_left );
         key_right_pressed   =   keyboard_check_pressed( assigned_key_right );

         key_up_pressed      =   keyboard_check_pressed( assigned_key_up );
         key_down_pressed    =   keyboard_check_pressed( assigned_key_down );

         key_action_pressed  =   keyboard_check_pressed( assigned_key_action );
         key_action2_pressed =   keyboard_check_pressed( assigned_key_action2 );

         /* Release */
         key_left_released   =   keyboard_check_released( assigned_key_left );
         key_right_released  =   keyboard_check_released( assigned_key_right );

         key_up_released     =   keyboard_check_released( assigned_key_up );
         key_down_released   =   keyboard_check_released( assigned_key_down );

         key_action_released =   keyboard_check_released( assigned_key_action );
         key_action2_released=   keyboard_check_released( assigned_key_action2 );

         //Stop Walking:
         if(key_right && key_left){
            key_right = false;
            key_left  = false;
         }
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,round(x),round(y) + 6,
    1,1,0,c_white,1);

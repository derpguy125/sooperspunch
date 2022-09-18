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

ducking = false;
rolling = false;

attack = false;
lunge = false;
running = false;

grv = 0.2;
jmp = -6.5;
mvl = 16;

dir = 1;
acc = 0.25;

top = 4;

canVarJump = false;

targRoom = rmHUB;
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
        key_run                 =   0;

        key_left_pressed        =   0;
        key_right_pressed       =   0;
        key_up_pressed          =   0;
        key_down_pressed        =   0;
        key_action_pressed      =   0;
        key_action2_pressed     =   0;
        key_run_pressed         =   0;

        key_left_released       =   0;
        key_right_released      =   0;
        key_up_released         =   0;
        key_down_released       =   0;
        key_action_released     =   0;
        key_action2_released    =   0;
        key_run_released        =   0;

        assigned_key_left       = vk_left;
        assigned_key_right      = vk_right;
        assigned_key_up         = vk_up;
        assigned_key_down       = vk_down;
        assigned_key_action     = ord("Z");
        assigned_key_action2    = ord("X");
        assigned_key_run        = vk_shift;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// other shit

global.spatulas = 0;
global.hasKey = false;

lookShiftX = 0;
lookShiftY = 0;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
attack = false;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=601
applies_to=self
invert=0
arg0=player_collisions
arg1=0
arg2=0
arg3=0
arg4=0
arg5=0
*/
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// time for movement

// horizontal movement
var moveKeys;
moveKeys = key_right - key_left;

if !rolling and !attack and !lunge and !pound and moveKeys != 0 then {
    dir = moveKeys;
    if moveKeys = 1 then {
        if hsp <  top then hsp += acc; else hsp =  top;
    }
    if moveKeys = -1 then {
        if hsp > -top then hsp -= acc; else hsp = -top;
    }
} else {
    if hsp > acc then hsp -= acc;
    else if hsp < -acc then hsp += acc;
    else {
        hsp = 0;
        if ground and rolling then {
            rolling = false;
            if place_meeting(x,y-1,parSolid) then {
                ducking = true;
                mask_index = sprSpongeMaskSmall;
                acc = 0.1;
                top = 2;
            }
        }
    }
}

// dashing

if ground then {
    // jumping
    if !ducking and key_action_pressed then {
        vsp = jmp;
        ground = false;
        canVarJump = true;
    } else {
        if ducking and key_action2_pressed then {
            rolling = true;
            ducking = false;
            hsp = 16 * dir;

        }
    }

    // attacking
    if !attack and !ducking and !rolling and !lunge and !pound and hsp = 0 and key_action2_pressed then {
        attack = true;
        alarm[0] = 32;
        hsp = 0;

        var atk;
        atk = instance_create(x+(dir * 8),y+4,objAttackThing);
        atk.image_xscale = dir;
        atk.image_speed = 0.5;
        atk.image_alpha = 0;
    }

    // lunging
    if !lunge and !ducking and !rolling and !pound and hsp != 0 and key_action2_pressed then {
        lunge = true;
        vsp = jmp / 1.7;
        hsp = dir * top;
        ground = false;
        acc = 0;

        var atk;
        atk = instance_create(x,y,objLungeThing);
        atk.image_xscale = dir;
        atk.image_speed = 0.5;
        atk.image_alpha = 0;
    }

    //dashing
    if !ducking and !rolling and !attack and !lunge and !pound and key_run then {
        running = true;

    } else {
        running = false;
        if instance_exists(objDashThing) then with objDashThing instance_destroy();
    }

    // ducking
    if !rolling and key_down then {
        ducking = true;
        mask_index = sprSpongeMaskSmall;
        acc = 0.1;
        top = 2;
    } else if rolling then {
        mask_index = sprSpongeMaskSmall;
        top = 16;
        acc = 0.3;
    } else if lunge then {
        mask_index = sprSpongeMask;
        acc = 0;
        top = 4;
    } else if running then {
        mask_index = sprSpongeMask;
        acc = 0.25;
        top = 12;

        if hsp >= 8 and !instance_exists(objDashThing) then {
            var atk;
            atk = instance_create(x+(dir * 8),y+4,objDashThing);
            atk.image_xscale = dir;
            atk.image_speed = 0;
            atk.image_alpha = 0;
        }
    } else if !rolling and !lunge and !running and !place_meeting(x,y-1,parSolid) then {
        ducking = false;
        mask_index = sprSpongeMask;
        acc = 0.25;
        top = 4;
    }
}

//vertical movement
else {

    if canVarJump and vsp < -0.25 and key_action_released then {
        vsp = -0.25;
        canVarJump = false;
    }

    if !pound and key_down_pressed then {
        pound = true;
        vsp = mvl;
        hsp = 0;

        var atk;
        atk = instance_create(x,y+16,objGPoundThing);
        atk.image_speed = 0;
        atk.image_alpha = 0;
        atk.image_xscale = dir;
    }

    if vsp < mvl then vsp += grv;
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// block destroying

if rolling or lunge then {
    var block;
    block = instance_place(x+hsp,y,objDestroyable);

    if block != noone then {
        with block {
            instance_destroy();
        }
    }
}
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

         key_run     =   keyboard_check( assigned_key_run );

         /* Press */
         key_left_pressed    =   keyboard_check_pressed( assigned_key_left );
         key_right_pressed   =   keyboard_check_pressed( assigned_key_right );

         key_up_pressed      =   keyboard_check_pressed( assigned_key_up );
         key_down_pressed    =   keyboard_check_pressed( assigned_key_down );

         key_action_pressed  =   keyboard_check_pressed( assigned_key_action );
         key_action2_pressed =   keyboard_check_pressed( assigned_key_action2 );

         key_run_pressed     =   keyboard_check_pressed( assigned_key_run );

         /* Release */
         key_left_released   =   keyboard_check_released( assigned_key_left );
         key_right_released  =   keyboard_check_released( assigned_key_right );

         key_up_released     =   keyboard_check_released( assigned_key_up );
         key_down_released   =   keyboard_check_released( assigned_key_down );

         key_action_released =   keyboard_check_released( assigned_key_action );
         key_action2_released=   keyboard_check_released( assigned_key_action2 );

         key_run_released    =   keyboard_check_released( assigned_key_run );
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// Animation Code

var curSprite;
curSprite = sprite_index;

if ground then {
    if !ducking and !rolling and !attack then {
        var moveKeys;
        moveKeys = key_right - key_left;

        if moveKeys != 0 then {
            sprite_index = sprSpongeMove;
            image_speed = 0.5;
        } else {
            sprite_index = sprSpongeIdle;
            image_speed = 0.1;
        }
    } else if ducking then {
        sprite_index = sprSpongeDuck;
        image_speed = 0;
    } else if rolling then {
        sprite_index = sprSpongeRoll;
        image_speed = 0.3;
    } else if attack then {
        sprite_index = sprSpongeAttack;
        image_speed = 0.5;
    }
} else {
    if !rolling and !lunge and !pound then {
        sprite_index = sprSpongeJump;
        if vsp < 0 then {
            image_index = 0;
        } else {
            image_index = 1;
        }
    } else if rolling then {
        sprite_index = sprSpongeRoll;
        image_speed = 0.3;
    } else if lunge then {
        sprite_index = sprSpongeLunge;
        image_speed = 0.25;

        if image_index >= 7 then {
            image_speed = 0;
            image_index = 7;
        }
    } else if pound then {
        sprite_index = sprSpongePound;
        image_speed = 0;
    }
}

if curSprite != sprite_index then image_index = 0;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// View code

view_xview[0] = (round(x) - (view_wview[0] div 2)) + lookShiftX;
view_yview[0] = (round(y) - (view_hview[0] div 2)) + lookShiftY;

if view_xview[0] <= 0                           then view_xview[0] = 0;
if view_xview[0] >= room_width  - view_wview[0] then view_xview[0] = room_width  - view_wview[0];

if view_yview[0] <= 0                           then view_yview[0] = 0;
if view_yview[0] >= room_height - view_hview[0] then view_yview[0] = room_height - view_hview[0];
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/


if rolling or lunge or pound or running then {
    draw_sprite_ext(sprite_index,image_index,round(x - (hsp*3)),round(y - (vsp*3)) + 4,
        dir,1,0,c_white,0.25);

    draw_sprite_ext(sprite_index,image_index,round(x - (hsp*2)),round(y - (vsp*2)) + 4,
        dir,1,0,c_white,0.5);

    draw_sprite_ext(sprite_index,image_index,round(x - (hsp)),round(y - (vsp)) + 4,
        dir,1,0,c_white,0.75);
}

draw_sprite_ext(sprite_index,image_index,round(x),round(y) + 4,
    dir,1,0,c_white,1);



draw_text(view_xview[0],view_yview[0],"GOT KEY: " + string(global.hasKey) + "#DASHING: " + string(running));

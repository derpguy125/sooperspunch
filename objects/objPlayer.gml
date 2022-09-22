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
/// anim shit

idleSprite  = sprPIdle;
moveSprite  = sprPMove;
dashSprite  = sprPDash;

jumpSprite  = sprPJump;
dJumpSprite = sprPCrouchJump;
poundSprite = sprPPound;

lungeSprite = sprPIdle;
duckSprite  = sprPCrouch;
crawlSprite = sprPCrawl;
rollSprite  = sprPRoll;
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// other shit

global.spatulas = 0;
global.hasKey = false;

lookShiftX = 0;
lookShiftY = -48;

prevX[0] = x;
prevX[1] = x;
prevX[2] = x;
prevX[3] = x;

prevY[0] = y;
prevY[1] = y;
prevY[2] = y;
prevY[3] = y;
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
    var slop;
    slop = instance_place(x,y+1,parSlope);

    if rolling and slop != noone then {

        hsp += ((acc*2) * slop.dir);

        if sign(hsp) == slop.dir then dir = slop.dir;

    } else {
        if hsp > acc then hsp -= acc;
        else if hsp < -acc then hsp += acc;
        else {
            hsp = 0;
            if ground and rolling then {
                rolling = false;
                if instance_exists(objRollThing) then with objRollThing instance_destroy();
                if place_meeting(x,y-1,parSolid) then {
                    ducking = true;
                    mask_index = sprPMaskSmall;
                    acc = 0.1;
                    top = 2;
                }
            }
        }
    }
}

// dashing

if ground then {
    // jumping
    if key_action_pressed then {
        if ducking then {
            jmp = -3.5;
        } else jmp = -6.5;

        vsp = jmp;
        ground = false;
        canVarJump = true;
    }

    /* attacking
    if !attack and !ducking and !rolling and !lunge and !pound and hsp = 0 and key_action2_pressed then {
        attack = true;
        alarm[0] = 32;
        hsp = 0;

        var atk;
        atk = instance_create(x+(dir * 8),y+4,objAttackThing);
        atk.image_xscale = dir;
        atk.image_speed = 0.5;
        atk.image_alpha = 0;
    }*/

    /* lunging
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
    }*/

    //dashing
    if !ducking and !rolling and !attack and !pound and key_run then {
        running = true;

    } else {
        running = false;
        if instance_exists(objDashThing) then with objDashThing instance_destroy();
    }

    // ducking
    if !rolling and key_down then {
        if (running and abs(hsp) >= 8 and (dir == sign(hsp))) then {
            rolling = true;
            if !instance_exists(objRollThing) then {

                var atk;
                atk = instance_create(x+(dir * 8),y+4,objRollThing);
                atk.image_xscale = dir;
                atk.image_speed = 0;
                atk.image_alpha = 0;

            }
        } else {
            ducking = true;
            mask_index = sprPMaskSmall;
            acc = 0.1;
            top = 2;
        }
    } else if rolling then {
        mask_index = sprPMaskSmall;
        top = 16;
        acc = 0.1;
    } else if lunge then {
        mask_index = sprPMask;
        acc = 0;
        top = 4;
    } else if running then {
        mask_index = sprPMask;
        acc = 0.25;
        top = 12;

        if abs(hsp) >= 8 and (dir == sign(hsp)) then {
            if !instance_exists(objDashThing) {
                var atk;
                atk = instance_create(x+(dir * 8),y+4,objDashThing);
                atk.image_xscale = dir;
                atk.image_speed = 0;
                atk.image_alpha = 0;
            }
        } else {
            if instance_exists(objDashThing) then with objDashThing instance_destroy();
        }
    } else if !rolling and !lunge and !running and !place_meeting(x,y-1,parSolid) then {
        ducking = false;
        mask_index = sprPMask;
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

    }

    if vsp < mvl then vsp += grv;
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/// prevX and prevY

if rolling or lunge or pound or (running and abs(hsp) >= 8 and (dir == sign(hsp))) then {
    prevX[3] = prevX[2]; prevY[3] = prevY[2];
    prevX[2] = prevX[1]; prevY[2] = prevY[1];
    prevX[1] = prevX[0]; prevY[1] = prevY[0];
    prevX[0] = x; prevY[0] = y;
} else {
    prevX[3] = x; prevY[3] = y;
    prevX[2] = x; prevY[2] = y;
    prevX[1] = x; prevY[1] = y;
    prevX[0] = x; prevY[0] = y;
}
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
    if !rolling and !attack then {
        var moveKeys;
        moveKeys = key_right - key_left;

        if moveKeys != 0 then {
            if (running and abs(hsp) >= 8 and (dir == sign(hsp))) then {
                sprite_index = dashSprite;
                image_speed = 0.5;
            } else if ducking then {
                sprite_index = crawlSprite;
                image_speed = 0.1;
            } else {
                sprite_index = moveSprite;
                image_speed = 0.25;
            }
        } else {
            if ducking then {
                sprite_index = duckSprite;
                image_speed = 0;
            } else {
                sprite_index = idleSprite;
                image_speed = 0.1;
            }
        }
    }else if rolling then {
        sprite_index = rollSprite;
        image_speed = 0.5;
    } else if attack then {
        sprite_index = idleSprite;
        image_speed = 0.5;
    }
} else {
    if !rolling and !lunge and !pound then {
        if ducking then {
            sprite_index = dJumpSprite;
        } else {
            sprite_index = jumpSprite;
        }
    } else if rolling then {
        sprite_index = rollSprite;
        image_speed = 0.3;
    } else if lunge then {
        sprite_index = lungeSprite;
        image_speed = 0.25;

        if image_index >= 7 then {
            image_speed = 0;
            image_index = 7;
        }
    } else if pound then {
        sprite_index = poundSprite;
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


if rolling or lunge or pound or (running and abs(hsp) >= 8 and (dir == sign(hsp))) then {
    draw_sprite_ext(sprite_index,image_index,round(prevX[3]),round(prevY[3]),
        dir,1,0,c_white,0.1);

    draw_sprite_ext(sprite_index,image_index,round(prevX[2]),round(prevY[2]),
        dir,1,0,c_white,0.2);

    draw_sprite_ext(sprite_index,image_index,round(prevX[1]),round(prevY[1]),
        dir,1,0,c_white,0.5);

    draw_sprite_ext(sprite_index,image_index,round(prevX[0]),round(prevY[0]),
        dir,1,0,c_white,0.75);
}

draw_sprite_ext(sprite_index,image_index,round(x),round(y),
    dir,1,0,c_white,1);



if global.hasKey then draw_sprite(sprKey,0,view_xview[0]+16,view_yview[0]+16)

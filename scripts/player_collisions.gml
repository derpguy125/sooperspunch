///Collision code

//Horizontal collisions
/* OLD?
if place_meeting(x+hsp,y,parSolid) {
    while !place_meeting(x+sign(hsp),y,parSolid) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;
*/

if (place_meeting(x+hsp,y,parSolid)){
    //Up slope
    var yplus;
    yplus=0;
    while(place_meeting(x+hsp,y-yplus,parSolid)&&yplus<=abs(hsp)) yplus+=1; //change the abs(hsp) to 3*abs(hsp) if you want to be able to go up a 3-1 slope, etc..
    if(place_meeting(x+hsp,y-yplus,parSolid)){
        while(!place_meeting(x+sign(hsp),y,parSolid)) x += sign(hsp);
        hsp=0;
    }else{
        y-=yplus;
    }
}
x += hsp;

//Down slope
if !place_meeting(x,y,parSolid) && vsp >= 0 && place_meeting(x,y+2+abs(hsp),parSolid){
    while(!place_meeting(x,y+1,parSolid)) {
        y += 1;
    }
}

//Vertical collisions
if place_meeting(x,y+vsp,parSolid) {
    while !place_meeting(x,y+sign(vsp),parSolid) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

//One Way Solid Colissions
if position_meeting(round(x), round(y) + 32, parSemiSolid) && vsp > 0  {
    var wall, sprite_bbox_bottom;

    wall = instance_position(round(x), round(y) + 32, parSemiSolid);
    sprite_bbox_bottom = sprite_get_bbox_bottom(mask_index) - sprite_get_yoffset(mask_index);

        if (vsp > 0) { //down
        y = (wall.bbox_top-1) - sprite_bbox_bottom;

        //ground = true;
        /*if pound then {
            allow_input = true;
            pound = false;

            smoke_puffs();
        }*/
    }
    vsp = 0;
}

if place_meeting(x,y+1,parSolid) or ((!(place_meeting(x, y, parSemiSolid))) && place_meeting(x, (y + 1), parSemiSolid)) then {
    ground = true;
    if lunge then {
        lunge = false;
        if instance_exists(objLungeThing) then with objLungeThing instance_destroy();
    }
    if pound then {
        pound = false;
        if instance_exists(objGPoundThing) then with objGPoundThing instance_destroy();
    }
}
else ground = false;


/* side collisions

if x <= view_xview[0] + 16 then {
    x = view_xview[0] + 16;
    hsp = 0;
};

if x >= (view_xview[0] + view_wview[0]) - 16 then {
    x = (view_xview[0] + view_wview[0]) - 16;
    hsp = 0;
};

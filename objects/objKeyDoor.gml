#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
active = false;
opened = false;

alarm[0] = 5;
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
active = true;
#define Collision_objPlayer
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with objPlayer {
    if key_up_pressed and hsp = 0 and global.hasKey and ground and !attack and !lunge and !rolling and !pound then {
        with other {
            ds_list_add(global.saveroom, id);
        }

        x = other.targetX;
        y = other.targetY;
        targRoom = other.targetRoom;
        room_goto(targRoom);

        global.hasKey = false;
    } else {

    }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!(ds_list_find_index(global.saveroom, id) == -1))
    instance_change(objDoor,true);

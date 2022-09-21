#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
active = false;

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
    if key_up_pressed and abs(hsp) <= 2 and ground and !attack and !lunge and !rolling and !pound then {
        x = other.targetX;
        y = other.targetY;
        room_goto(other.targetRoom);
    }
}

///scr_Move_State

// get the input from keyboard
scr_get_input();

// Dash state
if(dash_key)
{
    state = scr_Dash_State;
    alarm[0] = room_speed/4;
}

// Move the Player
scr_Player_Move(spd, 1);


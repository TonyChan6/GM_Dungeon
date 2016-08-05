/// scr_Move ( spd , mul )


// variable initialize
spd = argument[0];
var mul = argument[1];


// Get Direction
dir = point_direction(0, 0, xaxis, yaxis);
if (xaxis == 0 and yaxis == 0)
{
    len = 0;
}
else
{
    len = spd;
}

// Get the length
hspd = round(lengthdir_x(len , dir));
vspd = round(lengthdir_y(len , dir));


//scr_Player_Move(xaxis,yaxis);
scr_Move(hspd * mul, vspd * mul);

// sprite changed
image_speed = .4;


if(vspd == 0 and hspd == 0) 
{
    sprite_index = spr_Player_Warror_Idle;        
}
if ( vspd > 0)
{
    sprite_index = spr_Player_Warror_WalkRight;
}
else if ( vspd < 0)
{
    sprite_index = spr_Player_Warror_WalkRight;
}

if(hspd>0) 
{
    sprite_index = spr_Player_Warror_WalkRight;
    faceto = RIGHT;
}
else if (hspd <0) 
{
    sprite_index = spr_Player_Warror_WalkRight;
    faceto = LEFT;
}

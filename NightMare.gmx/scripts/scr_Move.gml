///scr_Player_Move(hspd,vspd)

var hspd = argument[0];
var vspd = argument[1];

// Horizontal collision

if(room = NM_Game){
    if(scr_grid_place_meeting(x+hspd,y))
    {
        hspd = 0;
    }
}       

if(room != NM_Game){
    if(place_meeting(x+hspd, y, obj_grass) || place_meeting(x+hspd, y, obj_airwall))
    {
        hspd = 0;
    }
}
// Move hroizontally
x += hspd;

// Verical collision

if(room = NM_Game){
   if(scr_grid_place_meeting(x,y+vspd))
    {
        vspd = 0;
    }        
}

if(room != NM_Game){
    if(place_meeting(x, y+vspd, obj_grass) || place_meeting(x, y+vspd, obj_airwall))
    {
        vspd = 0;
    }
}

// Move Vectical 
y += vspd;




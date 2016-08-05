/// 每隔一段时间在主角身边随机一个怪物（可传难度参数催促主角移动） 

// 怪物出现在主角身边的半径（像素）
var SpawnRaidus = 64;

// 随出怪物的间隔时间（可以自行加random做随机）
var SpawnGhostEnemyTimerDelta = 5;

// 随机点相对玩家的方向，这里没有进行grid验证，后续需要增加 ********
var dir = point_direction(0,0,random_range(-1,1),random_range(-1,1));

if(SpawnGhostEnemyTimer >= SpawnGhostEnemyTimerDelta*room_speed)
{
    instance_create(obj_Player_Knight.x + lengthdir_x(SpawnRaidus, dir)  ,obj_Player_Knight.y + lengthdir_y(SpawnRaidus, dir), obj_enemy_bat);
    SpawnGhostEnemyTimer = 0;
}
else
{
    SpawnGhostEnemyTimer++;
}



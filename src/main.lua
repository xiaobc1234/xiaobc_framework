require "init"
require "DataStream"



function main()
  
  --初始化
  b_init()
  
	yesorno,ret=showUI("ui.json");
  
  if yesorno==0 then 
       toast("您选择了取消，停止脚本运行")
       lua_exit()
  end
	
	--账号角色数
	roleCount = ret['账号角色数']+1
	worship = ret["膜拜城主"]--1表示膜拜   0表示不膜拜
    
  if ret["auto"]=="0" then
      --	自动副本全
      autoFB()
	elseif ret['降妖除魔和通天塔']=='0' then
		降妖除魔和通天塔()
	elseif ret['未知暗殿刷boss']=='0' then
		未知暗殿刷boss()
  end
  
end

function autoFB(role)
  
  --没有角色就默认第一个角色
  if not role then 
    role =1
  end
  
  --全局变量定义区
  openHreo = false;--是否召唤了战神,true表示召唤了战神
  
  showTip("欢迎使用冰尘脚本!")
  
  
  登录()
  sysLog("role："..role)
  选择角色进入游戏(role)
  for i=1,2 do
    mSleep(1000)
    领取离线奖励()
  end
  
  --执行5次想要除魔
  for i=1,5 do
    除魔任务()
  end
  --6个副本任务
  for i=1,6 do
    mSleep(1000)
    副本任务()
  end
  
	if worship=='1' then
		--膜拜城主
		膜拜城主()
	end
  
  for i=1,2 do
		通天塔是否左移了一段距离 =false;
    通天塔()
  end
  
  for i=1,3 do
    --个人boss
    个人BOSS()
  end
  
  for i=1,5 do
    喝酒()
  end
  
		返回登录界面()
	
  local roleTmp = role+1
  if roleTmp <=roleCount then
    autoFB(roleTmp)
  end
  
  
end


-- -----------------------主要是升级脚本---------------------------
function 降妖除魔和通天塔(role)
	--没有角色就默认第一个角色
  if not role then 
    role =1
  end
  
  --全局变量定义区
  openHreo = false;--是否召唤了战神,true表示召唤了战神
  
  showTip("欢迎使用冰尘脚本!")
  
  登录()
  sysLog("role："..role)
  选择角色进入游戏(role)
  for i=1,2 do
    mSleep(1000)
    领取离线奖励()
  end
  
	-- 中间逻辑部分
	除魔仅升级()
	for i=1,11 do
		sysLog("i="..i)
		除魔12次()
	end
	
	for i=1,2 do
		通天塔是否左移了一段距离 =false;
		通天塔仅升级()
	end
	
	返回登录界面()
	
  local roleTmp = role+1
  if roleTmp <=roleCount then
    降妖除魔和通天塔(roleTmp)
  end
	
end


-- -----------------------未知暗殿刷boss---------------------------
function 未知暗殿刷boss()
	--手动到未知暗殿
  
	
end



main()

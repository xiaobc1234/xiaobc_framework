require "init"
require "DataStream"

--简单的登录和切换角色脚本

function main()
  
  --初始化
  b_init()
  
   yesorno,retuserui=showUI("ui.json");
  
  if yesorno==0 then 
       toast("您选择了取消，停止脚本运行")
       lua_exit()
  end
    
  if retuserui["auto"]=="0" then
      --	自动副本全
      autoTask()
  end
  
end

function autoTask(role)
  
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
  
	-- TODO  中间自定义功能区
  
	返回登录界面()
	
  local roleTmp = role+1
  if roleTmp <=4 then
    autoFB(roleTmp)
  end
  
end


main()

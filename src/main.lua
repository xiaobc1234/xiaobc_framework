require "init"
require "DataStream"



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
	  autoFB()
	end

end

function autoFB(role)

	--没有角色就默认第一个角色
	if not role then 
		role =1
	end
	
	showTip("欢迎使用冰尘脚本!")
	
	
	登录()
	sysLog("role："..role)
	选择角色进入游戏(role)
	领取离线奖励()
	
	




end




main()

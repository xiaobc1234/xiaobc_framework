require "Mapping"

--参数说明
  --   [1]    = "pagename",    --页面名字
  --   [2]    = "check_par",   --检查函数的参数
  --   [3]    = "action_par",  --动作函数的参数
  --   [4]    = "ending"       --动作结束后运行的函数
  --   [5]    = "ending_par"   --动作结束后运行的参数
  --   ["c"]  = "check",       --检查函数
  --   ["cp"] = "check_par"    --检查函数的参数
  --   ["co"] = "chechout"     --检查是否存在的的参数,默认是检查到点后执行动作,这个参数改成true后,是检查不到点才执行动作
  --   ["a"]  = "action",      --动作函数
  --   ["ap"] = "action_par"   --动作函数的参数
  --   ["e"]  = "ending"       --动作结束后函数
  --   ["ep"] = "ending_par"   --动作结束后函数的参数


function 登录()

	local login = Mapping:new()
	login.pages={
		{"登录主界面",{0xffff7c,"57|40|0x060201,61|-67|0x8f0e02,61|146|0x5e4a49", 95, 516, 127, 811, 445},{638,550}}

	}
	--添加页面
	login:AddPages(login.pages)
	--执行
	login:Run()

end

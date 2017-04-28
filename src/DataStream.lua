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

function mapping(pages)
  local map = Mapping:new()
  --添加页面
  map:AddPages(pages)
  --执行
  map:Run()
end


function 登录()
	local pages={
		{"登录主界面",{0xffff7c,"57|40|0x060201,61|-67|0x8f0e02,61|146|0x5e4a49", 95, 516, 127, 811, 445},{638,550},"finish"},
		{"选择角色界面",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},nil,"finish"}
	}
	mapping(pages)
end

function 选择角色进入游戏(role)
  local pages={
	  {
      {"选择角色1",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,138},"sleep",500},
      {"进入游戏",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,644},"finish"}
    },
    {
      {"选择角色2",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,269},"sleep",500},
      {"进入游戏",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,644},"finish"}
    },{
      {"选择角色3",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,396},"sleep",500},
      {"进入游戏",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,644},"finish"}
    },
    {
      {"选择角色4",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,522},"sleep",500},
      {"进入游戏",{0x323221,"51|-3|0x000e06,-185|55|0x3e1d07,-268|80|0x2b0a02", 90, 878, 575, 1266, 702},{1103,644},"finish"}
    }
  }
  mapping(pages[role])
end


function 领取离线奖励()
	local pages = {
		{'离线奖励未领vip',{0x7e4513,"136|-248|0xffe1ac,221|-247|0x47e47a,218|-230|0x2ab05c,132|-240|0xa86819", 90, 723, 119, 1055, 436},{763,411}},
		{'离线奖励领取',{0x372f16,"129|-248|0xffe1ac,214|-247|0x47e47a,211|-230|0x2ab05c,125|-240|0xa86819", 90, 661, 116, 1048, 439},{1176,45},"finish"}
	}
mapping(pages)
end

function 除魔任务()
	local pages ={
		{'每日必做',{0xe4b968,"-1|18|0x6d3a0c,12|12|0x9d5915,-5|-6|0xf9d793", 95, 842, 13, 910, 78},{875,41},"sleep",500},
		{"降妖伏魔",{0xbb9922,"-1|18|0xc3a221,16|9|0xffff87,-8|7|0x8b7a43", 95, 664, 98, 722, 158},{1061,122},除魔任务详情1},
		{"领取降妖除魔奖励",{0xa83024,"-47|-4|0xfefbfa,-101|1|0xfcfbfb,-83|-14|0xc54a29", 95, 114, 401, 316, 462},{233,430},"finish"}
	}
	mapping(pages)
end

function 除魔任务详情1()
	local pages ={
		{"领取降妖除魔奖励",{0xa83024,"-47|-4|0xfefbfa,-101|1|0xfcfbfb,-83|-14|0xc54a29", 95, 114, 401, 316, 462},{233,430},"finish"},
		{"降妖除魔刷新",{0xdad6cd,"-4|6|0xe7e1d7,13|3|0xab8637,40|9|0xac7a38", 95, 168, 451, 267, 495},{212,468},"sleep",200},
		{"降妖除魔刷新",{0xdad6cd,"-4|6|0xe7e1d7,13|3|0xab8637,40|9|0xac7a38", 95, 168, 451, 267, 495},{212,468},"sleep",200},
		{"降妖除魔刷新",{0xdad6cd,"-4|6|0xe7e1d7,13|3|0xab8637,40|9|0xac7a38", 95, 168, 451, 267, 495},{212,468},"sleep",200},
		{"降妖除魔刷新",{0xdad6cd,"-4|6|0xe7e1d7,13|3|0xab8637,40|9|0xac7a38", 95, 168, 451, 267, 495},{212,468},"sleep",200},
		{"降妖除魔刷新",{0xdad6cd,"-4|6|0xe7e1d7,13|3|0xab8637,40|9|0xac7a38", 95, 168, 451, 267, 495},{212,468},"sleep",200},
		{"降妖除魔挑战",{0xdad6cd,"-4|6|0xe7e1d7,13|3|0xab8637,40|9|0xac7a38", 95, 168, 451, 267, 495},{215,620}},
		--TODO 降妖进行中每隔5s点击一次
		
	}
	mapping(pages)
end






















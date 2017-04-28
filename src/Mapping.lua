--映入Page模块,作为页面自身的动作,不在重复逻辑的使用base,不好界定base到底是什么
local Public=require "Public"
local CommonCode = require "CommonCode"
require "init"--只用它的showTip方法


--建立游戏逻辑的索引模块 
Mapping = {}
--以下是索引模块的各项参数的默认值,每个新建的索引可以单独设置
Mapping.timeout = 20        --出错超时时间
Mapping.repeattimes = 20    --判断出错重复页面的次数
Mapping.snapshot = true     --出错后截图
Mapping.checkout = false    --出错后运行程序
Mapping.errorrepeat = 1     --出错后运行程序的次数
Mapping.defaultfuzzy = 95   --默认检查函数的相似度
Mapping.defaultoffset = 5   --默认随机点击的偏移量为5个像素点
--Mapping.errorlog = true   --错误日志是否开启,等写完save模块,有了存储的功能,再写进去,现在不单独写了

--建立参数的简写方法,也可全拼写入
Mapping.parcase = {
  [1]    = "pagename",    --页面名字
  [2]    = "check_par",   --检查函数的参数
  [3]    = "action_par",  --动作函数的参数
  [4]    = "ending",       --动作结束后运行的函数
  [5]    = "ending_par",   --动作结束后运行的参数
  ["c"]  = "check",       --检查函数
  ["cp"] = "check_par",    --检查函数的参数
  ["co"] = "chechout",     --检查是否存在的的参数,默认是检查到点后执行动作,这个参数改成true后,是检查不到点才执行动作
  ["a"]  = "action",      --动作函数
  ["ap"] = "action_par",   --动作函数的参数
  ["e"]  = "ending",       --动作结束后函数
  ["ep"] = "ending_par"   --动作结束后函数的参数
}
--新建一个索引,name为可选参数,为上级索引的名字
function Mapping:new(name)
  local index  = {}
  index.pages   = {}
  --索引函数的默认方法
  index.basefn = Public
  --索引列表的上级
  index.prev   = name or false
  setmetatable(index,{__index = self})
  return index
end
--增加索引的页面方法如下 x指x坐标,y指y坐标,c指颜色
--xxx:AddPages{
--         检查x,y点坐标是否为c的颜色,是的话,点击x,y
--         {"页面名字",{x,y,c}},
--         检查x1,y1点坐标是否为c的颜色,是的话,点击x2,y2               
--         {"页面名字",{x1,y1,c},{x2,y2}}
--         检查x1,y1点坐标是否为c的颜色,是的话,点击x2,y2,并在点击后结束这个索引      
--         {"页面名字",{x1,y1,c},{x2,y2},"finish"}
--         同上,最后的save为save模块,让存档中某个值+1
--         {"页面名字",{x1,y1,c},{x2,y2},"save",{"测试","add",1}}
--         检查x1,y1点坐标是否为不是c的颜色,然后点击x2,y2,并在点击后结束这个索引 
--         {"页面名字",{x1,y1,c},{x2,y3},e = "finish" , checkout = true}
--         使用Base模块中的other方法检查页面,是的话,使用Base模块中的move方法,移动页面 
--         {"页面名字",{x1,y1,c},{x2,y2,x3,y3},c = Base.other , a = Base.move}
--         ......
--          }
function Mapping:AddPages( ... )
  for i , page in ipairs( ... ) do
		if type(self.pages[i])=="nil" then
			self.pages[i]={}
		end
    for key,value in pairs(page) do
      if self.parcase[key] == "ending" then
				if value=="finish" then
					self.pages[i][self.parcase[key]] = value
        elseif type(value) == "string" then
          self.pages[i][self.parcase[key]] = self.basefn[value]
        else
          self.pages[i][self.parcase[key]] = value
        end
      else
        self.pages[i][self.parcase[key]] = value
      end
    end
    self.pages[i]["pagename"]   = self.pages[i]["pagename"] or ""
    self.pages[i]["check"]      = self.pages[i]["check"] or self.basefn.check
    self.pages[i]["checkout"]   = false
    self.pages[i]["check_par"]  = self.pages[i]["check_par"] or false
    self.pages[i]["action_par"] = self.pages[i]["action_par"] or false
    self.pages[i]["ending_par"] = self.pages[i]["ending_par"] or false
    if self.pages[i]["action_par"] then
      self.pages[i]["action"] = self.pages[i]["action"] or self.basefn.click
    end
    self.pages[i]["defaultfuzzy"] = self.defaultfuzzy
    self.pages[i]["defaultoffset"] = self.defaultoffset
  end
end


-- 简单纠错方法，需要自行在CommonCode.lua文件中添加错误界面
function Mapping:CommonCode()
  for i,v in ipairs(CommonCode) do
    if Public:check(v[2]) then
      print("每个索引都要检查的错误页面："..v[1])
      if v[3] and type(v[3])=="table" then
        Public:click(v[3])
      end
    end
  end
end

--运行这个索引的内容
function Mapping:Run()
  --abnormal为检测异常的表,checkout记录每次是否检查到页面
  -- local abnormal,checkout = {pages={},normal = false,u.errornum = 0}
  self.finished = false
  while not self.finished do
	
		mSleep(500)--以免占用cpu过高
    keepScreen(true)
    for i,page in ipairs(self.pages) do
			if _debug then
				sysLog("pre当前操作："..page.pagename)
				x, y = findMultiColorInRegionFuzzy(page.check_par[1],page.check_par[2],page.check_par[3],page.check_par[4],page.check_par[5],page.check_par[6],page.check_par[7])
				sysLog(x.."-"..y)
				sysLog(page.check_par[1]..","..page.check_par[2]..","..page.check_par[3]..","..page.check_par[4]..","..page.check_par[5]..","..page.check_par[6]..","..page.check_par[7])
			end
			
			if page:check(page.check_par) then
        keepScreen(false)
        -- 先不管异常情况
        -- checkout = false
        -- abnormal = self:abnormal(abnormal,page.pagename)
        -- if abnormal then return false end 
        if page.action then 
					if _debug then
						sysLog("当前操作："..page.pagename)
					end
					--显示当前操作
					showTip("当前操作："..page.pagename)
          if page.action_par then
						
            if type(page.action_par)=="function" then
              page.action_par()
            else
              page:action(page.action_par) 
            end
          elseif page.action=="searchTap" then
							page:action(page.check_par)
					else 
            page:action() 
          end
        end
        if page.ending then 
          if page.ending=="finish" then
						if _debug then
							sysLog("finish")
						end
            self.finished =true--这个索引结束
						break
          elseif page.ending_par then
            page:ending(page.ending_par)
          else
            page:ending()
          end
        end
--        break
      end
      --检查不到任何页面,则向上级索引，或者说 之前已经走过这个流程，就走下面的一个索引
      if i == #self.pages and self.prev then
        self.prev:Run()
      end
    end
    keepScreen(false)
    -- 检查是否有错误页面出现
    Mapping:CommonCode()
    -- if checkout then
    --     abnormal = self:abnormal(abnormal)
    --     if abnormal then return false end
    -- end
    -- checkout = true 
  end
  return true
end







-- ------------------------------------------下面的方法暂时没有用到------------------------------------------------


--[[检查异常页面,重复同样页面(或者找不到页面,或者两张相同页面交替重复出现)20次以上(Mapping.repeattimes控制),
并且时间超过20秒(Mapping.timeout控制),则认为异常,异常是,以页面名字+时间命名进行全屏截图(Mapping.snapshot控制),
并且定义了Mapping.checkout函数后,执行该函数(比如重启游戏),之后继续判断,
Mapping.errorrepeat控制持续出错后执行checkout的时间,假如超过次数,则最后终止这个索引]]
function Mapping:abnormal(u,p)
  p = p or false
  --检查页面中不超过重复次数页面
  if #u.pages >= self.repeattimes then
    table.remove(u.pages,1)
  end 
  table.insert(u.pages,p)
  local p1 , p2 = u.pages[1] , u.pages[2]
  --检查页面是否全部重复或者是否为1,2,1,2这样持续重复两张(有时候一个页面无法判断,就会出现这样的问题) 
  for i,v in ipairs(u.pages) do
    if i%2 == 1 and v ~= p1 then 
      u.normal = true 
      u.time = os.time() 
      break 
    end
    if i%2 == 0 and (v ~= p1 and v ~=p2) then 
      u.normal = true 
      u.time = os.time()
      break 
    end
  end
  --判断是否正常
  if u.normal then
    u.normal = false
    return u
  elseif os.time() - u.time > self.timeout then
    if self.snapshot then
      local name
      if p1 == p2 then
        name = p1
      else
        name = p1.."_"..p2
      end 
      local snapshotname = name.."_"..os.date("%m-%d", os.time())..".png"
      snapshot(snapshotname)
    end
    if self.errorrepeat >= errornum and self.checkout then
      self.checkout()
      errornum = errornum + 1
    end
  else
    return u
  end
end
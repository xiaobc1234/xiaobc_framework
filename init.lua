require "DeviceCheck"

-- 分辨率，缩放，全局变量 等作用
function b_init()
  
  local w_,h_ = getScreenSize() --w < h
  local h = w_
  local w = h_
  
  _device = getCurrentDevice()
  
  
  local supportSize = (_device > 0) --检测是否支持该分辨率
  if not supportSize then
    
    dialog("不支持当前分辨率".."宽:"..w..",高:"..h, 8)
    lua_exit()
  end
  
  if _device == 5 then
    -- toast("强制")
    setScreenScale(720,1280)
  end
  
  
   yes,ret=showUI("homeChooce.json");
    if yes==0 then 
    toast("您选择了取消，停止脚本运行")
    lua_exit()
  end
  
  -- 0表示模拟器打开；1表示手机打开
  if ret["device"]=="0" then
    init("",0)
  else
    init("",1);
  end
  
  
end
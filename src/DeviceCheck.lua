_fsw,_fsh = getScreenSize()


function getCurrentDevice()

----- 安卓9:16   同iphone 5
if  (_fsw == 720 and _fsh == 1280) or (_fsw == 1080 and _fsh == 1920) or (_fsw == 1440 and _fsh == 2560)then
return 5
end

if  (_fsw == 750 and _fsh == 1334)  then --6  IOS 9:16 
return 5
end


if  (_fsw == 1242 and _fsh == 2208)  then--6p   IOS 9:16 
return 5
end
if  (_fsw == 1125 and _fsh == 2001)  then  -- 6p 放大   IOS 9:16 
return 5
end
if  (_fsw == 640 and _fsh == 1136)  then   --- 5s   IOS 9:16 
return 5
end

if  (_fsw == 1536 and _fsh == 2048)  then------ ipad 3,4,air, 高清mini   3:4
return 1
end



return -1;
end
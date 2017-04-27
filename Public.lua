local Public = {}


function Public:check(v)
	x, y = findMultiColorInRegionFuzzy(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
	if x > -1 then
		return 1
	else 
		return nil
	end
end

function Public:click(t)
 	Public:tap(t[1],t[2])
end

function Public:finish()
	-- 不用调用了
end

function Public:sleep(num)
  -- 不用调用了
  mSleep(num)
end

--点击
function Public:tap(x, y)
  math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
  local index = math.random(1,5)
  x = x+math.random(-2,2)
  y = y+math.random(-2,2)
  touchDown(index,x, y)
  mSleep(math.random(60,80))                                --某些情况可能要增大延迟
  touchUp(index, x, y)
  mSleep(20)
end

-- 滑动
function Public:swip(x1,y1,x2,y2)
  local Step,x,y = 20,x1,y1
  touchDown(1,x,y)
  local function v(z,c) if z > c then return (-1 * Step) else return Step end end
    while (math.abs(x-x2)>=Step) or (math.abs(y-y2)>=Step) do
      if math.abs(x-x2)>=Step then x = x + v(x1,x2) end
      if math.abs(y-y2)>=Step then y = y + v(y1,y2) end
      touchMove(1, x, y)
      mSleep(20)
    end
    touchMove(1, x2, y2)
    mSleep(30)
    touchUp(1,x2,y2)
 end


 function Public:test()
 	print("hello word")
 end



return Public


-- mapping的通用方法
function mapping(pages)
  local map = Mapping:new()
  --添加页面
  map:AddPages(pages)
  --执行
  return map:Run()
end
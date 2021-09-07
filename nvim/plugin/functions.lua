function Q.dump(...)
  local args = ...
  if type(args) ~= table then
    args = {...}
  end
  print(unpack(vim.tbl_map(vim.inspect, args)))
  return ...
end

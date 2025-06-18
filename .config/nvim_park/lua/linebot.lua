local M = {}

-- URL 인코딩 함수
local function url_encode(str)
  if not str then
    return str
  end
  str = string.gsub(str, "\r?\n", "\r\n")
  str = string.gsub(str, "([^A-Za-z0-9])", function(c)
    if #c > 1 then
      local result = ""
      for i = 1, #c do
        result = result .. string.format("%%%02X", string.byte(c, i))
      end
      return result
    end
    return string.format("%%%02X", string.byte(c))
  end)
  return str
end

-- 사용자 입력 받아 메시지 전송
function M.send_message()
  vim.ui.input({ prompt = "LINE 보낼 메시지를 입력하세요: " }, function(input)
    if input == nil or input == "" then
      print("메시지가 없습니다.")
      return
    end
    local encoded_msg = url_encode(input)
    local curl_cmd = string.format(
      "curl -s -X POST http://localhost:8001/send "
      .. '--data-urlencode "msg=%s" '
      .. '-H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8"',
      input
    )
    local handle = io.popen(curl_cmd)
    local result = handle:read("*a")
    handle:close()
    print("전송됨: " .. input)
  end)
end

-- 응답 가져오기
function M.get_response()
  local handle = io.popen("curl -s http://localhost:8000/response")
  local result = handle:read("*a")
  handle:close()
  print("응답: " .. result)
end

-- 명령어 등록
vim.api.nvim_create_user_command("LineSend", function()
  M.send_message()
end, {})
vim.api.nvim_create_user_command("LineReply", function()
  M.get_response()
end, {})

-- 키맵 등록
vim.keymap.set("n", "<leader>ls", ":LineSend<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>lr", ":LineReply<CR>", { noremap = true, silent = true })


return M

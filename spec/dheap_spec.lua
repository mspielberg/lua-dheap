local dheap = require "dheap"

local function verify(heap)
  local d = heap.d
  for i=0,#heap do
    local x = heap[i]
    if x then
      for n=d*i+1,d*i+d do
        if heap[n] and heap[n][1] < x[1] then
          return false
        end
      end
    end
  end
  return true
end

describe("dheap", function()
  it("should create a heap", function()
    local h = dheap.new()
    assert.is_true(verify(h))
  end)

  it("should add elements", function()
    local h = dheap.new()
    h:insert(1, 'world')
    assert.is_true(verify(h))
    h:insert(-1, 'hello')
    assert.is_true(verify(h))
  end)

  it("should return elements in order", function()
    local h = dheap.new()
    h:insert(1, 'world')
    h:insert(-1, 'hello')
    assert.same({-1, 'hello'}, {h:pop()})
    assert.same({1, 'world'}, {h:pop()})
  end)

  it("should delete from the middle", function()
    local h = dheap.new()
    for i=10,1,-1 do h:insert(i, i) end
    assert.is_true(verify(h))
    h:delete(3)
    assert.is_true(verify(h))
  end)

  it("should delete the last item", function()
    local h = dheap.new()
    h:insert(1, 'world')
    h:insert(-1, 'hello')
    h:delete('world')
    assert.is_true(verify(h))
    assert.is_nil(h[1])
  end)

  it("should pop the last element", function()
    local h = dheap.new()
    h:insert(1, 1)
    local k, v = h:pop()
    assert.same(1, k)
    assert.same(1, v)
    assert.is_nil(h[0])
  end)
end)
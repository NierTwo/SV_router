module queue_example;
  // 声明一个整型队列
  int my_queue[$];

  initial begin
    // 向队列添加元素
    my_queue.push_back(10);
    my_queue.push_back(20);
    my_queue.push_back(30);
    
    // 显示队列内容
    $display("Queue contents: %p", my_queue);
    
    // 访问队列元素
    $display("First element: %d", my_queue[0]);
    
    // 删除队列的第一个元素
    my_queue.pop_front();
    
    // 显示队列内容
    $display("Queue after pop_front: %p", my_queue);
  end
endmodule


//定长数组（内置），动态数组（列表），关联数组（hash）
module associative_array (
);
  initial begin
    bit [31:0] mem [int unsigned];
    int unsigned data, addr;
    repeat(5) begin
      std::randomize(addr, data) with {
        addr[31:8] == 0;
        addr[1:0] == 0;
        data inside {[1:10]};
      }
      $display("address : 'h%x, data : 'h%x", addr, data);
      mem[addr] = data;
      foreach(mem[idx]) $display("mem_address : 'h%x, data : 'h%x", idx ,mem[idx]);
    end
  end
endmodule

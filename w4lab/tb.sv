typedef struct {
    bit [3:0] chn_in;
    bit [3:0] data_addr;
    bit [7:0] data_data[];
} router_stml_fm;



interface router_intf;
    logic clock;
    logic reset_n;
    logic [15:0] din, frame_n, valid_n;
    logic [15:0] dout, valido_n, busy_n, frameo_n;
endinterface



interface router_gnrt_intf;
    router_stml_fm queue_case[$];
endinterface


//send stimulation
module router_stml(router_intf router_intf, router_gnrt_intf router_gnrt_intf); 
    initial begin : drive_begin
        router_intf.din <= '0;
        router_intf.frame_n <= '1;
        router_intf.valid_n <= '1;
        @(negedge router_intf.reset_n);
        repeat (10) @(posedge router_intf.clock);
        forever begin
            automatic router_stml_fm test_case;
            wait (router_gnrt_intf.queue_case.size() > 0);
            test_case = router_gnrt_intf.queue_case.pop_back();
            fork 
                drive_proc(test_case);
            join_none
        end
    end

    //begin : drive_proc
    task automatic drive_proc(router_stml_fm stml_pt);
        //first_address
        for (int i = 0; i < 4; i++) begin
            @(posedge router_intf.clock);
            router_intf.din[stml_pt.chn_in] = stml_pt.data_addr[i];
            router_intf.valid_n[stml_pt.chn_in] = 0;
            router_intf.frame_n[stml_pt.chn_in] = 0;
        end
        //second_pad
        for (int i = 0; i < 5; i++) begin
            @(posedge router_intf.clock);
            router_intf.din[stml_pt.chn_in] = 1;
            router_intf.valid_n[stml_pt.chn_in] = 1;
            router_intf.frame_n[stml_pt.chn_in] = 0;
        end
        //third_data
        foreach (stml_pt.data_data[id]) begin
            for (int i = 0; i < 8; i++) begin
                @(posedge router_intf.clock);
                router_intf.din[stml_pt.chn_in] = stml_pt.data_data[id][i];
                router_intf.valid_n[stml_pt.chn_in] = 0;
                router_intf.frame_n[stml_pt.chn_in] = (id == stml_pt.data_data.size()-1 && i == 7) ? 1 : 0;
            end
        end
        @(posedge router_intf.clock);
        router_intf.valid_n[stml_pt.chn_in] = 1;
    endtask
endmodule



module router_gnrt(router_gnrt_intf router_gnrt_intf);
    initial begin
        router_gnrt_intf.queue_case.push_front('{0, 3, '{8'h33}});
        router_gnrt_intf.queue_case.push_front('{3, 0, '{8'h77}});
    end
endmodule



// module router_mnt(router_intf router_intf);

//     task mnt_in;

//     endtask

//     task mnt_out;
//     endtask
// endmodule



module tb;
    bit clk, rst;

    initial begin
        clk <= 0;
        forever begin
            #5ns clk <= ~clk;
        end
    end
    initial begin
        #2ns rst <= 1;
        #10ns rst <= 0;
        #10ns rst <= 1;
    end

    router_intf router_intf();
    router_gnrt_intf router_gnrt_intf();
    assign router_intf.clock = clk;
    assign router_intf.reset_n = rst;

    router dut (
        .clock(clk),
        .reset_n(rst),
        .frame_n(router_intf.frame_n),
        .valid_n(router_intf.valid_n),
        .din(router_intf.din),
        .dout(router_intf.dout),
        .busy_n(router_intf.busy_n),
        .valido_n(router_intf.valido_n),
        .frameo_n(router_intf.frameo_n)
    );
    router_stml router_stml(router_intf, router_gnrt_intf);
    router_gnrt router_gnrt(router_gnrt_intf);
endmodule

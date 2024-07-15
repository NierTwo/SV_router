//send stimulation
module rt_stimulaor (
    input clock,
    input reset_n,
    output logic [15:0] din, frame_n, valid_n,
    input logic [15:0] dout, valido_n, busy_n, frameo_n
); 

    initial begin : drive_reset_proc
        din <= 0;
        frame_n <= 1;
        valid_n <= 1;
    end

    bit [3:0] addr;
    byte unsigned data[];
    initial begin : drive_chn10_proc
        @(negedge reset_n);
        repeat (10) @(posedge clock);
        addr = 3;
        data = '{8'h33, 8'h77};

        //first_address
        for (int i = 0; i < 4; i++) begin
            @(posedge clock);
            din[0] <= addr[i];
            valid_n[0] <= 0;
            frame_n[0] <= 0;
        end
        //second_pad
        for (int i = 0; i < 5; i++) begin
            @(posedge clock);
            din[0] <= 1;
            valid_n[0] <= 1;
            frame_n[0] <= 0;
        end
        //third_data
        foreach (data[id]) begin
            for (int i = 0; i < 8; i++) begin
                @(posedge clock);
                din[0] <= data[id][i];
                valid_n[0] <= 0;
                frame_n[0] <= (id == data.size()-1 && i == 7) ? 1 : 0;
            end
        end
    end

endmodule




module tb;
    bit clk, rst;
    logic [15:0] din, frame_n, valid_n;
    logic [15:0] dout, valido_n, busy_n, frameo_n;

    initial begin
        forever begin
            #5ns clk <= ~clk;
        end
    end

    initial begin
        #2ns rst <= 1;
        #10ns rst <= 0;
        #10ns rst <= 1;
    end
   
    router dut (
        .reset_n(rst),
        .clock(clk),
        .*
    );

    rt_stimulaor stim(
        .reset_n(rst),
        .clock(clk),
        .*
    );
endmodule
interface router_io(input bit clock);

    logic reset_n;
    logic [15:0] din, frame_n, valid_n;
    logic [15:0] dout, valido_n, busy_n, frameo_n;
    
    clocking cb @(posedge clock);
        default input #1ns output #1ns;
        output din;
        output reset_n;
        output frame_n;
        output valid_n;
        input dout;
        input valido_n;
        input busy_n;
        input frameo_n;
    endclocking: cb
    modport TB(clocking cb, output reset_n);
    
endinterface //router_io;

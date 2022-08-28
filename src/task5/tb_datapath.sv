module tb_datapath();

//THIS IS THE FINAL COMMIT
reg slow_clock, fast_clock, resetb, load_pcard1, load_pcard2,load_pcard3,
                load_dcard1, load_dcard2, load_dcard3;
wire [3:0] pcard3_out, pscore_out, dscore_out;
wire [6:0] HEX5, HEX4, HEX3,
           HEX2, HEX1, HEX0;

datapath dut(slow_clock, fast_clock, resetb, load_pcard1, load_pcard2,load_pcard3,
            load_dcard1, load_dcard2, load_dcard3,
            pcard3_out, pscore_out, dscore_out,
            HEX5, HEX4, HEX3,
            HEX2, HEX1, HEX0); 

initial begin
    slow_clock = 1'b0; #50;
forever begin
    slow_clock = 1'b1; #50;
    slow_clock = 1'b0; #50;
end
end

initial begin
    fast_clock = 1'b0; #10;
forever begin
    fast_clock = 1'b1; #10;
    fast_clock = 1'b0; #10;
end
end

initial begin

    //LOAD PCARD1

    resetb = 0;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b100000;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    #50;
    resetb = 1;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b100000;
    #50;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    //RESET
    resetb = 0;
    #10;

    //LOAD PCARD2
    resetb = 1;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b010000;
    #50;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);


    //LOAD PCARD3
    resetb = 1;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b001000;
    #50;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    //LOAD DCARD1
    resetb = 1;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b000100;
    #50;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    //LOAD DCARD2
    resetb = 1;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b000010;
    #50;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    

    //LOAD DCARD3
    resetb = 1;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b000001;
    #50;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    //RESET ONCE MORE
    resetb = 0;
    {load_pcard1, load_pcard2, load_pcard3,
                load_dcard1, load_dcard2, load_dcard3} = 6'b100000;
    $display("pscore_out: %b, dscore_out: %b, pcard3: %b", pscore_out, dscore_out, pcard3_out);
    $display("HEX0: %b, HEX1: %b, HEX2: %b, HEX3: %b, HEX4: %b, HEX5: %b", HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    #50;
    $stop;
end
						
endmodule


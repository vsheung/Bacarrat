module datapath(input slow_clock, input fast_clock, input resetb,
                input load_pcard1, input load_pcard2, input load_pcard3,
                input load_dcard1, input load_dcard2, input load_dcard3,
                output [3:0] pcard3_out,
                output [3:0] pscore_out, output [3:0] dscore_out,
                output[6:0] HEX5, output[6:0] HEX4, output[6:0] HEX3,
                output[6:0] HEX2, output[6:0] HEX1, output[6:0] HEX0);
//FINAL COMMIT
wire [3:0] new_card, pcard1wire, pcard2wire, pcard3wire, dcard1wire, dcard2wire, dcard3wire;	

//dealcard instantiation
dealcard dealcard1(fast_clock, resetb, new_card);

//scorehand instantiations
scorehand player(pcard1wire, pcard2wire, pcard3_out, pscore_out);
scorehand dealer(dcard1wire, dcard2wire, dcard3wire, dscore_out);

//6 reg4 instantiations
reg4 reg4_1(load_pcard1, resetb, slow_clock, new_card, pcard1wire);
reg4 reg4_2(load_pcard2, resetb, slow_clock, new_card, pcard2wire);
reg4 reg4_3(load_pcard3, resetb, slow_clock, new_card, pcard3wire);
reg4 reg4_4(load_dcard1, resetb, slow_clock, new_card, dcard1wire);
reg4 reg4_5(load_dcard2, resetb, slow_clock, new_card, dcard2wire);
reg4 reg4_6(load_dcard3, resetb, slow_clock, new_card, dcard3wire);

//pcard3 to state machine
assign pcard3_out = pcard3wire;

//6 card7seg instantiations
card7seg seg_0(pcard1wire, HEX0);
card7seg seg_1(pcard2wire, HEX1);
card7seg seg_2(pcard3wire, HEX2);
card7seg seg_3(dcard1wire, HEX3);
card7seg seg_4(dcard2wire, HEX4);
card7seg seg_5(dcard3wire, HEX5);



// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code.

endmodule

//reg4 file
module reg4 (load_card, resetb, slow_clock, new_card, output_wire);
input resetb, slow_clock, load_card;
input [3:0] new_card;
output reg [3:0] output_wire;

always @(posedge slow_clock or negedge resetb) begin
    if (resetb == 0)
        output_wire <= 4'b0000;      
    else if (load_card == 1'b1)
        output_wire <= new_card;
    else
        output_wire <= output_wire;
end
endmodule

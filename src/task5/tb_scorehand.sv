module tb_scorehand();

//FINAL COMMIT
reg [3:0] card1, card2, card3;
wire [3:0] total;

scorehand dut(card1, card2, card3, total);

initial begin

    //with no face cards
    card1 = 4'b0001;
    card2 = 4'b0111;
    card3 = 4'b0001;
    #50;
    assert(total == 4'b1001);

    //with 1 face card

    card1 = 4'b0001;
    card2 = 4'b0111;
    card3 = 4'b1101;
    #50;
    assert(total == 4'b1000);

    //with two face cards
    card1 = 4'b0001;
    card2 = 4'b1101;
    card3 = 4'b1101;
    #50;
    assert(total == 4'b0001);

    // with three face cards (smallest possible number
    card1 = 4'b1101;
    card2 = 4'b1101;
    card3 = 4'b1101;
    #50;
   assert(total == 4'b0000);

    //largest possible number
    card1 = 4'b1001;
    card2 = 4'b1001;
    card3 = 4'b1001;
    #50;
   assert(total == 4'b0111);

$stop;
    
end

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
						
endmodule


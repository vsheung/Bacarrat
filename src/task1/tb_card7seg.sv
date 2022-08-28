module tb_card7seg();
//FINAL COMMIT
reg [3:0] SW;
wire [6:0] HEX0;

card7seg dut(SW, HEX0);

initial begin
    //Testing input-dependent case statements in card7seg
    //BLANK
    SW = 4'b0000;
    #50;
    $display("Expected value is 7'b1111111, actual value is %b", HEX0);
    

    //ACE
    SW = 4'b0001;
    #50;
    $display("Expected value is 7'b0001000, actual value is %b", HEX0);

    //2
    SW = 4'b0010;
    #50;
    $display("Expected value is 7'b0100100, actual value is %b", HEX0);
    
    //3
    SW = 4'b0011;
    #50;
    $display("Expected value is 7'b0110000, actual value is %b", HEX0);

    //4
    SW = 4'b0100;
    #50;
    $display("Expected value is 7'b0011001, actual value is %b", HEX0);

    //5
    SW = 4'b0101;
    #50;
    $display("Expected value is 7'b0010010, actual value is %b", HEX0);

    //6
    SW = 4'b0110;
    #50;
    $display("Expected value is 7'b0000010, actual value is %b", HEX0);

    //7
    SW = 4'b0111;
    #50;
    $display("Expected value is 7'b1111000, actual value is %b", HEX0);

    //8
    SW = 4'b1000;
    #50;
    $display("Expected value is 7'b0000000, actual value is %b", HEX0);

    //9
    SW = 4'b1001;
    #50;
    $display("Expected value is 7'b0010000, actual value is %b", HEX0);

    //10
    SW = 4'b1010;
    #50;
    $display("Expected value is 7'b1000000, actual value is %b", HEX0);

    //JACK
    SW = 4'b1011;
    #50;
    $display("Expected value is 7'b1100001, actual value is %b", HEX0);

    //QUEEN
    SW = 4'b1100;
    #50;
    $display("Expected value is 7'b0011000, actual value is %b", HEX0);

    //KING
    SW = 4'b1101;
    #50;
    $display("Expected value is 7'b0001001, actual value is %b", HEX0);

    //testing default cases that should result in blank
    SW = 4'b1110;
    #50;
    $display("Expected value is 7'b1111111, actual value is %b", HEX0);

    SW = 4'B1111;
    #50;
    $display("Expected value is 7'b1111111, actual value is %b", HEX0);
end
// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
						
endmodule





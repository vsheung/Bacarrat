module scorehand(input [3:0] card1, input [3:0] card2, input [3:0] card3, output reg [3:0] total);
//FINAL COMMIT
reg [3:0] card1_mod, card2_mod, card3_mod;

always @(*) begin
        if (card1 >= 4'b1010)
            card1_mod = 4'b0000; 
        else 
            card1_mod = card1;

        if (card2 >= 4'b1010)
            card2_mod = 4'b0000; 
        else
            card2_mod = card2;

        if (card3 >= 4'b1010)
            card3_mod = 4'b0000; 
        else
            card3_mod = card3;
    
        total = (card1_mod + card2_mod + card3_mod)%10;
    
end


endmodule


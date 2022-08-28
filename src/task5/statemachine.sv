module statemachine(input slow_clock, input resetb,
                    input [3:0] dscore, input [3:0] pscore, input [3:0] pcard3,
                    output load_pcard1, output load_pcard2,output load_pcard3,
                    output load_dcard1, output load_dcard2, output load_dcard3,
                    output player_win_light, output dealer_win_light);

//FINAL COMMIT
// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the 
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.

`define PCARD1 4'b0000
`define BCARD1 4'b0001
`define PCARD2 4'b0010
`define BCARD2 4'b0011
`define PCARD3 4'b0100
`define BCARD3 4'b0101
`define GO_CALC_SCORE 4'b0110
`define BWINS 4'b0111
`define PWINS 4'b1000
`define TIE 4'b1010


reg [3:0] present_state, next_state;
reg load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, dealer_win_light_reg, player_win_light_reg;

always@ (posedge slow_clock or negedge resetb) begin
    if (resetb == 0) begin
        present_state <= `PCARD1;
    end else begin
        present_state <= next_state;
end
end

//state machine: taken from Professor Tor Aamodt's CPEN211 Lecture Slides

always_comb begin
    case (present_state)
            `PCARD1: next_state = `BCARD1;
            `BCARD1: next_state = `PCARD2;
            `PCARD2: next_state = `BCARD2;
            `BCARD2: if (dscore >= 4'b1000||pscore >= 4'b1000)// If player or dealer has 8 or 9, calculate score
                    next_state = `GO_CALC_SCORE;
                else if (pscore <= 4'b0101) //If player score is less than 5, player gets a card
                    next_state = `PCARD3;
                else if ((pscore == 4'b0110|| pscore == 4'b0111)&&(dscore<=4'b0101)) //If player score is 6 or 7 AND banker score is less than 5, banker gets a card
                    next_state = `BCARD3;
                else
                    next_state = `GO_CALC_SCORE;
            `PCARD3: if (dscore == 4'b0111) //If banker score from first 2 cards is 7, calculate score
                    next_state = `GO_CALC_SCORE;
                else if ((dscore == 4'b0110)&&((pcard3==4'b0110)||(pcard3==4'b0111))) // If banker score from first 2 cards is 6 AND
                    next_state = `BCARD3;                                             // players 3rd card is 6 or 7, banker gets card
                else if ((dscore == 4'b0101)&&((pcard3>=4'b0100)&&(pcard3<=4'b0111))) // If banker score from first 2 cards is 5 AND
                    next_state = `BCARD3;                                             // players 3rd card is from 4 to 7, banker gets card
                else if ((dscore == 4'b0100)&&((pcard3>=4'b0010)&&(pcard3<=4'b0111))) // If banker score from first 2 cards is 4 AND
                    next_state = `BCARD3;                                             // players 3rd card is from 2 to 7, banker gets card
                else if ((dscore == 4'b0011)&&(pcard3!=4'b1000))                      // If banker score from first 2 cards is 3 AND
                    next_state = `BCARD3;                                             // players 3rd card is anything but 8, banker gets card
                else if (dscore<=4'b0010)                                             // If banker score from first 2 cards is less than 2, banker gets card
                    next_state = `BCARD3;                                            
                else
                    next_state = `GO_CALC_SCORE;
            `BCARD3: next_state = `GO_CALC_SCORE;
            `GO_CALC_SCORE: if (dscore>pscore)
                            next_state = `BWINS;
                        else if (dscore<pscore)
                            next_state = `PWINS;
                        else
                            next_state = `TIE;
            default: next_state = `PCARD1;

    endcase
    
end

always_comb begin
    //outputs
    case (present_state)
        
        `PCARD1: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};
        `BCARD1: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
        `PCARD2: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0};
        `BCARD2: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
        `PCARD3: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0};
        `BCARD3: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
        `BWINS: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
        `PWINS: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
        `TIE: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1};
        default: {load_dcard1_reg, load_dcard2_reg, load_dcard3_reg, load_pcard1_reg, load_pcard2_reg, load_pcard3_reg, player_win_light_reg, dealer_win_light_reg} = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
    endcase
end

assign load_pcard1 = load_pcard1_reg;
assign load_pcard2 = load_pcard2_reg;
assign load_pcard3 = load_pcard3_reg;
assign load_dcard1 = load_dcard1_reg;
assign load_dcard2 = load_dcard2_reg;
assign load_dcard3 = load_dcard3_reg;
assign dealer_win_light = dealer_win_light_reg; 
assign player_win_light = player_win_light_reg;

endmodule


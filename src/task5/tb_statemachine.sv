module tb_statemachine();
//FINAL COMMIT
reg slow_clock, resetb;
reg [3:0] dscore, pscore, pcard3;
wire load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light;

statemachine dut(slow_clock, resetb,
                 dscore, pscore, pcard3,
                 load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light);

initial begin
    slow_clock = 1'b0; #5;
forever begin
    slow_clock = 1'b1; #5;
    slow_clock = 1'b0; #5;
end
end

initial begin

    //NATURAL: DEALER
    resetb = 0;
    dscore = 9;
    pscore = 6;
    pcard3 = 0;
    #10;
    resetb = 1;
    #50;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                player_win_light, dealer_win_light} == 8'b00000001);
    
    
    //NATURAL: PLAYER
    resetb = 0;
    dscore = 6;
    pscore = 9;
    pcard3 = 0;
    #10;
    resetb = 1;
    #50;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000010);

    //NATURAL: TIE
    resetb = 0;
    dscore = 9;
    pscore = 9;
    pcard3 = 0;
    #10;
    resetb = 1;
    #50;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000011);

    //PSCORE IS LESS THAN 5 AFTER 4 CARDS DEALT, ENSURE IT GOES TO PCARD3
    resetb = 0;
    dscore = 6;
    pscore = 4;
    pcard3 = 0;
    #10;
    resetb = 1;
    #40;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00100000);
    #50;

    //PSCORE IS 6/7 AFTER 4 CARDS DEALT && DSCORE IS LESS THAN 5, ENSURE IT GOES TO BCARD3
    resetb = 0;
    dscore = 4;
    pscore = 7;
    pcard3 = 0;
    #10;
    resetb = 1;
    #40;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000100);
    #50;
      

    /*CHECKING STATES AT PCARD3:*/
    resetb = 0;
    dscore = 3;
    pscore = 4;
    pcard3 = 0;
    #10;

    resetb = 1;
    #40;

    //IF DSCORE IS 7, GO STRAIGHT TO CALC SCORE
    dscore = 7;
    pscore = 0;
    pcard3 = 0;
    #10;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000000);
    #50;

    resetb = 0;
    dscore = 3;
    pscore = 4;
    pcard3 = 0;
    #10;

    resetb = 1;
    #40;
    
    //IF DSCORE IS 6 && PCARD 3 IS 6/7, GO TO BCARD3
    dscore = 6;
    pscore = 7;
    pcard3 = 6;
    #10;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000100);
    #50;

    resetb = 0;
    dscore = 3;
    pscore = 4;
    pcard3 = 0;
    #10;

    resetb = 1;
    #40;
    
    //IF DSCORE IS 5 && PCARD 3 IS 4-7, GO TO BCARD3
    dscore = 5;
    pscore = 7;
    pcard3 = 5;
    #10;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000100);
    #50;

    resetb = 0;
    dscore = 3;
    pscore = 4;
    pcard3 = 0;
    #10;

    resetb = 1;
    #40;
    
    //IF DSCORE IS 4 && PCARD 3 IS 2-7, GO TO BCARD3
    dscore = 4;
    pscore = 7;
    pcard3 = 5;
    #10;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000100);
    #50;

    resetb = 0;
    dscore = 3;
    pscore = 4;
    pcard3 = 0;
    #10;

    resetb = 1;
    #40;
    
    //IF DSCORE IS 3 && PCARD 3 IS ANYTHING BUT 8, GO TO BCARD3
    dscore = 3;
    pscore = 7;
    pcard3 = 7;
    #10;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000100);
    #50;

    resetb = 0;
    dscore = 3;
    pscore = 4;
    pcard3 = 0;
    #10;

    resetb = 1;
    #40;
    
    //IF DSCORE IS <=2, GO TO BCARD3
    dscore = 0;
    pscore = 7;
    pcard3 = 5;
    #10;
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000100);
    #50;

    /*CHECKING STATES AT BCARD3:*/

    resetb = 0;
    dscore = 4;
    pscore = 7;
    pcard3 = 0;
    #10;

    resetb = 1;
    #50;

    //GO STRAIGHT TO CALC SCORE
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000000);

    #10;
    //SHOULD DETERMINE PLAYER IS THE WINNER
    assert({load_pcard1, load_pcard2, load_pcard3,
                 load_dcard1, load_dcard2, load_dcard3,
                 player_win_light, dealer_win_light} == 8'b00000010);

    $stop;
end

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
						
endmodule


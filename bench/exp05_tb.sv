`timescale 1ns / 1ps

module seven_segment_tb();
    logic [3:0] num;
    logic [2:0] sel;
    logic [6:0] segments;
    logic dp;
    logic [7:0] anode;

    seven_segment uut (
        .num(num),
        .sel(sel),
        .segments(segments),
        .dp(dp),
        .anode(anode)
    );

    task driver(input logic [3:0] NUM = $random, input logic [2:0] SEL = $random);
        num = NUM;
        sel = SEL;
        #10;
    endtask

    task monitor();
        logic [6:0] expected_segments;
        logic [7:0] expected_anode;
        
        case(num)
            4'b0000: expected_segments = 7'b0000001;
            4'b0001: expected_segments = 7'b1001111;
            4'b0010: expected_segments = 7'b0010010;
            4'b0011: expected_segments = 7'b0000110;
            4'b0100: expected_segments = 7'b1001100;
            4'b0101: expected_segments = 7'b0100100;
            4'b0110: expected_segments = 7'b0100000;
            4'b0111: expected_segments = 7'b0001111;
            4'b1000: expected_segments = 7'b0000000;
            4'b1001: expected_segments = 7'b0000100;
            4'b1010: expected_segments = 7'b0001000;
            4'b1011: expected_segments = 7'b1100000;
            4'b1100: expected_segments = 7'b0110001;
            4'b1101: expected_segments = 7'b1000010;
            4'b1110: expected_segments = 7'b0110000;
            4'b1111: expected_segments = 7'b0111000;
        endcase

        case(sel)
            3'b000: expected_anode = 8'b11111110;
            3'b001: expected_anode = 8'b11111101;
            3'b010: expected_anode = 8'b11111011;
            3'b011: expected_anode = 8'b11110111;
            3'b100: expected_anode = 8'b11101111;
            3'b101: expected_anode = 8'b11011111;
            3'b110: expected_anode = 8'b10111111;
            3'b111: expected_anode = 8'b01111111;
        endcase
        
        if (expected_segments != segments)
            $display("ERROR - Segments: Given = %b, Expected = %b, Got = %b", num, expected_segments, segments);
        else
            $display("Passed - Segments: Given = %b, Got = %b", num, segments);
        
        if (expected_anode != anode)
            $display("ERROR - Anode: Given = %b, Expected = %b, Got = %b", sel, expected_anode, anode);
        else
            $display("Passed - Anode: Given = %b, Got = %b", sel, anode);
    endtask

    task direct_test(input logic [3:0] NUM, input logic [2:0] SEL);
        driver(NUM, SEL);
        monitor();
    endtask

    task random_test(input int number);
        for (int i = 0; i < number; i++) begin
            driver();
            monitor();
        end
    endtask

    initial begin
        for (int i = 0; i < 16; i++) begin
            direct_test(i, i % 8);
        end
    end
endmodule

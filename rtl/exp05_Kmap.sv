`timescale 1ns / 1ps

module seven_segment (
    input logic [3:0] num,
    input logic [2:0] sel,
    output logic [6:0] segments,
    output logic dp,
    output logic [7:0] anode
);

    always_comb begin
        dp = 1; // Keep Dot Point OFF
    end

    always_comb begin
        segments[0] = (~num[3] & ~num[2] & ~num[1] & num[0]) | (~num[3] & num[2] & ~num[1] & ~num[0]) | 
                      (num[3] & num[2] & ~num[1] & num[0]) | (num[3] & ~num[2] & num[1] & num[0]);
        segments[1] = (num[2] & num[1] & ~num[0]) | (num[3] & num[1] & num[0]) | 
                      (num[3] & num[2] & ~num[0]) | (~num[3] & num[2] & ~num[1] & num[0]);
        segments[2] = (~num[3] & ~num[2] & num[1] & ~num[0]) | (num[3] & num[2] & num[1]) | 
                      (num[3] & num[2] & ~num[0]);
        segments[3] = (~num[3] & num[2] & ~num[1] & ~num[0]) | (~num[3] & ~num[2] & ~num[1] & num[0]) | 
                      (num[2] & num[1] & num[0]) | (num[3] & ~num[2] & num[1] & ~num[0]);
        segments[4] = (~num[3] & num[0]) | (~num[2] & ~num[1] & num[0]) | (~num[3] & num[2] & ~num[1]);
        segments[5] = (~num[3] & ~num[2] & num[0]) | (~num[3] & ~num[2] & num[1]) | 
                      (~num[3] & num[1] & num[0]) | (num[3] & num[2] & ~num[1] & num[0]);
        segments[6] = (~num[3] & ~num[2] & ~num[1]) | (num[3] & num[2] & ~num[1] & ~num[0]) | 
                      (~num[3] & num[2] & num[1] & num[0]);
    end

    always_comb begin
        anode[0] = (sel[2] | sel[1] | sel[0]);
        anode[1] = (sel[2] | sel[1] | ~sel[0]);
        anode[2] = (sel[2] | ~sel[1] | sel[0]);
        anode[3] = (sel[2] | ~sel[1] | ~sel[0]);
        anode[4] = (~sel[2] | sel[1] | sel[0]);
        anode[5] = (~sel[2] | sel[1] | ~sel[0]);
        anode[6] = (~sel[2] | ~sel[1] | sel[0]);
        anode[7] = (~sel[2] | ~sel[1] | ~sel[0]);
    end

endmodule

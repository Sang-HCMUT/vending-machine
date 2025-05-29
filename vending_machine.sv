module vending_machine (
    input clk,
    input i_nickle,
    input i_dime,
    input i_quarter,
    output reg o_soda,
    output reg [2:0] o_change
);

    // Trạng thái định nghĩa bằng localparam
    localparam S0 = 0, S5 = 1, S10 = 2, S15 = 3, S20 = 4;

    reg [2:0] state, next_state;
    reg [6:0] total;  // Tổng tiền

    // Cập nhật trạng thái
    always @(posedge clk) begin
        state <= next_state;
    end

    // Xác định trạng thái kế tiếp
    always @(*) begin
        case (state)
            S0: begin
                if (i_nickle) next_state = S5;
                else if (i_dime) next_state = S10;
                else if (i_quarter) next_state = S20;
                else next_state = S0;
            end
            S5: begin
                if (i_nickle) next_state = S10;
                else if (i_dime) next_state = S15;
                else if (i_quarter) next_state = S20;
                else next_state = S5;
            end
            S10: begin
                if (i_nickle) next_state = S15;
                else if (i_dime || i_quarter) next_state = S20;
                else next_state = S10;
            end
            S15: begin
                next_state = S20;
            end
            S20: begin
                next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // Tính toán đầu ra
    always @(posedge clk) begin
        o_soda <= 0;
        o_change <= 3'b000;

        case (state)
            S0: begin
                total <= 0;
                if (i_nickle) total <= 5;
                else if (i_dime) total <= 10;
                else if (i_quarter) total <= 25;
            end
            S5: begin
                if (i_nickle) total <= 10;
                else if (i_dime) total <= 15;
                else if (i_quarter) total <= 30;
            end
            S10: begin
                if (i_nickle) total <= 15;
                else if (i_dime) total <= 20;
                else if (i_quarter) total <= 35;
            end
            S15: begin
                if (i_nickle || i_dime || i_quarter)
                    total <= total + (i_nickle ? 5 : (i_dime ? 10 : 25));
                else
                    total <= 15;
            end
            S20: begin
                o_soda <= 1;
                case (total - 20)
                    0: o_change <= 3'b000;
                    5: o_change <= 3'b001;
                    10: o_change <= 3'b010;
                    15: o_change <= 3'b011;
                    20: o_change <= 3'b100;
                    default: o_change <= 3'b000;
                endcase
                total <= 0;
            end
        endcase
    end

endmodule

module vending_machine_tb;

    reg clk;
    reg i_nickle, i_dime, i_quarter;
    wire o_soda;
    wire [2:0] o_change;

    vending_machine vm (
        .clk(clk),
        .i_nickle(i_nickle),
        .i_dime(i_dime),
        .i_quarter(i_quarter),
        .o_soda(o_soda),
        .o_change(o_change)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("vending.vcd");
        $dumpvars(0, vending_machine_tb);

        i_nickle = 0; i_dime = 0; i_quarter = 0;

        // Insert dime (¢10)
        #10 i_dime = 1; #10 i_dime = 0;

        // Insert quarter (¢25) => total = ¢35 → soda + 15¢ change
        #10 i_quarter = 1; #10 i_quarter = 0;

        #20;

        // Insert nickel + dime + dime (5 + 10 + 10 = 25)
        #10 i_nickle = 1; #10 i_nickle = 0;
        #10 i_dime = 1;   #10 i_dime = 0;
        #10 i_dime = 1;   #10 i_dime = 0;

        #20;

        
        // === TEST 3: Đúng 20¢ bằng 2 đồng 10¢ ===
        #10 i_dime = 1; #10 i_dime = 0;
        #10 i_dime = 1; #10 i_dime = 0;
        // → Tổng = 20¢ → Xuất nước, không thối
        #20;

        // === TEST 4: 4 đồng 5¢ (Nickel) ===
        #10 i_nickle = 1; #10 i_nickle = 0;
        #10 i_nickle = 1; #10 i_nickle = 0;
        #10 i_nickle = 1; #10 i_nickle = 0;
        #10 i_nickle = 1; #10 i_nickle = 0;
        // → Tổng = 20¢ → Xuất nước, không thối
        #20;

        // === TEST 5: 1 đồng 25¢ ===
        #10 i_quarter = 1; #10 i_quarter = 0;
        // → Xuất nước, thối 5¢ (o_change = 001)
        #20;

        $finish;

    end

endmodule


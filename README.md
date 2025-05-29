# Vending Machine – Milestone 1

This project is part of the **Computer Architecture (EE3043)** course at VNU-HCM University of Technology. The objective of Milestone 1 is to design a vending machine using Verilog and FSM concepts.


## 📚 Problem Statement
Design a vending machine that:
- Accepts coins: ¢5 (nickel), ¢10 (dime), ¢25 (quarter)
- Accepts only one coin per clock cycle
- Dispenses soda when total ≥ ¢20
- Returns change via a 3-bit `o_change` value

## 💡 Design Features
- Implemented using Verilog FSM (Moore-style)
- Modular and clean code structure
- Handles edge cases like overpayment and exact amount


## 🛠️ How to Simulate
Using Icarus Verilog:
```bash
iverilog -o vending.vvp src/vending_machine.v tb/vending_machine_tb.v
vvp vending.vvp
gtkwave waveform/vending.vcd
```

## FSM state diagram 
![image](https://github.com/user-attachments/assets/5721d62c-b575-4fb4-a5b8-d7b5bb8b6094)


## Waveform after all testcase
![image](https://github.com/user-attachments/assets/808f23b9-0d4b-4b29-95f2-386567de8b2d)



✅ Output Verification
All test cases pass. o_soda and o_change match expected outputs.

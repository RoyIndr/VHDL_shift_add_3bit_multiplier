# 🔢 3-Bit Shift-and-Add Multiplier (VHDL Structural Design)

This repository implements a **3-bit multiplier** using the **shift-and-add** algorithm in **VHDL**, designed in a  **modular and structural** manner. The project includes individual VHDL components (e.g., register, shifter, adder, control unit) that work together to perform multiplication sequentially.

---

## 📁 File Overview

| File Name          | Description |
|-------------------|-------------|
| `top.vhd`          | Top-level entity that connects the entire data path and control unit. |
| `control_unit.vhd` | Generates control signals for the data path. |
| `data_processor.vhd` | Main part to process the data, containing registers, adder, shifter, counter, etc. |
| `proc_accu.vhd`    | Accumulator to hold the intermediate and result of adder. |
| `proc_adder.vhd`   | 3-bit full adder for calculating partial sums. |
| `proc_counter.vhd` | To control iteration over bits. |
| `proc_reg.vhd`     | To store the multiplicand. |
| `proc_shifter.vhd` | Shifter that handles right-shifting of operands. |
| `fullAdder.vhd`    | 1-bit full adder used as a building block for `proc_adder`. |
| `tb.vhd`           | Testbench for simulating the complete multiplier system. |

---

## 🚀 How It Works

This multiplier performs `A × B` where both **A** and **B** are 3-bit unsigned numbers. The design uses a **shift-and-add algorithm** with the following steps:

1. **Registers** load operands A.
2. **Shifter** containcs 6-bit of data and shifts the multiplier bits.
3. **Adder** do binary addition of multiplicand and 3 highest bit of shifter then store it into accumulator
4. **Counter** controls the number of iterations / count the amount of shifting during the process.
5. **Control Unit (FSM)** manages the sequence of operations.

---

## 📊 Testbench
The testbench (`tb.vhd`) automatically applies input combinations and checks the output.

---

## 🧩 Modularity

This project is designed using structural VHDL. Each component can be independently simulated or reused in other digital systems, making the architecture easy to understand and expand.

---

## ✨ Possible Enhancements

- Upgrade to 4-bit or 8-bit multiplier.
- Add signed number support.
- Pipeline the datapath for faster operation.
- Display output on FPGA hardware (e.g., on 7-segment display or LEDs).

---

## 👤 Author

**Roy Indra Pratama**  
GitHub: [@RoyIndr](https://github.com/RoyIndr)


#  LabAutoIEC611311

This repository is maintained by the Robotics Joint Research Lab (JRL) between STIIMA-CNR and the University of Brescia. It includes IEC 61131-3 compliant examples, reusable function blocks, and utilities designed for educational and applied automation contexts using IEC611311.

---

## 📁 Repository Structure

- **[Programs](Programs/)**  
  - [`SimpleExampleMC2`](Programs/SimpleExampleMC2.md) – An illustrative example of the Tc2_MC2 Motion Control library
  - [`ChirpTest`](Programs/ChirpTest.md) – A complete motion experiment using chirp excitation and real-time logging.

__XXX.xml__ is the only program.
__XXX_FullPlcProject.xml__ is the entire PLC projects (PROGRAM, FB, DUTs, ...).


- **[Function Blocks](Function%20Blocks/)**  
  - [`FB_ChirpSignal`](Function%20Blocks/FB_ChirpSignal.md) – Generates linear or logarithmic chirp trajectories with optional acceleration and velocity modes.
  - [`FB_DataLogger`](Function%20Blocks/FB_DataLogger.md) – Binary logger.
  
- **[Derived User Types (DUTs)](DUTs/)**  
  - [`E_State (ChirpTest)`](DUTs/ChirpTaskE_State.xml) – Enumerator used in `ChirpTest`.
  - [`SimpleExampleMC2_MotorState (SimpleExampleMC2)`](DUTs/SimpleExampleMC2_MotorState.xml) – Enumerator used in `SimpleExampleMC2`.

---

## 🚀 Getting Started

1. Clone or download the repository.
2. Open TwinCAT 3 and import the desired `.xml` blocks.
3. Refer to each subfolder’s README for detailed usage instructions.

---

## 📄 License

Distributed under the BSD-3-Clause License.  
See [`LICENSE`](LICENSE) for more information.

---

## 👤 Authors

Developed at  
**Joint Robotics Lab – CARI**  
University of Brescia & STIIMA-CNR

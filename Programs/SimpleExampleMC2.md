
# 🧠 MAIN – Finite State Machine Axis Control Program (TwinCAT 3)

This README provides an in-depth explanation of the `MAIN` program implemented in **Structured Text (ST)** using the **PLCopen XML format**. The program is designed to control a single axis (`Axis1`) using a Finite State Machine (FSM). It leverages the `Tc2_MC2` library to execute basic motion tasks like enabling the drive, moving to predefined positions (`posA`, `posB`), and disabling the drive.

---

## 📐 Purpose

The `MAIN` program automates a motion cycle on a single NC axis using a deterministic FSM. The axis will:

1. **Wait** for an external `bStart` trigger.
2. **Enable** the drive.
3. **Move** to position `posA`.
4. **Move** back to position `posB`.
5. **Power off** the axis and return to idle.

---

## 🔧 Axis and Control Blocks

### Axis Reference

- `Axis1 : AXIS_REF`  
  A symbolic reference to the axis mapped in the TwinCAT I/O configuration. Provides access to feedback and control data for the axis, such as position, velocity, and status flags.

### Motion Function Blocks (from Tc2_MC2)

- `fbPower : MC_Power`  
  Handles enabling and disabling of the drive (motor power).
  
- `fbMoveA : MC_MoveAbsolute`  
  Executes a move to the user-defined position `posA`.

- `fbMoveB : MC_MoveAbsolute`  
  Executes a move to the user-defined position `posB` (typically returning).

---

## 🎛 Inputs and Outputs

### Input: `bStart AT %I* : BOOL`

- Mapped to a physical or virtual input (e.g., button or HMI).
- When TRUE, it starts the FSM and is reset immediately after.

### Output: `bMoving AT %Q* : BOOL`

- Mapped to a physical or virtual output (e.g., status lamp).
- TRUE when the state is anything other than `MotorState.NONE`.

---

## 🔁 FSM States (`MotorState`)

> The FSM uses a user-defined `ENUM` called `MotorState` (defined in DUTs).

States:
- `NONE`: Idle. Waits for `bStart`.
- `STARTING_MOTOR`: Powers on the drive using `fbPower`.
- `MOVE_TO_A`: Issues a move to `posA` using `fbMoveA`.
- `MOVE_TO_B`: Issues a move to `posB` using `fbMoveB`.
- `STOPPING_MOTOR`: Turns off the drive.

---

## 📈 Motion Parameters

- `posA : LREAL := 100.0`  
  First target position for the axis.

- `posB : LREAL := 0.0`  
  Second target position (usually home or return).

---

## 🔍 Monitoring

- `ActPos : LREAL`  
  Updated every cycle with `Axis1.NcToPlc.ActPos`. Can be visualized via HMI or logged.

---

## ⚙️ Execution Logic

### Axis Feedback

```pascal
ActPos := Axis1.NcToPlc.ActPos;
bMoving := state > MotorState.NONE;
```

### FSM Transitions

Each state transitions based on the success of the previous operation:

```pascal
CASE state OF
  MotorState.NONE:
    IF bStart THEN
      state := MotorState.STARTING_MOTOR;
      bStart := FALSE;
    END_IF

  MotorState.STARTING_MOTOR:
    IF fbPower.Status AND fbPower.Active THEN
      state := MotorState.MOVE_TO_A;
    END_IF
  ...
END_CASE
```

### FSM Behavior

Each state executes its corresponding motion block:

```pascal
CASE state OF
  MotorState.MOVE_TO_A:
    fbMoveA(
      Axis := Axis1,
      Execute := TRUE,
      Position := posA,
      ...
    );
  ...
END_CASE
```

All other blocks are set to `Execute := FALSE` to prevent unwanted actions.

---

## 🧱 Expandability

This architecture is modular and easy to extend. You could add:

- Homing routines
- Error detection and recovery states
- Additional motion states (e.g., MOVE_TO_C)

---

## 📂 Notes

- The logic follows best practices for calling MC blocks cyclically.
- This is ideal for motion experimentation, training, or basic automation cycles.
- Works seamlessly with TwinCAT HMI if variables are exposed.

---

## 👤 Author

**Manuel Beschi**  
Joint Robotics Lab (JRL) – CARI  
University of Brescia  
cari.unibs.it

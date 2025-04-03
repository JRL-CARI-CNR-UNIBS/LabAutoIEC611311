
# 📦 FB_DataLogger – TwinCAT Binary Data Logging Function Block

## 🧩 Overview

`FB_DataLogger` is a PLC function block designed for **logging numeric data** (e.g., time, position, velocity, torque) into a **binary file** during real-time operation in TwinCAT. It abstracts file handling operations like opening, writing, and closing, making it ideal for experiments, simulations, or monitoring tasks in automation and robotics systems.

---

## ⚙️ Features

- ✅ Handles file open/write/close using internal function blocks
- ✅ Logs binary data in `ARRAY[1..4] OF LREAL` format
- ✅ Compatible with TwinCAT file I/O over ADS
- ✅ 5-second timeout safety for all file operations
- ✅ Exposes status flags and file handle for easy integration
- ✅ Minimal configuration: only path and triggers needed

---

## 🧮 Interface

### ➤ Inputs (`VAR_INPUT`)

| Name         | Type          | Description                                              |
|--------------|---------------|----------------------------------------------------------|
| `netId`      | `T_AmsNetId`  | AMS Net ID (use `''` for local device)                   |
| `sFileName`  | `T_MaxString` | Full path to the binary file (e.g., `'C:\Logs\log.bin'`) |
| `bOpen`      | `BOOL`        | Rising edge opens the file                               |
| `bWrite`     | `BOOL`        | Rising edge writes current sample                        |
| `bClose`     | `BOOL`        | Rising edge closes the file                              |
| `t`          | `LREAL`       | Timestamp or simulation time                             |
| `act_pos`    | `LREAL`       | Actual position                                          |
| `act_vel`    | `LREAL`       | Actual velocity                                          |
| `act_torque` | `LREAL`       | Actual torque                                            |

---

### ➤ Outputs (`VAR_OUTPUT`)

| Name        | Type     | Description                                               |
|-------------|----------|-----------------------------------------------------------|
| `bDone`     | `BOOL`   | TRUE when file is successfully closed                     |
| `bBusy`     | `BOOL`   | TRUE when file operation is ongoing                       |
| `bError`    | `BOOL`   | TRUE if any error occurs                                  |
| `nErrorId`  | `UDINT`  | Error code returned by TwinCAT file functions             |
| `hFile`     | `UINT`   | File handle to be reused for write/close operations       |

---

### ➤ Internal Variables

| Name            | Type                  | Description                              |
|-----------------|-----------------------|------------------------------------------|
| `dataBuffer`    | `ARRAY[1..4] OF LREAL`| Buffer holding [t, pos, vel, torque]     |
| `nBytesToWrite` | `UDINT`               | Calculated size of data buffer in bytes  |
| `fbFileOpen`    | `FB_FileOpen`         | TwinCAT file open function block         |
| `fbFileWrite`   | `FB_FileWrite`        | TwinCAT file write function block        |
| `fbFileClose`   | `FB_FileClose`        | TwinCAT file close function block        |
| `bFileOpen`     | `BOOL`                | Internal flag for safe edge triggering   |

---

## 🚀 Example Usage

### Basic Usage in a Cyclic Task

```pascal
fbLogger(
    netId := '',
    sFileName := 'C:\Logs\experiment.bin',
    bOpen := startLogging,
    bWrite := logNow,
    bClose := stopLogging,
    t := systemTime,
    act_pos := position,
    act_vel := velocity,
    act_torque := torque
);
```

- Set `bOpen` TRUE once to open the file.
- Toggle `bWrite` TRUE to log each sample (e.g., once per cycle).
- Set `bClose` TRUE once to close the file when logging is finished.

---

## 📂 File Format

- Binary format with `ARRAY[1..4] OF LREAL`:
  1. `t` (time)
  2. `act_pos`
  3. `act_vel`
  4. `act_torque`

Each log sample is `4 × 8 bytes = 32 bytes`.

---

## 🧠 Tips

- Use `bWrite` carefully — ensure it's triggered once per sample.
- The file is overwritten on each `bOpen`, ensure unique names or post-processing.
- You can analyze the binary data offline using Python, MATLAB, or custom tools.

To load the file 
### 🔎 In MATLAB
```matlab
% Open file for reading in binary mode
filename = 'C:/Logs/experiment.bin';
fid = fopen(filename, 'rb');

% Check if the file was opened successfully
if fid == -1
    error('Failed to open file.');
end

% Read data: 4 columns, unknown number of rows
data = fread(fid, [4, Inf], 'double');
fclose(fid);

% Transpose for easier handling: rows = samples
data = data';

% Access individual signals
time = data(:,1);
pos  = data(:,2);
vel  = data(:,3);
torque = data(:,4);
```

### 🐍 In Python

```python
import numpy as np

# Load binary data file (adjust path as needed)
filename = 'C:/Logs/experiment.bin'

# Read binary file: 64-bit floats, 4 values per row
data = np.fromfile(filename, dtype=np.float64).reshape(-1, 4)

# Extract columns
time = data[:, 0]
pos = data[:, 1]
vel = data[:, 2]
torque = data[:, 3]
```
---

## 🧑‍💻 Author

**Manuel Beschi**  
Joint Robotics Lab (JRL) - CARI  
University of Brescia  
cari.unibs.it

---

## 🛠️ Version History

- **v1.0** – March 2025: Initial release

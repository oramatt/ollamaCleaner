# Ollama Model Cleaner

A simple Bash script to help you remove Ollama models and reclaim disk space on macOS. The script gives you the option to remove either **all** installed models or a **specific** one, while displaying disk usage before and after cleanup.

## Features

- Lists all installed Ollama models
- Allows you to:
  - Remove **all** models
  - Remove a **specific** model by name
- Stops any running models before removal
- Displays disk usage before and after cleanup
- Provides feedback and validation during operations

## Prerequisites

- macOS or any Unix-based system with Bash
- [Ollama](https://ollama.com/) installed and configured
- The script must be run in a terminal with permissions to manage Ollama models

## Usage

### 1. Clone the repository or download the script

```bash
git clone https://github.com/your-username/ollama-cleaner.git
cd ollama-cleaner
```

### 2. Make the script executable

```bash
chmod +x ollamaCleaner.sh
```

### 3. Run the script

```bash
./ollamaCleaner.sh
```

### 4. Follow the prompts

- You'll be asked whether to remove **All** models or a **Specific** model.
- If removing a specific model, you will be prompted to enter the model name.
- The script stops the model(s), removes them, and then lists any remaining models.

## Example Output

```
Currently installed Ollama models:
model1
model2

Do you want to remove (A)ll models or a (S)pecific one? [A/S]: A

Disk usage before cleanup:
...

Stopping all running models...
Removing all models...

Remaining models:
(no output)

Disk usage after cleanup:
...

Cleanup complete. Disk space has been freed.
```



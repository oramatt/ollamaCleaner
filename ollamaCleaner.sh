#!/bin/bash

# Remove Ollama models to free up disk space
#
# Design requirements:
# 1. List models with ollama list
# 2. Ask to remove ALL models or a specific model 
# 3. Stop the model(s) from running with ollama stop
# 4. Remove model(s) using ollama rm
# 5. List remaining models
# 6. Enjoy your freed up disk space

set -euo pipefail

# Step 1: List models
echo "Currently installed Ollama models:"
ollama list || { echo "Failed to list models. Is Ollama installed and running?"; exit 1; }
echo ""

# Step 2: Ask user what to do
read -rp "Do you want to remove (A)ll models or a (S)pecific one? [A/S]: " doWat
doWat=$(echo "$doWat" | tr '[:lower:]' '[:upper:]')  # Normalize input

if [[ "$doWat" == "A" ]]; then
    # Show disk usage before
    echo "Disk usage before cleanup:"
    df -h /
    echo ""

    # Step 3: Stop all models
    echo "Stopping all running models..."
    running_models=$(ollama list | awk 'NR>1 {print $1}')
    for model in $running_models; do
        ollama stop "$model" || echo "Failed to stop $model (maybe not running)"
    done

    # Step 4: Remove all models
    echo "Removing all models..."
    for model in $running_models; do
        ollama rm "$model" || echo "Failed to remove $model"
    done

elif [[ "$doWat" == "S" ]]; then
	echo "Disk usage before cleanup:"
    df -h /
    echo ""
    
    read -rp "Enter the name of the model you want to remove: " model

    # Check if the model exists
    if ! ollama list | awk 'NR>1 {print $1}' | grep -q "^$model$"; then
        echo "Model '$model' does not appear to be installed."
        exit 1
    fi

    # Step 3: Stop the model
    echo "Stopping model $model..."
    ollama stop "$model" || echo "Could not stop $model (maybe not running)"

    # Step 4: Remove the model
    echo "Removing model $model..."
    ollama rm "$model" || echo "Could not remove $model"

else
    echo "Invalid choice. Please select 'A' or 'S'."
    exit 1
fi

# Step 5: List remaining models
echo ""
echo "Remaining models:"
ollama list || echo "Could not list remaining models."

# Step 6: Optional disk usage report
echo ""
echo "Disk usage after cleanup:"
df -h /

# Step 7: Done
echo ""
echo "Cleanup complete. Disk space has been freed."

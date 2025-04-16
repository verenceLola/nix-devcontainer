# Function to get the battery path
get_battery_path() {
  local power_supply_dir="/sys/class/power_supply"
  local battery_dir=""

  if [[ -d "$power_supply_dir" ]]; then
    for entry in "$power_supply_dir"/*; do
      if [[ -f "$entry/type" ]]; then
        local type # Declare 'type' first
        type=$(cat "$entry/type") # Assign separately
        if [[ "$type" == "Battery" ]]; then
          battery_dir="$entry"
          echo "$battery_dir"
          return 0
        fi
      fi
    done
  fi
  echo "" # Return empty string if no battery directory is found
  return 1
}

# Get the battery directory
battery_path=$(get_battery_path)

if [[ -z "$battery_path" ]]; then
  echo "Error: Could not find battery information."
  exit 1
fi

# Get the battery capacity
capacity_file="$battery_path/capacity"
battery_level="" # Declare the variable first
if [[ -f "$capacity_file" ]]; then
  battery_level=$(cat "$capacity_file") # Assign the value separately
  echo "$battery_level%"
else
  echo "Error: Could not read battery capacity."
  exit 1
fi

exit 0

import os

def calculate_files_size(directory, prefix):
    total_size = 0
    
    # List all files in the given directory
    for filename in os.listdir(directory):
        # Check if the file starts with the given prefix, ends with '.bin', and has a numeric part
        if filename.startswith(prefix) and filename[len(prefix):-4].isdigit() and filename.endswith('.bin'):
            # Construct the full file path
            file_path = os.path.join(directory, filename)
            
            # Check if it's a file (not a directory)
            if os.path.isfile(file_path):
                # Get the file size and add to total_size
                total_size += os.path.getsize(file_path)
    
    return total_size

def calculate_bit_rate(total_size):
    # Convert total size to kilobytes (1 kB = 1024 bytes)
    total_size_kb = total_size / 1024
    
    # Calculate bitrate in kilobits per second (1 kbps = 1000 bps)
    bitrate_kbps = (total_size * 8) / (1 * 10 * 1000)  # (total_size * 8) gives bits, divided by 1000 for kbps

    return total_size_kb, bitrate_kbps

# Example usage
directory = './SCENE_loot_random/'  # Directory where the files are located
prefix = 'loot_15_seg#'      # Prefix for the file names
total_size = calculate_files_size(directory, prefix)
total_size_kb, result_kbps = calculate_bit_rate(total_size)

print(f"Total size of matching files: {total_size_kb:.2f} kB")
print(f"Calculated bitrate: {result_kbps:.2f} kbps")


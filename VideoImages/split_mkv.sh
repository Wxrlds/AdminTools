# Split mkv video into multiple parts by file size for transfer to fat32 USB Drives
mkvmerge --split 3500M -o output.mkv input.mkv
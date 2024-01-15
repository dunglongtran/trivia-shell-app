#!/bin/bash

# Hàm ghi log với timestamp
log_message() {
    local message="$1"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $message" >> ../log/app.log
}

# Gọi hàm ghi log với một thông điệp
log_message "$1"


#!/bin/bash

echo "Đăng nhập vào hệ thống"
read -p "Tên người dùng: " username
read -s -p "Mật khẩu: " password
echo

# Băm mật khẩu
hashed_password=$(echo -n "$password" | openssl dgst -sha256)

# Kiểm tra thông tin đăng nhập
if grep -q "^$username, $hashed_password" ../data/users.csv; then
    echo "Đăng nhập thành công."
    export USERNAME=$username
    bash main.sh
else
    echo "Thông tin đăng nhập không chính xác."
fi
#!/bin/bash

bash log.sh "Màn hình đăng nhập"

echo "Đăng nhập vào hệ thống"
read -p "Tên người dùng: " USER_NAME
read -s -p "Mật khẩu: " password
echo

# Băm mật khẩu
hashed_password=$(echo -n "$password" | openssl dgst -sha256)

# Kiểm tra thông tin đăng nhập
if grep -q "^$USER_NAME, $hashed_password" ../data/users.csv; then
    echo "Đăng nhập thành công."
    export USER_NAME=$USER_NAME
    bash log.sh "$USER_NAME đăng nhập thành công"
    bash main.sh
else
    echo "Thông tin đăng nhập không chính xác."
    bash log.sh "$USER_NAME - Thông tin đăng nhập không chính xác."
fi
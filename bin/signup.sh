#!/bin/bash

bash log.sh "Màn hình đăng ký"

echo "Đăng ký tài khoản mới"
read -p "Tên người dùng: " USER_NAME
read -s -p "Mật khẩu: " password
echo

# Kiểm tra tên người dùng
if grep -q "^$USER_NAME," ../data/users.csv; then
    echo "Tên người dùng đã tồn tại."
    bash log.sh "$USER_NAME Tên người dùng đã tồn tại."
    exit 1
fi

# Băm mật khẩu
hashed_password=$(echo -n "$password" | openssl dgst -sha256)

# Lưu thông tin người dùng
echo "$USER_NAME, $hashed_password" >> ../data/users.csv

echo "Đăng ký thành công."

export USER_NAME=$USER_NAME

bash log.sh "$USER_NAME Đăng ký thành công."

echo "Nhấn 'm' để quay lại menu chính hoặc 'q' để thoát."
read -n 1 -p "Lựa chọn của bạn: " choice
echo

case $choice in
    m) bash main.sh;;
    q) exit 0;;
    *) echo "Lựa chọn không hợp lệ. Thoát." && exit 1;;
esac
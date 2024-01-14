#!/bin/bash

echo "Đăng ký tài khoản mới"
read -p "Tên người dùng: " username
read -s -p "Mật khẩu: " password
echo

# Kiểm tra tên người dùng
if grep -q "^$username," ../data/users.csv; then
    echo "Tên người dùng đã tồn tại."
    exit 1
fi

# Băm mật khẩu
hashed_password=$(echo -n "$password" | openssl dgst -sha256)

# Lưu thông tin người dùng
echo "$username, $hashed_password" >> ../data/users.csv

echo "Đăng ký thành công."
export USERNAME=$username
echo "Nhấn 'm' để quay lại menu chính hoặc 'q' để thoát."
read -n 1 -p "Lựa chọn của bạn: " choice
echo

case $choice in
    m) bash main.sh;;
    q) exit 0;;
    *) echo "Lựa chọn không hợp lệ. Thoát." && exit 1;;
esac
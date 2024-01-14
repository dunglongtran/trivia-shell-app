#!/bin/bash

# Kiểm tra xem biến USERNAME có được đặt hay không
if [ -z "$USERNAME" ]; then
    # Nếu USERNAME không có giá trị, gọi signin.sh
    echo "Chưa đăng nhập. Đang chuyển đến trang đăng nhập..."
    bash authen.sh
else
    # Nếu USERNAME có giá trị, gọi start_test.sh
    echo "Chào mừng $USERNAME!"
    bash app.sh
fi

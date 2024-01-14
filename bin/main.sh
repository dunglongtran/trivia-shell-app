#!/bin/bash

# Kiểm tra xem biến USER_NAME có được đặt hay không
if [ -z "$USER_NAME" ]; then
    # Nếu USER_NAME không có giá trị, gọi signin.sh
    echo "Chưa đăng nhập. Đang chuyển đến trang đăng nhập..."
    bash authen.sh
else
    # Nếu USER_NAME có giá trị, gọi start_test.sh
    bash app.sh
fi

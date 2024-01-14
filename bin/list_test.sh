#!/bin/bash

# Đường dẫn đến thư mục chứa các file kết quả
results_dir="../data"
# Liệt kê các file kết quả, sắp xếp theo thời gian chỉnh sửa, mới nhất đầu tiên
files=$(ls -lt $results_dir | grep "${USER_NAME}_" | awk '{print $9}')

# Kiểm tra nếu không có file nào
if [ -z "$files" ]; then
    echo "Không có bài kiểm tra nào được tìm thấy."
    bash ./app.sh
fi

echo "Chọn một bài kiểm tra để xem kết quả:"
select file_name in  "Quay lại" $files; do
    # Kiểm tra nếu người dùng chọn 'Quay lại'
    if [ "$file_name" == "Quay lại" ]; then
    bash ./app.sh
    break
    fi
    # Kiểm tra nếu người dùng đã chọn một file
    if [ -n "$file_name" ]; then
        # Gọi script view_test.sh với file được chọn
        ./view_test.sh "$results_dir/$file_name"
        break
    else
        echo "Lựa chọn không hợp lệ. Hãy chọn lại."
    fi
done

#!/bin/bash

bash log.sh "Màn hình làm bài kiểm tra "


# Số lượng câu hỏi
NUM_QUESTIONS=30
questions=()
CORRECT_ANSWERS=0
index=0
# Đọc file vào mảng
while IFS= read -r line; do
#    questions+=("$line")
# Lược bỏ tiêu đề
     if [ "$index" -eq 0 ]; then
        index=$((index+1))
        continue
    fi
    modified_line=$(echo "$line" | tr -d '\r')
    questions+=("$modified_line")
    index=$((index+1))
done < ../data/questions.csv

# Xáo trộn mảng
for ((i=${#questions[@]}-1; i>0; i--)); do
    # Tạo số ngẫu nhiên
    j=$((RANDOM % (i+1)))
    # Hoán đổi
    temp=${questions[i]}
    questions[i]=${questions[j]}
    questions[j]=$temp
done

# In ra 30 câu hỏi đầu tiên sau khi xáo trộn
#for i in "${!questions[@]}"; do
#    if [ "$i" -ge "$NUM_QUESTIONS" ]; then
#        break
#    fi
#    IFS=',' read -r question correct_answer time_limit options <<< "${questions[i]}"
#    echo "Câu hỏi $((i+1)): $question"
#    echo "Thời gian: $time_limit giây"
#    # Tiếp tục xử lý các câu hỏi ở đây...
#done

# Xác định tên file CSV
current_time=$(date "+%Y_%m_%d_%H_%M")
csv_file="../data/${USER_NAME}_${current_time}.csv"

bash log.sh "$USER_NAME làm bài kiểm tra $csv_file"

clear

echo "**********************************************"
echo "*"
echo "* Bắt đầu bài kiểm tra"
echo "*"
echo "**********************************************"
echo
echo
# Tạo file CSV và viết header
echo "question,answer,answer_time" > "$csv_file"

# Vòng lặp qua từng câu hỏi
for i in "${!questions[@]}"; do
    if [ "$i" -ge "$NUM_QUESTIONS" ]; then
        break
    fi
  # Thay thế ', ' thành ' ,#space#'
    find=", "
    replace="#space#"
    line=${questions[i]//$find/$replace}
#    echo $line
    IFS=',' read -r question_text correct_answer time_limit option_a option_b option_c <<< "$line"
    question=${question_text//$replace/$find}
    echo "Câu hỏi $((i+1)): $question"
#    echo "$options"
#    IFS=',' read -r a b c <<< "$options"
    echo "[ ] a. $option_a"
    echo "[ ] b. $option_b"
    echo "[ ] c. $option_c"
#
#    time_limit=5
    echo "Thời gian: $time_limit giây"

    # Lưu thời gian bắt đầu
    start_time=$SECONDS

    # Thời gian bắt đầu trả lời
    read_time=$((time_limit + 2))
    
   

    # Bắt đầu bộ đếm thời gian
    end_time=$((SECONDS + time_limit))

    # Nhận câu trả lời
    read -t $read_time -p "Trả lời: " answer

     # Tính toán thời gian trả lời
     answer_time=$((SECONDS - start_time))

    # Kiểm tra thời gian
    if [ $SECONDS -gt $end_time ]; then
        echo "Hết thời gian!"
     echo "$question,Hết thời gian,$answer_time" >> "$csv_file"
    else
        # Lưu câu trả lời và thời gian còn lại
        echo "Câu trả lời của bạn: $answer" # Thêm code để lưu câu trả lời
        # Kiểm tra câu trả lời có đúng không
        case $answer in
            a) selected_answer=$option_a;;
            b) selected_answer=$option_b;;
            c) selected_answer=$option_c;;
            *) selected_answer="Không hợp lệ";;
        esac
    
        echo "$question,$selected_answer,$answer_time" >> "$csv_file"
    
        if [[ $selected_answer == $correct_answer ]]; then
            echo "Chính xác!"
            CORRECT_ANSWERS=$((CORRECT_ANSWERS + 1))
#            echo "CORRECT_ANSWERS $CORRECT_ANSWERS"
        else
            echo "Sai! Câu trả lời đúng là: $correct_answer"
        fi
    fi
echo
done

## create some variables
#str="When was the world’s first ATM introduced, in Enfield, UK?,1967,30,1967,1977,1987"
#find=", "
#replace="#space#"
## notice the the str isn't prefixed with $
##    this is just how this feature works :/
#result=${str//$find/$replace}
#echo $result
echo
echo
echo "Bài kiểm tra kết thúc."
echo
echo "Bạn đã trả lời đúng $CORRECT_ANSWERS/$NUM_QUESTIONS"
echo

bash log.sh "$USER_NAME Bài kiểm tra kết thúc với $CORRECT_ANSWERS/$NUM_QUESTIONS trả lời đúng"


while true; do
echo
echo "Chọn một trong các tuỳ chọn sau: "
echo "1. Trở lại"
echo "2. Xem kết quả"
echo "3. Thoát"
echo -n "Vui lòng chọn một tùy chọn: "
read -r choice

if [[ $choice =~ ^[0-9]+$ ]]; then

        choice=$(echo $choice | sed 's/[^0-9]*//g')
        break
else
 echo "Loi: Nhap so nguyen duong"
fi

done
echo "Bạn chọn $choice $csv_file"
case $choice in
        1) bash app.sh;;
        2) bash view_test.sh "$csv_file";;
        3) exit 0;;
        *) echo "Lựa chọn không hợp lệ. Thoát." && exit 1;;
esac
#!/bin/bash

# 1. Biến được khai báo nhưng không bao giờ sử dụng
UNUSED_VAR="Hello World"

# 2. Sử dụng backtick (`) thay vì $() để lấy kết quả của lệnh
current_path=$(pwd)

# 3. Không dùng dấu ngoặc kép (quote) bao quanh biến khi in ra
echo "Bạn đang ở thư mục:" $current_path

# 4. Quên quote biến trong cấu trúc điều kiện, và dùng '==' trong ngoặc vuông đơn '['
if [ $1 == "admin" ]; then
  echo "Chào mừng admin!"
fi

# 5. Đọc file sai cách (dùng vòng lặp for với cat)
for line in $(cat list.txt); do
  # 6. Lại quên quote biến
  echo $line
done

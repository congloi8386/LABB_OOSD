# Lab 07 - Quản lý nhân sự

Ứng dụng desktop quản lý nhân sự viết bằng Java Swing. Bài thực hành mô phỏng các nghiệp vụ nhân sự, chấm công, tính lương và thưởng/phạt cho Công ty sơn Đông Á.

## Chức năng

- Quản lý phòng ban và hồ sơ nhân viên.
- Tuyển dụng, theo dõi thử việc, đánh giá và quản lý hợp đồng.
- Quản lý quyết định lương, chức vụ và hồ sơ bảo hiểm.
- Lập kế hoạch phân công ca, chấm công và ghi nhận giờ phụ trội.
- Tính bảng lương từ chấm công, quyết định lương, phụ cấp, bảo hiểm và thưởng/phạt đã duyệt.
- Lập, phê duyệt quyết định thưởng/kỷ luật và theo dõi phiếu thu/chi.
- Đăng nhập theo vai trò, gồm Nhân sự, Trưởng phòng, Chấm công, Kế toán, Giám đốc và Nhân viên.
- Dữ liệu được lưu cục bộ bằng tuần tự hóa Java; lần chạy đầu tiên tự tạo dữ liệu mẫu.

## Yêu cầu

- JDK 17 trở lên (cần có `javac` và `java` trong `PATH`).
- Không cần cài thư viện bên ngoài.

## Chạy ứng dụng

Mở terminal tại thư mục `lab07`:

**Windows**

```bat
chay_windows.bat
```

Hoặc biên dịch và chạy thủ công:

```bat
javac -encoding UTF-8 -d out src\*.java
java -Dfile.encoding=UTF-8 -cp out Main
```

**Linux / macOS**

```bash
chmod +x chay_linux_mac.sh
./chay_linux_mac.sh
```

Script sẽ biên dịch mã nguồn vào thư mục `out` trước khi khởi chạy ứng dụng.

## Tài khoản mẫu

Các tài khoản dưới đây đều dùng mật khẩu `123456`:

| Tài khoản | Vai trò |
| --- | --- |
| `nhansu` | Nhân sự |
| `truongphong` | Trưởng phòng |
| `chamcong` | Chấm công |
| `ketoan` | Kế toán |
| `giamdoc` | Giám đốc |
| `nhanvien` | Nhân viên |

Đây là tài khoản phục vụ dữ liệu demo; hãy đổi mật khẩu trong ứng dụng nếu cần.

## Chạy kiểm thử

**Windows**

```bat
chay_windows.bat
java -cp out KiemThu
```

**Linux / macOS**

```bash
./chay_linux_mac.sh
java -cp out KiemThu
```

`KiemThu` chạy trên một tệp dữ liệu tạm riêng, không ghi đè dữ liệu ứng dụng của người dùng.

## Lưu trữ dữ liệu

Theo mặc định, dữ liệu được lưu tại:

- Windows: `%USERPROFILE%\.quanlynhansu\nhansu.dat`
- Linux / macOS: `~/.quanlynhansu/nhansu.dat`

Có thể chọn một vị trí lưu khác bằng cách truyền thuộc tính Java `qlyns.data`, ví dụ:

```bash
java -Dqlyns.data=duong-dan/toi/nhansu.dat -Dfile.encoding=UTF-8 -cp out Main
```

Sao lưu tệp dữ liệu này trước khi xóa hoặc thay đổi môi trường chạy.

## Cấu trúc thư mục

```text
lab07/
├── src/       # Mã nguồn Java
├── so_do/     # Sáu sơ đồ thiết kế Draw.io
├── out/       # Các tệp .class sau khi biên dịch
├── *.bat      # Script chạy và kiểm thử trên Windows
├── *.sh       # Script chạy trên Linux/macOS
└── *.jar      # Gói ứng dụng có sẵn
```

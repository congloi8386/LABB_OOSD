# Lab 8 - Quản lý cửa hàng nước giải khát

Đồ án gồm ứng dụng quản lý cửa hàng viết bằng Java Swing và các sơ đồ phân tích, thiết kế được tạo bằng draw.io.

## Chức năng chính

- Quản lý sản phẩm, nhãn hiệu, nhà cung cấp và khách hàng.
- Tạo đơn nhập hàng, nhận hàng theo từng đợt và cập nhật tồn kho.
- Lập hóa đơn bán hàng, hỗ trợ giao hàng theo lịch hẹn khi thiếu hàng.
- Theo dõi công nợ khách hàng và ghi nhận các lần thanh toán.
- Lưu dữ liệu cục bộ; lần chạy đầu sử dụng dữ liệu mẫu.
- Xem thống kê bán hàng và công nợ.

## Yêu cầu

- Java 17 trở lên.
- JDK 17 trở lên nếu cần biên dịch mã nguồn hoặc chạy kiểm tra chức năng.

## Chạy ứng dụng

Trên Windows, mở thư mục `SanPham_JavaSwing` rồi chạy một trong các tệp:

- `mo_phan_mem.bat`: chạy ứng dụng từ tệp JAR có sẵn.
- `chay_ung_dung.bat`: biên dịch mã nguồn rồi chạy ứng dụng.

Có thể chạy JAR trực tiếp từ thư mục `SanPham_JavaSwing`:

```shell
java -jar CuaHangNuocGiaiKhat.jar
```

## Kiểm tra chức năng

Trên Windows, chạy `SanPham_JavaSwing/kiem_tra_chuc_nang.bat`. Tệp này biên dịch mã nguồn và chạy các kiểm tra nghiệp vụ.

Hoặc chạy thủ công từ thư mục `SanPham_JavaSwing`:

```shell
javac -encoding UTF-8 -d bin src\Models.java src\BusinessService.java src\DataStore.java src\Main.java src\BusinessTests.java
java -ea -cp bin ngk.BusinessTests
```

## Sơ đồ

Thư mục `SoDo_DrawIO` chứa các sơ đồ use case, class, activity và sequence của bài lab. Mở các tệp `.drawio` bằng [diagrams.net](https://app.diagrams.net/) để xem hoặc chỉnh sửa.

## Cấu trúc thư mục

```text
Lab8/
├── SanPham_JavaSwing/
│   ├── src/                 # Mã nguồn Java
│   ├── bin/                 # Các lớp đã biên dịch
│   └── *.bat, *.sh, *.jar   # Tệp chạy và kiểm tra
└── SoDo_DrawIO/             # Sơ đồ thiết kế
```

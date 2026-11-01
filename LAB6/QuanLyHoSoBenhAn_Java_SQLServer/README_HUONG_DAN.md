# QUẢN LÝ HỒ SƠ BỆNH ÁN – JAVA SWING + SQL SERVER

**Ứng dụng desktop thực hành môn Phân tích thiết kế hướng đối tượng (Bài 5).** Đây là ứng dụng mô phỏng phục vụ học tập, **không phải phần mềm hồ sơ y tế đạt chuẩn để sử dụng trên bệnh nhân thật**.

## 1. Công nghệ

- Java 17 trở lên (khuyến nghị JDK 17 hoặc 21), Java Swing cho giao diện.
- SQL Server 2019/2022/Express (có thể dùng phiên bản khác còn hỗ trợ bởi driver).
- Microsoft JDBC Driver `com.microsoft.sqlserver:mssql-jdbc:13.6.1.jre11`, Maven tự tải.
- Maven 3.9+ để biên dịch và chạy; VS Code với Extension Pack for Java (và Maven for Java).

## 2. Cấu trúc dự án

```text
QuanLyHoSoBenhAn_Java_SQLServer/
├─ src/main/java/vn/edu/benhan/
│  ├─ Main.java               Giao diện chính, sidebar, đăng nhập
│  ├─ Db.java                 Kết nối JDBC, transaction
│  ├─ Auth.java               Phân quyền, xác thực mật khẩu
│  ├─ Theme.java              Định dạng Swing
│  ├─ Specs.java              Khai báo bảng / trường dữ liệu
│  ├─ DataPanel.java          Màn hình thêm/sửa/xóa/tìm kiếm
│  ├─ Workflows.java          Đăng ký/đóng phí và xuất viện/lưu bệnh án
│  ├─ DashboardPanel.java     Thống kê tổng quan
│  └─ ReportsPanel.java       Báo cáo và xuất CSV
├─ database/
│  ├─ 01_Tao_CSDL.sql         Tạo CSDL, bảng, khóa, view
│  ├─ 02_Du_Lieu_Mau.sql      Dữ liệu demo
│  └─ 03_Kiem_Tra_CSDL.sql    Các truy vấn kiểm tra
├─ config.properties         Cấu hình SQL Server trên máy bạn
├─ pom.xml                   Maven + JDBC driver
├─ CHAY_WINDOWS.bat          Chạy nhanh trong Windows
└─ README_HUONG_DAN.md
```

## 3. Cài đặt SQL Server

1. Mở **SQL Server Management Studio (SSMS)**, kết nối đúng instance SQL Server.
2. Mở `database/01_Tao_CSDL.sql` bằng **New Query** rồi nhấn **Execute / F5**. Script tạo database `QuanLyHoSoBenhAn`, bảng có khóa chính/ngoại và 2 view thống kê. Có thể chạy lại khi DB đã tồn tại.
3. Mở `database/02_Du_Lieu_Mau.sql`, Execute để thêm vài khoa, bác sĩ, bệnh nhân mẫu.
4. Dùng SSMS kiểm tra:

```sql
USE QuanLyHoSoBenhAn;
SELECT * FROM dbo.BenhNhan;
SELECT * FROM dbo.Khoa;
```

5. Bật **SQL Server Authentication (Mixed Mode)** nếu đăng nhập bằng tài khoản SQL (thường là `sa`) rồi khởi động lại dịch vụ SQL Server khi cần. Đảm bảo login có quyền CRUD trên `QuanLyHoSoBenhAn` (đối với bài lab, có thể dùng SQL login riêng). Không cần cấp quyền sysadmin cho ứng dụng.
6. Mở **SQL Server Configuration Manager → SQL Server Network Configuration → Protocols for [instance]**, bật **TCP/IP**. Trong IPAll, cấu hình TCP Port **1433** và bỏ TCP Dynamic Ports nếu muốn dùng cổng cố định; khởi động lại dịch vụ. SQL Express instance có thể dùng cổng động khác, khi đó phải sửa `port` trong config.
7. Trên Windows, kiểm tra trong PowerShell:

```powershell
Test-NetConnection localhost -Port 1433
```

Nếu kiểm tra trả `TcpTestSucceeded : True` nghĩa là cổng đang lắng nghe, **chưa** chắc xác thực SQL đã đúng.

## 4. Sửa thông tin kết nối

Mở `config.properties` ở thư mục gốc:

```properties
server=localhost
port=1433
database=QuanLyHoSoBenhAn
user=sa
password=MAT_KHAU_SQL_SERVER_CUA_BAN
encrypt=true
trustServerCertificate=true
loginTimeout=6
```

**Rất quan trọng:** thay `password` bằng mật khẩu SQL thực tế. `localhost:1433` là mặc định, **không phải mọi máy đều giống vậy**. Với SQL Express có tên instance `SQLEXPRESS`, cần bật TCP/IP và kiểm tra cổng thực tế hoặc cấu hình cổng tĩnh. `trustServerCertificate=true` chỉ dành cho môi trường local/lab, vì bỏ kiểm tra chứng chỉ máy chủ TLS; khi triển khai thực tế cần chứng chỉ tin cậy và `trustServerCertificate=false`. Không đưa `config.properties` có mật khẩu lên GitHub.

## 5. Chạy project bằng VS Code

1. Cài JDK 17 hoặc JDK 21; kiểm tra `java -version`.
2. Cài Apache Maven, kiểm tra `mvn -version`.
3. Mở **VS Code → File → Open Folder → QuanLyHoSoBenhAn_Java_SQLServer** (mở **thư mục gốc**, có `pom.xml`).
4. Cài **Extension Pack for Java** và **Maven for Java** trong VS Code.
5. Mở Terminal **trong thư mục gốc** rồi chạy:

```powershell
mvn clean compile
mvn exec:java
```

Hoặc nhấp đúp `CHAY_WINDOWS.bat` nếu Maven đã được thêm vào PATH. Maven cần Internet ở lần đầu để tải JDBC Driver. Không dùng Live Server (cổng 5500/8000) vì đây là ứng dụng Java Desktop.

## 6. Đăng nhập tài khoản mẫu

App **tự tạo tài khoản mẫu khi bảng `TaiKhoan` còn trống**, không cần INSERT tay.

| Đăng nhập | Mật khẩu | Vai trò |
| --- | --- | --- |
| `admin` | `admin123` | ADMIN: toàn quyền |
| `bacsi` | `bs123456` | BACSI: phiếu khám, xét nghiệm, toa thuốc |
| `tiepnhan` | `tn123456` | TIEPNHAN: bệnh nhân, lịch hẹn, lệ phí, đăng ký |
| `chamsoc` | `cs123456` | CHAMSOC: xác nhận thanh toán và lưu bệnh án |

Mật khẩu được lưu dưới dạng PBKDF2 có salt. **Các tài khoản và mật khẩu trên là DEMO, phải đổi/tắt khi dùng ngoài lớp học.** Ứng dụng này không có giao diện thay đổi mật khẩu và chưa đủ biện pháp bảo vệ dữ liệu y tế để triển khai thực tế.

## 7. Cách thao tác demo (đúng quy trình Bài 5)

1. **Bệnh nhân**: chọn menu `Bệnh nhân` → điền họ tên, ngày sinh theo `yyyy-MM-dd`, địa chỉ, số điện thoại, đường dẫn ảnh 3x4 → **Thêm**.
2. **Đăng ký + lập hồ sơ**: chọn bệnh nhân, nhập lệ phí năm (VD 500000) → **Lập hồ sơ và thu phí**. Hệ thống tạo phiếu đăng ký + đóng lệ phí + cấp hồ sơ trong **một SQL transaction**.
3. **Hồ sơ bệnh án**: xem `MaHS`, là mã để tìm kiếm tại lần khám sau.
4. **Lịch hẹn**: chọn bệnh nhân / bác sĩ, điền `NgayGioHen` theo `yyyy-MM-dd HH:mm`, chọn `Khám bệnh` hoặc `Định kỳ quý`.
5. **Phiếu khám**: chọn `MaHS`, bác sĩ, khoa, giờ khám, triệu chứng, chẩn đoán; chọn trạng thái ban đầu `Đang khám`.
6. **Xét nghiệm**: nếu cần, chỉ định xét nghiệm theo phiếu khám, sau đó điền kết quả.
7. **Toa thuốc → Chi tiết toa thuốc**: lập toa theo phiếu khám, thêm các thuốc/ số lượng/ liều dùng. Đây là dữ liệu mẫu phục vụ bài học, không phải chỉ định y khoa thực tế.
8. Quay lại **Phiếu khám**, chọn phiếu cần xử lý, đổi trạng thái thành `Chờ thanh toán`, nhấn **Sửa**.
9. Vào **Xuất viện + thanh toán**, chọn phiếu, nhập tiền → **Thanh toán & lưu bệnh án**. Với phiếu `Định kỳ quý`, người đã đóng lệ phí năm tương ứng được miễn phí một lần/quý và phải nhập `0`.
10. **Tổng quan** và **Báo cáo - tra cứu**: xem các view, xuất CSV (có cảnh báo bảo mật).

Nếu xóa hồ sơ đang được tham chiếu bởi lượt khám, SQL Server sẽ ngăn thao tác nhờ FOREIGN KEY.

## 8. SQL Server: các lỗi hay gặp

| Lỗi | Cách khắc phục |
| --- | --- |
| `Login failed for user 'sa'` | Kiểm tra Mixed Mode, đã bật login `sa`, và mật khẩu trong `config.properties` |
| `The TCP/IP connection to the host failed` | Kiểm tra SQL service, TCP/IP enabled, port 1433 thực tế, firewall |
| `Cannot open database 'QuanLyHoSoBenhAn'` | Chưa chạy `01_Tao_CSDL.sql`, sai instance hoặc thiếu quyền |
| `No suitable driver` | Phải chạy bằng Maven để tải `mssql-jdbc`; kiểm tra Internet lần đầu |
| `Invalid object name 'dbo.TaiKhoan'` | Đã kết nối DB nhưng chưa chạy đầy đủ file tạo CSDL |
| `Failed to validate the server name in a certificate` | Với lab local, sử dụng `encrypt=true;trustServerCertificate=true`; môi trường thực dùng CA |
| `mvn is not recognized` | Chưa cài Maven hoặc chưa đặt bin Maven vào PATH |
| Lỗi tiếng Việt | File mã hóa UTF-8, dùng JDK 17+, lưu tệp SQL UTF-8 và SSMS hỗ trợ Unicode với N'...' |

## 9. Những điểm cần biết trước khi nộp

- Code Java + SQL Server **đã được kiểm tra biên dịch Java 17**; chưa thể chạy thử kết nối tới SQL Server trên máy bạn khi không có server/tài khoản thực.
- Hệ thống demo dùng JDBC synchronous trong giao diện Swing: phù hợp bài lab local, chưa tối ưu truy vấn lớn.
- `Anh3x4` hiện lưu **đường dẫn** ảnh, chưa lưu file ảnh/BLOB. Nếu di chuyển sang máy khác, đường dẫn cần được cập nhật.
- Chưa có chức năng in toa thuốc, xuất PDF, phân quyền chi tiết theo từng bệnh nhân, audit log, sao lưu, mã hóa dữ liệu y tế ở trạng thái lưu trữ, và nghiệp vụ hoàn tiền. Cần làm thêm nếu triển khai thực tế.
- **Đừng sử dụng dữ liệu bệnh nhân thật để thuyết trình hoặc demo**.

## 10. Tên bảng và mối quan hệ

`BenhNhan` → `PhieuDangKy` → `HoSoBenhAn` → `PhieuKham` → `XetNghiem` / `ToaThuoc` → `ChiTietToaThuoc`.

`BacSi` thuộc `Khoa`; `PhieuKham` tham chiếu `BacSi` và `Khoa`; `LichHen` tham chiếu `BenhNhan` và bác sĩ; `DongPhiNam` tham chiếu `BenhNhan`; `ThanhToanVienPhi` tham chiếu `PhieuKham`.

Đối với các sơ đồ lớp đã vẽ trước, số lượng ở đường liên kết có thể trình bày **1** và **N** theo yêu cầu của thầy (không ghi `0..*`).

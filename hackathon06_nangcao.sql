create database quanlysinhvien_nangcao;
use quanlysinhvien_nangcao;
create table dmkhoa
(
    maKhoa  varchar(20) primary key,
    tenkhoa varchar(255)
);
create table dmnganh
(
    maNganh  int auto_increment primary key,
    tenNganh varchar(255),
    maKhoa   varchar(20) not null,
    foreign key (maKhoa) references dmkhoa (maKhoa)
);
create table dmlop
(
    maLop      varchar(20) primary key,
    tenLop     varchar(255),
    maNganh    int not null,
    khoaHoc    int,
    HeDT       varchar(255),
    namNhapHoc int,

    foreign key (maNganh) references dmnganh (maNganh)

);
create table dmhocphan
(
    maHP    int auto_increment primary key,
    tenHP   varchar(255),
    sodvht  int,
    maNganh int not null,
    hocKy   int,
    foreign key (maNganh) references dmnganh (maNganh)
);
create table sinhvien
(
    maSV     int auto_increment primary key,
    HoTen    varchar(255),
    maLop    varchar(20) not null,
    gioiTinh tinyint(1),
    ngaySinh date,
    diaChi   varchar(255),
    foreign key (maLop) references dmlop (maLop)

);
create table diemhp
(
    maSV   int not null,
    maHP   int not null,
    diemHP float,
    foreign key (maSV) references sinhvien (maSV),
    foreign key (maHP) references dmhocphan (maHP)
);
insert into dmkhoa (maKhoa, tenkhoa)
values ('CNTT', 'Công  nghệ thông tin '),
       ('KT', 'kế toán'),
       ('SP', 'sư phạm');
insert into dmnganh (maNganh, tenNganh, maKhoa)
values (140902, 'sư phạm toán tin', 'SP'),
       (408202, 'Tin học ứng dung', 'CNTT');
insert into dmlop (maLop, tenLop, maNganh, khoaHoc, HeDT, namNhapHoc)
values ('CT11', 'Cao đẳng tin học', 408202, 11, 'TC', 2013),
       ('CT12', 'Cao đẳng tin học', 408202, 12, 'CĐ', 2013),
       ('CT13', 'Cao đẳng tin học', 408202, 13, 'TC', 2014)
;
insert into dmhocphan (tenHP, sodvht, maNganh, hocKy)
values ('Toán cao cấp A1', 4, 408202, 1),
       ('Tiến Anh 1', 3, 408202, 1),
       ('Vật lý đại cương', 4, 408202, 1),
       ('Tiến Anh 2', 7, 408202, 1),
       ('Tiến Anh 1', 3, 140902, 2),
       ('Xác suất thống kê', 3, 408202, 2)
;
insert into sinhvien (HoTen, maLop, gioiTinh, ngaySinh, diaChi)
values ('Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
       ('Nguyễn THị Cẩm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
       ('Võ THị Hà', 'CT12', 1, '1995-07-02', 'An nhơn'),
       ('Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây sơn'),
       ('Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'vĩnh thạch'),
       ('Đăng THị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
       ('Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù Mỹ'),
       ('Nguyễn Văn Huy', 'CT11', 0, '1995-06-04', 'Tây Phước'),
       ('Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn')
;
insert into diemhp (maSV, maHP, diemHP)
values (2, 2, 5.9),
       (2, 3, 4.5),
       (3, 1, 4.3),
       (3, 2, 6.7),
       (3, 3, 7.3),
       (4, 1, 4),
       (4, 2, 5.2),
       (4, 3, 3.5),
       (5, 1, 9.8),
       (5, 2, 7.9),
       (5, 3, 7.5),
       (6, 1, 6.1),
       (6, 2, 5.6),
       (6, 3, 4),
       (7, 1, 6.2)
;
# 1.Cho biết họ tên sinh viên KHÔNG học học phần nào:
select sv.maSV,
       sv.HoTen
from sinhvien sv
where sv.maSV not in (select sv.maSV
                      from sinhvien sv
                               join diemhp d on sv.maSV = d.maSV
                               join dmhocphan dhp on dhp.maHP = d.maHP);
# 2.Cho biết họ tên sinh viên CHƯA học học phần nào có mã 1:
select sv.maSV,
       sv.HoTen
from sinhvien sv
where sv.maSV not in (select sv.maSV
                      from sinhvien sv
                               join diemhp d on sv.maSV = d.maSV
                               join dmhocphan dhp on dhp.maHP = d.maHP
                      where dhp.maHP = 1);
# 3.Cho biết Tên học phần KHÔNG có sinh viên điểm HP < 5:
select sv.maSV,
       sv.HoTen
from sinhvien sv
where sv.maSV not in (select sv.maSV
                      from sinhvien sv
                               join diemhp d on sv.maSV = d.maSV
                               join dmhocphan dhp on dhp.maHP = d.maHP
                      where d.diemHP < 5);
# 4.Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP < 5:
select sv.maSV,
       sv.HoTen
from sinhvien sv
where sv.maSV not in (select sv.maSV
                      from sinhvien sv
                               join diemhp d on sv.maSV = d.maSV
                               join dmhocphan dhp on dhp.maHP = d.maHP
                      where d.diemHP < 5);
# 5.Cho biết Tên lớp có sinh viên tên Hoa:
select distinct dl.tenLop
from dmlop dl
where dl.maLop in (select dl.maLop
                   from SinhVien
                   where HoTen like '%Hoa%');
# 6.	Cho biết HoTen sinh viên có điểm học phần 1 là <5.
select distinct sv.HoTen
from sinhvien sv
where sv.maSV in (select dhp.maHP
                  from diemhp dhp
                  where dhp.maHP = 1
                     or dhp.diemHP < 5);
# 7.	Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị học trình của học phần mã 1.
select dhp.maHP,
       dhp.tenHP,
       dhp.sodvht,
       dhp.maNganh,
       dhp.hocKy
from dmhocphan dhp
where dhp.sodvht > (select dhp.sodvht
                    from dmhocphan dhp
                    where dhp.maHP = 1);
# 8.	Cho biết HoTen sinh viên có DiemHP cao nhất. (ALL)
select distinct *
from sinhvien
         join diemhp d on sinhvien.maSV = d.maSV
where diemHP >= all (select diemHP from diemhp);
# 9.	Cho biết MaSV, HoTen sinh viên có điểm học phần mã 1 cao nhất.  (ALL)
select distinct maHP,
                HoTen
from sinhvien
         join diemhp d on sinhvien.maSV = d.maSV
where diemHP >= all (select diemHP from diemhp d where d.maHP = 1);
#10. Cho biết MaSV, MaHP có điểm HP lớn hơn bất kì các điểm HP của sinh viên mã 3 (ANY).
select distinct d.maSV,
                d.maHP
from sinhvien
         join diemhp d on sinhvien.maSV = d.maSV
where diemHP >= any (select diemHP from sinhvien sv where sv.maSV = 3);
# 11.	Cho biết MaSV, HoTen sinh viên ít nhất một lần học học phần nào đó. (EXISTS)
select distinct sv.maSV,
                sv.HoTen
from sinhvien sv
where exists (select 1
              from diemhp d
              where d.maSV = sv.maSV);
# 12.	Cho biết MaSV, HoTen sinh viên đã không học học phần nào. (EXISTS)
select sv.maSV,
       sv.HoTen
from sinhvien sv
where not exists (select 1
                  from diemhp d
                  where d.maSV = sv.maSV);
# 13.	Cho biết MaSV đã học ít nhất một trong hai học phần có mã 1, 2.
select distinct masv
from diemhp d
where d.maHP = 1
union
select distinct masv
from diemhp d
where d.maHP = 2;
# 14.	Tạo thủ tục có tên KIEM_TRA_LOP cho biết HoTen sinh viên KHÔNG có điểm HP <5 ở lớp có mã chỉ định (tức là tham số truyền vào procedure là mã lớp).
# Phải kiểm tra MaLop chỉ định có trong danh mục hay không, nếu không thì hiển thị thông báo ‘Lớp này không có trong danh mục’.
# Khi lớp tồn tại thì đưa ra kết quả.
# Ví dụ gọi thủ tục: Call KIEM_TRA_LOP(‘CT12’).
delimiter //
create procedure kiem_tra_lop(in maLop varchar(20), out output text)
begin
    declare classCount int;

    -- Kiểm tra MaLop có tồn tại trong danh mục không
    select count(*) into classCount
    from dmlop
    where maLop = maLop;

    if classCount = 0 then
        set output = 'Lớp này không có trong danh mục';
    else
        -- Kiểm tra HoTen sinh viên KHÔNG có điểm HP < 5 trong lớp có mã chỉ định (maLop)
        select distinct sv.HoTen
        into output
        from sinhvien sv
        where sv.maLop = maLop and sv.maSV not in (
            select d.maSV
            from diemhp d
            where d.diemHP < 5
        );
    end if;
end //
delimiter ;
call kiem_tra_lop('CT12', @output);
select @output;

-- 15. Tạo một trigger để kiểm tra tính hợp lệ của dữ liệu nhập vào bảng sinhvien là MaSV không được rỗng
-- Nếu rỗng hiển thị thông báo ‘Mã sinh viên phải được nhập’.
delimiter //
create trigger check_maSV_before_insert
    before insert on sinhvien
    for each row
begin
    if new.maSV is null then
        signal sqlstate '45000'
            set message_text = 'Mã sinh viên phải được nhập';
    end if;
end //
delimiter ;

-- 16. Tạo một TRIGGER khi thêm một sinh viên trong bảng sinhvien ở một lớp nào đó thì cột SiSo của lớp đó trong bảng dmlop (các bạn tạo thêm một cột SiSo trong bảng dmlop) tự động tăng lên 1,
-- đảm bảo tính toàn vẹn dữ liệu khi thêm một sinh viên mới trong bảng sinhvien thì sinh viên đó phải có mã lớp trong bảng dmlop.
-- Đảm bảo tính toàn vẹn dữ liệu khi thêm là mã lớp phải có trong bảng dmlop.
-- 17. Viết một function DOC_DIEM đọc điểm chữ số thập phân thành chữ
-- Sau đó ứng dụng để lấy ra MaSV, HoTen, MaHP, DiemHP, DOC_DIEM(DiemHP) để đọc điểm HP của sinh viên đó thành chữ
-- 18. Tạo thủ tục: HIEN_THI_DIEM
-- Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của những sinh viên có DiemHP nhỏ hơn số chỉ định, nếu không có thì hiển thị thông báo không có sinh viên nào.
delimiter //
create procedure HIEN_THI_DIEM(in diemThreshold float)
begin
    select sv.maSV, sv.HoTen, sv.maLop, d.diemHP, d.maHP
    from sinhvien sv
             left join diemhp d on sv.maSV = d.maSV
    where d.diemHP < diemThreshold or d.diemHP is null;
end //
delimiter ;
call HIEN_THI_DIEM(6);
-- 19. Tạo thủ tục: HIEN_THI_MAHP
-- Hiển thị HoTen sinh viên CHƯA học học phần có mã chỉ định. Kiểm tra mã học phần chỉ định có trong danh mục không. Nếu không có thì hiển thị thông báo không có học phần này.
delimiter //
create procedure HIEN_THI_MAHP(in maHPValue int)
begin
    if not exists (select 1 from dmhocphan where maHP = maHPValue) then
        select 'Không có học phần này' as HoTen;
    else
        select sv.HoTen
        from sinhvien sv
        where sv.maSV not in (
            select d.maSV
            from diemhp d
            where d.maHP = maHPValue
        );
    end if;
end //
delimiter ;
call HIEN_THI_MAHP(1);

-- 20. Tạo thủ tục: HIEN_THI_TUOI
-- Hiển thị danh sách gồm: MaSV, HoTen, MaLop, NgaySinh, GioiTinh, Tuoi của sinh viên có tuổi trong khoảng chỉ định. Nếu không có thì hiển thị không có sinh viên nào.
delimiter //
create procedure HIEN_THI_TUOI(in tuoiMin int, in tuoiMax int)
begin
    select sv.maSV, sv.HoTen, sv.maLop, sv.ngaySinh, sv.gioiTinh, year(current_date()) - year(sv.ngaySinh) as Tuoi
    from sinhvien sv
    where year(current_date()) - year(sv.ngaySinh) between tuoiMin and tuoiMax;
end //
delimiter ;
call HIEN_THI_TUOI(20, 30);




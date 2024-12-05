--DROP TABLE NguoiDung;
CREATE TABLE NguoiDung(
    ID_ND NUMBER(8,0),
    Email VARCHAR2(50),
    Matkhau VARCHAR2(20),
    VerifyCode VARCHAR2(10) DEFAULT NULL,
    Trangthai VARCHAR2(10) DEFAULT '',
    Vaitro VARCHAR2(20)
);
--Them rang buoc
ALTER TABLE NguoiDung
    ADD CONSTRAINT ND_Email_NNULL CHECK ('Email' is not null)
    ADD CONSTRAINT ND_Matkhau_NNULL CHECK ('Matkhau' is not null)
    ADD CONSTRAINT ND_Vaitro_Ten CHECK (Vaitro in ('Khach Hang','Nhan Vien','Nhan Vien Kho','Quan Ly'));

--Them khoa chinh
ALTER TABLE NguoiDung ADD CONSTRAINT NguoiDung_PK PRIMARY KEY (ID_ND);
    
--DROP TABLE NhanVien;
CREATE TABLE NhanVien(
    ID_NV NUMBER(8,0),
    TenNV VARCHAR2(50),
    NgayVL DATE ,
    SDT VARCHAR2(50),
    Chucvu VARCHAR2(50),
    ID_ND NUMBER(8,0) DEFAULT NULL,
    ID_NQL NUMBER(8,0),
    Tinhtrang VARCHAR2(20)
);
--Them rang buoc
alter table NhanVien
    add constraint NV_TenNV_NNULL CHECK ('TenNV' is not null)
    add constraint NV_SDT_NNULL CHECK ('SDT' is not null)
    add constraint NV_NgayVL_NNULL CHECK ('NgayVL' is not null)
    add constraint NV_Chucvu_Thuoc CHECK (Chucvu in ('Phuc vu','Tiep tan','Thu ngan','Bep','Kho','Quan ly'))
    add constraint NV_Tinhtrang_Thuoc CHECK (Tinhtrang in ('Dang lam viec','Da nghi viec'));

--Them khoa chinh
ALTER TABLE NhanVien ADD CONSTRAINT NV_PK PRIMARY KEY (ID_NV);

--Them khoa ngoai
ALTER TABLE NhanVien
 ADD CONSTRAINT NV_fk_idND FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND)
 ADD CONSTRAINT NV_fk_idNQL FOREIGN KEY (ID_NQL) REFERENCES NhanVien(ID_NV);
 
--DROP TABLE KhachHang;
CREATE TABLE KhachHang(
    ID_KH NUMBER(8,0),
    TenKH VARCHAR2(50), 
    Ngaythamgia DATE, 
    Doanhso NUMBER(10,0) DEFAULT 0, 
    Diemtichluy NUMBER(5,0) DEFAULT 0,
    ID_ND NUMBER(8,0)
);
--Them rang buoc
ALTER TABLE KhachHang
    ADD CONSTRAINT KH_TenKH_NNULL CHECK ('TenKH' is not null)
    ADD CONSTRAINT KH_Ngaythamgia_NNULL CHECK ('Ngaythamgia' is not null)
    ADD CONSTRAINT KH_Doanhthu_NNULL CHECK ('Doanhthu' is not null)
    ADD CONSTRAINT KH_Diemtichluy_NNULL CHECK ('Diemtichluy' is not null)
    ADD CONSTRAINT KH_IDND_NNULL CHECK ('ID_ND' is not null);

--Them khoa chinh
ALTER TABLE KhachHang ADD CONSTRAINT KhachHang_PK PRIMARY KEY (ID_KH);
    
--Them khoa ngoai
ALTER TABLE KhachHang ADD CONSTRAINT KH_fk_idND FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND);

--DROP TABLE MonAn;
CREATE TABLE MonAn(
    ID_MonAn NUMBER(8,0),
    TenMon VARCHAR2(50), 
    DonGia NUMBER(8,0),
    Loai VARCHAR2(50),
    TrangThai VARCHAR2(30)
);
--Them rang buoc
ALTER TABLE MonAn
    ADD CONSTRAINT MA_TenMon_NNULL CHECK ('TenMon' is not null)
    ADD CONSTRAINT MA_DonGia_NNULL CHECK ('Dongia' is not null)
    ADD CONSTRAINT MA_Loai_Ten CHECK (Loai in ('Vietnam','China','Thailand','Japan','France','Korea'
                                                 ,'India','Malaysia','Germany','Italy','Australia','Netherlands'))
    ADD CONSTRAINT MA_TrangThai_Thuoc CHECK (TrangThai in('Dang kinh doanh','Ngung kinh doanh'));                                             

--Them khoa chinh
ALTER TABLE MonAn ADD CONSTRAINT MonAn_PK PRIMARY KEY (ID_MonAn);

--DROP TABLE Ban;
CREATE TABLE Ban(
    ID_Ban NUMBER(8,0),
    TenBan VARCHAR2(50), 
    Vitri VARCHAR2(50), 
    Trangthai VARCHAR2(50)
);
--Them rang buoc
ALTER TABLE Ban
    ADD CONSTRAINT Ban_TenBan_NNULL CHECK ('TenBan' is not null)
    ADD CONSTRAINT Ban_Vitri_NNULL CHECK ('Vitri' is not null)
    ADD CONSTRAINT Ban_Trangthai_Ten CHECK (Trangthai in ('Con trong','Dang dung bua','Da dat truoc'));

--Them khoa chinh
ALTER TABLE Ban ADD CONSTRAINT Ban_PK PRIMARY KEY (ID_Ban);

--DROP TABLE Voucher;
CREATE TABLE Voucher(
    Code_Voucher VARCHAR2(10),
    Mota VARCHAR2(50),
    Phantram NUMBER(3,0),
    LoaiMA VARCHAR2(50),
    SoLuong NUMBER(3,0),
    Diem NUMBER(8,0)
);
--Them rang buoc
ALTER TABLE Voucher
    ADD CONSTRAINT V_Code_NNULL CHECK ('Code_Voucher' is not null)
    ADD CONSTRAINT V_Mota_NNULL CHECK ('Mota' is not null)
    ADD CONSTRAINT V_Phantram_NNULL CHECK (Phantram > 0 AND Phantram <= 100)
    ADD CONSTRAINT V_LoaiMA_Thuoc CHECK (LoaiMA in ('All' ,'Vietnam', 'China', 'Thailand', 'Japan', 'France', 'Korea',
                                              'India', 'Malaysia', 'Germany', 'Italy', 'Australia', 'Netherlands'));

--Them khoa chinh
ALTER TABLE Voucher ADD CONSTRAINT Voucher_PK PRIMARY KEY (Code_Voucher);
    
--DROP TABLE HoaDon;
CREATE TABLE HoaDon(
    ID_HoaDon NUMBER(8,0),
    ID_KH NUMBER(8,0),
    ID_Ban NUMBER(8,0),
    NgayHD DATE,
    TienMonAn NUMBER(8,0),
    Code_Voucher VARCHAR2(10),
    TienGiam NUMBER(8,0),
    Tongtien NUMBER(10,0),
    Trangthai VARCHAR2(50)
);
--Them rang buoc
ALTER TABLE HoaDon
    ADD CONSTRAINT HD_NgayHD_NNULL CHECK ('TenMon' is not null)
    ADD CONSTRAINT HD_TrangThai CHECK (Trangthai in ('Chua thanh toan','Da thanh toan'));

--Them khoa chinh
ALTER TABLE HoaDon ADD CONSTRAINT HD_PK PRIMARY KEY (ID_HoaDon);

--Them khoa ngoai
ALTER TABLE HoaDon
 ADD CONSTRAINT HD_fk_idKH FOREIGN KEY (ID_KH) REFERENCES KhachHang(ID_KH)
 ADD CONSTRAINT HD_fk_idBan FOREIGN KEY (ID_Ban) REFERENCES Ban(ID_Ban);
 
--DROP TABLE CTHD;
CREATE TABLE CTHD(
    ID_HoaDon NUMBER(8,0),
    ID_MonAn NUMBER(8,0),
    SoLuong NUMBER(3,0),
    Thanhtien NUMBER(10,0)
);
--Them rang buoc
ALTER TABLE CTHD ADD CONSTRAINT CTHD_SoLuong_NNULL CHECK ('SoLuong' is not null);

--Them khoa chinh
ALTER TABLE CTHD ADD CONSTRAINT CTHD_PK PRIMARY KEY (ID_HoaDon, ID_MonAn);

--Them khoa ngoai
ALTER TABLE CTHD
 ADD CONSTRAINT CTHD_fk_idHD FOREIGN KEY (ID_HoaDon) REFERENCES HoaDon(ID_HoaDon)
 ADD CONSTRAINT CTHD_fk_idMonAn FOREIGN KEY (ID_MonAn) REFERENCES MonAn(ID_MonAn);


--DROP TABLE NguyenLieu;
CREATE TABLE NguyenLieu(
    ID_NL NUMBER(8,0),
    TenNL VARCHAR2(50), 
    Dongia NUMBER(8,0), 
    Donvitinh VARCHAR2(50)
);
--Them rang buoc
ALTER TABLE NguyenLieu
    ADD CONSTRAINT NL_TenNL_NNULL CHECK ('TenNL' is not null)
    ADD CONSTRAINT NL_Dongia_NNULL CHECK ('Dongia' is not null)
    ADD CONSTRAINT NL_DVT_Thuoc CHECKCHECK (Donvitinh in ('g','kg','ml','l'));

--Them khoa chinh
ALTER TABLE NguyenLieu ADD CONSTRAINT NL_PK PRIMARY KEY (ID_NL);

--DROP TABLE Kho;
CREATE TABLE Kho(
    ID_NL NUMBER(8,0),
    SLTon NUMBER(3,0) DEFAULT 0
);
--Them rang buoc
ALTER TABLE Kho ADD CONSTRAINT Kho_pk PRIMARY KEY (ID_NL);

--Them khoa ngoai
ALTER TABLE Kho ADD CONSTRAINT Kho_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL);

--DROP TABLE PhieuNK;
CREATE TABLE PhieuNK(
    ID_NK NUMBER(8,0),
    ID_NV NUMBER(8,0),
    NgayNK DATE,
    Tongtien NUMBER(10,0) DEFAULT 0
);
--Them rang buoc
ALTER TABLE PhieuNK ADD CONSTRAINT PNK_NgayNK_NNULL CHECK ('NgayNK' is not null);

--Them khoa chinh
ALTER TABLE PhieuNK ADD CONSTRAINT PNK_PK PRIMARY KEY (ID_NK);

ALTER TABLE PhieuNK ADD CONSTRAINT PNK_fk_idNV FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV);

--DROP TABLE CTNK;
CREATE TABLE CTNK(
    ID_NK NUMBER(8,0),
    ID_NL NUMBER(8,0),
    SoLuong NUMBER(3,0),
    Thanhtien NUMBER(10,0)
);
--Them rang buoc
ALTER TABLE CTNK ADD CONSTRAINT CTNK_SL_NNULL CHECK ('SoLuong' is not null);

--Them khoa chinh
ALTER TABLE CTNK ADD CONSTRAINT CTNK_PK PRIMARY KEY (ID_NK,ID_NL);
    
--Them khoa ngoai
ALTER TABLE CTNK
 ADD CONSTRAINT CTNK_fk_idNK FOREIGN KEY (ID_NK) REFERENCES PhieuNK(ID_NK)
 ADD CONSTRAINT CTNK_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL);

--DROP TABLE PhieuXK;
CREATE TABLE PhieuXK(
    ID_XK NUMBER(8,0),
    ID_NV NUMBER(8,0),
    NgayXK DATE
);
--Them rang buoc
ALTER TABLE PhieuXK ADD CONSTRAINT PXK_NgayXK_NNULL CHECK ('NgayXK' is not null);

--Them khoa chinh
ALTER TABLE PhieuXK add constraint PXK_PK PRIMARY KEY (ID_XK);

--Them khoa ngoai
ALTER TABLE PhieuXK ADD CONSTRAINT PXK_fk_idNV FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV);

--DROP TABLE CTXK;
CREATE TABLE CTXK(
    ID_XK NUMBER(8,0),
    ID_NL NUMBER(8,0),
    SoLuong NUMBER(3,0)
);
--Them rang buoc
ALTER TABLE CTXK ADD CONSTRAINT CTXK_SL_NNULL CHECK ('SoLuong' is not null);

--Them khoa chinh
ALTER TABLE CTXK ADD CONSTRAINT CTXK_PK PRIMARY KEY (ID_XK,ID_NL);

--Them khoa ngoai
ALTER TABLE CTXK
 ADD CONSTRAINT CTNK_fk_idXK FOREIGN KEY (ID_XK) REFERENCES PhieuXK(ID_XK)
 ADD CONSTRAINT CTXK_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL);


--Trigger
--1. Trigger Thanhtien o CTHD bang SoLuong x Dongia cua mon an do
CREATE OR REPLACE TRIGGER Tg_CTHD_Thanhtien
BEFORE INSERT OR UPDATE OF SoLuong ON CTHD
FOR EACH ROW
DECLARE 
    gia MonAn.DonGia%TYPE;
BEGIN
    SELECT DonGia INTO gia
    FROM MonAn
    WHERE MonAn.ID_MonAn = :new.ID_MonAn;
    
    :new.ThanhTien := :new.SoLuong * gia;
END;
/
--2. Trigger Tien mon an o Hoa Don bang tong thanh tien o CTHD
create or replace TRIGGER Tg_HD_TienMonAn
AFTER INSERT OR UPDATE OR DELETE ON CTHD
FOR EACH ROW
BEGIN
    IF INSERTING THEN    
        UPDATE HoaDon 
		SET TienMonAn = TienMonAn + :new.ThanhTien 
		WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
    END IF;

    IF UPDATING THEN    
        UPDATE HoaDon 
		SET TienMonAn = TienMonAn + :new.ThanhTien - :old.ThanhTien 
		WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;
    END IF;

    IF DELETING THEN    
        UPDATE HoaDon 
		SET TienMonAn = TienMonAn - :old.ThanhTien 
		WHERE HoaDon.ID_HoaDon=:old.ID_HoaDon;
    END IF;
END;
/
--3. Trigger Tien giam o Hoa Don = tong thanh tien cua mon An duoc giam x Phantram
create or replace TRIGGER Tg_HD_TienGiam
AFTER INSERT OR UPDATE OR DELETE ON CTHD
FOR EACH ROW
DECLARE 
    v_code HoaDon.Code_Voucher%TYPE;
    v_loaiMA Voucher.LoaiMA%TYPE;
    MA_Loai MonAn.Loai%TYPE;
BEGIN
    v_code := NULL;
    v_loaiMA := NULL;

    -- Tim Code Voucher và Loai mon an duoc Ap dung Voucher tu bang Voucher
    IF (INSERTING OR UPDATING) THEN
        SELECT HoaDon.Code_Voucher, Voucher.LoaiMA INTO v_code, v_loaiMA
        FROM HoaDon LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE ID_HoaDon = :new.ID_HoaDon;

        -- Tim loai mon an cua Mon an vua duoc them vao CTHD   
        SELECT Loai INTO MA_Loai
        FROM MonAn 
        WHERE ID_MonAn = :new.ID_MonAn;
    END IF;

    IF (DELETING) THEN
        SELECT HoaDon.Code_Voucher, Voucher.LoaiMA INTO v_code, v_loaiMA
        FROM HoaDon LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
        WHERE ID_HoaDon = :old.ID_HoaDon;

        -- Tim loai mon an cua Mon an vua duoc xoa khoi CTHD   
        SELECT Loai INTO MA_Loai
        FROM MonAn 
        WHERE ID_MonAn = :old.ID_MonAn;
    END IF;

    IF (v_code IS NOT NULL) THEN
        IF (v_loaiMA = 'All' OR v_loaiMA = MA_Loai) THEN 
            IF (INSERTING) THEN    
                UPDATE HoaDon 
				SET TienGiam = TienGiam + CTHD_Tinhtiengiam(:new.ThanhTien,v_code) 
				WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;

            ELSIF (UPDATING) THEN    
                UPDATE HoaDon 
				SET TienGiam = TienGiam + CTHD_Tinhtiengiam(:new.ThanhTien,v_code) - CTHD_Tinhtiengiam(:old.ThanhTien,v_code) 
				WHERE HoaDon.ID_HoaDon=:new.ID_HoaDon;

            ELSIF (DELETING) THEN    
                UPDATE HoaDon 
				SET TienGiam = TienGiam - CTHD_Tinhtiengiam(:old.ThanhTien,v_code) 
				WHERE HoaDon.ID_HoaDon=:old.ID_HoaDon;
            END IF;
        END IF;
    END IF;
END;
/
--4. Tong tien o Hoa Don = Tien mon an - Tien giam
CREATE OR REPLACE TRIGGER Tg_HD_Tongtien
AFTER INSERT OR UPDATE OF TienMonAn,TienGiam ON HoaDon
BEGIN
    UPDATE HoaDon 
	SET Tongtien= TienMonAn - TienGiam;
END;
/
--5. Khi cap nhat Code_Voucher o HoaDon, Tinh tien giam theo thong tin cua Voucher do va giam Diem tich luy cua KH
CREATE OR REPLACE TRIGGER Tg_HD_DoiVoucher
BEFORE UPDATE OF Code_Voucher ON HoaDon
FOR EACH ROW
DECLARE 
    TongtienLoaiMonAnduocgiam number(8,0);
    v_Diemdoi number;
    v_Phantram number;
    v_LoaiMA Voucher.LoaiMA%TYPE;
BEGIN
    IF(:new.Code_Voucher is not null) THEN
        SELECT Diem,Phantram,LoaiMA INTO v_Diemdoi,v_Phantram,v_LoaiMA
        FROM Voucher
        WHERE Code_Voucher=:new.Code_Voucher;
        
        KH_TruDTL(:new.ID_KH,v_diemdoi);
        Voucher_GiamSL(:new.Code_Voucher);
        
        IF(v_LoaiMA='All') THEN
            TongtienLoaiMonAnduocgiam := :new.TienMonAn;
        ELSE 
            SELECT SUM(Thanhtien) INTO TongtienLoaiMonAnduocgiam
            FROM CTHD JOIN MonAn ON MonAn.ID_MonAn = CTHD.ID_MonAn
            WHERE ID_HoaDon = :new.ID_HoaDon AND LOAI = v_LoaiMA;
        END IF;
        
        :new.Tiengiam := ROUND(TongtienLoaiMonAnduocgiam*v_Phantram/100);
        :new.Tongtien := :new.Tienmonan-:new.Tiengiam;
    ELSE
        RAISE_APPLICATION_ERROR(-20000,'Voucher khong ton tai');
    END IF;
END;
/
--6. Diem tich luy cua Khach hang duoc tinh bang 0.005% Tong tien cua hoa don (1.000.000d tuong duong 50 diem)
CREATE OR REPLACE TRIGGER Tg_KH_DoanhsovaDTL
AFTER UPDATE OF Trangthai ON HoaDon
FOR EACH ROW
BEGIN
    IF :new.Trangthai='Da thanh toan' THEN
        UPDATE KhachHang 
		SET Doanhso = Doanhso + :new.Tongtien 
		WHERE ID_KH=:new.ID_KH;
        UPDATE KhachHang 
		SET Diemtichluy = Diemtichluy + ROUND(:new.Tongtien*0.00005)
        WHERE ID_KH=:new.ID_KH;
    END IF;
END;
/
--7. Khi trang thai don hang tro thanh 'Da thanh toan' trang thai ban chuyen tu 'Dang dung bua' sang 'Con trong'
CREATE OR REPLACE TRIGGER Tg_TrangthaiBan
AFTER INSERT OR UPDATE OF Trangthai ON HoaDon
FOR EACH ROW
BEGIN
    IF(:new.Trangthai='Chua thanh toan') THEN 
        UPDATE Ban 
		SET Trangthai='Dang dung bua' 
		WHERE ID_Ban=:new.ID_Ban;
    ELSE 
        UPDATE Ban 
		SET Trangthai='Con trong' 
		WHERE ID_Ban=:new.ID_Ban;
    END IF; 
END;
/
--8. Trigger Thanh tien o CTNK bang SoLuong x Dongia cua nguyen lieu do
CREATE OR REPLACE TRIGGER Tg_CTNK_Thanhtien
BEFORE INSERT OR UPDATE OF SoLuong ON CTNK
FOR EACH ROW
DECLARE 
    gia NguyenLieu.DonGia%TYPE;
BEGIN
    SELECT DonGia INTO gia
    FROM NguyenLieu
    WHERE NguyenLieu.ID_NL = :new.ID_NL;
    
    :new.ThanhTien := :new.SoLuong * gia;
    
END;
/
--9. Trigger Tong tien o PhieuNK bang tong thanh tien cua CTNK
CREATE OR REPLACE TRIGGER Tg_PNK_Tongtien
AFTER INSERT OR UPDATE OR DELETE ON CTNK
FOR EACH ROW
BEGIN
    IF INSERTING THEN    
        UPDATE PhieuNK 
		SET Tongtien = Tongtien + :new.ThanhTien 
		WHERE PhieuNK.ID_NK = :new.ID_NK;
    END IF;
    
    IF UPDATING THEN    
        UPDATE PhieuNK 
		SET Tongtien = Tongtien + :new.ThanhTien - :old.ThanhTien 
		WHERE PhieuNK.ID_NK = :new.ID_NK;
    END IF;
    
    IF DELETING THEN    
        UPDATE PhieuNK 
		SET Tongtien = Tongtien - :old.ThanhTien 
		WHERE PhieuNK.ID_NK = :old.ID_NK;
    END IF;
END;
/
--10. Trigger khi them CTNK tang So luong ton cua nguyen lieu trong kho
CREATE OR REPLACE TRIGGER Tg_Kho_ThemSLTon
AFTER INSERT OR DELETE OR UPDATE OF SoLuong ON CTNK
FOR EACH ROW
BEGIN
    IF INSERTING THEN    
        UPDATE Kho 
		SET SLTon = SLTon + :new.SoLuong 
		WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF UPDATING THEN    
        UPDATE Kho 
		SET SLTon = SLTon + :new.SoLuong - :old.SoLuong 
		WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF DELETING THEN    
        UPDATE Kho 
		SET SLTon = SLTon - :old.SoLuong 
		WHERE Kho.ID_NL = :old.ID_NL;
    END IF;
END;
/
--11. Trigger khi them CTXK giam So luong ton cua nguyen lieu trong kho
CREATE OR REPLACE TRIGGER Tg_Kho_GiamSLTon
AFTER INSERT OR DELETE OR UPDATE OF SoLuong ON CTXK
FOR EACH ROW
BEGIN
    IF INSERTING THEN    
        UPDATE Kho 
		SET SLTon = SLTon - :new.SoLuong 
		WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF UPDATING THEN    
        UPDATE Kho 
		SET SLTon = SLTon - :new.SoLuong + :old.SoLuong 
		WHERE Kho.ID_NL = :new.ID_NL;
    END IF;
    
    IF DELETING THEN    
        UPDATE Kho 
		SET SLTon = SLTon + :old.SoLuong 
		WHERE Kho.ID_NL = :old.ID_NL;
    END IF;
END;
/
--12. Trigger khi them mot Nguyen Lieu moi, them NL do vao Kho
CREATE OR REPLACE TRIGGER Tg_Kho_ThemNL
AFTER INSERT ON NguyenLieu
FOR EACH ROW
BEGIN
    INSERT INTO Kho(ID_NL) VALUES(:new.ID_NL);
END;
/

--Procedure
--1. Procudure them mot khach hang moi voi cac thong tin tenKH , NgayTG va ID_ND
CREATE OR REPLACE PROCEDURE KH_ThemKH(tenKH KHACHHANG.TenKH%TYPE, NgayTG KHACHHANG.Ngaythamgia%TYPE,
ID_ND KHACHHANG.ID_ND%TYPE)
IS
    v_ID_KH KHACHHANG.ID_KH%TYPE;
IS 
BEGIN
    --Them ma KH tiep theo
    SELECT MIN(ID_KH) + 1 INTO v_ID_KH
    FROM KHACHHANG
    WHERE ID_KH + 1 NOT IN(SELECT ID_KH FROM KHACHHANG);
    
    INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (v_ID_KH,tenKH,TO_DATE(NgayTG,'dd-MM-YYYY'),ID_ND);
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR('Thong tin khong hop le');
END;
/
--2. Procudure them mot nhan vien moi voi cac thong tin tenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang
CREATE OR REPLACE PROCEDURE NV_ThemNV(tenNV NHANVIEN.TenNV%TYPE, NgayVL NHANVIEN.NgayVL%TYPE, SDT NHANVIEN.SDT%TYPE,
Chucvu NHANVIEN.Chucvu%TYPE,ID_NQL NHANVIEN.ID_NQL%TYPE, Tinhtrang NHANVIEN.Tinhtrang%TYPE)
IS
    v_ID_NV NHANVIEN.ID_NV%TYPE;
IS 
BEGIN
    --Them ma KH tiep theo
    SELECT MIN(ID_NV) + 1 INTO v_ID_NV
    FROM NHANVIEN
    WHERE ID_NV + 1 NOT IN(SELECT ID_NV FROM NHANVIEN);
    
    INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) 
    VALUES (v_ID_NV,tenNV,TO_DATE(NgayVL,'dd-MM-YYYY'),SDT,Chucvu,ID_NQL,Tinhtrang);
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR('Thong tin khong hop le');
END;
/
--3. Procudure xoa mot NHANVIEN voi idNV
CREATE OR REPLACE PROCEDURE NV_XoaNV(idNV NHANVIEN.ID_NV%TYPE)
IS
    v_count NUMBER;
    idNQL NHANVIEN.ID_NQL%TYPE;
BEGIN 
    SELECT COUNT(ID_NV),ID_NQL INTO v_count,ID_NQL
    FROM NHANVIEN
    WHERE ID_NV = idNV;
    
    IF(v_count>0) THEN
        IF (id_NV = idNQL) THEN
            RAISE_APPLICATION_ERROR(-20000,'Khong the xoa QUAN LY');
        ELSE
            FOR cur IN (SELECT ID_NK FROM PHIEUNK
            WHERE ID_NV = idNV
            )
            LOOP
                DELETE FROM CTNK WHERE ID_NK = cur.ID_NK;
            END LOOP;
            
            FOR cur IN (SELECT ID_XK FROM PHIEUXK
            WHERE ID_NV = idNV
            )
            LOOP
                DELETE FROM CTXK WHERE ID_XK = cur.ID_XK;
            END LOOP;
            
            DELETE FROM PHIEUNK WHERE ID_NV = idNV;
            DELETE FROM PHIEUNK WHERE ID_NV = idNV;
            DELETE FROM NHANVIEN WHERE ID_NV = idNV;
        END IF;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Nhan vien khong ton tai');
    END IF;
END;
/
--4. Procudure xoa mot KHACHHANG voi idKH
CREATE OR REPLACE PROCEDURE KH_XoaKH(idKH KHACHHANG.ID_KH%TYPE)
IS
    v_count NUMBER;
BEGIN 
    SELECT COUNT(*) INTO v_count
    FROM KHACHHANG
    WHERE ID_KH = idKH;
    
    IF(v_count > 0) THEN
        FOR cur IN (SELECT ID_HoaDon FROM HOADON 
        WHERE ID_KH = idKH
        )
        LOOP
            DELETE FROM CTHD WHERE ID_HoaDon = cur.ID_HoaDon;
        END LOOP;
        DELETE FROM HOADON WHERE ID_KH = idKH;
        DELETE FROM KHACHHANG WHERE ID_KH = idKH;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
    END IF;
END;
/

--5. Procedure xem thong tin KHACHHANG voi thong tin idKH
CREATE OR REPLACE PROCEDURE KH_XemTT(idKH KHACHHANG.ID_KH%TYPE)
IS
BEGIN 
    FOR cur IN (SELECT TenKH,Ngaythamgia,Doanhso,Diemtichluy,ID_ND
    FROM KHACHHANG WHERE ID_KH = idKH;
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma khach hang: '||idKH);
        DBMS_OUTPUT.PUT_LINE('Ten khach hang: '||cur.TenKH);
        DBMS_OUTPUT.PUT_LINE('Ngay tham gia: '||TO_CHAR(cur.Ngaythamgia,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Doanh so: '||cur.Doanhso);
        DBMS_OUTPUT.PUT_LINE('Diemtichluy: '||cur.Diemtichluy);
        DBMS_OUTPUT.PUT_LINE('Ma nguoi dung: '||cur.ID_ND);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
    END LOOP;
END;
/
--6. Procedure xem thong tin NHANVIEN voi thong tin idNV
CREATE OR REPLACE PROCEDURE NV_XemTT(idNV NHANVIEN.ID_NV%TYPE)
IS
BEGIN 
    FOR cur IN (SELECT TenKH,NgayVL,SDT,Chucvu,ID_NQL   
    FROM NHANVIEN WHERE ID_NV = idNV;
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||idNV);
        DBMS_OUTPUT.PUT_LINE('Ten nhan vien: '||cur.TenNV);
        DBMS_OUTPUT.PUT_LINE('Ngay vao lam: '||TO_CHAR(cur.NgayVL,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Chuc vu: '||cur.Chucvu);
        DBMS_OUTPUT.PUT_LINE('Ma nguoi quan ly: '||cur.ID_NQL);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Nhan vien khong ton tai');
    END LOOP;
END;
/
--7. Procedure liet ke danh sach hoa don tu ngay A den ngay B
CREATE OR REPLACE PROCEDURE DS_HoaDon_tuAdenB(fromA DATE, toB DATE)
IS
BEGIN 
    FOR cur IN (SELECT ID_HOADON,ID_KH,ID_BAN,NGAYHD,TIENMONAN,TIENGIAM,TONGTIEN,TRANGTHAI   
    FROM HOADON WHERE NGAYHD BETWEEN fromA AND (toB + 1);
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma hoa don: '||cur.ID_HOADON);
        DBMS_OUTPUT.PUT_LINE('Ma khach hang: '||cur.ID_KH);
        DBMS_OUTPUT.PUT_LINE('Ma ban: '||cur.ID_BAN);
        DBMS_OUTPUT.PUT_LINE('Ngay hoa don: '||TO_CHAR(cur.NgayHD,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Tien mon an: '||cur.TIENMONAN);
        DBMS_OUTPUT.PUT_LINE('Tien giam: '||cur.TIENGIAM);
        DBMS_OUTPUT.PUT_LINE('Tong tien: '||cur.TONGTIEN);
        DBMS_OUTPUT.PUT_LINE('Trang thai: '||cur.TRANGTHAI);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
    END LOOP;
END;
/
--8. Procedure liet ke danh sach phieu nhap kho tu ngay A den ngay B
CREATE OR REPLACE PROCEDURE DS_PhieuNK_tuAdenB(fromA DATE, toB DATE)
IS
BEGIN 
    FOR cur IN (SELECT ID_NK,ID_NV,NGAYNK,TONGTIEN  
    FROM PHIEUNK WHERE NGAYNK BETWEEN fromA AND (toB + 1);
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma nhap kho: '||cur.ID_NK);
        DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||cur.ID_NV);
        DBMS_OUTPUT.PUT_LINE('Ngay nhap kho: '||TO_CHAR(cur.NGAYNK,'dd-MM-YYYY');
        DBMS_OUTPUT.PUT_LINE('Tong tien: '||cur.TONGTIEN);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
    END LOOP;
END;
/
--9. Procedure liet ke danh sach phieu xuat kho tu ngay A den ngay B
CREATE OR REPLACE PROCEDURE DS_PhieuXK_tuAdenB(fromA DATE, toB DATE)
IS
BEGIN 
    FOR cur IN (SELECT ID_XK,ID_NV,NGAYXK
    FROM PHIEUXK WHERE NGAYXK BETWEEN fromA AND (toB + 1);
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma xuat kho: '||cur.ID_XK);
        DBMS_OUTPUT.PUT_LINE('Ma nhan vien: '||cur.ID_NV);
        DBMS_OUTPUT.PUT_LINE('Ngay xuat kho: '||TO_CHAR(cur.NGAYXK,'dd-MM-YYYY');
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co hoa don nao');
    END LOOP;
END;
/
--10.  Procedure xem chi tiet hoa don cua 1 hoa don
CREATE OR REPLACE PROCEDURE HD_XemCTHD(idHD HOADON.ID_HOADON%TYPE)
IS
BEGIN 
    FOR cur IN (SELECT ID_MONAN,SOLUONG,THANHTIEN
    FROM CTHD WHERE ID_HOADON = idHD;
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Ma mon an: '||cur.ID_MONAN);
        DBMS_OUTPUT.PUT_LINE('So luong: '||cur.SOLUONG);
        DBMS_OUTPUT.PUT_LINE('Thanh tien: '||cur.THANHTIEN);
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
             RAISE_APPLICATION_ERROR(-20000,'Khong co chi tiet hoa don nao');
    END LOOP;
END;
/
--11. Procedure giam So Luong cua Voucher di 1 khi KH doi Voucher
CREATE OR REPLACE PROCEDURE Voucher_GiamSL(code Voucher.Code_Voucher%TYPE)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Voucher
    WHERE Code_Voucher = code;
    IF(v_count > 0) THEN
        UPDATE Voucher 
		SET SoLuong = SoLuong - 1 
		WHERE Code_Voucher = code;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Voucher khong ton tai');
    END IF;
END;
/
--12. Procedure giam Diem tich luy cua KH khi doi Voucher
CREATE OR REPLACE PROCEDURE KH_TruDTL(ID KHACHHANG.ID_KH%TYPE,diemdoi NUMBER)
IS
    v_count NUMBER;
BEGIN 
    SELECT COUNT(*) INTO v_count
    FROM KHACHHANG
    WHERE ID_KH = ID;
    IF(v_count > 0) THEN
        UPDATE KHACHHANG 
		SET Diemtichluy = Diemtichluy - diemdoi 
		WHERE ID_KH=ID;
    ELSE 
        RAISE_APPLICATION_ERROR(-20000,'Khach hang khong ton tai');
    END IF;
END;
/

--Function 
--1. Function Tinh doanh thu hoa don theo ngay
CREATE OR REPLACE FUNCTION DoanhThuHD_theoNgay (ngHD DATE)
RETURN NUMBER
IS 
    v_Doanhthu NUMBER;
BEGIN
    SELECT SUM(Tongtien) INTO v_Doanhthu
    FROM HOADON 
    WHERE NGAYHD = ngHD;
    
    v_Doanhthu := NVL(v_Doanhthu,0);
    RETURN v_Doanhthu;
END;
/
--2. Function Tinh chi phi nhap kho theo ngay
CREATE OR REPLACE FUNCTION ChiPhiNK_theoNgay (ngNK DATE)
RETURN NUMBER
IS 
    v_Chiphi NUMBER;
BEGIN
    SELECT SUM(Tongtien) INTO v_Chiphi
    FROM PHIEUNK 
    WHERE NGAYNK = ngNK;
    
    v_Chiphi := NVL(v_Chiphi,0);
    RETURN v_Chiphi;
END;
/
--3. Function Tinh doanh so trung binh cua x KHACHHANG co doanh so cao nhat
CREATE OR REPLACE FUNCTION DoanhsoTB_TOPxKH(x INT)
RETURN DECIMAL
IS 
   v_avg DECIMAL;
BEGIN
    SELECT AVG(Doanhso)
    INTO v_avg
    FROM (
        SELECT Doanhso 
        FROM KHACHHANG
        ORDER BY Doanhso DESC
        FETCH FIRST x ROWS ONLY
        );
    RETURN v_avg;
END;
/
--4. Function Tinh so luong KHACHANG moi trong thang chi dinh cua nam co it nhat mot hoa don co tri gia tren x vnd
CREATE OR REPLACE FUNCTION SL_KH_Moi(thang NUMBER, nam NUMBER, trigiaHD NUMBER)
RETURN NUMBER
IS 
   v_count NUMBER;
BEGIN
    SELECT COUNT(ID_KH) INTO v_count
    FROM KHACHHANG
    WHERE EXTRACT(MONTH FROM Ngaythamgia)=thang AND EXTRACT(YEAR FROM Ngaythamgia) = nam
    AND EXISTS(SELECT *
               FROM HOADON 
               WHERE HOADON.ID_KH=KHACHHANG.ID_KH AND TONGTIEN>trigiaHD
               );
    RETURN v_count;          
END;
/
--5. Function Tinh tien mon an duoc giam khi them mot CTHD moi
CREATE OR REPLACE FUNCTION CTHD_Tinhtiengiam(Tongtien Number,Code Voucher.Code_Voucher%TYPE)
RETURN NUMBER
IS 
    Tiengiam NUMBER;
    v_phantram NUMBER;
BEGIN
    SELECT Phantram INTO v_Phantram
    FROM Voucher
    WHERE Code_Voucher=Code;
    Tiengiam := ROUND(Tongtien*v_Phantram/100);
    RETURN Tiengiam;
END;
/
--Them data
ALTER SESSION SET NLS_DATE_FORMAT = 'dd-MM-YYYY';
--Them data cho Bang NguoiDung
--Nhan vien
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (100,'Manager001@gmail.com','123','Verified','Quan Ly');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (101,'NhanVien001@gmail.com','123','Verified','Nhan Vien');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (102,'NhanVien002@gmail.com','123','Verified','Nhan Vien Kho');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (103,'NhanVien003@gmail.com','123','Verified','Nhan Vien');
--Khach Hang
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (104,'KhachHang001@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (105,'KhachHang002@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (106,'KhachHang003@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (107,'KhachHang004@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (108,'KhachHang005@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (109,'KhachHang006@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (110,'KhachHang007@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (111,'KhachHang008@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (112,'KhachHang009@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (113,'KhachHang010@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (114,'KhachHang011@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (115,'KhachHang012@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (116,'KhachHang013@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (117,'KhachHang014@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (118,'KhachHang015@gmail.com','123','Verified','Khach Hang');

--Them data cho bang Nhan Vien
ALTER SESSION SET NLS_DATE_FORMAT = 'dd-MM-YYYY';
--Co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (100,'Duc Vinh','20/05/2024','0938024123','Quan ly',100,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (101,'Thien Kim','23/05/2024','0938132538','Tiep tan',101,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (102,'My Duyen','23/05/2024','0938333764','Kho',102,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (103,'Thao Nguyen','25/05/2024','0938637254','Tiep tan',103,100,'Dang lam viec');
--Khong co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (104,'Nguyen Thanh Binh','30/05/2024','0934266452','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (105,'Le Van','26/05/2024','0933123894','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (106,'Pham Thi Giang','22/05/2024','0980233974','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (107,'Dinh Thai Vinh','24/05/2024','0938897234','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (108,'Tran My Nhan','28/05/2024','0987633124','Thu ngan',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (109,'Tran Cam Van','28/05/2024','0982367251','Bep',100,'Dang lam viec');

--Them data cho bang KhachHang
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (100,'Le Minh Duong','30/05/2024',104);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (101,'Nguyen Hong Dao','30/05/2024',105);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (102,'Dinh Quoc Thinh','30/05/2024',106);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (103,'Nguyen Thi Mai','01/06/2024',107);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (104,'Tran Anh Thu','01/06/2024',108);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (105,'Tran Tuyet Nhung','07/06/2024',109);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (106,'Vo Thanh Hang','07/06/2024',110);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (107,'Hoang Le Quynh Nhu','10/06/2024',111);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (108,'Phan Ngoc Nu','10/06/2024',112);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (109,'Hoang The Minh','13/06/2024',113);

--Vietnam
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (1, 'BANH XEO', 10000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (2, 'THIT KHO TAU', 180000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (3, 'COM TAM', 99000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (4, 'PHO GA', 119000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (5, 'BUN BO HUE', 139000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (6, 'BO KHO', 250000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (7, 'COM GA', 89000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (8, 'SUON CHUA NGOT', 200000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (9, 'CANH CHUA CA MU', 549000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (10, 'CA NGU KHO', 149000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (11, 'BUN DAU MAM TOM', 140000, 'Vietnam', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (12, 'RAM NUONG QUANG NGAI', 299000, 'Vietnam', 'Dang kinh doanh');

--china
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (13, 'VIT QUAY BAC KINH', 399000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (14, 'COM CHIEN DUONG CHAU', 89000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (15, 'SUI CAO HAP', 179000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (16, 'PHAT NHAY TUONG', 499000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (17, 'DAU SOT TU XUYEN', 180000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (18, 'MI TRUONG THO', 109000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (19, 'DAU HU THOI CHIEN', 89000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (20, 'BUN QUA CAU', 239000, 'China', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (21, 'TRUNG BACH THAO', 180000, 'China', 'Dang kinh doanh');

--Thailand
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (22, 'GAEND KEOW WAN', 180000, 'Thailand', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (23, 'LAU THAI', 499000, 'Thailand', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (24, 'PAT THAI', 230000, 'Thailand', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (25, 'SANG KAYA FUG TONG', 390000, 'Thailand', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (26, 'SOM TUM THAI', 190000, 'Thailand', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (27, 'TOM YUM', 390000, 'Thailand', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (28, 'XOI XOAI', 89000, 'Thailand', 'Dang kinh doanh');

--Japan
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (29, 'TONKATSU', 299000, 'Japan', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (30, 'TEMPURA', 265000, 'Japan', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (31, 'SUKIYAKI', 1990000, 'Japan', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (32, 'MI SOBA', 255000, 'Japan', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (33, 'SASHIMI', 1650000, 'Japan', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (34, 'SUSHI', 1850000, 'Japan', 'Dang kinh doanh');

--France
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (35, 'BANH CREPE', 109000, 'France', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (36, 'BANH PAIN AU CHOCOLAT', 209000, 'France', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (37, 'BANH MI NUONG', 250000, 'France', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (38, 'SALADE NICOISE', 150000, 'France', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (39, 'STEAK TARTARE', 350000, 'France', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (40, 'ESCARGOT', 450000, 'France', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (90, 'COM SUON', 70000, 'France', 'Ngung kinh doanh');


--Korea
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (41, 'GA OM ANDONG', 399000, 'Korea', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (42, 'BACH TUOC SONG', 499000, 'Korea', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (43, 'THIT BO TUOI SONG YUKHOE', 250000, 'Korea', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (44, 'KIMCHI JJIGAE', 150000, 'Korea', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (45, 'GA HAM SAM', 599000, 'Korea', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (46, 'TOKBOKKI', 250000, 'Korea', 'Dang kinh doanh');

--India
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (47, 'SAMOSA', 150000, 'India', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (48, 'CA RI', 120000, 'India', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (49, 'COM BIRYANI', 120000, 'India', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (50, 'COM GA TIKKA MASALA', 160000, 'India', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (51, 'BANH SUA CHIEN', 89000, 'India', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (52, 'TRA MASALA', 95000, 'India', 'Dang kinh doanh');

--Malaysia
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (53, 'COM NASI KERABU', 250000, 'Malaysia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (54, 'BO RENDANG', 350000, 'Malaysia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (55, 'HU TIEU CHAR KUEY TEOW', 250000, 'Malaysia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (56, 'MI PENANG ASSAM LAKSA', 250000, 'Malaysia', 'Dang kinh doanh');

--Germany
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (57, 'ROULADEN', 450000, 'Germany', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (58, 'SAUERBRATEN', 350000, 'Germany', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (59, 'SCHNITZEL', 400000, 'Germany', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (60, 'SCHWEINSHAXE', 399000, 'Germany', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (61, 'MY ONG', 150000, 'Germany', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (62, 'KARRTOFFELPUFFER', 350000, 'Germany', 'Dang kinh doanh');

--Italy
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (63, 'ARANCINI', 229000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (64, 'THIT HEO NUONG SOT CAM', 299000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (65, 'BISTECCA', 299000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (66, 'SPAGHETTI', 199000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (67, 'BRUSCHETE', 299000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (68, 'GA PHO MAI', 399000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (69, 'CORNETTI', 59000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (70, 'LASAGNA', 299000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (71, 'MY Y SOT KEM', 199000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (72, 'OSSOBUCO', 499000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (73, 'RIBOLLITA', 229000, 'Italy', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (74, 'RISOTTO', 399000, 'Italy', 'Dang kinh doanh');

--Australia
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (75, 'SIGNATURE WINE', 3290000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (76, 'VANG DO', 3990000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (77, 'VANG TRANG', 2890000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (78, 'VANG ÚC', 5590000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (79, 'CA BARRAMUNDI', 499000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (80, 'THIT CA SAU', 599000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (81, 'GA PARMIGIANA', 350000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (82, 'THIT KANGAROO', 760000, 'Australia', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (83, 'BANH PAVLOVA', 240000, 'Australia', 'Dang kinh doanh');

SELECT *
FROM monan
WHERE Loai = 'Netherlands'
--Netherlands
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (84, 'BANH OLIEBOLLEN', 289000, 'Netherlands', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (85, 'BANH POFFERTJES', 289000, 'Netherlands', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (86, 'CA TRICH', 389000, 'Netherlands', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (87, 'HUTSPOT', 349000, 'Netherlands', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (88, 'KIBBLING', 199000, 'Netherlands', 'Dang kinh doanh');
INSERT INTO MonAn(ID_MonAn, TenMon, Dongia, Loai, TrangThai) VALUES (89, 'STAMPOT', 219000, 'Netherlands', 'Dang kinh doanh');

--Them data cho bang Ban
--Tang 1
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (100,'Ban T1.1','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (101,'Ban T1.2','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (102,'Ban T1.3','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (103,'Ban T1.4','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (104,'Ban T1.5','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (105,'Ban T1.6','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (106,'Ban T1.7','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (107,'Ban T1.8','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (108,'Ban T1.9','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (109,'Ban T1.10','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (110,'Ban T1.11','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (111,'Ban T1.12','Tang 1','Con trong');

--Tang 2
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (112,'Ban T2.1','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (113,'Ban T2.2','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (114,'Ban T2.3','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (115,'Ban T2.4','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (116,'Ban T2.5','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (117,'Ban T2.6','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (118,'Ban T2.7','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (119,'Ban T2.8','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (120,'Ban T2.9','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (121,'Ban T2.10','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (122,'Ban T2.11','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (123,'Ban T2.12','Tang 2','Con trong');

--Tang 3
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (124,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (125,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (126,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (127,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (128,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (129,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (130,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (131,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (132,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (133,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (134,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES (135,'Ban T3.1','Tang 3','Con trong');

--Them data cho bang Voucher
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('loQy','20% off for Vietnam Menu',20,'Vietnam',10,200);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('pCfI','30% off for China Menu',30,'China',5,300);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('pApo','20% off for Thailand Menu',20,'Thailand',10,200);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('ugQx','100% off for Korea Menu',100,'Korea',3,500);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('nxVX','20% off for All Menu',20,'All',5,300);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('Pwyn','20% off for Japan Menu',20,'Japan',10,200);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('bjff','50% off for France Menu',50,'France',5,600);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('YPzJ','20% off for Australia Menu',20,'Australia',5,200);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('Y5g0','30% off for Netherlands Menu',30,'Netherlands',5,300);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('7hVO','60% off for Vietnam Menu',60,'Vietnam',0,1000);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('WHLm','20% off for Italy Menu',20,'Italy',0,200);
INSERT INTO Voucher(Code_Voucher,mota, Phantram,LoaiMA,SoLuong,Diem) VALUES ('GTsC','20% off for France Menu',20,'France',0,200);

--Them data cho bang HoaDon
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (101, 100, 100, TO_DATE('15-04-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (102, 104, 102, TO_DATE('15-04-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (103, 105, 103, TO_DATE('02-05-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (104, 101, 101, TO_DATE('05-05-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (105, 103, 120, TO_DATE('12-05-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (106, 104, 100, TO_DATE('12-05-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (107, 107, 103, TO_DATE('20-05-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (108, 108, 101, TO_DATE('20-05-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (109, 100, 100, TO_DATE('20-05-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (110, 103, 101, TO_DATE('01-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (111, 106, 102, TO_DATE('01-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (112, 108, 103, TO_DATE('01-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (113, 106, 102, TO_DATE('01-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (114, 108, 103, TO_DATE('01-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (115, 109, 104, TO_DATE('02-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (116, 100, 105, TO_DATE('02-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (117, 106, 106, TO_DATE('02-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (118, 102, 106, TO_DATE('05-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (119, 103, 106, TO_DATE('10-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (120, 104, 106, TO_DATE('10-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (121, 105, 106, TO_DATE('10-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) VALUES (122, 107, 106, TO_DATE('10-06-2024', 'DD-MM-YYYY'), 0, 0, 'Chua thanh toan');

--Them data cho CTHD
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,3,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,10,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,2,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,4,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (103,12,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,30,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,59,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,28,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,88,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,70,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,75,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,78,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,32,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,12,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,12,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,40,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (109,45,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,34,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,43,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,65,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,47,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,49,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,31,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,30,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,32,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (115,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,57,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,34,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,67,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,66,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,34,10);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,35,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,83,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,78,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,38,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,39,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,53,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,31,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,33,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,34,6);

UPDATE HOADON 
SET TrangThai = 'Da thanh toan';

--Them data cho bang NguyenLieu
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (100,'Thit ga',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (101,'Thit heo',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (102,'Thit bo',80000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (103,'Tom',100000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (104,'Ca hoi',500000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (105,'Gao',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (106,'Sua tuoi',40000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (107,'Bot mi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (108,'Dau ca hoi',1000000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (109,'Dau dau nanh',150000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (110,'Muoi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (111,'Duong',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (112,'Hanh tay',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (113,'Toi',30000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (114,'Dam',50000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES (115,'Thit de',130000,'kg');

--Them data cho PhieuNK
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (100,102,'10-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (101,102,'11-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (102,102,'12-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (103,102,'12-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (104,102,'15-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (105,102,'12-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (106,102,'15-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (107,102,'12-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (108,102,'15-05-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (109,102,'12-06-2024');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (110,102,'02-06-2024');

--Them data cho CTNK
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,100,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,101,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,101,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,103,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,104,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,105,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,106,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,107,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,108,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,109,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,110,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (105,110,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,102,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,115,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,110,35);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,105,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,104,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,103,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,106,30);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,106,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,107,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,110,20);

--Them data cho PhieuXK
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (100,102,'10-06-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (101,102,'11-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (102,102,'12-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (103,102,'13-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (104,102,'12-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (105,102,'13-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (106,102,'12-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (107,102,'15-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (108,102,'20-05-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (109,102,'15-06-2024');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (110,102,'10-06-2024');

--Them data cho CTXK
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,100,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,101,7);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,103,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,106,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,109,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,112,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,113,8);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,103,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,106,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,115,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,114,5);

--Het--
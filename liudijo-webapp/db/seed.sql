-- Seed admin user (change password hash! here for demo only)
-- Generate bcrypt hash in app runtime. For seed we keep empty.

INSERT INTO Users (Email, PasswordHash, FullName, RoleId, IsActive)
VALUES ('admin@liudijo.com', 0x31, 'Administrator', (SELECT RoleId FROM Roles WHERE Name='ADMIN'), 1);

INSERT INTO Products (Name, Slug, Type, Price, Currency, IsActive)
VALUES (N'Gmail EDU 4 năm', 'gmail-edu-4y', 'ACCOUNT', 99000, 'VND', 1),
       (N'Tài khoản Netflix 1 tháng', 'netflix-1m', 'ACCOUNT', 120000, 'VND', 1),
       (N'Key Office 365', 'office365-key', 'KEY', 150000, 'VND', 1);

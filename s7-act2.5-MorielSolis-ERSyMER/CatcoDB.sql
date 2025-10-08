-- ========================================
-- Base de datos
-- ========================================
DROP DATABASE IF EXISTS CatcoDb;
CREATE DATABASE IF NOT EXISTS CatcoDB;
USE CatcoDB;

-- ========================================
-- TABLAS DEL NEGOCIO
-- ========================================

CREATE TABLE Productos (
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    fechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE DetallesProductos (
    idDetalle INT AUTO_INCREMENT PRIMARY KEY,
    idProducto INT NOT NULL,
    tipoDeProducto VARCHAR(50),
    FechaVencimiento VARCHAR(50),
    peso DECIMAL(10,2),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Venta (
    idVenta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    clienteNombre VARCHAR(100),
    clienteEmail VARCHAR(100)
);

CREATE TABLE DetalleVentas (
    idDetalleVenta INT AUTO_INCREMENT PRIMARY KEY,
    idVenta INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) AS (cantidad * precioUnitario) STORED,
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ========================================
-- TABLAS DE ASP.NET Identity
-- ========================================

CREATE TABLE AspNetUsers (
    Id VARCHAR(450) PRIMARY KEY,
    UserName VARCHAR(256),
    NormalizedUserName VARCHAR(256),
    Email VARCHAR(256),
    NormalizedEmail VARCHAR(256),
    EmailConfirmed BIT NOT NULL DEFAULT 0,
    PasswordHash TEXT,
    SecurityStamp TEXT,
    ConcurrencyStamp TEXT,
    PhoneNumber VARCHAR(50),
    PhoneNumberConfirmed BIT NOT NULL DEFAULT 0,
    TwoFactorEnabled BIT NOT NULL DEFAULT 0,
    LockoutEnd DATETIME,
    LockoutEnabled BIT NOT NULL DEFAULT 1,
    AccessFailedCount INT NOT NULL DEFAULT 0
);

CREATE TABLE AspNetRoles (
    Id VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(256),
    NormalizedName VARCHAR(256),
    ConcurrencyStamp TEXT
);

CREATE TABLE AspNetUserRoles (
    UserId VARCHAR(255) NOT NULL,
    RoleId VARCHAR(255) NOT NULL,
    PRIMARY KEY(UserId, RoleId),
    FOREIGN KEY(UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE,
    FOREIGN KEY(RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetUserClaims (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    UserId VARCHAR(255) NOT NULL,
    ClaimType TEXT,
    ClaimValue TEXT,
    FOREIGN KEY(UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetRoleClaims (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    RoleId VARCHAR(255) NOT NULL,
    ClaimType TEXT,
    ClaimValue TEXT,
    FOREIGN KEY(RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetUserLogins (
    LoginProvider VARCHAR(128) NOT NULL,
    ProviderKey VARCHAR(128) NOT NULL,
    ProviderDisplayName VARCHAR(128),
    UserId VARCHAR(255) NOT NULL,
    PRIMARY KEY(LoginProvider, ProviderKey),
    FOREIGN KEY(UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetUserTokens (
    UserId VARCHAR(255) NOT NULL,
    LoginProvider VARCHAR(128) NOT NULL,
    Name VARCHAR(128) NOT NULL,
    Value TEXT,
    PRIMARY KEY(UserId, LoginProvider, Name),
    FOREIGN KEY(UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

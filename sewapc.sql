CREATE DATABASE IF NOT EXISTS sewapc;
USE sewapc;

-- Dumping structure for table sewapc.pc
CREATE TABLE IF NOT EXISTS pc (
  id_pc int NOT NULL AUTO_INCREMENT,
  model varchar(50) NOT NULL,
  spesifikasi text NOT NULL,
  PRIMARY KEY (id_pc)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sewapc.pc: ~2 rows (approximately)
INSERT INTO pc (id_pc, model, spesifikasi) VALUES
	(1, 'Asus RX 224', 'RTX 4050 TI');
INSERT INTO pc (id_pc, model, spesifikasi) VALUES
	(2, 'Dell PHI AJW 223', 'RX 505');
INSERT INTO pc (id_pc, model, spesifikasi) VALUES
	(3, 'Nvidia RIZZ Z1', 'RTX 5090 ');

-- Dumping structure for table sewapc.pelanggan
CREATE TABLE IF NOT EXISTS pelanggan (
  id_pelanggan int NOT NULL AUTO_INCREMENT,
  nama varchar(100) NOT NULL,
  telepon varchar(15) NOT NULL,
  alamat text,
  PRIMARY KEY (id_pelanggan)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sewapc.pelanggan: ~2 rows (approximately)
INSERT INTO pelanggan (id_pelanggan, nama, telepon, alamat) VALUES
	(1, 'Danil', '89347928372', 'adawdad');
INSERT INTO pelanggan (id_pelanggan, nama, telepon, alamat) VALUES
	(2, 'Subaru', '4534535', 'sfefsadawd');
INSERT INTO pelanggan (id_pelanggan, nama, telepon, alamat) VALUES
	(3, 'Lila', '0374892374', 'hjgjg');

-- Dumping structure for table sewapc.penyewaan
CREATE TABLE IF NOT EXISTS penyewaan (
  id_penyewaan int NOT NULL AUTO_INCREMENT,
  id_pelanggan int DEFAULT NULL,
  id_pc int DEFAULT NULL,
  tanggal_sewa date NOT NULL,
  tanggal_kembali date DEFAULT NULL,
  total_biaya decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (id_penyewaan),
  KEY id_pelanggan (id_pelanggan),
  KEY id_pc (id_pc),
  CONSTRAINT penyewaan_ibfk_1 FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan),
  CONSTRAINT penyewaan_ibfk_2 FOREIGN KEY (id_pc) REFERENCES pc (id_pc)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table sewapc.penyewaan: ~2 rows (approximately)
INSERT INTO penyewaan (id_penyewaan, id_pelanggan, id_pc, tanggal_sewa, tanggal_kembali, total_biaya) VALUES
	(1, 1, 2, '2025-01-22', '2025-01-25', 20000000.00);
INSERT INTO penyewaan (id_penyewaan, id_pelanggan, id_pc, tanggal_sewa, tanggal_kembali, total_biaya) VALUES
	(2, 2, 1, '2025-01-22', '2025-01-31', 900000.00);

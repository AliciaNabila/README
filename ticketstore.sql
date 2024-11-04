-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Nov 2024 pada 05.45
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ticketstore`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `ticketstore`
--

CREATE TABLE `ticketstore` (
  `id` int(11) NOT NULL,
  `destination` varchar(30) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `ticketstore`
--

INSERT INTO `ticketstore` (`id`, `destination`, `date`, `price`, `stock`) VALUES
(1, 'Jakarta - Kota Metropolitan', '2024-12-10', 550000.00, 90),
(2, 'Bandung - Kota Kembang', '2024-12-11', 320000.00, 140),
(3, 'Surabaya - Kota Pahlawan', '2024-12-12', 480000.00, 75),
(4, 'Yogyakarta - Kota Budaya', '2024-12-13', 360000.00, 110),
(5, 'Bali - Pulau Dewata', '2024-12-14', 620000.00, 55),
(6, 'Medan - Kota Bersejarah', '2024-12-15', 500000.00, 85),
(7, 'Makassar - Kota Pelabuhan', '2024-12-16', 470000.00, 70),
(8, 'Semarang - Kota Pelayaran', '2024-12-17', 400000.00, 95),
(9, 'Palembang - Kota Musi', '2024-12-18', 430000.00, 65),
(10, 'Balikpapan - Kota Minyak', '2024-12-19', 510000.00, 80);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `ticketstore`
--
ALTER TABLE `ticketstore`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `ticketstore`
--
ALTER TABLE `ticketstore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

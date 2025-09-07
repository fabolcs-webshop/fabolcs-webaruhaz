-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3306
-- Létrehozás ideje: 2025. Sze 07. 05:48
-- Kiszolgáló verziója: 9.1.0
-- PHP verzió: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `fabolcs_webaruhaz`
--
CREATE DATABASE IF NOT EXISTS `fabolcs_webaruhaz` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `fabolcs_webaruhaz`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `egyedi_keresek`
--

DROP TABLE IF EXISTS `egyedi_keresek`;
CREATE TABLE IF NOT EXISTS `egyedi_keresek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nev` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `telefon` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `uzenet` text COLLATE utf8mb4_general_ci NOT NULL,
  `datum` datetime DEFAULT CURRENT_TIMESTAMP,
  `olvasott` tinyint(1) DEFAULT '0',
  `valaszolt` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

DROP TABLE IF EXISTS `felhasznalok`;
CREATE TABLE IF NOT EXISTS `felhasznalok` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `jelszo` varchar(255) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `regdatum` datetime DEFAULT CURRENT_TIMESTAMP,
  `torolve` datetime DEFAULT NULL,
  `telefon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`id`, `email`, `jelszo`, `nev`, `admin`, `regdatum`, `torolve`, `telefon`) VALUES
(10, 'fabolcs@gmail.com', '$2y$10$OejLw/RKnA7/k18KfCxdzOePyxqWjKSN9yqbXCNxkRtE4wwoe5/We', 'Kuti Szabolcs', 1, '2025-06-20 20:16:47', NULL, NULL),
(24, 'hajdumesi94@gmail.com', '$2y$10$9fuIrk78Fn8DLLYamEoY2.KDI/RAqpDdAjy0gMnekFrYxHej3CUhu', 'Kutiné Hajdú Emese', 0, '2025-07-25 13:19:36', NULL, '+36305671147'),
(25, 'szabku@freemail.hu', '$2y$10$RE.ZIU791CmptmFcbO1mp.u7/b7rxv2K08kS2EtHbtlwvQ6UzOvE6', 'Kuti Szabolcs', 0, '2025-08-30 09:50:00', NULL, '+36305671147');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `fiok_torlesi_kerelmek`
--

DROP TABLE IF EXISTS `fiok_torlesi_kerelmek`;
CREATE TABLE IF NOT EXISTS `fiok_torlesi_kerelmek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `felhasznalo_id` int NOT NULL,
  `kersel_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `feldolgozatlan` tinyint(1) NOT NULL DEFAULT '1',
  `megjegyzes` text,
  PRIMARY KEY (`id`),
  KEY `felhasznalo_id` (`felhasznalo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kosar_tetelek`
--

DROP TABLE IF EXISTS `kosar_tetelek`;
CREATE TABLE IF NOT EXISTS `kosar_tetelek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `felhasznalo_id` int NOT NULL,
  `termek_id` int NOT NULL,
  `mennyiseg` int NOT NULL,
  `letrehozva` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `felhasznalo_id` (`felhasznalo_id`),
  KEY `termek_id` (`termek_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendelesek`
--

DROP TABLE IF EXISTS `rendelesek`;
CREATE TABLE IF NOT EXISTS `rendelesek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `felhasznalo_id` int NOT NULL,
  `datum` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `felhasznalo_id` (`felhasznalo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendeles_tetelek`
--

DROP TABLE IF EXISTS `rendeles_tetelek`;
CREATE TABLE IF NOT EXISTS `rendeles_tetelek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rendeles_id` int NOT NULL,
  `termek_id` int NOT NULL,
  `mennyiseg` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `termek_id` (`termek_id`),
  KEY `fk_rendeles_id` (`rendeles_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;

--
-- A tábla adatainak kiíratása `rendeles_tetelek`
--

INSERT INTO `rendeles_tetelek` (`id`, `rendeles_id`, `termek_id`, `mennyiseg`) VALUES
(42, 41, 9, 4),
(43, 41, 7, 2),
(44, 42, 7, 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendeles_veglegesites`
--

DROP TABLE IF EXISTS `rendeles_veglegesites`;
CREATE TABLE IF NOT EXISTS `rendeles_veglegesites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `felhasznalo_id` int NOT NULL,
  `szallitasi_cimek_id` int NOT NULL,
  `szallitasi_partner_id` int NOT NULL,
  `rendeles_datum` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `felhasznalo_id` (`felhasznalo_id`),
  KEY `szallitasi_cimek_id` (`szallitasi_cimek_id`),
  KEY `szallitasi_partner_id` (`szallitasi_partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

--
-- A tábla adatainak kiíratása `rendeles_veglegesites`
--

INSERT INTO `rendeles_veglegesites` (`id`, `felhasznalo_id`, `szallitasi_cimek_id`, `szallitasi_partner_id`, `rendeles_datum`) VALUES
(34, 24, 59, 10, '2025-07-27 11:45:06'),
(35, 25, 60, 10, '2025-08-30 07:52:22');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szallitasi_cimek`
--

DROP TABLE IF EXISTS `szallitasi_cimek`;
CREATE TABLE IF NOT EXISTS `szallitasi_cimek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `felhasznalo_id` int NOT NULL,
  `cim` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `felhasznalo_id` (`felhasznalo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3;

--
-- A tábla adatainak kiíratása `szallitasi_cimek`
--

INSERT INTO `szallitasi_cimek` (`id`, `felhasznalo_id`, `cim`) VALUES
(59, 24, '6800 Szeged, Gyöm 11'),
(60, 25, '6800 Hódmezővásárhely, Kat 2');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szallitasi_partnerek`
--

DROP TABLE IF EXISTS `szallitasi_partnerek`;
CREATE TABLE IF NOT EXISTS `szallitasi_partnerek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nev` varchar(50) NOT NULL,
  `tipus` varchar(100) DEFAULT NULL,
  `ar` int NOT NULL,
  `kep` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

--
-- A tábla adatainak kiíratása `szallitasi_partnerek`
--

INSERT INTO `szallitasi_partnerek` (`id`, `nev`, `tipus`, `ar`, `kep`) VALUES
(10, 'FOXPOST', 'Előre utalás, házhoz szállítás', 1500, 'kepek/foxpost.png'),
(11, 'GLS', 'Előre utalás, házhoz szállítás', 2000, 'kepek/gls.png'),
(12, 'MPL', 'Előre utalás, házhoz szállítás', 5000, 'kepek/mpl.png');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `termekek`
--

DROP TABLE IF EXISTS `termekek`;
CREATE TABLE IF NOT EXISTS `termekek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nev` varchar(100) NOT NULL,
  `leiras` text,
  `ar` int NOT NULL,
  `keszlet` int NOT NULL,
  `kep` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;

--
-- A tábla adatainak kiíratása `termekek`
--

INSERT INTO `termekek` (`id`, `nev`, `leiras`, `ar`, `keszlet`, `kep`) VALUES
(7, 'Jack Russell terrier', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nJack Russel terrier fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/jack_russel_terrier_oldal.jpg'),
(8, 'Amerikai staffordshire', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nAmerikai staffordshire fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga:3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/amerikai_staffordshire_oldal.jpg'),
(9, 'Bichon Havanese', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nBichon Havanese fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga:3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/bichon_havanese_oldal.jpg'),
(10, 'Boston terrier', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nBoston terrier fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga:3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/boston_terrier_oldal.jpg'),
(11, 'Labrador', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nLabrador fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/golden_retriever_oldal.jpg'),
(12, 'Golden retriever', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nGolden retriever fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/labrador_oldal.jpg'),
(13, 'Német juhász', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nNémet juhász fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/nemetjuhasz_oldal.jpg'),
(14, 'Rottwailer', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nRottwailer fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/rottwailer_oldal.jpg'),
(15, 'Tacskó', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nTacskó fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga:3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/tacsko_oldal.jpg'),
(16, 'Újfundlandi', 'Fali kulcstartó\r\n\r\nA termékről :\r\n\r\nÚjfundlandi fali kulcstartó 7db kulcs fel akasztására alkalmas.Tőkéletes ajándék lehet önnek családjának és barátainak.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 24x26 cm', 4332, 0, 'kepek/ujfullandi_oldal.jpg'),
(17, 'Game Over', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga:3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/gameover_oldal1.jpg'),
(18, 'Gamer', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga:3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/gamer_oldal.jpg'),
(19, 'Gazda1', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/gazda1_oldal1.jpg'),
(20, 'Lovas', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/gazda2_oldal1.jpg'),
(21, 'Horgász', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/horgasz_oldal1.jpg'),
(22, 'Jedi,Varázsló', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/jedi_wizard_oldal1.jpg'),
(23, 'Kerékpárosok', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/kerekparosok_oldal1.jpg'),
(24, 'Menekülés', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/par1_oldal.jpg'),
(25, 'Pár', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 5 cm', 157, 0, 'kepek/par2_oldal.jpg'),
(26, 'Pár2', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/par3_oldal.jpg'),
(27, 'R2D2,BB8', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/R2-D2_BB-8_oldal1.jpg'),
(28, 'Ültetőkártya1', 'Esküvői köszönet ajándék és ültetőkártya\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár és vendégeik nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 6x9cm', 235, 0, 'kepek/ultetokartya1_oldal.jpg'),
(29, 'Ültetőkártya2', 'Esküvői köszönet ajándék és ültetőkártya\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár és vendégeik nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 6x9cm', 235, 0, 'kepek/ultetokartya2_oldal.jpg'),
(30, 'Varázsló', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 4x6 cm', 157, 0, 'kepek/varazslo_oldal.jpg'),
(31, 'Virágok', 'Esküvői köszönet ajándék\r\n\r\nA termékről :\r\n\r\nSzeretné megköszönni a kedves vendégeinek, hogy részt vettek, és önökkel ünnepeltek a nagy napon? Kedves kis köszönetajándék lehet melyett hűtőmágnesként is választható, mely egyedileg készül az ifjú pár nevével és az esküvő dátumával, de bármelyik szöveges rész megváltoztatható igény szerint.\r\n\r\nAnyaga: 3 mm vastag natúr nyírfa\r\nMérete: 5x6 cm', 177, 0, 'kepek/viragok_oldal.jpg');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `uj_rendelesek`
--

DROP TABLE IF EXISTS `uj_rendelesek`;
CREATE TABLE IF NOT EXISTS `uj_rendelesek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rendeles_azonosito` varchar(50) NOT NULL,
  `felhasznalo_id` int NOT NULL,
  `szallitasi_cimek_id` int NOT NULL,
  `szallitasi_partner_id` int NOT NULL,
  `datum` datetime DEFAULT CURRENT_TIMESTAMP,
  `statusz` varchar(50) DEFAULT NULL,
  `megjegyzes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;

--
-- A tábla adatainak kiíratása `uj_rendelesek`
--

INSERT INTO `uj_rendelesek` (`id`, `rendeles_azonosito`, `felhasznalo_id`, `szallitasi_cimek_id`, `szallitasi_partner_id`, `datum`, `statusz`, `megjegyzes`) VALUES
(41, 'RND-20250727-24FD', 24, 59, 10, '2025-07-27 11:45:06', 'gyartas', ''),
(42, 'RND-20250830-9605', 25, 60, 10, '2025-08-30 07:52:22', 'gyartas', 'dfdsfsdfsdfs');

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `fiok_torlesi_kerelmek`
--
ALTER TABLE `fiok_torlesi_kerelmek`
  ADD CONSTRAINT `fiok_torlesi_kerelmek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`);

--
-- Megkötések a táblához `kosar_tetelek`
--
ALTER TABLE `kosar_tetelek`
  ADD CONSTRAINT `kosar_tetelek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`),
  ADD CONSTRAINT `kosar_tetelek_ibfk_2` FOREIGN KEY (`termek_id`) REFERENCES `termekek` (`id`);

--
-- Megkötések a táblához `rendelesek`
--
ALTER TABLE `rendelesek`
  ADD CONSTRAINT `rendelesek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`);

--
-- Megkötések a táblához `rendeles_tetelek`
--
ALTER TABLE `rendeles_tetelek`
  ADD CONSTRAINT `fk_rendeles_id` FOREIGN KEY (`rendeles_id`) REFERENCES `uj_rendelesek` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rendeles_tetelek_ibfk_2` FOREIGN KEY (`termek_id`) REFERENCES `termekek` (`id`);

--
-- Megkötések a táblához `rendeles_veglegesites`
--
ALTER TABLE `rendeles_veglegesites`
  ADD CONSTRAINT `rendeles_veglegesites_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`),
  ADD CONSTRAINT `rendeles_veglegesites_ibfk_2` FOREIGN KEY (`szallitasi_cimek_id`) REFERENCES `szallitasi_cimek` (`id`),
  ADD CONSTRAINT `rendeles_veglegesites_ibfk_3` FOREIGN KEY (`szallitasi_partner_id`) REFERENCES `szallitasi_partnerek` (`id`);

--
-- Megkötések a táblához `szallitasi_cimek`
--
ALTER TABLE `szallitasi_cimek`
  ADD CONSTRAINT `szallitasi_cimek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

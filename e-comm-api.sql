-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 13, 2025 at 03:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e-comm-api`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address` text NOT NULL,
  `subdistrict` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `regency` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'Indonesia',
  `phone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `address`, `subdistrict`, `district`, `regency`, `province`, `postal_code`, `country`, `phone`, `created_at`, `updated_at`) VALUES
(2, 3, 'Jl. Pagesangan Timur No.16', 'Pagesangan', 'Jambangan', 'Surabaya', 'Jawa Timur', '66203', 'Indonesia', '6288232220652', '2025-02-10 02:01:02', '2025-02-10 02:12:36');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant` varchar(100) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `product_id`, `variant`, `quantity`) VALUES
(22, 3, 47, NULL, 1),
(28, 3, 10, 'White', 10);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `img_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `img_url`) VALUES
(26, 'Electronics', 'electronics', 'Discover the latest tech marvels! From powerful laptops and cutting-edge smartphones to immersive home theater systems and smart home gadgets, find the perfect electronic companion for your digital life.', 'uploads\\category/1737954541720-349089609.jpg'),
(27, 'Men\'s Clothing', 'mens-clothing', 'Elevate your style with our collection of men\'s clothing. Explore sharp suits, casual wear, durable outerwear, and essential accessories for a confident and contemporary look.', 'uploads\\category/1737954743409-740067389.jpg'),
(28, 'Women\'s Clothing', 'womens-clothing', 'Express your unique style with our curated collection of women\'s fashion. Discover trendy dresses, comfortable basics, stylish outerwear, and statement accessories for every occasion.', 'uploads\\category/1737954768673-877087834.jpg'),
(29, 'Home & Garden', 'home-and-garden', 'Create your dream home and garden oasis. Find stylish furniture, inspiring décor, essential kitchenware, and everything you need to cultivate a beautiful and functional living space, inside and out.', 'uploads\\category/1737954798254-720705854.jpg'),
(30, 'Books & Literature', 'books-and-literature', 'Embark on literary adventures and expand your knowledge with our vast selection of books. From captivating novels and thought-provoking non-fiction to engaging children\'s stories and educational textbooks, discover your next favorite read.', 'uploads\\category/1737954821820-216208748.jpg'),
(31, 'Sports & Outdoors', 'sports-and-outdoors', 'Gear up for your next adventure! Explore high-performance sports equipment, durable outdoor gear, and comfortable activewear for all your athletic pursuits and outdoor explorations. Get ready to conquer new challenges.', 'uploads\\category/1737954843155-214217511.jpg'),
(32, 'Toys & Games', 'toys-and-games', 'Unleash your inner child and discover a world of fun and imagination. Explore exciting toys, engaging games, challenging puzzles, and creative playthings for all ages. Let the games begin!', 'uploads\\category/1737954872089-394036102.jpg'),
(33, 'Beauty & Personal Care', 'beauty-and-personal-care', 'Enhance your natural beauty and indulge in self-care with our premium selection of beauty and personal care products. Discover skincare essentials, luxurious cosmetics, fragrant perfumes, and everything you need to look and feel your best.', 'uploads\\category/1737954912583-490343950.jpg'),
(34, 'Food & Beverage', 'food-and-beverage', 'Satisfy your cravings and discover culinary delights. Explore a wide variety of delicious food and beverages, from pantry staples and gourmet treats to refreshing drinks and ready-to-eat meals. Treat your taste buds to a culinary adventure.', 'uploads\\category/1737954931042-584002560.jpg'),
(35, 'Health & Wellness', 'health-and-wellness', 'Prioritize your well-being and live a healthier, happier life. Explore a range of health and wellness products, including vitamins, supplements, fitness equipment, and personal care items designed to support your physical and mental wellness journey.', 'uploads\\category/1737954954670-703696532.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('pending','shipped','delivered','canceled') NOT NULL DEFAULT 'pending',
  `total_price` bigint(20) NOT NULL,
  `payment_status` enum('pending','completed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_addresses`
--

CREATE TABLE `order_addresses` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `address` text NOT NULL,
  `subdistrict` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `regency` varchar(255) NOT NULL,
  `province` int(255) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'Indonesia',
  `phone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant` varchar(100) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_transactions`
--

CREATE TABLE `payment_transactions` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `amount` bigint(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `variant` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`variant`)),
  `price` bigint(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `img_urls` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`img_urls`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `slug`, `description`, `variant`, `price`, `stock`, `rating`, `category_id`, `img_urls`, `created_at`, `updated_at`) VALUES
(7, 'iPhone 16 Pro 512GB', 'iphone-16-pro-512gb', 'Introducing iPhone 16 Pro: Innovation Beyond Boundaries\n\nExperience the pinnacle of smartphone technology with the iPhone 16 Pro. This groundbreaking device pushes the limits of what\'s possible, delivering unparalleled performance, stunning visuals, and groundbreaking camera capabilities.', '[\"Black Titanium\",\"Desert Titanium\",\"Natural Titanium\",\"White Titanium\"]', 21000000, 561, 4.4, 26, '[\"uploads\\\\product\\\\1738041143745-450207664.jpg\",\"uploads\\\\product\\\\1738041143747-580150900.jpg\",\"uploads\\\\product\\\\1738041143750-682704840.jpg\",\"uploads\\\\product\\\\1738041143750-113493580.jpg\"]', '2025-01-28 05:12:23', '2025-02-05 09:08:53'),
(8, 'Samsung S24 Ultra 512GB', 'samsung-s24-ultra-512gb', 'Introducing the Samsung Galaxy S24 Ultra: Redefining the Smartphone Experience\n\nThe Samsung Galaxy S24 Ultra pushes the boundaries of innovation, delivering a premium smartphone experience that seamlessly blends cutting-edge technology with elegant design.', '[\"Titanium Black\",\"Titanium Gray\",\"Titanium Violet\",\"Titanium Yellow\"]', 23000000, 6182, 3.8, 26, '[\"uploads\\\\product\\\\1738084864905-879935294.jpg\",\"uploads\\\\product\\\\1738084864907-670533973.jpg\",\"uploads\\\\product\\\\1738084864912-413601772.jpg\",\"uploads\\\\product\\\\1738084864921-990160852.jpg\"]', '2025-01-28 17:21:04', '2025-02-05 09:08:53'),
(9, 'Google Pixel 9 Pro 128GB', 'google-pixel-9-pro-128gb', 'Google Pixel 9 Pro: Experience the Power of Google\n\nThe Google Pixel 9 Pro redefines the smartphone experience, delivering cutting-edge technology with the signature Google magic.', '[\"Obsidian\",\"Hazel\",\"Porcelain\",\"Rose Quartz\"]', 13800000, 1435, 3.4, 26, '[\"uploads\\\\product\\\\1738085066052-163467853.jpg\",\"uploads\\\\product\\\\1738085066053-278141329.jpg\",\"uploads\\\\product\\\\1738085066054-368531727.jpg\",\"uploads\\\\product\\\\1738085066055-8136762.jpg\"]', '2025-01-28 17:24:26', '2025-02-05 09:08:53'),
(10, 'Xiaomi 14 Ultra 512GB', 'xiaomi-14-ultra-512gb', 'International Model - No Warranty in US. USA ONLY COMPATIBLE WITH TMOBILE / MINT, TELLO GLOBAL VERSION . Does NOT Work With Verizon Sprint Boost Metro Pcs At&t Cricket. Unlocked Worldwide . - FCC ID: 2AFZZN28L\nDual Nano sim 5G (NO SD SLOT) :5G: n1/2/3/5/7/8/20/25/28/38/40/41/48/66/75/77/784G: LTE FDD: B1/2/3/4/5/7/8/12/13/17/18/19/20/25/26/28/32/664G: LTE TDD: B38/39/40/41/42/483G: UMTS: B1/2/4/5/6/8/192G: GSM: B2/3/5/8Supports 4x4 MIMO\nLeica professional optical lensLEICA VARIO-SUMMILUX 1:1.63-2.5/12-120 ASPH.Leica main camera LYT-90050MP3.2μm 4-in-1 Super Pixel23mm equivalent focal lengthf/1.63-f/4.0 stepless variable apertureOISALD1\'\' sensor size8P lensAFLeica 75mm floating telephoto camera 50MPf/1.875mm equivalent focal lengthOISFloating telephoto lensSupport 10cm macro photographyIMX8586P lensAFLeica 120mm periscope camera50MPf/2.5120mm equivalent focal lengthOISSupport 30cm macro photographyIMX858AFLeica 12mm ultra-wide camera50MP122° FOV12mm equivalent focal lengthf/1.8Support 5cm macro photographyIMX8587P lensAF\nAll Around Liquid DisplayWQHD+ 6.73\" AMOLED3200 x 1440, 522 ppiLTPO, AdaptiveSync ProRefresh rate: dynamic 1-120HzTouch sampling rate: up to 240Hz*Touch sampling rate may vary according to the content on your display.OLED materials type: Xiaomi-custom C8 display panelBrightness: HBM 1000 nits (typ), 3000 nits peak brightnessPro HDR display, support UltraHDRDolby VisionHDR10+68 billion colorsColor gamut: DCI-P3TrueColor displayAdaptive colorsOriginal color PROAdaptive reading modeSunlight modeDC dimming / 1920Hz PWM dimmingTÜV Rheinland Low Blue Light (Hardware Solution) CertifiedTÜV Rheinland Flicker Free CertifiedTÜV Rheinland Circadian Friendly CertifiedXiaomi Shield Glass\nSnapdragon 8 Gen 3 Mobile Platform4nm power-efficient manufacturing processCPU:1x Prime core (X4-based), up to 3.3GHz3x Performance cores (A720-based), up to 3.2GHz2x Performance cores (A720-based), up to 3.0GHz2x Efficiency cores (A520-based), up to 2.3GHzGPU: Qualcomm Adreno GPU\nCooling System : Xiaomi IceLoop system / Security In-screen fingerprint sensor AI face unlock / NFC : Yes 4610mAh (typ) batteryXiaomi Surge Battery Management systemXiaomi Surge charging chipsetXiaomi Surge battery management chipset90W HyperCharge*31mins to 100% (Boost mode)50W wireless HyperCharge*46mins to 100%*Wireless chargers are sold separately.*Charging data tested in Xiaomi Internal Labs, actual results may vary.Reverse wireless chargingUSB-C 3.2 Gen 1\n32MP in-display selfie cameraf/2.01/3.14\'\' sensor size90° FOVFront camera photography featuresDynamic Framing (0.8x, 1x)Night modeHDRPortrait mode with bokeh and depth controlPalm ShutterTimed burstMovie frameSelfie timerScreen softlightFront camera video featuresVideo teleprompterSlow motion selfieTime-lapse selfieMovie frameEIS Video stabilizationFront camera video recordingHDR video recording with Dolby Vision up to 4K at 30 fps4K (3840x2160) video recording at 30 fps, or 60 fps1080p (1920x1080) HD video recording at 30 fps, or 60 fps720p (1280x720) HD video recording at 30 fps\nGPS: L1+L5Galileo: E1+E5a | GLONASS: G1 | Beidou | NavIC: L5A-GPS supplementary positioning | Electronic compass | Wireless network | Data network| SAP\nProximity sensor | Ambient light sensor | Accelerometer | Gyroscope | Electronic compass | IR blaster | Barometer | Flicker sensor | X-axis linear vibration motor | Laser autofocus\nWireless NetworksXiaomi Surge T1 TunerWi-Fi 7 capability*Wi-Fi 7/Wi-Fi 6E/Wi-Fi 6 capability may vary based on regional availability and local network support.*Wi-Fi connectivity (including Wi-Fi frequency bands, Wi-Fi standards and other features as ratified in IEEE Standard 802.11 specifications) may vary based on regional availability and local network support. The function may be added via OTA when and where applicable.Qualcomm FastConnect 7800 Mobile Connectivity SystemHigh band SimultaneousMulti-Link OperationSupports 2x2 MIMO, 8x8 Sounding for MU-MIMO, WiFi DirectBluetooth 5.4, Dual-BluetoothSupports SBC/AAC/AptX/AptX HD/AptX Adaptive/LDAC/LHDC 5.0', '[\"Black\",\"White\"]', 17000000, 8235, 4.2, 26, '[\"uploads\\\\product\\\\1738085244846-87848579.jpg\",\"uploads\\\\product\\\\1738085244848-281817360.jpg\"]', '2025-01-28 17:27:24', '2025-02-05 09:08:53'),
(11, 'Nothing Phone (2) - 512 GB + 12 GB Ram', 'nothing-phone-2---512-gb--12-gb-ram', 'Nothing OS 2.0: A new visual identity. Customise everything from app labels and grid design to widget size and colour themes. Now with new folder layouts. Create widgets for quick settings functions or save time by adding key widgets directly to your lock screen. The new Glyph Interface: Key information, in a flash. Assign different light and sound sequences for each contact and notification type. Use the lights to track progress or create your very own ringtones with the Glyph Composer.', '[\"Dark Grey\",\"White\"]', 11000000, 7553, 3.2, 26, '[\"uploads\\\\product\\\\1738085396669-23659509.jpg\",\"uploads\\\\product\\\\1738085396677-254695542.jpg\",\"uploads\\\\product\\\\1738085396682-178175380.jpg\",\"uploads\\\\product\\\\1738085396707-772367437.jpg\"]', '2025-01-28 17:29:56', '2025-02-05 09:08:53'),
(12, 'Wrangler Authentics Cargo Pant', 'wrangler-authentics-cargo-pant', 'RELAXED FIT. These cargo pants sit at the natural waist. Designed with a relaxed fit through the seat and thigh, these cargos will keep you comfortable during any task\nSTRETCH TWILL. A Wrangler classic, these straight-leg men\'s pants have stretch and flexibility for comfort in movement. A Hollywood waistband offers extra support with your favorite belt\nCLASSIC CARGO PANT. This classic cargo pant is sure to be comfortable and functional for everyday wear. From the outdoors to work, this pant is built for versatility with a timeless silhouette and extra storage\nHEAVY-DUTY HARDWARE. Finished with a heavy-duty zipper fly and button closure\nQUICK-ACCESS STORAGE. Equipped with 6 pockets for maximum storage capacity. 2 side cargo flap pockets, 2 slash pockets, and 2 back patch pockets, for easy-access storage. Great for safely storing your cell-phone, tools, wallet, and other personal items or gadgets', '[\"Kangaroo\",\"Olive\",\"Elmwood\",\"Olive Drab\"]', 485000, 9876, 3.6, 27, '[\"uploads\\\\product\\\\1738085940942-265069565.jpg\",\"uploads\\\\product\\\\1738085940952-620893371.jpg\",\"uploads\\\\product\\\\1738085940953-599213155.jpg\",\"uploads\\\\product\\\\1738085940953-689323153.jpg\"]', '2025-01-28 17:39:00', '2025-02-05 09:08:53'),
(13, 'Legendary Whitetails Flannel Casual Shirt', 'legendary-whitetails-flannel-casual-shirt', '[Relaxed Fit]: Refer to our size chart for the ideal fit; The Buck Camp Flannel is designed to highlight the chest and waist, offering a comfortable yet stylish shape; Its double-pleated back ensures ease of movement without any pulling or tugging; Adhere to care instructions for optimal shrinkage management\n[Quality of Material]: Legendary Whitetails flannel shirt for men, recognized for its top-tier quality, is crafted from 100% soft brushed cotton flannel and promises warmth and breathability; This 5.1 ounce Buck Camp Flannel Shirt is ideally weighted for layering or standalone wear, indoors and out; Beyond its softness, its pill-resistant premium fabric quality ensures a consistently sharp look and lasting comfort\n[Authentic Designs]: Our plaid shirt men\'s designs stay true to their images, ensuring you get exactly what you see; immediate out of box comfort with no need for a \"break-in\" period; Its fade-resistant fabric ensures your men\'s flannel long sleeve shirt looks as vibrant as day one, wash after wash\n[Traditional Style]: The classic single pocket design gives you a clean look while providing an option for storage; use the pencil slot to hold your pencil when scoring on the range or safeguarding your sunglasses\n[Corduroy Lined Cuffs & Collar]: Experience the classic touch of quintessential corduroy lining in our flannel shirt for men; not only does it enhance durability, but it also ensures the collar and cuffs maintain their shape', '[\"Birch Poseidon Plaid\"]', 486900, 8765, 3.8, 27, '[\"uploads\\\\product\\\\1738086171039-950841409.jpg\",\"uploads\\\\product\\\\1738086171045-780792417.jpg\",\"uploads\\\\product\\\\1738086171049-192478302.jpg\"]', '2025-01-28 17:42:51', '2025-02-05 09:08:53'),
(14, 'Long-Sleeve Soft Touch Quarter-Zip Sweater', 'long-sleeve-soft-touch-quarter-zip-sweater', 'REGULAR FIT: Comfortable, easy fit through the shoulders, chest, and waist\nCOTTON BLEND YARN: A blended cotton yarn with a super soft hand feel and a refined knit texture.\nMIDWEIGHT ZIP-UP SWEATER: The perfect weather layering piece. Wear with a collared shirt for a modern, polished look or layer with a tee for a more casual feel.\nDETAILS: Soft rib neckline with zipper closure and rib sleeve cuffs and bottom hem for enhanced stretch and recovery.', '[\"Off-white\"]', 620000, 3458, 4.4, 27, '[\"uploads\\\\product\\\\1738086307680-172632677.jpg\",\"uploads\\\\product\\\\1738086307690-742134884.jpg\",\"uploads\\\\product\\\\1738086307692-212681252.jpg\",\"uploads\\\\product\\\\1738086307693-84792449.jpg\"]', '2025-01-28 17:45:07', '2025-02-05 09:08:53'),
(15, 'Active Performance Tech T-Shirts Pack of 2', 'active-performance-tech-t-shirts-pack-of-2', 'Fabric type : 100% Polyester\nCare instructions : Machine Wash Cold, Tumble Dry\nOrigin : Imported\nClosure type : Pull On\n', '[\"Black/Medium Grey\",\"Green/Black\",\"Burgundy/White\",\"Dark Blue/Teal Blue\"]', 194000, 23478, 4.0, 27, '[\"uploads\\\\product\\\\1738086563561-849464891.jpg\",\"uploads\\\\product\\\\1738086563570-471061552.jpg\",\"uploads\\\\product\\\\1738086563572-886327059.jpg\",\"uploads\\\\product\\\\1738086563573-943134477.jpg\"]', '2025-01-28 17:49:23', '2025-02-05 09:01:36'),
(16, 'Bomber Jacket Spring Fall Casual Jackets', 'bomber-jacket-spring-fall-casual-jackets', 'XiaoYouYu Fabric: polyester; Lightweight, soft fabric for your comfort\nXiaoYouYu Design: 2 side pockets, 1 deep inner pocket\nXiaoYouYu Feature: ribbed collar, hem and cuffs, full zip, long sleeves for warmth and style\nXiaoYouYu Style: classic lightweight bomber jacket for men, easy to match, suitable for winter, autumn, spring.\nXiaoYouYu Occassion: not only suitable for daily wear, but also for work, street fashion, party and golf', '[\"Coffee\"]', 582000, 129, 4.4, 27, '[\"uploads\\\\product\\\\1738086698465-438763069.jpg\",\"uploads\\\\product\\\\1738086698466-502826930.jpg\",\"uploads\\\\product\\\\1738086698467-165358526.jpg\",\"uploads\\\\product\\\\1738086698468-676418546.jpg\"]', '2025-01-28 17:51:38', '2025-02-05 09:08:53'),
(17, 'Nike Golf Web Belt 3 Pack', 'nike-golf-web-belt-3-pack', '3 web straps one buckle\nOne size fits all up to 42\n2 percent zinc', '[\"Black\",\"White\",\"Cyber\",\"Grey\",\"Tan\"]', 546000, 8525, 3.6, 27, '[\"uploads\\\\product\\\\1738086958158-757258687.jpg\",\"uploads\\\\product\\\\1738086958159-250152.jpg\",\"uploads\\\\product\\\\1738086958161-649451185.jpg\"]', '2025-01-28 17:55:58', '2025-02-05 09:08:53'),
(18, 'Anrabess Open Front Knit Lightweight Cardigan', 'anrabess-open-front-knit-lightweight-cardigan', 'Size - XS=US(0-2),S=US(4-6),M=US(8-10),L=US(12-14),XL=US(16-18),XXL=US(20-22) ，see details in rich description.\nWash - Hand wash / Do Not Bleach / Dry Flat / Do not iron.\nFeatures - Open front. Pockets. Lapel Neckline. Knit fabric provides flexibility. Not lined.\nThis cardi is such a perfect choice for cozy days! Warm and soft material, you\'re sure to love wearing this gorgeous style all day long!You can easily throw this cardigan on over jeans and a top, a cute dress, or a romper for a stylish look!\nOccassion - Great for casual, daily, school, office, going out, holiday, vacation, street wear in any seasons especially in autumn and winter.', '[\"Beige\",\"Pink\",\"Off-white\",\"Black\"]', 808000, 195, 4.0, 28, '[\"uploads\\\\product\\\\1738109574071-230021311.jpg\",\"uploads\\\\product\\\\1738109574071-634091883.jpg\",\"uploads\\\\product\\\\1738109574071-914023333.jpg\",\"uploads\\\\product\\\\1738109574072-328142181.jpg\"]', '2025-01-29 00:12:54', '2025-02-05 09:01:36'),
(19, 'Iwollence High Waist Wide Pants', 'iwollence-high-waist-wide-pants', 'Breathable Material：100% Polyester. These wide-leg pants are for women that are not see-through, Super soft, Lightweight, flowy, and skin-friendly, Ensuring maximum comfort and coolness.\nStylish and comfortable： Wide Leg Lounge Pants with Pockets are a perfect combination of style and comfort, High-waisted design tie-knot provides ample coverage, and the adjustable tie-knot allows for maximum comfort and a customized fit. The method of these wide-leg pants makes them suitable for curvy women, those with thick calves and thighs, and many others.\nVersatile and practical： wide leg pants are ideal for a wide range of activities, including daily life, yoga, jogging, hiking, night out, outdoor activities, casual wear, home wear, streetwear, going out, vacation or beach wear, maternity， stylish looking for any occasion. The pockets offer added convenience for storing essentials like your phone, keys, or wallet.\nStandard US Size: S(4-6), M(8-10), L(12-14), XL(16-18),XXL(20-22). We strongly suggest that you take your body measurements first, and then please look at the size chart on our detail page before ordering.\nGarment Care： Both Machine Wash and Hand washable, These wide-leg pants please wash by hand or machine with cold water, and hang to dry. The material drapes in the most flattering way and you can easily get a chic look.', '[\"Black\"]', 289000, 8732, 4.0, 28, '[\"uploads\\\\product\\\\1738109854687-191854304.jpg\",\"uploads\\\\product\\\\1738109854688-782664499.jpg\"]', '2025-01-29 00:17:34', '2025-02-05 09:01:36'),
(20, 'OQQ Women 2 Piece Skirts', 'oqq-women-2-piece-skirts', 'Great stretchy fabric: 90% Nylon, 10% Spandex.Super soft and stretchy. Package content:2* Skirts\nSexy Mini Skirts, favorable mini length, wrap, high waist, simple in design,don’t see through, Best womens, ladies and teen girl clothes.\nSexy Mini Skirts, favorable mini length, wrap, high waist, simple in design,don’t see through, Best womens, ladies and teen girl clothes.\nSexy Mini Skirts, favorable mini length, wrap, high waist, simple in design,don’t see through, Best womens, ladies and teen girl clothes.\nGiving you confidence and support for any occasion.this seamless mini skirts will have you always on-trend, in the go out or at home.', '[\"Black\",\"Beige\",\"White\",\"Hide Pink\",\"Dark Grey\",\"Grey Blue\"]', 501000, 2153, 4.2, 28, '[\"uploads\\\\product\\\\1738110041837-496994081.jpg\",\"uploads\\\\product\\\\1738110041839-511136557.jpg\",\"uploads\\\\product\\\\1738110041840-296193327.jpg\"]', '2025-01-29 00:20:41', '2025-02-05 09:08:53'),
(21, 'FindThy Kawaii Long Sleeve Button Up Cardigan', 'findthy-kawaii-long-sleeve-button-up-cardigan', 'Button Closure\nV-neck, long sleeves, color block, separate bowknots, you can put it in anywhere you like\nCute cardigan with bowknots, button down long sleeved knit JK uniform sweater with pocket, pair with shirts, vest, jeans, skirts, flats, sneakers, jumpsuit, wide leg pants.\nClassic long-sleeve color blocking v neckline cable knitted cardigan sweaters, suitable for party, dates, club, work office, school, seaside, vacation, trips, leisure, picnic, a great gift for teens.\nAll items are US size. If you have any concern, please leave it in Customer Q&A, we will reply you ASAP', '[\"Pink\",\"Khaki\",\"Beige\"]', 517000, 291, 3.8, 28, '[\"uploads\\\\product\\\\1738110223791-506082807.jpg\",\"uploads\\\\product\\\\1738110223792-434898692.jpg\",\"uploads\\\\product\\\\1738110223794-110261077.jpg\"]', '2025-01-29 00:23:43', '2025-02-05 09:08:53'),
(22, 'Abaya Long Sleeve Button Down Shirt and Pants', 'abaya-long-sleeve-button-down-shirt-and-pants', 'Package Include: 1PC Shirt and 1PC Pants; Women\'s Muslim 2 Pieces Sets Long Sleeve Button Down Shirt and Pants Abaya Casual Dubai Outfits. Features: Long Sleeve, Turn-down Collar, Elastic Cuffs, Chest Pockets, Button Closure, Elastic Waistband, Loose Fit. The baggy material can ensure the comfort after hours of studying or working.\nMuslim Abaya Women Top Pants 2 Pieces Solid Color: The Middle East Arabic costume long sleeve top and wide leg pants for women, gives you a simple but elegant look to celebrate the Corban Festival. Long sleeve with elastic cuffs for an elegant and charming feeling. With a detachable belt which can be tied a bowknot at front or back to offer a flattering fit and show your slim waistline. Match wide leg pants with elastic waistband to complete the full look.\nThe Middle East Arabic Muslim Clothes For Women: Modest full length can offer a full coverage to the body, loose fit for a comfy wearing experience all day long. Long sleeve turn-down collar shirt, single-breasted buttons at front, shows the graceful and mature temperament. Long sleeve with elastic cuffs, can stay in place and won’t ride up easily by every move. Medium rise wide leg loose pants, with an elastic waistband, offers a flattering fit to the body.\nOccasions: Abaya turkey long top dress caftan kaftans islamic clothing abayas top wide leg pants two-piece muslim sets fit for Muslim costume, Eid Clothes, Corban Festival, Dubai Modest Robes, Church, Out going, Id al-Fitr, Tight Knot, Ramadan, Prayer, Family Gathering, School, home, office, sports, travel, holiday, ceremony, vacation or other occasions, also a great outfit to your sister, girlfriend or wife .\nFabric: Middle east arabic outfits for womens long sleeve top dress loose fit wide leg pants set dubai islamic muslim clothes made of selected fabric, the material is soft, comfortable and breathable to wear, no irritation to the delicate skin, won\'t deform after washing, offer a pleasant wearing experience to you. They can go well with a hijab to complete a modest look. The Arabic outfit is not only for Corban Festival, but also for casual daily wear.', '[\"Pink\",\"Khaki\",\"Black\"]', 711800, 2352, 3.8, 28, '[\"uploads\\\\product\\\\1738110511987-481833939.jpg\",\"uploads\\\\product\\\\1738110511989-696852783.jpg\",\"uploads\\\\product\\\\1738110511989-163773522.jpg\",\"uploads\\\\product\\\\1738110511990-531954894.jpg\"]', '2025-01-29 00:28:31', '2025-02-05 09:08:53'),
(23, 'LOVEVOOK Purses and Handbags', 'lovevook-purses-and-handbags', '【The Only Purses You\'ll Ever Need】 Our LOVEVOOK handbags serves as a shoulder bag, handbag, tote, and crossbody bag all in one. It\'s a multi-purpose accessory that transitions seamlessly from work to weekend.\n【Sized for Real Life】 Dimensions: 14.4*4.8*9.6 inches, the handle height of 7.5 inch.The adjustable shoulder strap can be extended up to 24.8 inches is perfect for carrying or slinging over your shoulder.\n【Quality You Can Feel】 Made from High-Quality PU Leather, our bags are not only fashionable but also durable.\n【Details That Make a Difference】 Utility doesn\'t sacrifice style. Our bags come with unique ornaments and a long removable shoulder strap, offering versatility and a touch of elegant lady charm.\n【Room for Everything】 1 external rear zippered pocket, 2 large compartment pockets, 2 internal zippered pockets, and 2 slip pockets, providing ample space to organize all your essentials.\n【Just the Right Fit for Your Day 】 Our bag comfortably holds your daily essentials like phones, cosmetics, and even a water bottle.', '[\"Brown\",\"Grey\",\"Green Beige\"]', 412000, 123, 4.0, 28, '[\"uploads\\\\product\\\\1738110819782-119423002.jpg\",\"uploads\\\\product\\\\1738110819783-418365835.jpg\",\"uploads\\\\product\\\\1738110819784-723430252.jpg\",\"uploads\\\\product\\\\1738110819784-972468277.jpg\"]', '2025-01-29 00:33:39', '2025-02-05 09:08:53'),
(24, 'CADANI 5-Pack Metal Plant Stands for Outdoor Indoor', 'cadani-5-pack-metal-plant-stands-for-outdoor-indoor', '【5-Pack】Package includes 5 metal plant stands for indoor and outdoor use. Each metal plant stand has different size to fit different sizes of flowerpots. and made of high-strength metal, not easily deformed. It is very suitable for heavy flower pots or other flower pots\n【Promoting Healthy Plant Growth】The varying heights not only create visual layers, enhancing the aesthetic and adding individuality to the space. but also ensure optimal light exposure for plants, which is beneficial for their healthy growth\n【Upgrade Design】The top of these planter stand designed with with guard rails which can prevent the pots from slipping. Very sturdy and stable, without tilting and tripping. flower pot placed on the potted plant stand as steady as they are on the ground\n【Anti-rust, Never Hurt the Floor】The plant stand is designed with a protective pad to prevent any scratches and wear on the floor. The surface of the plant shelf has an anti-rust coating. When you water the plant or place it in a humid environment, the iron plant stand will not rust and has a long service life\n【100% Money Back】This plant stand has a lifetime warranty. If you are not satisfied with this, please contact us. We\'ll process a refund or send you a replacement part, no returns or any strings attached. All issues will be resolved within 24 hours', '[\"Black\",\"Bronze\",\"White\"]', 379800, 2735, 3.6, 29, '[\"uploads\\\\product\\\\1738111039606-26591930.jpg\",\"uploads\\\\product\\\\1738111039607-412456225.jpg\",\"uploads\\\\product\\\\1738111039609-543777095.jpg\",\"uploads\\\\product\\\\1738111039612-645757113.jpg\"]', '2025-01-29 00:37:19', '2025-02-05 09:08:53'),
(25, 'Big Round Ottoman with Storage Set of 2 Multifunctional', 'big-round-ottoman-with-storage-set-of-2-multifunctional', '[ Larger Size, Larger Capacity] The velvet round ottoman with storage have 2 sizes: 17\"D x 17\"W x 18\"H (Larger) 15\"D x 15\"W x 15\"H(Small),the large size mean more confortable for sitting and much more storage space.This footrest stool is so stable that it can hold up to 300 pounds.\n【Ottoman with Hidden Storage】Tufted ottoman is designed with a large storage compartment. Super suitable for family room to stash child toys, magazines or blankets, it can make everything in well organized. Removable lid can be easy access to get or store items. It blends well with your decor, adding a chic and special storage in your home.\n【Unique craftsmanship】The Cream Storage Ottoman designed with luxurious and skin-friendly velvet fabric, filled with high density sponge making this ottoman very comfortable for sitting. Button tufted design embraces modern essential and classic style, creating a refined and high-end atmosphere for your home.\n【Versatile and Practical Footstool】The set of 2 ottoman round can not only be used to store your extra items, but also can be a footstool ottoman when you watching TV for bedroom, a stool when your friends come to have a coffee with you for living room, a vanity stool when you put on your makeup beside vanity table.\n【Easy to Set Up】Easy to put together.Easy to clean and maintain. If you have any question about footstool, please contact our professional after-sales team without hesitation and we will solve your problem timely.', '[\"Grey\",\"White\"]', 2085000, 175, 3.6, 29, '[\"uploads\\\\product\\\\1738111420542-546956019.jpg\",\"uploads\\\\product\\\\1738111420544-163938880.jpg\",\"uploads\\\\product\\\\1738111420544-890368852.jpg\",\"uploads\\\\product\\\\1738111420546-474416459.jpg\"]', '2025-01-29 00:43:40', '2025-02-05 09:08:53'),
(26, 'Famiware Milkyway Plates and Bowls Set 12 Pieces', 'famiware-milkyway-plates-and-bowls-set-12-pieces', '【WHAT WILL YOU GET?】This dinnerware set includes 4*10.25” dinner plates, 4*8” salad plates, 4*5.75” cereal bowls. This is a great combination for a family dinner party.\n【SCRATCH RESISTANT】Our glaze is fired at 2340℉ for 13.5 hours to form a strong scratch resistant surface. No need to worry about scratches from your forks or knives.\n【DISHWASHER AND MICROWAVE SAFE】Our dishes have passed microwave and dishwasher safe testing at internationally accredited laboratories. Each plate and bowl is 100% dishwasher safe and microwave safe.\n【LEAD FREE ALL NATURAL GLAZE】ALL our plates and bowls are made of lead-free glaze. You can safely use them to serve steaks, salads or desserts.\n【BEST CHOICE】Famiware dishes dinnerware sets are popular with young people with exquisite glaze and unique design. It\'s a great choice for housewarmings, holidays, weddings, and fun celebrations.\n【FUN SPECKLED DESIGN】These rounded dishes feature a minimalist design. Spruce up meal time with these neutral pieces that feature a brown speckled pattern, making each piece unique.\n【STACKABLE & EASY TO CLEAN】These dishes are stackable and don\'t take up a lot of space in your cupboard. Easy to clean, you can wash them with foam and water or place them into your dishwasher.\n【STONEWARE WITH ORGANIC CLAY】The organic clay not only giving you rich representation, but also provides stronger and more reliable stoneware, Our organic clay has optimal heat retention to keep your food hotter longer.\n【FAMIWARE\' S PROMISE】We promise to send you replacements if you receive some pieces that is damaged during shipping, simply send us a message on Amazon and our service is available daily to hear your request.', '[\"White\"]', 905900, 2375, 4.0, 29, '[\"uploads\\\\product\\\\1738111594624-691048575.jpg\",\"uploads\\\\product\\\\1738111594627-218569403.jpg\",\"uploads\\\\product\\\\1738111594627-2971474.jpg\",\"uploads\\\\product\\\\1738111594629-771311873.jpg\"]', '2025-01-29 00:46:34', '2025-02-05 09:01:36'),
(27, 'Ultra Sharp High Carbon Powder Steel Knife Block Set 16 Pieces', 'ultra-sharp-high-carbon-powder-steel-knife-block-set-16-pieces', '【All-In-One Knife Set】This comprehensive 16-piece set includes an 8 inch chef knife, 7 inch santoku knife, 8 inch slicing knife, 8 inch bread knife, 7 inch fillet knife, 6 inch utility knife, 3.75 inch paring knife, six 4.5 inch steak knives, all-purpose scissors, and an acacia-wrapped block, ensuring you are well-equipped for any culinary task\n【Premium Powder Steel】Stamped from rust proof and tarnish resistant high carbon steel, this complete knife set show a superior durability, and high quality that make them rust-resistance, ensuring long lasting cutting performance over time; HRC 60±2 Rockwell hardness makes it one of the toughest knife sets in its class\n【Ultra Sharp Blades】 With a signature 15-degree tapered, hand-ground edge, each high-carbon blade provides maximum sharpness and alignment to cut, chop, julienne, slice, dice and more with ease and precision; A wide range of sharp blade shapes and gadgets to deal with a variety of food such as meat, vegetable, fruit, bread, fish as so on\n【Ergonomic Wood Handle】Blade is seamlessly riveted into the handle which makes it more strength; The pakkawood handle with streamlined ergonomical design is easy to grip, making long sessions of food prep virtually effortless and fatigue-free for fingers, wrists and forearms while adding aesthetic value to the knife set\n【Easy Cleaning & Convenient Storage】We recommend you to handwash the knife set to maintain sharpness and expand its service life; Coming with a wooden block, all knives can be stored safely and orderly. And the ventilated design is good for air circulation to keep knives dry; Note: This is not a Damascus Kitchen Knife Set', '[]', 4850000, 127, 3.6, 29, '[\"uploads\\\\product\\\\1738111733650-579622188.jpg\",\"uploads\\\\product\\\\1738111733653-509352902.jpg\",\"uploads\\\\product\\\\1738111733655-614440268.jpg\"]', '2025-01-29 00:48:53', '2025-02-05 09:08:53'),
(28, 'DULLEMELO Storage Cubes 12 inch 4 Pack', 'dullemelo-storage-cubes-12-inch-4-pack', '【Unique Design & Modern & Decorative】Set of 4 , dimensions(each): 12(L) x 12(W) x 12(H) inches. Home organization Baskets bring you organizing convenience and a sweet home. The fabric baskets with neutral colors can match many home styles - keeping your home nice and tidy.\n【Material】These cube storage bins are constructed of sturdy and attractive linen & cardboard with linen interior lining. The sturdy leather handles make it easy to carry or pull off and out of shelves.\n【Care】Please wipe away stains with a dry cloth and make it dry for daily care; DO NOT wash the products. There may be a light smell when the package is opened first; please put products in a well-ventilated place for several hours.\n【Collapsible Baskets】These fabric cube storage boxes are foldable for easy storage if not in use. Great for socks, underwear, books, magazines, toys, pet products, wipes, towels, decorations, office supplies, DVDs, and gifts.\n【100% Customer Satisfaction】We provide customers with premium quality products and services, and you can buy confidently. If you have any concerns or suggestions about the foldable fabric storage bins, please contact us at any time.\nKINDLY NOTE: Size manual measurement may cause a 1-2cm error. Please determine the size you need before you buy.', '[\"White/Grey\",\"Beige\",\"White/Green\"]', 580000, 2385, 4.6, 29, '[\"uploads\\\\product\\\\1738112019208-393845616.jpg\",\"uploads\\\\product\\\\1738112019211-547199066.jpg\",\"uploads\\\\product\\\\1738112019213-521378807.jpg\",\"uploads\\\\product\\\\1738112019216-369862478.jpg\",\"uploads\\\\product\\\\1738112019227-732617542.jpg\"]', '2025-01-29 00:53:39', '2025-02-05 09:08:53'),
(29, 'MooMee Bedding Duvet Cover Set Extra Long', 'moomee-bedding-duvet-cover-set-extra-long', 'Material: Made of 100% long-staple cotton for durability, softness, and a more luxurious feel for longer. Sateen weave is exclusively made of high-quality 600 thread count which creates a lustrous, durable fabric like Egyptian cotton.\nStylish: It\'s silky to the touch with a slight sheen. Simple solid light gray is most easily comparable to any color of your room decor. Great for everyday use, this duvet cover set offers smooth and soft comfort–all year-round.\nAwesome Details: Duvet Cover has a hidden zip closure barely noticeable; 8 interior corner ties to keep duvet/comforter in place; Pillow Cases have envelope end to tuck the pillow inside.\nKing Size Duvet Cover Set Package Includes: Duvet Cover (1 piece): 104 in. x 90 in.; Pillow Cases (Standard 2 pieces): 20 in. x 36 in.; Duvet/comforter inside is not included.\nEasy Care: Machine wash cold, gentle cycle only, using mild, liquid Laundry Detergent. Do not bleach. Iron on low heat if needed. Tumble dry low. Note: Do not overload washer and dryer.', '[\"Light Grey\"]', 1164000, 1864, 3.6, 29, '[\"uploads\\\\product\\\\1738112303264-23346410.jpg\",\"uploads\\\\product\\\\1738112303267-581898232.jpg\",\"uploads\\\\product\\\\1738112303269-819527179.jpg\"]', '2025-01-29 00:58:23', '2025-02-05 09:08:53'),
(30, 'Superior Egyptian Cotton Pile Bath Towel Set of 2', 'superior-egyptian-cotton-pile-bath-towel-set-of-2', 'Egyptian Cotton Pile\n𝐎𝐏𝐔𝐋𝐄𝐍𝐓 𝐂𝐎𝐌𝐅𝐎𝐑𝐓: These towels are crafted from Egyptian Cotton pile fibers that are naturally strong, absorbent, and soft; heavyweight and plush; Set includes: 2 Bath Towels (55\"L x 30\"W)\n𝐌𝐎𝐃𝐄𝐑𝐍 𝐃𝐄𝐒𝐈𝐆𝐍: State-of-the-art design is fashionable, elegant and classy; rope border for added texture and style; this beautiful bundle is perfect for any master bath, powder room, or guest bathroom; loop for easy hanging and drying\n𝐃𝐄𝐋𝐈𝐆𝐇𝐓𝐅𝐔𝐋 𝐂𝐎𝐋𝐎𝐑𝐒: Black, Chocolate Dark Brown, Charcoal, Cream, Forest Green, Latte Brown, Light Blue, Navy Blue, Plum, Purple, Red, Orange Rust, Seafoam, Stone Grey, Teal, Toast, Tea Rose Pink, White, Coral, Denim Blue, Silver, and Turquoise\n𝐄𝐅𝐅𝐎𝐑𝐓𝐋𝐄𝐒𝐒 𝐂𝐀𝐑𝐄: For the most luxurious results, we recommend to wash with like colors, tumble dry low, and remove promptly from the dryer. Please follow care label instructions for best results\n𝐄𝐗𝐂𝐄𝐋𝐋𝐄𝐍𝐓 𝐆𝐈𝐅𝐓: Our designs match a variety of styles and make great gifts; perfect for friends and family; we\'re committed to make products safer for you and safer for the world; this product is OEKO-TEX certified for safety and sustainability', '[]', 718000, 2783, 4.0, 29, '[\"uploads\\\\product\\\\1738112424863-748716471.jpg\",\"uploads\\\\product\\\\1738112424864-276541967.jpg\",\"uploads\\\\product\\\\1738112424866-318938215.jpg\"]', '2025-01-29 01:00:24', '2025-02-05 09:08:53'),
(31, 'MPLONG Abstract Natural Geometric Wall Art Set of 3', 'mplong-abstract-natural-geometric-wall-art-set-of-3', '[High-quality material] High-definition pictures and photos printed with high-quality framed environmentally friendly canvas\n[Wide application] Perfect wall art decoration choice for any environment: living room, bedroom, bathroom, hotel, kitchen, bar, office\n[Easy to hang] There is an inner slot on the back of the PS material frame, which can be directly hung with nails (with a pendant kit)\n[Note] Due to different monitor brands, the actual color may be slightly different from the store picture. If you have any questions, you can send us an email.', '[\"16*24 inches\",\"20*28 inches\",\"24*32 inches\"]', 1115000, 1256, 3.8, 29, '[\"uploads\\\\product\\\\1738112774153-981028190.jpg\",\"uploads\\\\product\\\\1738112774154-690845740.jpg\",\"uploads\\\\product\\\\1738112774155-708149075.jpg\",\"uploads\\\\product\\\\1738112774157-239093449.jpg\",\"uploads\\\\product\\\\1738112774159-65483284.jpg\"]', '2025-01-29 01:06:14', '2025-02-05 09:08:53'),
(32, 'Revenge of the Tipping Point: Overstories, Superspreaders, and the Rise of Social Engineering', 'revenge-of-the-tipping-point-overstories-superspreaders-and-the-rise-of-social-engineering', 'AN INSTANT NEW YORK TIMES BESTSELLER\n\nMost Anticipated in:\nAARP | Associated Press | Time Magazine | Oprah Daily | Chicago Tribune | Literary Hub |\nPublishers Weekly | Publishers Lunch\nTwenty-five years after the publication of his groundbreaking first book, Malcolm Gladwell returns with a brand-new volume that reframes the lessons of The Tipping Point in a startling and revealing light.\n\nWhy is Miami…Miami? What does the heartbreaking fate of the cheetah tell us about the way we raise our children? Why do Ivy League schools care so much about sports? What is the Magic Third, and what does it mean for racial harmony? In this provocative new work, Malcolm Gladwell returns for the first time in twenty-five years to the subject of social epidemics and tipping points, this time with the aim of explaining the dark side of contagious phenomena.\n \nThrough a series of riveting stories, Gladwell traces the rise of a new and troubling form of social engineering. He takes us to the streets of Los Angeles to meet the world’s most successful bank robbers, rediscovers a forgotten television show from the 1970s that changed the world, visits the site of a historic experiment on a tiny cul-de-sac in northern California, and offers an alternate history of two of the biggest epidemics of our day: COVID and the opioid crisis. Revenge of the Tipping Point is Gladwell’s most personal book yet. With his characteristic mix of storytelling and social science, he offers a guide to making sense of the contagions of modern world. It’s time we took tipping points seriously.', '[]', 260000, 1245, 4.6, 30, '[\"uploads\\\\product\\\\1738207777403-949190267.jpg\"]', '2025-01-30 03:29:37', '2025-02-05 09:08:53'),
(33, 'Nexus: A Brief History of Information Networks from the Stone Age to AI', 'nexus-a-brief-history-of-information-networks-from-the-stone-age-to-ai', '#1 NEW YORK TIMES BESTSELLER • From the author of Sapiens comes the groundbreaking story of how information networks have made, and unmade, our world.\n\n“Striking original . . . A historian whose arguments operate on the scale of millennia has managed to capture the zeitgeist perfectly.”—The Economist\n\n“This deeply important book comes at a critical time as we all think through the implications of AI and automated content production. . . . Masterful and provocative.”—Mustafa Suleyman, author of The Coming Wave\n\nFor the last 100,000 years, we Sapiens have accumulated enormous power. But despite allour discoveries, inventions, and conquests, we now find ourselves in an existential crisis. The world is on the verge of ecological collapse. Misinformation abounds. And we are rushing headlong into the age of AI—a new information network that threatens to annihilate us. For all that we have accomplished, why are we so self-destructive?\n\nNexus looks through the long lens of human history to consider how the flow of information has shaped us, and our world. Taking us from the Stone Age, through the canonization of the Bible, early modern witch-hunts, Stalinism, Nazism, and the resurgence of populism today, Yuval Noah Harari asks us to consider the complex relationship between information and truth, bureaucracy and mythology, wisdom and power. He explores how different societies and political systems throughout history have wielded information to achieve their goals, for good and ill. And he addresses the urgent choices we face as non-human intelligence threatens our very existence.\n \nInformation is not the raw material of truth; neither is it a mere weapon. Nexus explores the hopeful middle ground between these extremes, and in doing so, rediscovers our shared humanity.', '[]', 48000, 4363, 4.0, 30, '[\"uploads\\\\product\\\\1738207847669-954907179.jpg\"]', '2025-01-30 03:30:47', '2025-02-05 09:01:36'),
(34, 'Supercommunicators: How to Unlock the Secret Language of Connection', 'supercommunicators-how-to-unlock-the-secret-language-of-connection', 'NEW YORK TIMES BESTSELLER • From the author of The Power of Habit, a fascinating exploration of what makes conversations work—and how we can all learn to be supercommunicators at work and in life\n\n“A winning combination of stories, studies, and guidance that might well transform the worst communicators you know into some of the best.”—Adam Grant, author of Think Again and Hidden Potential\n\nONE OF NPR’S BEST BOOKS OF THE YEAR • FINALIST FOR THE SABEW BEST IN BUSINESS BOOK AWARD\n\nCome inside a jury room as one juror leads a starkly divided room to consensus. Join a young CIA officer as he recruits a reluctant foreign agent. And sit with an accomplished surgeon as he tries, and fails, to convince yet another cancer patient to opt for the less risky course of treatment. In Supercommunicators, Charles Duhigg blends deep research and his trademark storytelling skills to show how we can all learn to identify and leverage the hidden layers that lurk beneath every conversation.\n\nCommunication is a superpower and the best communicators understand that whenever we speak, we’re actually participating in one of three conversations: practical (What’s this really about?), emotional (How do we feel?), and social (Who are we?). If you don’t know what kind of conversation you’re having, you’re unlikely to connect. \n\nSupercommunicators know the importance of recognizing—and then matching—each kind of conversation, and how to hear the complex emotions, subtle negotiations, and deeply held beliefs that color so much of what we say and how we listen. Our experiences, our values, our emotional lives—and how we see ourselves, and others—shape every discussion, from who will pick up the kids to how we want to be treated at work. In this book, you will learn why some people are able to make themselves heard, and to hear others, so clearly.\n\nWith his storytelling that takes us from the writers’ room of The Big Bang Theory to the couches of leading marriage counselors, Duhigg shows readers how to recognize these three conversations—and teaches us the tips and skills we need to navigate them more successfully.\n\nIn the end, he delivers a simple but powerful lesson: With the right tools, we can connect with anyone.', '[]', 242000, 2352, 4.4, 30, '[\"uploads\\\\product\\\\1738207914219-736164538.jpg\"]', '2025-01-30 03:31:54', '2025-02-05 09:08:53'),
(35, 'Selling the Dream: The Billion-Dollar Industry Bankrupting Americans', 'selling-the-dream-the-billion-dollar-industry-bankrupting-americans', 'Peabody and Emmy Award–winning journalist Jane Marie expands on her popular podcastThe Dreamto expose the scourge of multilevel marketing schemes and how they have profited off the evisceration of the American working class.\n\nWe’ve all heard of Amway, Mary Kay, Tupperware, and LuLaRoe, but few know the nefarious way they, and countless other multilevel marketing (MLM) companies, prey on desperate Americans struggling to make ends meet.\n\nWhen factories close, stalwart industries shutter, and blue-collar opportunities evaporate, MLMs are there, ready to pounce on the crumbling American Dream. MLMs thrive in rural areas and on military bases, targeting women with promises of being their own boss and millions of dollars in easy income—even at the risk of their entire life savings. But the vast majority—99.7%—of those who join an MLM make no money or lose money, and wind up stuck with inventory they can’t sell to recoup their losses.\n\nSelling the Dream “is an urgent and riveting exposé” (Publishers Weekly, starred review) that reveals how these companies—often owned by political and corporate elites, such as the DeVos and the Van Andel families—have made a windfall in profit off of the desperation of the American working class.', '[]', 242000, 1266, 3.8, 30, '[\"uploads\\\\product\\\\1738207963769-128938366.jpg\"]', '2025-01-30 03:32:43', '2025-02-05 09:08:53'),
(36, 'Feel-Good Productivity: How to Do More of What Matters to You', 'feel-good-productivity-how-to-do-more-of-what-matters-to-you', 'The secret to productivity isn’t discipline. It’s joy.\n\nWe think that productivity is all about hard work. That the road to success is lined with endless frustration and toil. But what if there’s another way?\n\nDr Ali Abdaal – the world\'s most-followed productivity expert – has uncovered an easier and happier path to success. Drawing on decades of psychological research, he has found that the secret to productivity and success isn\'t grind – it\'s feeling good. If you can make your work feel good, then productivity takes care of itself.\n\nIn this revolutionary book, Ali reveals how the science of feel-good productivity can transform your life. He introduces the three hidden \'energisers\' that underpin enjoyable productivity, the three \'blockers\' we must overcome to beat procrastination, and the three \'sustainers\' that prevent burnout and help us achieve lasting fulfillment. He recounts the inspiring stories of founders, Olympians, and Nobel-winning scientists who embody the principles of Feel-Good Productivity. And he introduces the simple, actionable changes that you can use to achieve more and live better, starting today.\n\nArmed with Ali’s insights, you won’t just accomplish more. You’ll feel happier and more fulfilled along the way.', '[]', 242000, 1267, 4.0, 30, '[\"uploads\\\\product\\\\1738208007924-931160623.jpg\"]', '2025-01-30 03:33:27', '2025-02-05 09:01:36'),
(37, 'The Algebra of Wealth: A Simple Formula for Financial Security', 'the-algebra-of-wealth-a-simple-formula-for-financial-security', 'AN INSTANT #1 NEW YORK TIMES BESTSELLER\n\nA must-have guide to optimizing your life for wealth and success, from bestselling author, NYU professor, and cohost of the Pivot podcast Scott Galloway.\n\nToday’s workers have more opportunities and mobility than any generation before. They also face unprecedented challenges, including inflation, labor and housing shortages, and climate volatility. Even the notion of retirement is undergoing a profound rethink, as our lifespans extend and our relationship with work evolves. In this environment, the tried-and-true financial advice our parents followed is no longer enough. It’s time for a new playbook.\n\nIn The Algebra of Wealth, Scott Galloway lays bare the rules of financial success in today’s economy. In his characteristic unvarnished, no-BS style, he explains what you need to know in order to better your chances for economic security no matter what. You’ll learn:\n\nHow to find and follow your talent, not your passion, when making career decisions\nHow to ride and optimize big economic waves (hard truth: market dynamics always trump individual achievement)\nWhat small steps you can take that pay big returns later, including diversification and tax planning\nHow stoicism can help you minimize spending and develop better financial habits\n\nBrimming with wise, game-changing advice from one of the world’s most popular business school professors, The Algebra of Wealth offers a powerful framework for making the most of what opportunities come your way.', '[]', 274000, 5489, 4.4, 30, '[\"uploads\\\\product\\\\1738208064319-356645892.jpg\"]', '2025-01-30 03:34:24', '2025-02-05 09:08:53'),
(38, 'The Myth of Making It: A Workplace Reckoning', 'the-myth-of-making-it-a-workplace-reckoning', 'We can bury the girlboss, but what comes next? The former executive editor of Teen Vogue tells the story of her personal workplace reckoning and argues for collective responsibility to reimagine work as we know it.\n\n“One of the smartest voices we have on gender, power, capitalist exploitation, and the entrenched inequities of the workplace.”—Rebecca Traister, author of Good and Mad\n\n“As I sat in the front row that day, I was 80 percent faking it with a 100-percent-real Gucci bag.” Samhita Mukhopadhyay had finally made it: she had her dream job, dream clothes—dream life. But time and time again, she found herself sacrificing time with family and friends, paying too much for lattes, and limping home after working twelve hours a day. Success didn’t come without costs, right? Or so she kept telling herself. And Mukhopadhyay wasn’t alone: Far too many of us are taught that we need to work ourselves to the bone to live a good life. That we just need to climb up the corporate ladder, to “lean in” and “hustle,” to enact change. But as Mukhopadhyay shows, these definitions of success are myths—and they are seductive ones.\n\nMukhopadhyay traces the origins of these myths, taking us from the sixties to the present. She forms a critical overview of workplace feminism, looking at stories from her own professional career, analysis from activists and experts, and of course, experiences of workers at different levels. As more individuals continue to question whether their professional ambitions can lead to happiness and fulfillment in the first place, Mukhopadhyay asks, What would it mean to have a liberated workplace? Mukhopadhyay emerges with a vision for a workplace culture that pays fairly, recognizes our values, and gives people access to the resources they need.\n\nAcall to action to redefine and reimagine work as we know it, The Myth of Making It is a field guide and manifesto for all of us who are tired, searching for justice, and longing to be liberated from the oppressive grip of hustle culture.', '[]', 226000, 1289, 3.8, 30, '[\"uploads\\\\product\\\\1738208119257-226296014.jpg\"]', '2025-01-30 03:35:19', '2025-02-05 09:08:53');
INSERT INTO `products` (`id`, `name`, `slug`, `description`, `variant`, `price`, `stock`, `rating`, `category_id`, `img_urls`, `created_at`, `updated_at`) VALUES
(39, 'Slow Productivity: The Lost Art of Accomplishment Without Burnout', 'slow-productivity-the-lost-art-of-accomplishment-without-burnout', 'A New York Times, Washington Post, USA Today, and IndieBound bestseller\n\n\n\"Brilliant and timely\" — Oliver Burkeman\n\n\n~ Do Fewer Things. Work at a Natural Pace. Obsess over Quality. ~\n\nFrom the New York Times bestselling author of Digital Minimalism and Deep Work, a groundbreaking philosophy for pursuing meaningful accomplishment while avoiding overload\n\nOur current definition of “productivity” is broken. It pushes us to treat busyness as a proxy for useful effort, leading to impossibly lengthy task lists and ceaseless meetings. We’re overwhelmed by all we have to do and on the edge of  burnout, left to decide between giving into soul-sapping hustle culture or rejecting ambition altogether. But are these really our only choices?\n\nLong before the arrival of pinging inboxes and clogged schedules, history’s most creative and impactful philosophers, scientists, artists, and writers mastered the art of producing valuable work with staying power. In this timely and provocative book, Cal Newport harnesses the wisdom of these traditional knowledge workers to radically transform our modern jobs. Drawing from deep research on the habits and mindsets of a varied cast of storied thinkers – from Galileo and Isaac Newton, to Jane Austen and Georgia O’Keefe – Newport lays out the key principles of “slow productivity,” a more sustainable alternative to the aimless overwhelm that defines our current moment. Combining cultural criticism with systematic pragmatism, Newport deconstructs the absurdities inherent in standard notions of productivity, and then provides step-by-step advice for cultivating a slower, more humane alternative.\n\nFrom the aggressive rethinking of workload management, to introducing seasonal variation, to shifting your performance toward long-term quality, Slow Productivity provides a roadmap for escaping overload and arriving instead at a more timeless approach to pursuing meaningful accomplishment. The world of work is due for a new revolution. Slow productivity is exactly what we need.', '[]', 242000, 3263, 3.6, 30, '[\"uploads\\\\product\\\\1738208171994-910663193.jpg\"]', '2025-01-30 03:36:12', '2025-02-05 09:08:53'),
(40, 'The Third Perspective: Brave Expression in the Age of Intolerance', 'the-third-perspective-brave-expression-in-the-age-of-intolerance', 'In our deeply divided, binary world, honest discussion is stressful for all sides. International thought leader Africa Brooke says there is another way: the Third Perspective. \n\nIn this manifesto, Africa teaches us how to return to critical thinking and reduce societal divides by opening our minds and being more self-questioning in difficult discussions. This book will help you figure out what you truly believe—as opposed to parroting or having knee-jerk reactions in conversation. You’ll learn to share your views, hear theirs, make a point you feel must be made, and try to find common ground without self-censorship or self-sabotage.\n\nThis personal guide helps readers move away from rigid thinking, allowing them to enter any potentially difficult discussion about politics, work, personal responsibility, race, sex, gender, religion — whatever the subject — while maintaining integrity, authenticity, and openness, and successfully expressing opinions while listening to contrary points of view. \n\nAfrica has built a successful business coaching an exclusive roster of high-profile clients seeking to handle themselves in the public eye. The tools offered in The Third Perspective have been honed over years of that experience: hers is a proven system that works. She offers readers a new path for communication, and because communication is everything, critical to building trust and fruitful relationships, a life transforming experience.  \n\nAfrica Brooke’s framework has three pillars—Awareness, Responsibility, and Expression—that ask: what is stopping you from speaking your mind, what do you stand for, what are you willing to risk?', '[]', 258000, 1237, 4.4, 30, '[\"uploads\\\\product\\\\1738208220871-107634758.jpg\"]', '2025-01-30 03:37:00', '2025-02-05 09:08:53'),
(41, 'On the Edge: The Art of Risking Everything', 'on-the-edge-the-art-of-risking-everything', 'The Instant New York Times Bestseller\n\n“Engaging and entertaining… a glimpse of the economy of the future.” —Tim Wu, New York Times Book Review\n\nFrom the New York Times bestselling author of The Signal and the Noise,the definitive guide to our era of risk—and the players raising the stakes\n \nIn the bestselling The Signal and the Noise, Nate Silver showed how forecasting would define the age of Big Data. Now, in this timely and riveting new book, Silver investigates “the River,” the community of like-minded people whose mastery of risk allows them to shape—and dominate—so much of modern life.\n\nThese professional risk-takers—poker players and hedge fund managers, crypto true believers and blue-chip art collectors—can teach us much about navigating the uncertainty of the twenty-first century. By immersing himself in the worlds of Doyle Brunson, Peter Thiel, Sam Bankman-Fried, Sam Altman, and many others, Silver offers insight into a range of issues that affect us all, from the frontiers of finance to the future of AI.\n\nMost of us don’t have traits commonly found in the River: high tolerance for risk, appreciation of uncertainty, affinity for numbers—paired with an instinctive distrust of conventional wisdom and a competitive drive so intense it can border on irrational. For those in the River, complexity is baked in, and the work is how to navigate it. People in the River have increasing amounts of wealth and power in our society, and understanding their mindset—and the flaws in their thinking— is key to understanding what drives technology and the global economy today.\n\nTaking us behind the scenes from casinos to venture capital firms, and from the FTX inner sanctum to meetings of the effective altruism movement, On the Edge is a deeply reported, all-access journey into a hidden world of power bro­kers and risk-takers.', '[]', 307000, 3458, 4.0, 30, '[\"uploads\\\\product\\\\1738208297301-852740664.jpg\"]', '2025-01-30 03:38:17', '2025-02-05 09:01:36'),
(42, 'Versa-Brella UPF 50+ Personal Sun Shade - Portable Umbrella', 'versa-brella-upf-50-personal-sun-shade---portable-umbrella', 'STAY SHADED ANYWHERE: The Versa-Brella features a heavy-duty clamp that opens up to 1.5 inches, allowing it to securely attach to various tubular and squared surfaces on chairs, wagons, strollers, golf carts, and more\nSUPERIOR SUN PROTECTION: Made with UPF 50+ material, this personal compact sports umbrella shields your skin from 99.5% of UV rays during outdoor activities\nMAXIMUM SHADE: When open, the Versa-Brella spans 38 x 39 inches, providing a generous 10 square feet of shade to keep you comfortable and protected\nADJUSTABLE SUN BLOCKING: The Versa-Brella portable umbrella features a 4-way, 360-degree swivel and two push-button hinges that enable you to adjust the angle and position of the sun shade to block the sun from any angle for tailored solar protection\nCOMPACT & PORTABLE: Weighing only 1.8 pounds and folding down to 35.04 x 3.35 inches, this outdoor umbrella comes in its own carrying case with built in sling handle, making it easy to take with you anywhere and store when not in use\nSAFE & USER FRIENDLY: Featuring protective safety tips on the umbrella\'s edges for added eye protection, the Versa-Brella is safer and easier to set up than bulky, traditional umbrellas', '[\"Regular\",\"Large\"]', 452000, 1274, 4.2, 31, '[\"uploads\\\\product\\\\1738208555269-243673920.jpg\",\"uploads\\\\product\\\\1738208555272-962946185.jpg\",\"uploads\\\\product\\\\1738208555273-135196557.jpg\",\"uploads\\\\product\\\\1738208555274-771817454.jpg\"]', '2025-01-30 03:42:35', '2025-02-05 09:08:53'),
(43, 'Franklin Sports Badminton Net Sets', 'franklin-sports-badminton-net-sets', 'FUN FOR EVERYONE: This go-to, complete badminton set is a perfect gift for the whole family that can be enjoyed by all ages for unforgettable outdoor fun\nEASY TO ASSEMBLE NET: The net is 20\' x 1.5\' long and stands 5\' tall so you can easily fit many players at once\nALL IN ONE SET: This set comes with (4) steel badminton rackets, (2) nylon birdies, (6) stakes and guy ropes\nPORTABLE: This set comes with a carrying box designed to store and transport all the components of the set with ease so you can bring this set to the beach, the park, or anywhere else\nFAMILY FUN: Create memories with family and friends that will last a lifetime with this complete badminton set from Franklin Sports', '[]', 493000, 458, 4.2, 31, '[\"uploads\\\\product\\\\1738208710763-30281291.jpg\",\"uploads\\\\product\\\\1738208710765-546881355.jpg\",\"uploads\\\\product\\\\1738208710767-295604915.jpg\"]', '2025-01-30 03:45:10', '2025-02-05 09:08:53'),
(44, 'Sportneer Heated Chairs Outdoor Sports', 'sportneer-heated-chairs-outdoor-sports', 'Benefits of a Heated Camping Chair for Adult: Three levels of adjustable heat: HIGH: 140°F / MID: 122°F / LOW: 104°F. The adjustable heat will help you focus and enjoy rather than being uncomfortable and cold. With warmth and comfort instituted into the chair, you will not have to carry extra necessities like blankets or portable heaters.\nBest Heated Camping Chair for You: The heated chair outdoor sports features USB-powered heating technology (portable USB battery not included). The heat safely penetrates the body to relax and warm your muscles at any outdoor sports, beach, or camping activities. A simple push of a button can warm up your seat up to 104-140°F degrees Fahrenheit. Works with ANY USB battery pack and lasts for hours. Simply plug the USB cable into the USB Port of your battery and feel the warmth!\nA Heated Camping Chairs for Four Seasons: You can use the heating function in winter or use it as a regular folding chair in summer. Built to last, the portable camp heated chair outdoor sports is constructed with heavy-duty 7075 aluminum alloy and 900D Oxford cloth.The load capacity of this robust portable camping heated chair is up to 330 lbs. To keep your small accessories well organized, each backpacking chair is designed with 2 side pockets.\nEffortless Setup and Cleaning: With foldable Oxford cloth and metal poles, setup has never been easier - no handyman skills required! After installing the portable heated chair outdoor sports, you only need to put the mobile power supply in the right pocket, connect it to the USB interface, press the button, and the bottom of the heated camping chairs will start to heat. The maximum temperature does not exceed 140°F, protecting your safety at all times.\nUltralight & Compact: When you\'re going camping, hiking or beach, you need all the convenience you can get! The Sportneer camping chair with heater only weighs 3.75lbs and can be folded into a 14\" * 5.9\" * 6.1\" one, making it easy to bring along. Plus, with a robust weight capacity of up to 330 lbs, it\'s perfect for all outdoor enthusiasts.', '[]', 937000, 237, 4.4, 31, '[\"uploads\\\\product\\\\1738208835423-162610522.jpg\",\"uploads\\\\product\\\\1738208835426-679544069.jpg\",\"uploads\\\\product\\\\1738208835427-669665239.jpg\",\"uploads\\\\product\\\\1738208835429-161081694.jpg\",\"uploads\\\\product\\\\1738208835435-335962633.jpg\"]', '2025-01-30 03:47:15', '2025-02-05 09:08:53'),
(45, 'Pickleball Paddles Set of 2', 'pickleball-paddles-set-of-2', '【FIBERGLASS MATERIALS】Our paddles are built with a honeycomb polymer core and are optimally balanced to be lightweight and durable. Each paddle weighs 7.5- 7.9 oz. The soft, comfortable grip along with a light fiberglass surface provides a nice bounce and reduces ball deflection, which improves pitching performance and strikes the perfect balance between great gameplay, controls\n【FULL CONTROL COMFORTABLE GRIP】 The grip is designed with soft material and sweat-wicking ventilation holes, anti-slip, abrasion-resistant, and durable one-piece grip you will never get fatigued after longtime play, meanwhile minimizing slippage to give you the perfect wrist movement and flexible rotation\n【LIGHTWEIGHT WITH EDGE GUARD PROTECTION】Less stress on your elbow/shoulder and provide better maneuverability. The overlapping edge guard maintains the integrity of the paddle and provides a covering to the interior, avoiding the risk of delaminating. It can withstand multiple strikes from the ball\n【USAPA APPROVED】 YC DGYCASI pickleball paddle is tested and approved by USAPA for pickleball championship. Each paddle is manufactured strictly according to USAPA standards, and carries a USAPA approval label\n【CHOOSE FAVORITE PADDLE】Our pickleball paddle set has vibrant sporty colors. The paddles surface area of 15.7”x 7.8” and gives the paddle a logo sweet spot for better control in every hit. At the same time, our pickleball paddle is also an ideal gift for family or friends\n【PICKLEBALL SET】 This pickleball set of unbeatable value includes 2 fiberglass pickleball paddles, 2 outdoor pickleball balls, 2 indoor pickleball balls, 1 pickleball bag to accommodate this pickleball paddles set of 2 with all your essential pickleball accessories\n【AFTER-SALES SERVICE】 YC DGYCASI every pickleball paddle is backed by superior quality and under strict quality inspection. Our pickleball paddle is one of the better choices of choice for men or women. If you have any questions, rest easy, knowing we’ve got your back through it all', '[]', 484000, 154, 4.0, 31, '[\"uploads\\\\product\\\\1738208940886-736933322.jpg\",\"uploads\\\\product\\\\1738208940889-76051828.jpg\",\"uploads\\\\product\\\\1738208940890-147666042.jpg\",\"uploads\\\\product\\\\1738208940891-382560651.jpg\"]', '2025-01-30 03:49:00', '2025-02-05 09:01:36'),
(46, 'Hiking Backpack Large 35L', 'hiking-backpack-large-35l', 'Premium & Durable：BAGPARKK lightweight hiking backpack is made of high-quality tear and water resistant nylon fabric,Two-way metal zippers and the extra strength provided by double-layer bottom piece and enhanced by bar-tacks at major stress points provide long-lasting durability against daily activities.\nFoldable & Lightweight：The Foldable backpack weighs only 0.88 pounds and can be easily folded into a small one for storage. The folded size is only 7 * 6* 2inch, which is not bigger than a book and takes very small space.To avoid overweight charge, simply unfold from your checked bags and use it as a carry on for your excess baggage.\nMultipurpose：This large capacity backpack provides enough space for outdoor travel, camping, hiking, day trips and shopping. The main pocket is Large enough to hold books and clothes. An inner zippered pocket is a perfect place for travel essentials such as cash, credit cards, and passport. Two large sides mesh pockets for water bottles or umbrella.\nElaborate Design：Breathable mesh shoulder straps with plentiful sponge padding help relieve the stress from your shoulder. The camping backpack is printed with reflective signs。And chest buckle designed as a survival whistle for quick and easy use in case of emergency.The sides of the backpack have elastic that can hold two sets of trekking sticks or adjust the webbing according to needs. A must have for sports , hiking and camping.Fit for men and women.\nPurchase Tips： If you have any questions or concerns, don\'t hesitate to contact us for assistance.We believe our hiking backpack will not let you down. Your sincere opinion makes our backpacks better.\nTHIS ITEM IS NOT INTENDED FOR USE BY CHILDREN 12 AND UNDER.', '[]', 274000, 347, 4.2, 31, '[\"uploads\\\\product\\\\1738209048998-750037493.jpg\",\"uploads\\\\product\\\\1738209049001-604867963.jpg\",\"uploads\\\\product\\\\1738209049002-178299125.jpg\",\"uploads\\\\product\\\\1738209049005-288056611.jpg\",\"uploads\\\\product\\\\1738209049007-283332011.jpg\",\"uploads\\\\product\\\\1738209049008-775651906.jpg\"]', '2025-01-30 03:50:49', '2025-02-05 09:08:53'),
(47, 'NOOLA Hydration Backpack with 3L TPU Water Bladder', 'noola-hydration-backpack-with-3l-tpu-water-bladder', 'nylon\nImported\nTactical Outdoor Hydration Backpack- Our hiking hydration pack has comprehensive features for hiking adventures and outdoor sports. The 900D abrasion-resistant nylon material, multi pockets (9 pockets including 4 zippered pockets and 5 multi compartments), BPA and odor free TPU hydration bladder, 3L large capacity hydration reservoir, double fastened shoulder and waist straps, tactical molle compatible system integrate into unique hiking water backpack.\nWell Organized Ample Space - Keep all of your essentials organized and secure inside 9 functional and separated pockets, including 4 zippered pockets and 5 multi compartments for conveniently storing bladder, clothes, towel, snacks, phone, sunglasses, keys etc.\nNO BPA or Odor TPU Hydration Bladder: Our hiking water backpack packs with a 3L large capacity TPU hydration bladder, which is BPA and odor free. And 3L large capacity ensures enough water supply for a long day’s exhausted hiking, trekking, or you can also flexibly accommodate your water supply according to your needs.\nMolle Compatible: our tactical molle hydration pack is well constructed with 5 molle straps, which is appropriated for attaching your hiking gear, camping or any other essentials and expand your stuff into a day’s trip.\nBreathable system: Padded shoulder straps, breathable back pad and lightweight design are the good tool for outdoor sports.', '[]', 586000, 1256, 4.2, 31, '[\"uploads\\\\product\\\\1738316046540-593525722.jpg\",\"uploads\\\\product\\\\1738316046544-548067036.jpg\",\"uploads\\\\product\\\\1738316046549-913222545.jpg\",\"uploads\\\\product\\\\1738316046550-823455657.jpg\",\"uploads\\\\product\\\\1738316046552-314650347.jpg\"]', '2025-01-31 09:34:06', '2025-02-05 09:08:53');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `product_id`, `rating`, `comment`, `created_at`, `updated_at`) VALUES
(9, 3, 7, 5, 'Best product ever!!', '2025-02-05 07:57:53', '2025-02-05 07:57:53'),
(10, 3, 7, 4, 'Just the usual, Nothing new!!', '2025-02-05 07:58:26', '2025-02-05 07:58:26'),
(11, 3, 7, 5, 'So excited to get one!', '2025-02-05 08:01:18', '2025-02-05 08:01:18'),
(2062, 12, 7, 3, 'I love this! Works perfectly.', '2025-01-25 09:25:11', '2025-02-05 09:08:53'),
(2063, 17, 7, 5, 'Good value for money.', '2025-01-28 05:10:21', '2025-02-05 09:08:53'),
(2064, 6, 7, 3, 'Not worth the hype.', '2025-01-25 23:17:00', '2025-02-05 09:08:53'),
(2065, 8, 7, 5, 'I love this! Works perfectly.', '2025-01-24 21:29:18', '2025-02-05 09:08:53'),
(2066, 18, 7, 5, 'Decent product, but delivery was slow.', '2025-01-31 19:34:15', '2025-02-05 09:08:53'),
(2067, 23, 8, 3, 'Decent product, but delivery was slow.', '2025-02-03 04:12:11', '2025-02-05 09:08:53'),
(2068, 17, 8, 5, 'It\'s okay, nothing special.', '2025-02-03 01:07:13', '2025-02-05 09:08:53'),
(2069, 23, 8, 5, 'Exceeded my expectations!', '2025-01-30 09:03:02', '2025-02-05 09:08:53'),
(2070, 21, 8, 3, 'Amazing quality for the price!', '2025-01-31 23:32:23', '2025-02-05 09:08:53'),
(2071, 11, 8, 3, 'Not worth the hype.', '2025-01-28 14:49:24', '2025-02-05 09:08:53'),
(2072, 12, 9, 4, 'Very satisfied with my purchase.', '2025-01-26 08:54:31', '2025-02-05 09:08:53'),
(2073, 14, 9, 3, 'Would buy again.', '2025-02-02 12:56:10', '2025-02-05 09:08:53'),
(2074, 15, 9, 3, 'The build quality is impressive.', '2025-01-29 19:28:12', '2025-02-05 09:08:53'),
(2075, 16, 9, 4, 'Not bad, but could be better.', '2025-01-27 19:34:06', '2025-02-05 09:08:53'),
(2076, 8, 9, 3, 'Great product! Highly recommended.', '2025-01-24 19:57:20', '2025-02-05 09:08:53'),
(2077, 20, 10, 5, 'I love this! Works perfectly.', '2025-01-25 13:37:21', '2025-02-05 09:08:53'),
(2078, 15, 10, 4, 'Not worth the hype.', '2025-01-26 03:35:48', '2025-02-05 09:08:53'),
(2079, 7, 10, 3, 'Great product! Highly recommended.', '2025-01-30 02:38:54', '2025-02-05 09:08:53'),
(2080, 6, 10, 4, 'I love this! Works perfectly.', '2025-01-27 07:21:52', '2025-02-05 09:08:53'),
(2081, 19, 10, 5, 'Not bad, but could be better.', '2025-01-27 21:36:08', '2025-02-05 09:08:53'),
(2082, 6, 11, 3, 'Good value for money.', '2025-02-01 19:31:18', '2025-02-05 09:08:53'),
(2083, 16, 11, 3, 'Good value for money.', '2025-02-03 20:48:31', '2025-02-05 09:08:53'),
(2084, 14, 11, 4, 'Not bad, but could be better.', '2025-02-04 15:05:15', '2025-02-05 09:08:53'),
(2085, 11, 11, 3, 'Not bad, but could be better.', '2025-02-04 04:25:02', '2025-02-05 09:08:53'),
(2086, 20, 11, 3, 'Decent product, but delivery was slow.', '2025-01-25 14:47:08', '2025-02-05 09:08:53'),
(2087, 7, 12, 4, 'Decent product, but delivery was slow.', '2025-01-30 16:27:33', '2025-02-05 09:08:53'),
(2088, 15, 12, 4, 'Very satisfied with my purchase.', '2025-02-03 07:45:17', '2025-02-05 09:08:53'),
(2089, 7, 12, 4, 'I love this! Works perfectly.', '2025-02-01 10:21:53', '2025-02-05 09:08:53'),
(2090, 14, 12, 3, 'Great product! Highly recommended.', '2025-01-29 08:44:33', '2025-02-05 09:08:53'),
(2091, 7, 12, 3, 'Amazing quality for the price!', '2025-01-30 15:42:13', '2025-02-05 09:08:53'),
(2092, 3, 13, 3, 'It\'s okay, nothing special.', '2025-02-03 23:30:07', '2025-02-05 09:08:53'),
(2093, 7, 13, 5, 'Exceeded my expectations!', '2025-01-27 05:37:07', '2025-02-05 09:08:53'),
(2094, 14, 13, 4, 'Good value for money.', '2025-02-01 00:01:52', '2025-02-05 09:08:53'),
(2095, 21, 13, 3, 'Decent product, but delivery was slow.', '2025-01-25 16:44:25', '2025-02-05 09:08:53'),
(2096, 22, 13, 4, 'Decent product, but delivery was slow.', '2025-01-26 11:32:20', '2025-02-05 09:08:53'),
(2097, 17, 14, 5, 'Great product! Highly recommended.', '2025-02-04 04:30:36', '2025-02-05 09:08:53'),
(2098, 23, 14, 4, 'Good value for money.', '2025-01-29 01:40:14', '2025-02-05 09:08:53'),
(2099, 22, 14, 5, 'Not worth the hype.', '2025-01-26 00:24:44', '2025-02-05 09:08:53'),
(2100, 8, 14, 4, 'It\'s okay, nothing special.', '2025-01-28 02:40:32', '2025-02-05 09:08:53'),
(2101, 11, 14, 4, 'Good value for money.', '2025-01-29 14:25:58', '2025-02-05 09:08:53'),
(2102, 11, 15, 5, 'The build quality is impressive.', '2025-02-01 21:53:18', '2025-02-05 09:08:53'),
(2103, 14, 15, 3, 'Not bad, but could be better.', '2025-02-02 16:47:54', '2025-02-05 09:08:53'),
(2104, 16, 15, 3, 'The build quality is impressive.', '2025-01-24 12:25:25', '2025-02-05 09:08:53'),
(2105, 16, 15, 4, 'The build quality is impressive.', '2025-02-05 01:47:13', '2025-02-05 09:08:53'),
(2106, 6, 15, 5, 'The build quality is impressive.', '2025-01-26 16:01:52', '2025-02-05 09:08:53'),
(2107, 21, 16, 5, 'Amazing quality for the price!', '2025-02-01 21:32:44', '2025-02-05 09:08:53'),
(2108, 3, 16, 5, 'Amazing quality for the price!', '2025-01-31 11:16:55', '2025-02-05 09:08:53'),
(2109, 11, 16, 4, 'I love this! Works perfectly.', '2025-02-04 16:36:27', '2025-02-05 09:08:53'),
(2110, 16, 16, 5, 'Very satisfied with my purchase.', '2025-01-24 12:47:49', '2025-02-05 09:08:53'),
(2111, 10, 16, 3, 'Good value for money.', '2025-01-29 13:30:35', '2025-02-05 09:08:53'),
(2112, 3, 17, 3, 'Would buy again.', '2025-01-24 14:07:58', '2025-02-05 09:08:53'),
(2113, 23, 17, 3, 'Not bad, but could be better.', '2025-01-24 14:58:46', '2025-02-05 09:08:53'),
(2114, 19, 17, 5, 'Great product! Highly recommended.', '2025-01-31 03:29:25', '2025-02-05 09:08:53'),
(2115, 7, 17, 3, 'Good value for money.', '2025-01-26 19:03:48', '2025-02-05 09:08:53'),
(2116, 12, 17, 4, 'Decent product, but delivery was slow.', '2025-02-02 19:18:12', '2025-02-05 09:08:53'),
(2117, 12, 18, 5, 'Would buy again.', '2025-02-03 07:44:02', '2025-02-05 09:08:53'),
(2118, 20, 18, 3, 'Very satisfied with my purchase.', '2025-01-30 14:43:21', '2025-02-05 09:08:53'),
(2119, 8, 18, 5, 'Amazing quality for the price!', '2025-02-03 23:16:10', '2025-02-05 09:08:53'),
(2120, 23, 18, 3, 'Exceeded my expectations!', '2025-01-25 09:30:35', '2025-02-05 09:08:53'),
(2121, 22, 18, 4, 'Not bad, but could be better.', '2025-01-28 01:46:22', '2025-02-05 09:08:53'),
(2122, 8, 19, 5, 'Not worth the hype.', '2025-01-29 22:42:53', '2025-02-05 09:08:53'),
(2123, 11, 19, 3, 'Amazing quality for the price!', '2025-01-28 03:58:36', '2025-02-05 09:08:53'),
(2124, 12, 19, 4, 'Amazing quality for the price!', '2025-01-29 22:18:06', '2025-02-05 09:08:53'),
(2125, 14, 19, 5, 'Would buy again.', '2025-01-25 06:20:45', '2025-02-05 09:08:53'),
(2126, 12, 19, 3, 'Very satisfied with my purchase.', '2025-01-25 22:23:06', '2025-02-05 09:08:53'),
(2127, 22, 20, 5, 'Decent product, but delivery was slow.', '2025-02-03 05:11:10', '2025-02-05 09:08:53'),
(2128, 18, 20, 3, 'It\'s okay, nothing special.', '2025-01-28 12:34:31', '2025-02-05 09:08:53'),
(2129, 3, 20, 5, 'Decent product, but delivery was slow.', '2025-02-03 08:09:06', '2025-02-05 09:08:53'),
(2130, 20, 20, 5, 'Very satisfied with my purchase.', '2025-01-26 22:48:43', '2025-02-05 09:08:53'),
(2131, 12, 20, 3, 'Not worth the hype.', '2025-01-31 00:10:19', '2025-02-05 09:08:53'),
(2132, 8, 21, 4, 'Would buy again.', '2025-02-02 08:19:11', '2025-02-05 09:08:53'),
(2133, 19, 21, 5, 'It\'s okay, nothing special.', '2025-01-26 11:59:25', '2025-02-05 09:08:53'),
(2134, 19, 21, 3, 'Good value for money.', '2025-02-04 06:40:40', '2025-02-05 09:08:53'),
(2135, 19, 21, 3, 'Amazing quality for the price!', '2025-02-01 10:23:14', '2025-02-05 09:08:53'),
(2136, 15, 21, 4, 'I love this! Works perfectly.', '2025-01-28 02:12:14', '2025-02-05 09:08:53'),
(2137, 3, 22, 4, 'Not bad, but could be better.', '2025-02-04 14:42:25', '2025-02-05 09:08:53'),
(2138, 21, 22, 3, 'Very satisfied with my purchase.', '2025-02-03 18:31:42', '2025-02-05 09:08:53'),
(2139, 8, 22, 4, 'The build quality is impressive.', '2025-01-25 10:49:37', '2025-02-05 09:08:53'),
(2140, 20, 22, 5, 'Great product! Highly recommended.', '2025-01-27 05:27:28', '2025-02-05 09:08:53'),
(2141, 3, 22, 3, 'Would buy again.', '2025-02-02 08:22:56', '2025-02-05 09:08:53'),
(2142, 21, 23, 5, 'It\'s okay, nothing special.', '2025-01-24 14:09:25', '2025-02-05 09:08:53'),
(2143, 21, 23, 4, 'Very satisfied with my purchase.', '2025-01-30 13:46:05', '2025-02-05 09:08:53'),
(2144, 19, 23, 4, 'Amazing quality for the price!', '2025-02-01 01:36:43', '2025-02-05 09:08:53'),
(2145, 22, 23, 4, 'Exceeded my expectations!', '2025-01-30 19:12:53', '2025-02-05 09:08:53'),
(2146, 15, 23, 3, 'Not bad, but could be better.', '2025-01-31 22:13:14', '2025-02-05 09:08:53'),
(2147, 22, 24, 3, 'Not worth the hype.', '2025-01-28 11:52:58', '2025-02-05 09:08:53'),
(2148, 17, 24, 4, 'I love this! Works perfectly.', '2025-01-25 13:35:41', '2025-02-05 09:08:53'),
(2149, 23, 24, 4, 'Would buy again.', '2025-02-01 02:37:54', '2025-02-05 09:08:53'),
(2150, 20, 24, 3, 'The build quality is impressive.', '2025-01-28 20:33:28', '2025-02-05 09:08:53'),
(2151, 23, 24, 4, 'Not worth the hype.', '2025-01-30 19:12:01', '2025-02-05 09:08:53'),
(2152, 7, 25, 4, 'Would buy again.', '2025-02-03 10:40:40', '2025-02-05 09:08:53'),
(2153, 6, 25, 3, 'Not bad, but could be better.', '2025-02-01 14:34:05', '2025-02-05 09:08:53'),
(2154, 18, 25, 3, 'Not bad, but could be better.', '2025-01-27 17:37:21', '2025-02-05 09:08:53'),
(2155, 3, 25, 4, 'Amazing quality for the price!', '2025-02-03 01:59:47', '2025-02-05 09:08:53'),
(2156, 6, 25, 4, 'Amazing quality for the price!', '2025-01-27 01:29:11', '2025-02-05 09:08:53'),
(2157, 14, 26, 4, 'I love this! Works perfectly.', '2025-02-03 22:35:44', '2025-02-05 09:08:53'),
(2158, 16, 26, 5, 'I love this! Works perfectly.', '2025-01-28 08:52:01', '2025-02-05 09:08:53'),
(2159, 18, 26, 4, 'Exceeded my expectations!', '2025-02-04 10:18:06', '2025-02-05 09:08:53'),
(2160, 15, 26, 4, 'Exceeded my expectations!', '2025-01-26 09:57:50', '2025-02-05 09:08:53'),
(2161, 7, 26, 3, 'Would buy again.', '2025-02-01 17:33:04', '2025-02-05 09:08:53'),
(2162, 17, 27, 3, 'Exceeded my expectations!', '2025-01-28 13:02:04', '2025-02-05 09:08:53'),
(2163, 23, 27, 3, 'Would buy again.', '2025-01-28 12:55:11', '2025-02-05 09:08:53'),
(2164, 10, 27, 5, 'Decent product, but delivery was slow.', '2025-01-26 07:48:37', '2025-02-05 09:08:53'),
(2165, 11, 27, 3, 'Good value for money.', '2025-01-27 17:31:32', '2025-02-05 09:08:53'),
(2166, 7, 27, 4, 'The build quality is impressive.', '2025-02-02 13:06:23', '2025-02-05 09:08:53'),
(2167, 19, 28, 5, 'Amazing quality for the price!', '2025-02-04 21:34:02', '2025-02-05 09:08:53'),
(2168, 20, 28, 5, 'Would buy again.', '2025-02-04 12:24:01', '2025-02-05 09:08:53'),
(2169, 16, 28, 5, 'Exceeded my expectations!', '2025-01-28 09:32:48', '2025-02-05 09:08:53'),
(2170, 14, 28, 5, 'Decent product, but delivery was slow.', '2025-01-24 17:22:54', '2025-02-05 09:08:53'),
(2171, 10, 28, 3, 'Good value for money.', '2025-01-30 04:21:56', '2025-02-05 09:08:53'),
(2172, 15, 29, 3, 'Great product! Highly recommended.', '2025-01-29 07:43:30', '2025-02-05 09:08:53'),
(2173, 3, 29, 4, 'Decent product, but delivery was slow.', '2025-02-01 01:55:25', '2025-02-05 09:08:53'),
(2174, 10, 29, 4, 'Not worth the hype.', '2025-01-26 02:31:18', '2025-02-05 09:08:53'),
(2175, 14, 29, 3, 'Not worth the hype.', '2025-01-27 20:03:58', '2025-02-05 09:08:53'),
(2176, 12, 29, 4, 'Not bad, but could be better.', '2025-01-31 20:12:07', '2025-02-05 09:08:53'),
(2177, 6, 30, 3, 'Not worth the hype.', '2025-01-28 16:01:18', '2025-02-05 09:08:53'),
(2178, 21, 30, 5, 'I love this! Works perfectly.', '2025-02-03 02:08:25', '2025-02-05 09:08:53'),
(2179, 14, 30, 4, 'Not bad, but could be better.', '2025-02-04 07:02:25', '2025-02-05 09:08:53'),
(2180, 7, 30, 5, 'It\'s okay, nothing special.', '2025-01-26 01:19:43', '2025-02-05 09:08:53'),
(2181, 17, 30, 3, 'Good value for money.', '2025-01-30 04:14:28', '2025-02-05 09:08:53'),
(2182, 8, 31, 5, 'Decent product, but delivery was slow.', '2025-02-04 13:06:17', '2025-02-05 09:08:53'),
(2183, 12, 31, 3, 'Not bad, but could be better.', '2025-01-28 21:30:25', '2025-02-05 09:08:53'),
(2184, 8, 31, 5, 'Not worth the hype.', '2025-01-29 00:25:40', '2025-02-05 09:08:53'),
(2185, 7, 31, 3, 'Great product! Highly recommended.', '2025-01-28 05:14:12', '2025-02-05 09:08:53'),
(2186, 7, 31, 3, 'Not worth the hype.', '2025-01-27 10:47:01', '2025-02-05 09:08:53'),
(2187, 18, 32, 5, 'Exceeded my expectations!', '2025-02-04 01:01:56', '2025-02-05 09:08:53'),
(2188, 21, 32, 5, 'Very satisfied with my purchase.', '2025-01-29 14:14:12', '2025-02-05 09:08:53'),
(2189, 10, 32, 5, 'The build quality is impressive.', '2025-02-01 02:40:54', '2025-02-05 09:08:53'),
(2190, 14, 32, 4, 'Great product! Highly recommended.', '2025-02-04 17:02:44', '2025-02-05 09:08:53'),
(2191, 12, 32, 4, 'Would buy again.', '2025-01-27 07:15:52', '2025-02-05 09:08:53'),
(2192, 23, 33, 4, 'The build quality is impressive.', '2025-01-27 10:58:10', '2025-02-05 09:08:53'),
(2193, 12, 33, 5, 'Very satisfied with my purchase.', '2025-01-25 17:23:44', '2025-02-05 09:08:53'),
(2194, 23, 33, 4, 'Very satisfied with my purchase.', '2025-01-30 12:04:00', '2025-02-05 09:08:53'),
(2195, 20, 33, 3, 'I love this! Works perfectly.', '2025-01-25 16:17:59', '2025-02-05 09:08:53'),
(2196, 7, 33, 4, 'It\'s okay, nothing special.', '2025-01-30 14:26:28', '2025-02-05 09:08:53'),
(2197, 3, 34, 5, 'Not bad, but could be better.', '2025-01-30 12:49:54', '2025-02-05 09:08:53'),
(2198, 14, 34, 4, 'Decent product, but delivery was slow.', '2025-02-03 16:27:23', '2025-02-05 09:08:53'),
(2199, 15, 34, 5, 'Not bad, but could be better.', '2025-01-31 11:51:25', '2025-02-05 09:08:53'),
(2200, 14, 34, 3, 'Very satisfied with my purchase.', '2025-02-04 18:42:52', '2025-02-05 09:08:53'),
(2201, 16, 34, 5, 'Great product! Highly recommended.', '2025-01-26 15:10:05', '2025-02-05 09:08:53'),
(2202, 11, 35, 3, 'It\'s okay, nothing special.', '2025-01-27 06:57:57', '2025-02-05 09:08:53'),
(2203, 19, 35, 4, 'Would buy again.', '2025-01-28 01:59:11', '2025-02-05 09:08:53'),
(2204, 8, 35, 4, 'Would buy again.', '2025-01-26 01:52:28', '2025-02-05 09:08:53'),
(2205, 16, 35, 3, 'Very satisfied with my purchase.', '2025-01-26 05:55:54', '2025-02-05 09:08:53'),
(2206, 3, 35, 5, 'The build quality is impressive.', '2025-01-28 16:01:55', '2025-02-05 09:08:53'),
(2207, 18, 36, 5, 'Amazing quality for the price!', '2025-01-29 07:23:51', '2025-02-05 09:08:53'),
(2208, 10, 36, 4, 'Good value for money.', '2025-02-01 03:34:21', '2025-02-05 09:08:53'),
(2209, 19, 36, 4, 'It\'s okay, nothing special.', '2025-01-27 03:15:23', '2025-02-05 09:08:53'),
(2210, 10, 36, 4, 'I love this! Works perfectly.', '2025-02-03 14:16:53', '2025-02-05 09:08:53'),
(2211, 18, 36, 3, 'Would buy again.', '2025-01-24 18:57:03', '2025-02-05 09:08:53'),
(2212, 6, 37, 5, 'I love this! Works perfectly.', '2025-01-30 22:32:23', '2025-02-05 09:08:53'),
(2213, 14, 37, 5, 'Good value for money.', '2025-01-25 04:31:39', '2025-02-05 09:08:53'),
(2214, 3, 37, 5, 'Not worth the hype.', '2025-01-30 19:47:37', '2025-02-05 09:08:53'),
(2215, 11, 37, 4, 'Good value for money.', '2025-01-31 12:26:24', '2025-02-05 09:08:53'),
(2216, 14, 37, 3, 'Not bad, but could be better.', '2025-01-27 12:44:33', '2025-02-05 09:08:53'),
(2217, 10, 38, 3, 'Not bad, but could be better.', '2025-01-28 08:54:17', '2025-02-05 09:08:53'),
(2218, 22, 38, 5, 'It\'s okay, nothing special.', '2025-01-27 20:10:45', '2025-02-05 09:08:53'),
(2219, 8, 38, 3, 'Great product! Highly recommended.', '2025-01-25 20:05:53', '2025-02-05 09:08:53'),
(2220, 7, 38, 3, 'Would buy again.', '2025-02-04 08:07:31', '2025-02-05 09:08:53'),
(2221, 6, 38, 5, 'It\'s okay, nothing special.', '2025-02-04 05:25:19', '2025-02-05 09:08:53'),
(2222, 8, 39, 5, 'Not worth the hype.', '2025-01-26 04:39:45', '2025-02-05 09:08:53'),
(2223, 21, 39, 3, 'Good value for money.', '2025-01-30 02:20:10', '2025-02-05 09:08:53'),
(2224, 8, 39, 4, 'Amazing quality for the price!', '2025-01-25 22:21:23', '2025-02-05 09:08:53'),
(2225, 6, 39, 3, 'It\'s okay, nothing special.', '2025-01-30 03:11:25', '2025-02-05 09:08:53'),
(2226, 3, 39, 3, 'Good value for money.', '2025-01-31 01:32:43', '2025-02-05 09:08:53'),
(2227, 22, 40, 4, 'Not worth the hype.', '2025-01-30 17:10:26', '2025-02-05 09:08:53'),
(2228, 21, 40, 5, 'The build quality is impressive.', '2025-01-27 22:02:05', '2025-02-05 09:08:53'),
(2229, 3, 40, 4, 'Exceeded my expectations!', '2025-02-01 03:34:27', '2025-02-05 09:08:53'),
(2230, 10, 40, 4, 'Amazing quality for the price!', '2025-01-30 00:07:02', '2025-02-05 09:08:53'),
(2231, 7, 40, 5, 'Amazing quality for the price!', '2025-01-26 10:16:51', '2025-02-05 09:08:53'),
(2232, 19, 41, 5, 'Would buy again.', '2025-01-26 13:27:04', '2025-02-05 09:08:53'),
(2233, 16, 41, 4, 'Amazing quality for the price!', '2025-02-01 16:10:50', '2025-02-05 09:08:53'),
(2234, 21, 41, 3, 'Not worth the hype.', '2025-01-30 08:01:37', '2025-02-05 09:08:53'),
(2235, 3, 41, 4, 'Not bad, but could be better.', '2025-02-04 04:20:51', '2025-02-05 09:08:53'),
(2236, 18, 41, 4, 'Would buy again.', '2025-02-03 09:51:41', '2025-02-05 09:08:53'),
(2237, 18, 42, 3, 'Not bad, but could be better.', '2025-02-03 02:21:59', '2025-02-05 09:08:53'),
(2238, 3, 42, 4, 'Amazing quality for the price!', '2025-01-29 06:15:34', '2025-02-05 09:08:53'),
(2239, 16, 42, 5, 'Amazing quality for the price!', '2025-01-27 16:40:41', '2025-02-05 09:08:53'),
(2240, 8, 42, 4, 'Very satisfied with my purchase.', '2025-02-05 01:15:23', '2025-02-05 09:08:53'),
(2241, 20, 42, 5, 'I love this! Works perfectly.', '2025-02-04 23:46:25', '2025-02-05 09:08:53'),
(2242, 12, 43, 5, 'Very satisfied with my purchase.', '2025-01-25 02:10:47', '2025-02-05 09:08:53'),
(2243, 19, 43, 3, 'It\'s okay, nothing special.', '2025-02-03 07:29:12', '2025-02-05 09:08:53'),
(2244, 6, 43, 3, 'Not bad, but could be better.', '2025-01-31 21:59:17', '2025-02-05 09:08:53'),
(2245, 21, 43, 5, 'It\'s okay, nothing special.', '2025-02-02 20:09:12', '2025-02-05 09:08:53'),
(2246, 8, 43, 5, 'Not worth the hype.', '2025-02-01 12:57:47', '2025-02-05 09:08:53'),
(2247, 19, 44, 4, 'Exceeded my expectations!', '2025-02-03 19:00:32', '2025-02-05 09:08:53'),
(2248, 15, 44, 5, 'Good value for money.', '2025-02-01 18:09:52', '2025-02-05 09:08:53'),
(2249, 17, 44, 5, 'Not bad, but could be better.', '2025-02-01 15:22:47', '2025-02-05 09:08:53'),
(2250, 7, 44, 4, 'Very satisfied with my purchase.', '2025-02-03 11:15:02', '2025-02-05 09:08:53'),
(2251, 3, 44, 4, 'It\'s okay, nothing special.', '2025-01-30 19:16:39', '2025-02-05 09:08:53'),
(2252, 6, 45, 3, 'Exceeded my expectations!', '2025-01-25 10:46:27', '2025-02-05 09:08:53'),
(2253, 19, 45, 4, 'Not bad, but could be better.', '2025-02-02 15:11:24', '2025-02-05 09:08:53'),
(2254, 23, 45, 4, 'I love this! Works perfectly.', '2025-01-26 21:26:18', '2025-02-05 09:08:53'),
(2255, 17, 45, 5, 'Good value for money.', '2025-01-27 10:34:02', '2025-02-05 09:08:53'),
(2256, 12, 45, 4, 'Good value for money.', '2025-01-30 17:48:27', '2025-02-05 09:08:53'),
(2257, 20, 46, 5, 'Good value for money.', '2025-01-24 15:54:24', '2025-02-05 09:08:53'),
(2258, 17, 46, 3, 'Great product! Highly recommended.', '2025-02-03 19:16:39', '2025-02-05 09:08:53'),
(2259, 8, 46, 4, 'Good value for money.', '2025-01-27 06:51:50', '2025-02-05 09:08:53'),
(2260, 16, 46, 5, 'It\'s okay, nothing special.', '2025-01-29 04:32:03', '2025-02-05 09:08:53'),
(2261, 23, 46, 4, 'Great product! Highly recommended.', '2025-01-27 16:57:09', '2025-02-05 09:08:53'),
(2262, 17, 47, 4, 'Exceeded my expectations!', '2025-01-25 19:52:23', '2025-02-05 09:08:53'),
(2263, 7, 47, 4, 'Amazing quality for the price!', '2025-01-28 05:16:25', '2025-02-05 09:08:53'),
(2264, 12, 47, 5, 'Great product! Highly recommended.', '2025-01-31 15:53:26', '2025-02-05 09:08:53'),
(2265, 8, 47, 4, 'Exceeded my expectations!', '2025-02-02 03:54:40', '2025-02-05 09:08:53'),
(2266, 17, 47, 4, 'It\'s okay, nothing special.', '2025-01-28 11:06:11', '2025-02-05 09:08:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `profile_photo` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `profile_photo`, `created_at`, `updated_at`) VALUES
(3, 'NAMA', 'misbach@guest.com', '$2b$10$xXk5HS6wHN6wGDFbhPhLv.5/oHBmFxkIyGgvacrV0IWwnWbimgJve', 'user', 'uploads\\profile-photo/1739156952674-693964797.jpg', '2025-01-22 16:28:54', '2025-02-10 03:09:12'),
(6, 'misbach2', 'misbach2@guest.com', '$2b$10$JNcbRkOmIRrs2uZd3pJ2Xu7gPQrypwf8rFp.xpECIZd6ne/iLin46', 'user', NULL, '2025-01-29 02:01:18', '2025-01-29 02:01:18'),
(7, 'johndoe', 'janedoe@pubsec.gov', '$2b$10$SeH4rRrgndjFmTqUPkPAH.FYzgN5TF7ZUcQIH5rTRpbAnZOvnlYbS', 'user', NULL, '2025-01-29 02:03:20', '2025-01-29 02:03:20'),
(8, 'misbach3', 'misbach3@guest.com', '$2b$10$99ylUsdlwvf47NE5u6ALz.wr1Yln/HT9lGiNd4iw6hGBgOKIs3wqS', 'user', NULL, '2025-02-05 02:40:03', '2025-02-05 02:40:03'),
(10, 'yazid achmad', 'yazid@gmail.com', '$2b$10$iayNWNs7UJtL1e1SR6/YLuXSg94cInM1YupnYJc570bM0CXbKUT7W', 'user', NULL, '2025-02-05 02:57:10', '2025-02-05 02:57:10'),
(11, 'muhamad parisz hidayatv ', 'hjknk@cvbn', '$2b$10$cUdm5wiqVfU2fASQrtOXjO1bNhEZBkwiTdMKtWJRrTxX4aGPSNqHW', 'user', NULL, '2025-02-05 02:58:34', '2025-02-05 02:58:34'),
(12, 'HYUN BIN', 'hyuu@gmail.com', '$2b$10$7.5h7b1itkHKC/lp7uTne.7JxB7TchdNNxdSWJrSftnBgN50HzdWK', 'user', NULL, '2025-02-05 03:01:39', '2025-02-05 03:01:39'),
(14, 'raihan nazhiif yudhistira', 'raihannazhiifyudhistira@gmail.com', '$2b$10$RaAlW7vTA6Y89hEtLvg1H.J2kVfTAII1aVDM520bLP/.CUbBHVBi2', 'user', NULL, '2025-02-05 03:22:03', '2025-02-05 03:22:03'),
(15, 'Yazid', 'yazid234g@gmail.com', '$2b$10$An4c3IMnBZn8VUanTkEcl.2Qsvl0lNEfpJGEMn3TEvHG4poZ9UDp6', 'user', NULL, '2025-02-05 03:25:23', '2025-02-05 03:25:23'),
(16, 'muhamad parisz hidayat', 'muhamadparisz08@gmail.com', '$2b$10$tcV/gi4XYMjqfccTOC2AwOHG.4Mha5dTisgEnSpNtP7Hn5HRYKkA.', 'user', NULL, '2025-02-05 03:25:59', '2025-02-05 03:25:59'),
(17, 'raihan nazhiif yudhistira', 'faeyza07@gmail.com', '$2b$10$uUe8smvIdmlex/bpep3suOaNEdz8Kha0TkHSZuS6JXSx55.2neIlm', 'user', NULL, '2025-02-05 03:29:04', '2025-02-05 03:29:04'),
(18, 'Admin Misbach', 'admin@admin.com', '$2b$10$CE6Z4G2KluUDoD292nsY6OuJ/npiSa7jkKSvQktVsKbZCXYvHn8nW', 'user', NULL, '2025-02-05 03:29:24', '2025-02-05 03:29:24'),
(19, 'asdfgh', 'qwertyu@gmail.com', '$2b$10$RGiWuzEv6ZPC2Q127HA4vup4r5wLLzhwat/OTPFPaxnWn6/AfEB0C', 'user', NULL, '2025-02-05 03:30:58', '2025-02-05 03:30:58'),
(20, 'sabar', 'sabar@gmail.com', '$2b$10$3WUPHnPNAf5CTJLqXo72VuolpVz8jFGBij2s9C095qMrVFgmpZ9/G', 'user', NULL, '2025-02-05 03:32:39', '2025-02-05 03:32:39'),
(21, 'muhamad parisz hidayat', 'muhamadparisz08@mail.com', '$2b$10$i17jY2ok3lAUz.EvW6CvaeSaMYPUa62G4uaJjvgTm1ZfTdnSdGnuy', 'user', NULL, '2025-02-05 03:34:36', '2025-02-05 03:34:36'),
(22, 'raihan nazhiif yudhistira', 'a@a.com', '$2b$10$7GdmnvY1w2RiYk8RtnxQU.5UUR1YSQzVMQTlmD7MjV5I6T0N67XV6', 'user', NULL, '2025-02-05 03:51:08', '2025-02-05 03:51:08'),
(23, 'Raja', 'rajamalaikha@gmail.com', '$2b$10$F2j1PcAMldPPJZmIDDQBm.H01.0NZ5by1cQOud5BtCiSvc7q/TF8K', 'user', NULL, '2025-02-05 04:14:17', '2025-02-05 04:14:17'),
(24, 'achmad', 'achmad@gmail.com', '$2b$10$rLB2/ySSp98mXAdIhVQpgebvWYT6P3HCx2tv4.W9/RTkSZ1MHeBf.', 'user', NULL, '2025-02-07 03:31:32', '2025-02-07 03:31:32'),
(25, 'rafie', 'rafie@gmail.com', '$2b$10$oRFQGDq/So64VjTO8GFHxewExspwxy/JnyvRGiAl.Zd3qlODCwkp2', 'user', NULL, '2025-02-07 03:57:07', '2025-02-07 03:57:07'),
(26, 'Zainul Arkaan ', 'zainaril13@gmail.com', '$2b$10$Uu/Uvbi4OlvE6YYslM5wUOU.x30D3DD0d0Nv6TBXKd7bttCB7/6tO', 'user', NULL, '2025-02-10 03:28:59', '2025-02-10 03:28:59'),
(27, 'nayaka', 'nayakaihsanmuttaqin@gmail.com', '$2b$10$UbctqGFewSg25rmFibO5D.LxvmSRpeLcABjWGhp4yb85hVrLluvTu', 'user', NULL, '2025-02-10 04:45:12', '2025-02-10 04:45:12'),
(28, 'nayaka', 'nayakaihsanmuttaqin1@gmail.com', '$2b$10$j1czihXJD/wHlhdFGE5iduJCRpf8M7ppNdJMMlCXeG2kq4qDdwEj2', 'user', NULL, '2025-02-10 06:51:56', '2025-02-10 06:51:56'),
(29, 'muhamad parisz hidayat', 'muhamadparisz@gmail.com', '$2b$10$G3x2l1ZWPv7U9gS6adPfDOd9cSB1wCfysvtyskQ62Lg/zz31swr0C', 'user', NULL, '2025-02-10 07:28:42', '2025-02-10 07:28:42'),
(30, 'Danish', 'danish@test.com', '$2b$10$6QtOASs0AZMgj8JxN.xLwOHgZU8DCovB4DYFhT90i/dsPRsIboKky', 'user', NULL, '2025-02-10 07:50:00', '2025-02-10 07:50:00'),
(31, 'Izzan', 'izzanathmar.m@gmail.com', '$2b$10$B7XAzmF7pn8iR1CuaxO7y.fsF12tqTzrcdNiovVC/qeDZhW1fWN9e', 'user', NULL, '2025-02-11 02:39:15', '2025-02-11 02:39:15'),
(32, 'raja', 'sucepet@gmail.com', '$2b$10$4cmchCT0hwFHocyngUkoNeHmVhLNv0Lr/Il/3whdtPWmNqWiOEw5.', 'user', NULL, '2025-02-13 02:22:03', '2025-02-13 02:22:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_user_id_foreign` (`user_id`),
  ADD KEY `carts_product_id_foreign` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_addresses`
--
ALTER TABLE `order_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_order_id_foreign` (`order_id`),
  ADD KEY `items_product_id_foreign` (`product_id`);

--
-- Indexes for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_user_id_foreign` (`user_id`),
  ADD KEY `reviews_product_id_foreign` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_addresses`
--
ALTER TABLE `order_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2267;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_addresses`
--
ALTER TABLE `order_addresses`
  ADD CONSTRAINT `order_addresses_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD CONSTRAINT `payment_transactions_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

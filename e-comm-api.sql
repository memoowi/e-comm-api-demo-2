-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2025 at 05:35 AM
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
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `img_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `img_url`) VALUES
(26, 'Electronics', 'Discover the latest tech marvels! From powerful laptops and cutting-edge smartphones to immersive home theater systems and smart home gadgets, find the perfect electronic companion for your digital life.', 'uploads\\category/1737954541720-349089609.jpg'),
(27, 'Men\'s Clothing', 'Elevate your style with our collection of men\'s clothing. Explore sharp suits, casual wear, durable outerwear, and essential accessories for a confident and contemporary look.', 'uploads\\category/1737954743409-740067389.jpg'),
(28, 'Women\'s Clothing', 'Express your unique style with our curated collection of women\'s fashion. Discover trendy dresses, comfortable basics, stylish outerwear, and statement accessories for every occasion.', 'uploads\\category/1737954768673-877087834.jpg'),
(29, 'Home & Garden', 'Create your dream home and garden oasis. Find stylish furniture, inspiring décor, essential kitchenware, and everything you need to cultivate a beautiful and functional living space, inside and out.', 'uploads\\category/1737954798254-720705854.jpg'),
(30, 'Books & Literature', 'Embark on literary adventures and expand your knowledge with our vast selection of books. From captivating novels and thought-provoking non-fiction to engaging children\'s stories and educational textbooks, discover your next favorite read.', 'uploads\\category/1737954821820-216208748.jpg'),
(31, 'Sports & Outdoors', 'Gear up for your next adventure! Explore high-performance sports equipment, durable outdoor gear, and comfortable activewear for all your athletic pursuits and outdoor explorations. Get ready to conquer new challenges.', 'uploads\\category/1737954843155-214217511.jpg'),
(32, 'Toys & Games', 'Unleash your inner child and discover a world of fun and imagination. Explore exciting toys, engaging games, challenging puzzles, and creative playthings for all ages. Let the games begin!', 'uploads\\category/1737954872089-394036102.jpg'),
(33, 'Beauty & Personal Care', 'Enhance your natural beauty and indulge in self-care with our premium selection of beauty and personal care products. Discover skincare essentials, luxurious cosmetics, fragrant perfumes, and everything you need to look and feel your best.', 'uploads\\category/1737954912583-490343950.jpg'),
(34, 'Food & Beverage', 'Satisfy your cravings and discover culinary delights. Explore a wide variety of delicious food and beverages, from pantry staples and gourmet treats to refreshing drinks and ready-to-eat meals. Treat your taste buds to a culinary adventure.', 'uploads\\category/1737954931042-584002560.jpg'),
(35, 'Health & Wellness', 'Prioritize your well-being and live a healthier, happier life. Explore a range of health and wellness products, including vitamins, supplements, fitness equipment, and personal care items designed to support your physical and mental wellness journey.', 'uploads\\category/1737954954670-703696532.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('pending','shipped','delivered','canceled') NOT NULL DEFAULT 'pending',
  `total_price` bigint(20) NOT NULL,
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
  `quantity` int(11) NOT NULL,
  `price` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `variant` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`variant`)),
  `price` bigint(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `img_urls` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`img_urls`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `variant`, `price`, `stock`, `category_id`, `img_urls`, `created_at`, `updated_at`) VALUES
(7, 'iPhone 16 Pro 512GB', 'Introducing iPhone 16 Pro: Innovation Beyond Boundaries\n\nExperience the pinnacle of smartphone technology with the iPhone 16 Pro. This groundbreaking device pushes the limits of what\'s possible, delivering unparalleled performance, stunning visuals, and groundbreaking camera capabilities.', '[\"Black Titanium\",\"Desert Titanium\",\"Natural Titanium\",\"White Titanium\"]', 21000000, 561, 26, '[\"uploads\\\\product\\\\1738041143745-450207664.jpg\",\"uploads\\\\product\\\\1738041143747-580150900.jpg\",\"uploads\\\\product\\\\1738041143750-682704840.jpg\",\"uploads\\\\product\\\\1738041143750-113493580.jpg\"]', '2025-01-28 05:12:23', '2025-01-28 05:12:23'),
(8, 'Samsung S24 Ultra 512GB', 'Introducing the Samsung Galaxy S24 Ultra: Redefining the Smartphone Experience\n\nThe Samsung Galaxy S24 Ultra pushes the boundaries of innovation, delivering a premium smartphone experience that seamlessly blends cutting-edge technology with elegant design.', '[\"Titanium Black\",\"Titanium Gray\",\"Titanium Violet\",\"Titanium Yellow\"]', 23000000, 6182, 26, '[\"uploads\\\\product\\\\1738084864905-879935294.jpg\",\"uploads\\\\product\\\\1738084864907-670533973.jpg\",\"uploads\\\\product\\\\1738084864912-413601772.jpg\",\"uploads\\\\product\\\\1738084864921-990160852.jpg\"]', '2025-01-28 17:21:04', '2025-01-28 17:21:04'),
(9, 'Google Pixel 9 Pro 128GB', 'Google Pixel 9 Pro: Experience the Power of Google\n\nThe Google Pixel 9 Pro redefines the smartphone experience, delivering cutting-edge technology with the signature Google magic.', '[\"Obsidian\",\"Hazel\",\"Porcelain\",\"Rose Quartz\"]', 13800000, 1435, 26, '[\"uploads\\\\product\\\\1738085066052-163467853.jpg\",\"uploads\\\\product\\\\1738085066053-278141329.jpg\",\"uploads\\\\product\\\\1738085066054-368531727.jpg\",\"uploads\\\\product\\\\1738085066055-8136762.jpg\"]', '2025-01-28 17:24:26', '2025-01-28 17:24:26'),
(10, 'Xiaomi 14 Ultra 512GB', 'International Model - No Warranty in US. USA ONLY COMPATIBLE WITH TMOBILE / MINT, TELLO GLOBAL VERSION . Does NOT Work With Verizon Sprint Boost Metro Pcs At&t Cricket. Unlocked Worldwide . - FCC ID: 2AFZZN28L\nDual Nano sim 5G (NO SD SLOT) :5G: n1/2/3/5/7/8/20/25/28/38/40/41/48/66/75/77/784G: LTE FDD: B1/2/3/4/5/7/8/12/13/17/18/19/20/25/26/28/32/664G: LTE TDD: B38/39/40/41/42/483G: UMTS: B1/2/4/5/6/8/192G: GSM: B2/3/5/8Supports 4x4 MIMO\nLeica professional optical lensLEICA VARIO-SUMMILUX 1:1.63-2.5/12-120 ASPH.Leica main camera LYT-90050MP3.2μm 4-in-1 Super Pixel23mm equivalent focal lengthf/1.63-f/4.0 stepless variable apertureOISALD1\'\' sensor size8P lensAFLeica 75mm floating telephoto camera 50MPf/1.875mm equivalent focal lengthOISFloating telephoto lensSupport 10cm macro photographyIMX8586P lensAFLeica 120mm periscope camera50MPf/2.5120mm equivalent focal lengthOISSupport 30cm macro photographyIMX858AFLeica 12mm ultra-wide camera50MP122° FOV12mm equivalent focal lengthf/1.8Support 5cm macro photographyIMX8587P lensAF\nAll Around Liquid DisplayWQHD+ 6.73\" AMOLED3200 x 1440, 522 ppiLTPO, AdaptiveSync ProRefresh rate: dynamic 1-120HzTouch sampling rate: up to 240Hz*Touch sampling rate may vary according to the content on your display.OLED materials type: Xiaomi-custom C8 display panelBrightness: HBM 1000 nits (typ), 3000 nits peak brightnessPro HDR display, support UltraHDRDolby VisionHDR10+68 billion colorsColor gamut: DCI-P3TrueColor displayAdaptive colorsOriginal color PROAdaptive reading modeSunlight modeDC dimming / 1920Hz PWM dimmingTÜV Rheinland Low Blue Light (Hardware Solution) CertifiedTÜV Rheinland Flicker Free CertifiedTÜV Rheinland Circadian Friendly CertifiedXiaomi Shield Glass\nSnapdragon 8 Gen 3 Mobile Platform4nm power-efficient manufacturing processCPU:1x Prime core (X4-based), up to 3.3GHz3x Performance cores (A720-based), up to 3.2GHz2x Performance cores (A720-based), up to 3.0GHz2x Efficiency cores (A520-based), up to 2.3GHzGPU: Qualcomm Adreno GPU\nCooling System : Xiaomi IceLoop system / Security In-screen fingerprint sensor AI face unlock / NFC : Yes 4610mAh (typ) batteryXiaomi Surge Battery Management systemXiaomi Surge charging chipsetXiaomi Surge battery management chipset90W HyperCharge*31mins to 100% (Boost mode)50W wireless HyperCharge*46mins to 100%*Wireless chargers are sold separately.*Charging data tested in Xiaomi Internal Labs, actual results may vary.Reverse wireless chargingUSB-C 3.2 Gen 1\n32MP in-display selfie cameraf/2.01/3.14\'\' sensor size90° FOVFront camera photography featuresDynamic Framing (0.8x, 1x)Night modeHDRPortrait mode with bokeh and depth controlPalm ShutterTimed burstMovie frameSelfie timerScreen softlightFront camera video featuresVideo teleprompterSlow motion selfieTime-lapse selfieMovie frameEIS Video stabilizationFront camera video recordingHDR video recording with Dolby Vision up to 4K at 30 fps4K (3840x2160) video recording at 30 fps, or 60 fps1080p (1920x1080) HD video recording at 30 fps, or 60 fps720p (1280x720) HD video recording at 30 fps\nGPS: L1+L5Galileo: E1+E5a | GLONASS: G1 | Beidou | NavIC: L5A-GPS supplementary positioning | Electronic compass | Wireless network | Data network| SAP\nProximity sensor | Ambient light sensor | Accelerometer | Gyroscope | Electronic compass | IR blaster | Barometer | Flicker sensor | X-axis linear vibration motor | Laser autofocus\nWireless NetworksXiaomi Surge T1 TunerWi-Fi 7 capability*Wi-Fi 7/Wi-Fi 6E/Wi-Fi 6 capability may vary based on regional availability and local network support.*Wi-Fi connectivity (including Wi-Fi frequency bands, Wi-Fi standards and other features as ratified in IEEE Standard 802.11 specifications) may vary based on regional availability and local network support. The function may be added via OTA when and where applicable.Qualcomm FastConnect 7800 Mobile Connectivity SystemHigh band SimultaneousMulti-Link OperationSupports 2x2 MIMO, 8x8 Sounding for MU-MIMO, WiFi DirectBluetooth 5.4, Dual-BluetoothSupports SBC/AAC/AptX/AptX HD/AptX Adaptive/LDAC/LHDC 5.0', '[\"Black\",\"White\"]', 17000000, 8235, 26, '[\"uploads\\\\product\\\\1738085244846-87848579.jpg\",\"uploads\\\\product\\\\1738085244848-281817360.jpg\"]', '2025-01-28 17:27:24', '2025-01-28 17:27:24'),
(11, 'Nothing Phone (2) - 512 GB + 12 GB Ram', 'Nothing OS 2.0: A new visual identity. Customise everything from app labels and grid design to widget size and colour themes. Now with new folder layouts. Create widgets for quick settings functions or save time by adding key widgets directly to your lock screen. The new Glyph Interface: Key information, in a flash. Assign different light and sound sequences for each contact and notification type. Use the lights to track progress or create your very own ringtones with the Glyph Composer.', '[\"Dark Grey\",\"White\"]', 11000000, 7553, 26, '[\"uploads\\\\product\\\\1738085396669-23659509.jpg\",\"uploads\\\\product\\\\1738085396677-254695542.jpg\",\"uploads\\\\product\\\\1738085396682-178175380.jpg\",\"uploads\\\\product\\\\1738085396707-772367437.jpg\"]', '2025-01-28 17:29:56', '2025-01-28 17:29:56'),
(12, 'Wrangler Authentics Cargo Pant', 'RELAXED FIT. These cargo pants sit at the natural waist. Designed with a relaxed fit through the seat and thigh, these cargos will keep you comfortable during any task\nSTRETCH TWILL. A Wrangler classic, these straight-leg men\'s pants have stretch and flexibility for comfort in movement. A Hollywood waistband offers extra support with your favorite belt\nCLASSIC CARGO PANT. This classic cargo pant is sure to be comfortable and functional for everyday wear. From the outdoors to work, this pant is built for versatility with a timeless silhouette and extra storage\nHEAVY-DUTY HARDWARE. Finished with a heavy-duty zipper fly and button closure\nQUICK-ACCESS STORAGE. Equipped with 6 pockets for maximum storage capacity. 2 side cargo flap pockets, 2 slash pockets, and 2 back patch pockets, for easy-access storage. Great for safely storing your cell-phone, tools, wallet, and other personal items or gadgets', '[\"Kangaroo\",\"Olive\",\"Elmwood\",\"Olive Drab\"]', 485000, 9876, 27, '[\"uploads\\\\product\\\\1738085940942-265069565.jpg\",\"uploads\\\\product\\\\1738085940952-620893371.jpg\",\"uploads\\\\product\\\\1738085940953-599213155.jpg\",\"uploads\\\\product\\\\1738085940953-689323153.jpg\"]', '2025-01-28 17:39:00', '2025-01-28 17:39:00'),
(13, 'Legendary Whitetails Flannel Casual Shirt', '[Relaxed Fit]: Refer to our size chart for the ideal fit; The Buck Camp Flannel is designed to highlight the chest and waist, offering a comfortable yet stylish shape; Its double-pleated back ensures ease of movement without any pulling or tugging; Adhere to care instructions for optimal shrinkage management\n[Quality of Material]: Legendary Whitetails flannel shirt for men, recognized for its top-tier quality, is crafted from 100% soft brushed cotton flannel and promises warmth and breathability; This 5.1 ounce Buck Camp Flannel Shirt is ideally weighted for layering or standalone wear, indoors and out; Beyond its softness, its pill-resistant premium fabric quality ensures a consistently sharp look and lasting comfort\n[Authentic Designs]: Our plaid shirt men\'s designs stay true to their images, ensuring you get exactly what you see; immediate out of box comfort with no need for a \"break-in\" period; Its fade-resistant fabric ensures your men\'s flannel long sleeve shirt looks as vibrant as day one, wash after wash\n[Traditional Style]: The classic single pocket design gives you a clean look while providing an option for storage; use the pencil slot to hold your pencil when scoring on the range or safeguarding your sunglasses\n[Corduroy Lined Cuffs & Collar]: Experience the classic touch of quintessential corduroy lining in our flannel shirt for men; not only does it enhance durability, but it also ensures the collar and cuffs maintain their shape', '[\"Birch Poseidon Plaid\"]', 486900, 8765, 27, '[\"uploads\\\\product\\\\1738086171039-950841409.jpg\",\"uploads\\\\product\\\\1738086171045-780792417.jpg\",\"uploads\\\\product\\\\1738086171049-192478302.jpg\"]', '2025-01-28 17:42:51', '2025-01-28 17:42:51'),
(14, 'Long-Sleeve Soft Touch Quarter-Zip Sweater', 'REGULAR FIT: Comfortable, easy fit through the shoulders, chest, and waist\nCOTTON BLEND YARN: A blended cotton yarn with a super soft hand feel and a refined knit texture.\nMIDWEIGHT ZIP-UP SWEATER: The perfect weather layering piece. Wear with a collared shirt for a modern, polished look or layer with a tee for a more casual feel.\nDETAILS: Soft rib neckline with zipper closure and rib sleeve cuffs and bottom hem for enhanced stretch and recovery.', '[\"Off-white\"]', 620000, 3458, 27, '[\"uploads\\\\product\\\\1738086307680-172632677.jpg\",\"uploads\\\\product\\\\1738086307690-742134884.jpg\",\"uploads\\\\product\\\\1738086307692-212681252.jpg\",\"uploads\\\\product\\\\1738086307693-84792449.jpg\"]', '2025-01-28 17:45:07', '2025-01-28 17:45:07'),
(15, 'Active Performance Tech T-Shirts Pack of 2', 'Fabric type : 100% Polyester\nCare instructions : Machine Wash Cold, Tumble Dry\nOrigin : Imported\nClosure type : Pull On\n', '[\"Black/Medium Grey\",\"Green/Black\",\"Burgundy/White\",\"Dark Blue/Teal Blue\"]', 194000, 23478, 27, '[\"uploads\\\\product\\\\1738086563561-849464891.jpg\",\"uploads\\\\product\\\\1738086563570-471061552.jpg\",\"uploads\\\\product\\\\1738086563572-886327059.jpg\",\"uploads\\\\product\\\\1738086563573-943134477.jpg\"]', '2025-01-28 17:49:23', '2025-01-28 17:49:23'),
(16, 'Bomber Jacket Spring Fall Casual Jackets', 'XiaoYouYu Fabric: polyester; Lightweight, soft fabric for your comfort\nXiaoYouYu Design: 2 side pockets, 1 deep inner pocket\nXiaoYouYu Feature: ribbed collar, hem and cuffs, full zip, long sleeves for warmth and style\nXiaoYouYu Style: classic lightweight bomber jacket for men, easy to match, suitable for winter, autumn, spring.\nXiaoYouYu Occassion: not only suitable for daily wear, but also for work, street fashion, party and golf', '[\"Coffee\"]', 582000, 129, 27, '[\"uploads\\\\product\\\\1738086698465-438763069.jpg\",\"uploads\\\\product\\\\1738086698466-502826930.jpg\",\"uploads\\\\product\\\\1738086698467-165358526.jpg\",\"uploads\\\\product\\\\1738086698468-676418546.jpg\"]', '2025-01-28 17:51:38', '2025-01-28 17:51:38'),
(17, 'Nike Golf Web Belt 3 Pack', '3 web straps one buckle\nOne size fits all up to 42\n2 percent zinc', '[\"Black\",\"White\",\"Cyber\",\"Grey\",\"Tan\"]', 546000, 8525, 27, '[\"uploads\\\\product\\\\1738086958158-757258687.jpg\",\"uploads\\\\product\\\\1738086958159-250152.jpg\",\"uploads\\\\product\\\\1738086958161-649451185.jpg\"]', '2025-01-28 17:55:58', '2025-01-28 17:55:58'),
(18, 'Anrabess Open Front Knit Lightweight Cardigan', 'Size - XS=US(0-2),S=US(4-6),M=US(8-10),L=US(12-14),XL=US(16-18),XXL=US(20-22) ，see details in rich description.\nWash - Hand wash / Do Not Bleach / Dry Flat / Do not iron.\nFeatures - Open front. Pockets. Lapel Neckline. Knit fabric provides flexibility. Not lined.\nThis cardi is such a perfect choice for cozy days! Warm and soft material, you\'re sure to love wearing this gorgeous style all day long!You can easily throw this cardigan on over jeans and a top, a cute dress, or a romper for a stylish look!\nOccassion - Great for casual, daily, school, office, going out, holiday, vacation, street wear in any seasons especially in autumn and winter.', '[\"Beige\",\"Pink\",\"Off-white\",\"Black\"]', 808000, 195, 28, '[\"uploads\\\\product\\\\1738109574071-230021311.jpg\",\"uploads\\\\product\\\\1738109574071-634091883.jpg\",\"uploads\\\\product\\\\1738109574071-914023333.jpg\",\"uploads\\\\product\\\\1738109574072-328142181.jpg\"]', '2025-01-29 00:12:54', '2025-01-29 00:12:54'),
(19, 'Iwollence High Waist Wide Pants', 'Breathable Material：100% Polyester. These wide-leg pants are for women that are not see-through, Super soft, Lightweight, flowy, and skin-friendly, Ensuring maximum comfort and coolness.\nStylish and comfortable： Wide Leg Lounge Pants with Pockets are a perfect combination of style and comfort, High-waisted design tie-knot provides ample coverage, and the adjustable tie-knot allows for maximum comfort and a customized fit. The method of these wide-leg pants makes them suitable for curvy women, those with thick calves and thighs, and many others.\nVersatile and practical： wide leg pants are ideal for a wide range of activities, including daily life, yoga, jogging, hiking, night out, outdoor activities, casual wear, home wear, streetwear, going out, vacation or beach wear, maternity， stylish looking for any occasion. The pockets offer added convenience for storing essentials like your phone, keys, or wallet.\nStandard US Size: S(4-6), M(8-10), L(12-14), XL(16-18),XXL(20-22). We strongly suggest that you take your body measurements first, and then please look at the size chart on our detail page before ordering.\nGarment Care： Both Machine Wash and Hand washable, These wide-leg pants please wash by hand or machine with cold water, and hang to dry. The material drapes in the most flattering way and you can easily get a chic look.', '[\"Black\"]', 289000, 8732, 28, '[\"uploads\\\\product\\\\1738109854687-191854304.jpg\",\"uploads\\\\product\\\\1738109854688-782664499.jpg\"]', '2025-01-29 00:17:34', '2025-01-29 00:17:34'),
(20, 'OQQ Women 2 Piece Skirts', 'Great stretchy fabric: 90% Nylon, 10% Spandex.Super soft and stretchy. Package content:2* Skirts\nSexy Mini Skirts, favorable mini length, wrap, high waist, simple in design,don’t see through, Best womens, ladies and teen girl clothes.\nSexy Mini Skirts, favorable mini length, wrap, high waist, simple in design,don’t see through, Best womens, ladies and teen girl clothes.\nSexy Mini Skirts, favorable mini length, wrap, high waist, simple in design,don’t see through, Best womens, ladies and teen girl clothes.\nGiving you confidence and support for any occasion.this seamless mini skirts will have you always on-trend, in the go out or at home.', '[\"Black\",\"Beige\",\"White\",\"Hide Pink\",\"Dark Grey\",\"Grey Blue\"]', 501000, 2153, 28, '[\"uploads\\\\product\\\\1738110041837-496994081.jpg\",\"uploads\\\\product\\\\1738110041839-511136557.jpg\",\"uploads\\\\product\\\\1738110041840-296193327.jpg\"]', '2025-01-29 00:20:41', '2025-01-29 00:20:41'),
(21, 'FindThy Kawaii Long Sleeve Button Up Cardigan', 'Button Closure\nV-neck, long sleeves, color block, separate bowknots, you can put it in anywhere you like\nCute cardigan with bowknots, button down long sleeved knit JK uniform sweater with pocket, pair with shirts, vest, jeans, skirts, flats, sneakers, jumpsuit, wide leg pants.\nClassic long-sleeve color blocking v neckline cable knitted cardigan sweaters, suitable for party, dates, club, work office, school, seaside, vacation, trips, leisure, picnic, a great gift for teens.\nAll items are US size. If you have any concern, please leave it in Customer Q&A, we will reply you ASAP', '[\"Pink\",\"Khaki\",\"Beige\"]', 517000, 291, 28, '[\"uploads\\\\product\\\\1738110223791-506082807.jpg\",\"uploads\\\\product\\\\1738110223792-434898692.jpg\",\"uploads\\\\product\\\\1738110223794-110261077.jpg\"]', '2025-01-29 00:23:43', '2025-01-29 00:23:43'),
(22, 'Abaya Long Sleeve Button Down Shirt and Pants', 'Package Include: 1PC Shirt and 1PC Pants; Women\'s Muslim 2 Pieces Sets Long Sleeve Button Down Shirt and Pants Abaya Casual Dubai Outfits. Features: Long Sleeve, Turn-down Collar, Elastic Cuffs, Chest Pockets, Button Closure, Elastic Waistband, Loose Fit. The baggy material can ensure the comfort after hours of studying or working.\nMuslim Abaya Women Top Pants 2 Pieces Solid Color: The Middle East Arabic costume long sleeve top and wide leg pants for women, gives you a simple but elegant look to celebrate the Corban Festival. Long sleeve with elastic cuffs for an elegant and charming feeling. With a detachable belt which can be tied a bowknot at front or back to offer a flattering fit and show your slim waistline. Match wide leg pants with elastic waistband to complete the full look.\nThe Middle East Arabic Muslim Clothes For Women: Modest full length can offer a full coverage to the body, loose fit for a comfy wearing experience all day long. Long sleeve turn-down collar shirt, single-breasted buttons at front, shows the graceful and mature temperament. Long sleeve with elastic cuffs, can stay in place and won’t ride up easily by every move. Medium rise wide leg loose pants, with an elastic waistband, offers a flattering fit to the body.\nOccasions: Abaya turkey long top dress caftan kaftans islamic clothing abayas top wide leg pants two-piece muslim sets fit for Muslim costume, Eid Clothes, Corban Festival, Dubai Modest Robes, Church, Out going, Id al-Fitr, Tight Knot, Ramadan, Prayer, Family Gathering, School, home, office, sports, travel, holiday, ceremony, vacation or other occasions, also a great outfit to your sister, girlfriend or wife .\nFabric: Middle east arabic outfits for womens long sleeve top dress loose fit wide leg pants set dubai islamic muslim clothes made of selected fabric, the material is soft, comfortable and breathable to wear, no irritation to the delicate skin, won\'t deform after washing, offer a pleasant wearing experience to you. They can go well with a hijab to complete a modest look. The Arabic outfit is not only for Corban Festival, but also for casual daily wear.', '[\"Pink\",\"Khaki\",\"Black\"]', 711800, 2352, 28, '[\"uploads\\\\product\\\\1738110511987-481833939.jpg\",\"uploads\\\\product\\\\1738110511989-696852783.jpg\",\"uploads\\\\product\\\\1738110511989-163773522.jpg\",\"uploads\\\\product\\\\1738110511990-531954894.jpg\"]', '2025-01-29 00:28:31', '2025-01-29 00:28:31'),
(23, 'LOVEVOOK Purses and Handbags', '【The Only Purses You\'ll Ever Need】 Our LOVEVOOK handbags serves as a shoulder bag, handbag, tote, and crossbody bag all in one. It\'s a multi-purpose accessory that transitions seamlessly from work to weekend.\n【Sized for Real Life】 Dimensions: 14.4*4.8*9.6 inches, the handle height of 7.5 inch.The adjustable shoulder strap can be extended up to 24.8 inches is perfect for carrying or slinging over your shoulder.\n【Quality You Can Feel】 Made from High-Quality PU Leather, our bags are not only fashionable but also durable.\n【Details That Make a Difference】 Utility doesn\'t sacrifice style. Our bags come with unique ornaments and a long removable shoulder strap, offering versatility and a touch of elegant lady charm.\n【Room for Everything】 1 external rear zippered pocket, 2 large compartment pockets, 2 internal zippered pockets, and 2 slip pockets, providing ample space to organize all your essentials.\n【Just the Right Fit for Your Day 】 Our bag comfortably holds your daily essentials like phones, cosmetics, and even a water bottle.', '[\"Brown\",\"Grey\",\"Green Beige\"]', 412000, 123, 28, '[\"uploads\\\\product\\\\1738110819782-119423002.jpg\",\"uploads\\\\product\\\\1738110819783-418365835.jpg\",\"uploads\\\\product\\\\1738110819784-723430252.jpg\",\"uploads\\\\product\\\\1738110819784-972468277.jpg\"]', '2025-01-29 00:33:39', '2025-01-29 00:33:39'),
(24, 'CADANI 5-Pack Metal Plant Stands for Outdoor Indoor', '【5-Pack】Package includes 5 metal plant stands for indoor and outdoor use. Each metal plant stand has different size to fit different sizes of flowerpots. and made of high-strength metal, not easily deformed. It is very suitable for heavy flower pots or other flower pots\n【Promoting Healthy Plant Growth】The varying heights not only create visual layers, enhancing the aesthetic and adding individuality to the space. but also ensure optimal light exposure for plants, which is beneficial for their healthy growth\n【Upgrade Design】The top of these planter stand designed with with guard rails which can prevent the pots from slipping. Very sturdy and stable, without tilting and tripping. flower pot placed on the potted plant stand as steady as they are on the ground\n【Anti-rust, Never Hurt the Floor】The plant stand is designed with a protective pad to prevent any scratches and wear on the floor. The surface of the plant shelf has an anti-rust coating. When you water the plant or place it in a humid environment, the iron plant stand will not rust and has a long service life\n【100% Money Back】This plant stand has a lifetime warranty. If you are not satisfied with this, please contact us. We\'ll process a refund or send you a replacement part, no returns or any strings attached. All issues will be resolved within 24 hours', '[\"Black\",\"Bronze\",\"White\"]', 379800, 2735, 29, '[\"uploads\\\\product\\\\1738111039606-26591930.jpg\",\"uploads\\\\product\\\\1738111039607-412456225.jpg\",\"uploads\\\\product\\\\1738111039609-543777095.jpg\",\"uploads\\\\product\\\\1738111039612-645757113.jpg\"]', '2025-01-29 00:37:19', '2025-01-29 00:37:19'),
(25, 'Big Round Ottoman with Storage Set of 2 Multifunctional', '[ Larger Size, Larger Capacity] The velvet round ottoman with storage have 2 sizes: 17\"D x 17\"W x 18\"H (Larger) 15\"D x 15\"W x 15\"H(Small),the large size mean more confortable for sitting and much more storage space.This footrest stool is so stable that it can hold up to 300 pounds.\n【Ottoman with Hidden Storage】Tufted ottoman is designed with a large storage compartment. Super suitable for family room to stash child toys, magazines or blankets, it can make everything in well organized. Removable lid can be easy access to get or store items. It blends well with your decor, adding a chic and special storage in your home.\n【Unique craftsmanship】The Cream Storage Ottoman designed with luxurious and skin-friendly velvet fabric, filled with high density sponge making this ottoman very comfortable for sitting. Button tufted design embraces modern essential and classic style, creating a refined and high-end atmosphere for your home.\n【Versatile and Practical Footstool】The set of 2 ottoman round can not only be used to store your extra items, but also can be a footstool ottoman when you watching TV for bedroom, a stool when your friends come to have a coffee with you for living room, a vanity stool when you put on your makeup beside vanity table.\n【Easy to Set Up】Easy to put together.Easy to clean and maintain. If you have any question about footstool, please contact our professional after-sales team without hesitation and we will solve your problem timely.', '[\"Grey\",\"White\"]', 2085000, 175, 29, '[\"uploads\\\\product\\\\1738111420542-546956019.jpg\",\"uploads\\\\product\\\\1738111420544-163938880.jpg\",\"uploads\\\\product\\\\1738111420544-890368852.jpg\",\"uploads\\\\product\\\\1738111420546-474416459.jpg\"]', '2025-01-29 00:43:40', '2025-01-29 00:43:40'),
(26, 'Famiware Milkyway Plates and Bowls Set 12 Pieces', '【WHAT WILL YOU GET?】This dinnerware set includes 4*10.25” dinner plates, 4*8” salad plates, 4*5.75” cereal bowls. This is a great combination for a family dinner party.\n【SCRATCH RESISTANT】Our glaze is fired at 2340℉ for 13.5 hours to form a strong scratch resistant surface. No need to worry about scratches from your forks or knives.\n【DISHWASHER AND MICROWAVE SAFE】Our dishes have passed microwave and dishwasher safe testing at internationally accredited laboratories. Each plate and bowl is 100% dishwasher safe and microwave safe.\n【LEAD FREE ALL NATURAL GLAZE】ALL our plates and bowls are made of lead-free glaze. You can safely use them to serve steaks, salads or desserts.\n【BEST CHOICE】Famiware dishes dinnerware sets are popular with young people with exquisite glaze and unique design. It\'s a great choice for housewarmings, holidays, weddings, and fun celebrations.\n【FUN SPECKLED DESIGN】These rounded dishes feature a minimalist design. Spruce up meal time with these neutral pieces that feature a brown speckled pattern, making each piece unique.\n【STACKABLE & EASY TO CLEAN】These dishes are stackable and don\'t take up a lot of space in your cupboard. Easy to clean, you can wash them with foam and water or place them into your dishwasher.\n【STONEWARE WITH ORGANIC CLAY】The organic clay not only giving you rich representation, but also provides stronger and more reliable stoneware, Our organic clay has optimal heat retention to keep your food hotter longer.\n【FAMIWARE\' S PROMISE】We promise to send you replacements if you receive some pieces that is damaged during shipping, simply send us a message on Amazon and our service is available daily to hear your request.', '[\"White\"]', 905900, 2375, 29, '[\"uploads\\\\product\\\\1738111594624-691048575.jpg\",\"uploads\\\\product\\\\1738111594627-218569403.jpg\",\"uploads\\\\product\\\\1738111594627-2971474.jpg\",\"uploads\\\\product\\\\1738111594629-771311873.jpg\"]', '2025-01-29 00:46:34', '2025-01-29 00:46:34'),
(27, 'Ultra Sharp High Carbon Powder Steel Knife Block Set 16 Pieces', '【All-In-One Knife Set】This comprehensive 16-piece set includes an 8 inch chef knife, 7 inch santoku knife, 8 inch slicing knife, 8 inch bread knife, 7 inch fillet knife, 6 inch utility knife, 3.75 inch paring knife, six 4.5 inch steak knives, all-purpose scissors, and an acacia-wrapped block, ensuring you are well-equipped for any culinary task\n【Premium Powder Steel】Stamped from rust proof and tarnish resistant high carbon steel, this complete knife set show a superior durability, and high quality that make them rust-resistance, ensuring long lasting cutting performance over time; HRC 60±2 Rockwell hardness makes it one of the toughest knife sets in its class\n【Ultra Sharp Blades】 With a signature 15-degree tapered, hand-ground edge, each high-carbon blade provides maximum sharpness and alignment to cut, chop, julienne, slice, dice and more with ease and precision; A wide range of sharp blade shapes and gadgets to deal with a variety of food such as meat, vegetable, fruit, bread, fish as so on\n【Ergonomic Wood Handle】Blade is seamlessly riveted into the handle which makes it more strength; The pakkawood handle with streamlined ergonomical design is easy to grip, making long sessions of food prep virtually effortless and fatigue-free for fingers, wrists and forearms while adding aesthetic value to the knife set\n【Easy Cleaning & Convenient Storage】We recommend you to handwash the knife set to maintain sharpness and expand its service life; Coming with a wooden block, all knives can be stored safely and orderly. And the ventilated design is good for air circulation to keep knives dry; Note: This is not a Damascus Kitchen Knife Set', '[]', 4850000, 127, 29, '[\"uploads\\\\product\\\\1738111733650-579622188.jpg\",\"uploads\\\\product\\\\1738111733653-509352902.jpg\",\"uploads\\\\product\\\\1738111733655-614440268.jpg\"]', '2025-01-29 00:48:53', '2025-01-29 00:48:53'),
(28, 'DULLEMELO Storage Cubes 12 inch 4 Pack', '【Unique Design & Modern & Decorative】Set of 4 , dimensions(each): 12(L) x 12(W) x 12(H) inches. Home organization Baskets bring you organizing convenience and a sweet home. The fabric baskets with neutral colors can match many home styles - keeping your home nice and tidy.\n【Material】These cube storage bins are constructed of sturdy and attractive linen & cardboard with linen interior lining. The sturdy leather handles make it easy to carry or pull off and out of shelves.\n【Care】Please wipe away stains with a dry cloth and make it dry for daily care; DO NOT wash the products. There may be a light smell when the package is opened first; please put products in a well-ventilated place for several hours.\n【Collapsible Baskets】These fabric cube storage boxes are foldable for easy storage if not in use. Great for socks, underwear, books, magazines, toys, pet products, wipes, towels, decorations, office supplies, DVDs, and gifts.\n【100% Customer Satisfaction】We provide customers with premium quality products and services, and you can buy confidently. If you have any concerns or suggestions about the foldable fabric storage bins, please contact us at any time.\nKINDLY NOTE: Size manual measurement may cause a 1-2cm error. Please determine the size you need before you buy.', '[\"White/Grey\",\"Beige\",\"White/Green\"]', 580000, 2385, 29, '[\"uploads\\\\product\\\\1738112019208-393845616.jpg\",\"uploads\\\\product\\\\1738112019211-547199066.jpg\",\"uploads\\\\product\\\\1738112019213-521378807.jpg\",\"uploads\\\\product\\\\1738112019216-369862478.jpg\",\"uploads\\\\product\\\\1738112019227-732617542.jpg\"]', '2025-01-29 00:53:39', '2025-01-29 00:53:39'),
(29, 'MooMee Bedding Duvet Cover Set Extra Long', 'Material: Made of 100% long-staple cotton for durability, softness, and a more luxurious feel for longer. Sateen weave is exclusively made of high-quality 600 thread count which creates a lustrous, durable fabric like Egyptian cotton.\nStylish: It\'s silky to the touch with a slight sheen. Simple solid light gray is most easily comparable to any color of your room decor. Great for everyday use, this duvet cover set offers smooth and soft comfort–all year-round.\nAwesome Details: Duvet Cover has a hidden zip closure barely noticeable; 8 interior corner ties to keep duvet/comforter in place; Pillow Cases have envelope end to tuck the pillow inside.\nKing Size Duvet Cover Set Package Includes: Duvet Cover (1 piece): 104 in. x 90 in.; Pillow Cases (Standard 2 pieces): 20 in. x 36 in.; Duvet/comforter inside is not included.\nEasy Care: Machine wash cold, gentle cycle only, using mild, liquid Laundry Detergent. Do not bleach. Iron on low heat if needed. Tumble dry low. Note: Do not overload washer and dryer.', '[\"Light Grey\"]', 1164000, 1864, 29, '[\"uploads\\\\product\\\\1738112303264-23346410.jpg\",\"uploads\\\\product\\\\1738112303267-581898232.jpg\",\"uploads\\\\product\\\\1738112303269-819527179.jpg\"]', '2025-01-29 00:58:23', '2025-01-29 00:58:23'),
(30, 'Superior Egyptian Cotton Pile Bath Towel Set of 2', 'Egyptian Cotton Pile\n𝐎𝐏𝐔𝐋𝐄𝐍𝐓 𝐂𝐎𝐌𝐅𝐎𝐑𝐓: These towels are crafted from Egyptian Cotton pile fibers that are naturally strong, absorbent, and soft; heavyweight and plush; Set includes: 2 Bath Towels (55\"L x 30\"W)\n𝐌𝐎𝐃𝐄𝐑𝐍 𝐃𝐄𝐒𝐈𝐆𝐍: State-of-the-art design is fashionable, elegant and classy; rope border for added texture and style; this beautiful bundle is perfect for any master bath, powder room, or guest bathroom; loop for easy hanging and drying\n𝐃𝐄𝐋𝐈𝐆𝐇𝐓𝐅𝐔𝐋 𝐂𝐎𝐋𝐎𝐑𝐒: Black, Chocolate Dark Brown, Charcoal, Cream, Forest Green, Latte Brown, Light Blue, Navy Blue, Plum, Purple, Red, Orange Rust, Seafoam, Stone Grey, Teal, Toast, Tea Rose Pink, White, Coral, Denim Blue, Silver, and Turquoise\n𝐄𝐅𝐅𝐎𝐑𝐓𝐋𝐄𝐒𝐒 𝐂𝐀𝐑𝐄: For the most luxurious results, we recommend to wash with like colors, tumble dry low, and remove promptly from the dryer. Please follow care label instructions for best results\n𝐄𝐗𝐂𝐄𝐋𝐋𝐄𝐍𝐓 𝐆𝐈𝐅𝐓: Our designs match a variety of styles and make great gifts; perfect for friends and family; we\'re committed to make products safer for you and safer for the world; this product is OEKO-TEX certified for safety and sustainability', '[]', 718000, 2783, 29, '[\"uploads\\\\product\\\\1738112424863-748716471.jpg\",\"uploads\\\\product\\\\1738112424864-276541967.jpg\",\"uploads\\\\product\\\\1738112424866-318938215.jpg\"]', '2025-01-29 01:00:24', '2025-01-29 01:00:24'),
(31, 'MPLONG Abstract Natural Geometric Wall Art Set of 3', '[High-quality material] High-definition pictures and photos printed with high-quality framed environmentally friendly canvas\n[Wide application] Perfect wall art decoration choice for any environment: living room, bedroom, bathroom, hotel, kitchen, bar, office\n[Easy to hang] There is an inner slot on the back of the PS material frame, which can be directly hung with nails (with a pendant kit)\n[Note] Due to different monitor brands, the actual color may be slightly different from the store picture. If you have any questions, you can send us an email.', '[\"16*24 inches\",\"20*28 inches\",\"24*32 inches\"]', 1115000, 1256, 29, '[\"uploads\\\\product\\\\1738112774153-981028190.jpg\",\"uploads\\\\product\\\\1738112774154-690845740.jpg\",\"uploads\\\\product\\\\1738112774155-708149075.jpg\",\"uploads\\\\product\\\\1738112774157-239093449.jpg\",\"uploads\\\\product\\\\1738112774159-65483284.jpg\"]', '2025-01-29 01:06:14', '2025-01-29 01:06:14');

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(3, 'misbach', 'misbach@guest.com', '$2b$10$6Xpoxk.bPYO9TnK84R1lD.IrCuJJXqI1Ak5cGyXm9oGIFkYiZvccC', 'user', '2025-01-22 16:28:54', '2025-01-22 16:28:54'),
(6, 'misbach2', 'misbach2@guest.com', '$2b$10$JNcbRkOmIRrs2uZd3pJ2Xu7gPQrypwf8rFp.xpECIZd6ne/iLin46', 'user', '2025-01-29 02:01:18', '2025-01-29 02:01:18'),
(7, 'johndoe', 'janedoe@pubsec.gov', '$2b$10$SeH4rRrgndjFmTqUPkPAH.FYzgN5TF7ZUcQIH5rTRpbAnZOvnlYbS', 'user', '2025-01-29 02:03:20', '2025-01-29 02:03:20');

--
-- Indexes for dumped tables
--

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
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_order_id_foreign` (`order_id`),
  ADD KEY `items_product_id_foreign` (`product_id`);

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
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

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
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

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

Config = {
	-- looks like this: 'LLL NNN'
	-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
	PlateLetters = 3,
	PlateNumbers = 3,
	PlateUseSpace = true,

	ResellPercentage = 0.6,
	TestDriveTimer = 30,
	Locations = {
		{ Identifier = 'catalogus', Coords = vector3(-56.9, -1097.1, 25.4) },
		{ Identifier = 'sell', Coords = vector3(-44.6, -1080.7, 25.6) },
		{ Identifier = 'spawnpoint', Coords = vector3(-28.6, -1085.6, 25.5), Heading = 330.0 }
	},
	Categories = {
		['compacts'] = 'Compacts',
		['coupes'] = 'Coupés',
		['motorcycles'] = 'Motors',
		['muscle'] = 'Muscle',
		['offroad'] = 'Off Road',
		['sedans'] = 'Sedans',
		['sports'] = 'Sports',
		['tuner1'] = 'Tuner',
		['super'] = 'Super',
		['suvs'] = 'SUVs',
		['vans'] = 'Vans'
	},
	Vehicles = {
		-- Compacts (compacts)
		{ name = 'Panto', model = 'panto', price = 1500, instore = true, harness = false, category = 'compacts', imglink = 'https://skisnowgames.nl/gta_cars/panto.png' },
		{ name = 'Blista', model = 'blista', price = 2750, instore = true, harness = false, category = 'compacts', imglink = 'https://skisnowgames.nl/gta_cars/blista.png' },
		{ name = 'Mini Cooper', model = 'cooperworks', price = 3500, instore = true, harness = false, category = 'compacts', imglink = 'https://img.gta5-mods.com/q95/images/mini-john-cooper-works-add-on-replace-tuning/d31cab-GTAVLauncher%202016-04-15%2021-05-24-44.png' },

		-- Coupés (coupes)
		{ name = 'Pontiac Firebird 1987', model = 'firebird87', price = 8200, instore = true, harness = false, category = 'coupes', imglink = 'https://img.gta5-mods.com/q95/images/1987-pontiac-firebird-trans-am-gta-add-on-lods-template/5e0699-2.jpg' },
		{ name = 'Mercedes E63', model = 'e63amg', price = 18500, instore = true, harness = false, category = 'coupes', imglink = 'https://img.gta5-mods.com/q95/images/mercedes-benz-e63-s-amg-add-on-lod-s-tuning-sound/be43ca-enb2020_6_15_19_52_31-1.png' },
		{ name = 'Cyclone', model = 'cyclone', price = 30000, instore = true, harness = true, category = 'coupes', imglink = 'https://skisnowgames.nl/gta_cars/cyclone.png' },
		{ name = 'Tesla Model S', model = 'models', price = 37500, instore = true, harness = false, category = 'coupes', imglink = 'https://img.gta5-mods.com/q95/images/tesla-model-s-add-on-cdfec839-7cf7-4908-8a02-d9112c4c1a52/a0a864-Slide4.JPG' },
		{ name = 'Mercedes-AMG C63', model = 'c63coupe', price = 39500, instore = true, harness = false, category = 'coupes', imglink = 'https://img.gta5-mods.com/q95/images/mercedes-benz-c63-coupe-amg-add-on-replace/eff5e9-yMiPDJ6EX0KTnRK4_V1_IA_0_0.jpg' },
		{ name = 'Bentley Supersport', model = 'ben17', price = 45000, instore = true, harness = false, category = 'coupes', imglink = 'https://img.gta5-mods.com/q95/images/2014-bentley-continental-gt-add-on-rhd/fcb204-Untitled6.jpg' },
		{ name = 'Corvette C8', model = 'c8', price = 220000, instore = true, harness = true, category = 'coupes', imglink = 'https://img.gta5-mods.com/q95/images/2020-corvette-c8-stingray-add-on-oiv-tuning-template/015250-20210228202210_1.jpg' },

		-- Motors (motorcycles)
		{ name = 'BF400', model = 'bf400', price = 2500, instore = true, harness = false, category = 'motorcycles', imglink = 'https://skisnowgames.nl/gta_cars/bf400.png' },
		{ name = 'Sanctus', model = 'sanctus', price = 3500, instore = true, harness = false, category = 'motorcycles', imglink = 'https://skisnowgames.nl/gta_cars/sanctus.png' },
		{ name = 'Manchez', model = 'manchez', price = 5500, instore = true, harness = false, category = 'motorcycles', imglink = 'https://skisnowgames.nl/gta_cars/manchez.png' },
		{ name = 'Harley Davidson', model = 'HDIron883', price = 12500, instore = true, harness = false, category = 'motorcycles', imglink = 'https://img.gta5-mods.com/q85-w800/images/harley-davidson-xl883n-sportster-iron-883-2017-add-on/bb2766-hd1.png' },
		{ name = 'Yamaha R6', model = 'r6', price = 29500, instore = true, harness = false, category = 'motorcycles', imglink = 'https://img.gta5-mods.com/q85-w800/images/yamaha-yzf-r6-2015-add-on-tunable/42c99a-GTA5%202016-04-03%2018-30-00-40.jpg' },
		{ name = 'Ducati 1199', model = 'd99', price = 34000, instore = true, harness = false, category = 'motorcycles', imglink = 'https://img.gta5-mods.com/q95/images/ducati-1199-panigale-add-on-tunable-imtaj/1d5d89-GTA5%202016-03-25%2017-30-09-81.jpg' },
		
		-- Muscle (muscle)
		{ name = 'Nightshade', model = 'nightshade', price = 6500, instore = true, harness = false, category = 'muscle', imglink = 'https://skisnowgames.nl/gta_cars/nightshade.png' },
		{ name = 'Ford Shelby GT500', model = 'taki428', price = 12000, instore = true, harness = false, category = 'muscle', imglink = 'https://img.gta5-mods.com/q85-w800/images/shelby-gt500-428cj-1969-add-on-tuning/465ec2-aEVE-20210725164634.127.png' },
		{ name = 'Chevrolet Camaro ZL1', model = 'zl12017', price = 32000, instore = true, harness = false, category = 'muscle', imglink = 'https://img.gta5-mods.com/q85-w800/images/chevrolet-camaro-zl1-2017-add-on/bae403-123.png' },
		{ name = 'Ford Mustang GT', model = 'mgt', price = 48000, instore = true, harness = false, category = 'muscle', imglink = 'https://img.gta5-mods.com/q95/images/2015-ford-mustang-gt/848bca-557f82fbb2fb4316a3826b1227a4462308f7d3c8.jpg' },
		{ name = 'Dodge Challenger', model = '16challenger', price = 86000, instore = true, harness = false, category = 'muscle', imglink = 'https://img.gta5-mods.com/q95/images/2015-dodge-challenger-add-on-stock-shaker-hellcat/d62c91-enb2017_8_6_11_16_55.jpg' },
		{ name = 'Dodge SRT Hellcat', model = 'sjdodge', price = 78000, instore = true, harness = false, category = 'muscle', imglink = 'https://img.gta5-mods.com/q95/images/2020-dodge-charger-srt-hellcat-addon-tuning-extras/1c46fc-photo_2022-03-26_00-14-23.jpg' },

		-- Off Road (offroad)
		{ name = 'GMC Sierra 1500', model = 'gmcs', price = 21500, instore = true, harness = false, category = 'offroad', imglink = 'https://img.gta5-mods.com/q95/images/gmc-sierra-1500-crew-cab-all-terrain-x-2017-add-on/c3aaee-EVE-20180611021548.jpg' },
		{ name = 'Ford Bronco Wildtrak', model = 'wildtrak', price = 27500, instore = true, harness = false, category = 'offroad', imglink = 'https://img.gta5-mods.com/q95/images/2021-ford-bronco-wildtrak-add-on-fivem/d693a7-20210421154917_1.jpg' },
		{ name = 'Mercedes G65', model = 'g65amg', price = 30000, instore = true, harness = false, category = 'offroad', imglink = 'https://img.gta5-mods.com/q95/images/mercedes-benz-g-class-2019-add-on/e6e0ec-EVE-20180617150006.jpg' },

		-- Sedans (sedans)
		{ name = 'Washington', model = 'washington', price = 5000, instore = true, harness = false, category = 'sedans', imglink = 'https://skisnowgames.nl/gta_cars/washington.png' },
		{ name = 'Audi A8', model = 'a8audi', price = 8000, instore = true, harness = false, category = 'sedans', imglink = 'https://img.gta5-mods.com/q95/images/audi-a8-dragon777/8eb3a7-GTA5%202018-08-26%2016-36-24-44.jpg' },
		{ name = 'Crown Victoria', model = 'stanier', price = 5500, instore = true, harness = false, category = 'sedans', imglink = 'https://img.gta5-mods.com/q85-w800/images/1999-ford-crown-victoria/44fe7f-FCV_STOCK_1.jpg' },
		{ name = 'Kuruma', model = 'kuruma', price = 15000, instore = true, harness = false, category = 'sedans', imglink = 'https://skisnowgames.nl/gta_cars/kuruma.png' },
		{ name = 'Audi RS6', model = 'audirs6tk', price = 25000, instore = true, harness = false, category = 'sedans', imglink = 'https://img.gta5-mods.com/q95/images/2014-audi-rs6/c66c7c-GTA5%202017-12-31%2016-27-41.jpg' },

		-- Sports (sports)
		{ name = 'RT3000', model = 'rt3000', price = 8000, instore = true, harness = false, category = 'sports', imglink = 'https://peacemakersnetwork.org/wp-content/uploads/2019/09/placeholder.jpg' },
		{ name = 'Schlagen', model = 'schlagen', price = 11000, instore = true, harness = false, category = 'sports', imglink = 'https://skisnowgames.nl/gta_cars/schlagen.png' },
		{ name = 'Subaru Impreza WRX', model = 'subwrx', price = 18000, instore = true, harness = true, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/2011-subaru-impreza-sti-tunable/f78ab4-1%20-%202011%20Subaru%20Impreza%20STI%20GTA%20V%20%201.jpg' },
		{ name = 'Mitsubishi Evo IX', model = 'evo9mr', price = 19500, instore = false, harness = true, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/mitsubishi-lancer-evolution-ix-mr-add-on/40db32-QQ%E5%9B%BE%E7%89%8720160719002856.jpg' },
		{ name = 'Audi RS3 Sportback', model = 'rs318', price = 20000, instore = true, harness = false, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/audi-rs3-sportback-2018-add-on-tuning/c61e5a-EVE1.jpg' },
		{ name = 'Nissan Skyline R34', model = 'skyline', price = 27500, instore = true, harness = true, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/nissan-skyline-gt-r-bnr34-yca-y97y/0c6b6a-GTA5%202015-09-19%2002-39-17-82.jpg' },
		{ name = 'Coquette', model = 'coquette', price = 30000, instore = true, harness = false, category = 'sports', imglink = 'https://skisnowgames.nl/gta_cars/coquette.png' },
		{ name = 'Lexus LC 500', model = 'lc500', price = 35000, instore = true, harness = true, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/2018-lexus-lc-500-add-on-tuning-hq/7fed58-2DcBbOJ.jpg' },
		{ name = 'Corvette C7', model = 'c7', price = 45000, instore = false, harness = true, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/2014-chevrolet-corvette-c7-stingray-aige/94c335-20161117230409_1.jpg' },
		{ name = 'BMW M5 (Drift)', model = 'bmci', price = 52000, instore = true, harness = true, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/bmw-m5-f90-2018-add-on-hq-template/07f471-wmplayer%202018-01-24%2012-11-17-41.png' },
		{ name = 'Nissan GT-R R35', model = 'r35', price = 115000, instore = true, harness = true, category = 'sports', imglink = 'https://img.gta5-mods.com/q95/images/nissan-gtr-r35-varis-wald-c-west-topsecret/e3c7ac-20180514214521_1.jpg' },

		-- Super (super)
		{ name = 'Ford GT', model = 'fgt', price = 145000, instore = true, harness = true, category = 'super', imglink = 'https://img.gta5-mods.com/q95/images/2005-ford-gt-aige/2b6afe-33333.jpg' },
		{ name = 'BMW M8', model = 'bmwm8', price = 175000, instore = true, harness = false, category = 'super', imglink = 'https://img.gta5-mods.com/q85-w800/images/2019-bmw-m8/1abba6-9.png' },
		{ name = 'Porsche Cayman 981', model = 'c981', price = 180000, instore = true, harness = false, category = 'super', imglink = 'https://img.gta5-mods.com/q95/images/porsche-cayman-981-gts-template-tuning/2ad95b-Grand_Theft_Auto_V_Screenshot_2019.12.11_-_18.58.15.40.jpg' },
		{ name = 'Lamborghini Huracan', model = 'lhuracant', price = 260000, instore = true, harness = false, category = 'super', imglink = 'https://img.gta5-mods.com/q95/images/lamborghini-huracan-add-on-tuning/2428df-notmy.png' },
		{ name = 'McLaren 720s', model = '720s', price = 302000, instore = true, harness = true, category = 'super', imglink = 'https://cs2.gtaall.com/screenshots/4dc09/2019-05/original/6709259486d77fce54d383c34b1caa7931480f7b/724698-ice2019-5-22-17-40-59.jpg' },
		{ name = 'Ferrari Superfast', model = 'f812', price = 430000, instore = true, harness = true, category = 'super', imglink = 'https://img.gta5-mods.com/q95/images/ferrari-812-superfast/81c8d7-4.jpg' },
		{ name = 'Bugatti Veyron', model = 'bugatti', price = 1900000, instore = true, harness = true, category = 'super', imglink = 'https://img.gta5-mods.com/q95/images/bugatti-veyron-grand-sport/49c8c2-9.jpg' },
		{ name = 'Jaguar XJR-15', model = 'xjr15', price = 175000, instore = true, harness = true, category = 'super', imglink = 'https://img.gta5-mods.com/q95/images/jaguar-xjr-15-add-on-fivem/194ea1-6.jpg' },

		-- SUVs (suvs)
		{ name = 'Chevrolet Tahoe', model = 'tahoe', price = 20000, instore = true, harness = false, category = 'suvs', imglink = 'https://img.gta5-mods.com/q95/images/chevrolet-tahoe-add-on-replace/dce7aa-0_168f23_df066d9_XXXL.png' },
		{ name = 'Jeep Trackhawk', model = 'trhawk', price = 35000, instore = true, harness = false, category = 'suvs', imglink = 'https://img.gta5-mods.com/q95/images/2018-jeep-grand-cherokee-trackhawk-series-iv-add-on/399598-GTA5%202018-05-02%2012-08-59-77.png' },
		{ name = 'Range-Rover Velar', model = 'velar', price = 45000, instore = true, harness = false, category = 'suvs', imglink = 'https://img.gta5-mods.com/q95/images/2018-range-rover-velar/8c0bb7-QQ%E5%9B%BE%E7%89%8720190609113949.jpg' },
		{ name = 'Ford Mustang Mach-E', model = 'mache', price = 68000, instore = true, harness = false, category = 'suvs', imglink = 'https://img.gta5-mods.com/q85-w800/images/2021-mustang-mach-e-add-on-fivem/b3e689-20210105130344_1.jpg' },
		{ name = 'Audi Q8 2020', model = 'q820', price = 82000, instore = true, harness = false, category = 'suvs', imglink = 'https://img.gta5-mods.com/q95/images/audi-q8-50tdi-2020-add-on-fivem/2960e1-5.jpg' },

		-- Vans (vans)
		{ name = 'Youga Classic', model = 'youga2', price = 20000, instore = true, harness = false, category = 'vans', imglink = 'https://skisnowgames.nl/gta_cars/youga.png' },
		{ name = 'Bison', model = 'bison', price = 21000, instore = true, harness = false, category = 'vans', imglink = 'https://skisnowgames.nl/gta_cars/bison.png' },
		{ name = 'Burrito', model = 'burrito3', price = 22500, instore = true, harness = false, category = 'vans', imglink = 'https://skisnowgames.nl/gta_cars/burrito.png' },
		{ name = 'Gang Burrito', model = 'gburrito2', price = 25000, instore = true, harness = false, category = 'vans', imglink = 'https://skisnowgames.nl/gta_cars/gangburrito.png' },

		-- Tuner (tuner1)
		-- 195 (MediumAcc)
		{ name = 'Futo', model = 'futo2', price = 25000, instore = true, harness = false, category = 'tuner1', imglink = 'https://peacemakersnetwork.org/wp-content/uploads/2019/09/placeholder.jpg' },
		-- 195 (FastAcc)
		{ name = 'Elegy', model = 'elegy', price = 28000, instore = true, harness = true, category = 'tuner1', imglink = 'https://www.gtabase.com/images/gta-5/vehicles/sports/main/elegy-retro-custom.jpg' },
		{ name = 'BMW M3 E36', model = 'rm3e36', price = 31250, instore = false, harness = true, category = 'tuner1', imglink = 'https://img.gta5-mods.com/q95/images/bmw-m3-e36-streetcustom-add-on-tuning/05b27d-20161009013302_1.jpg' },
		-- 208 (MediumAcc)
		{ name = 'Nissan Fairlady 350Z', model = 'maj350z', price = 35000, instore = true, harness = true, category = 'tuner1', imglink = 'https://img.gta5-mods.com/q95/images/nissan-350z-z33-add-on-tuning/eb9c43-6.png' },
		-- Ultimate drift
		{ name = 'Drift Tampa', model = 'tampa2', price = 45000, instore = true, harness = true, category = 'tuner1', imglink = 'https://skisnowgames.nl/gta_cars/tampa2.png' },

		-- Tuner (tuner2)
		-- 187 (SlowAcc)
		{ name = 'Previon', model = 'previon', price = 0, instore = false, harness = true, category = 'tuner2', imglink = 'https://peacemakersnetwork.org/wp-content/uploads/2019/09/placeholder.jpg' },
		-- 196 (MediumAcc)
		{ name = 'Remus', model = 'remus', price = 0, instore = false, harness = true, category = 'tuner2', imglink = 'https://peacemakersnetwork.org/wp-content/uploads/2019/09/placeholder.jpg' },
		-- 206 (MediumAcc)
		{ name = 'ZR350', model = 'zr350', price = 0, instore = false, harness = true, category = 'tuner2', imglink = 'https://peacemakersnetwork.org/wp-content/uploads/2019/09/placeholder.jpg' },
		{ name = 'Nissan Silvia S14', model = 'silvia3', price = 0, instore = false, harness = true, category = 'tuner2', imglink = 'https://www.skisnowgames.nl/images/1exy4ezl.png' },
		-- 208 (FastAcc)
		{ name = 'Dominator', model = 'dominator7', price = 0, instore = false, harness = true, category = 'tuner2' },
		-- ~213 (MediumAcc)
		{ name = 'Nissan Skyline R32', model = 'bnr32', price = 0, instore = false, harness = true, category = 'tuner2' },

		-- Tuner (tuner3)
		-- 227 (FastAcc)
		{ name = 'Sultan', model = 'sultan3', price = 0, instore = false, harness = true, category = 'tuner3' },
		-- 236 (MediumAcc)
		{ name = 'Comet', model = 'comet6', price = 0, instore = false, harness = true, category = 'tuner3' },
		-- 248 (FastAcc)
		{ name = 'Jester', model = 'jester4', price = 0, instore = false, harness = true, category = 'tuner3' },
		-- 261 (FastAcc)
		{ name = 'Vectre', model = 'vectre', price = 0, instore = false, harness = true, category = 'tuner3' },
		-- 265 (UltraAcc)
		{ name = 'Toyota Supra', model = 'a80', price = 0, instore = false, harness = true, category = 'tuner3', imglink = 'https://img.gta5-mods.com/q95/images/toyota-supra-add-on-stock-more-tuning/15a926-(5).jpg' },

		-- Emergency
		-- Cop cars
		{ model = 'polvic2',  instore = false, harness = false, category = 'emergency' },
		{ model = 'polchar',  instore = false, harness = true,  category = 'emergency' },
		{ model = 'camaroRB', instore = false, harness = true,  category = 'emergency' },
		-- Ambulance cars
		-- ...

		-- Emergency Bikes
		{ model = 'polthrust', instore = false, category = 'b_emergency' },
	}
}

--[[
	Image Placeholder: https://peacemakersnetwork.org/wp-content/uploads/2019/09/placeholder.jpg
	Tuner Update Cars: https://rage.mp/forums/topic/10496-los-santos-tuners-hashes/
]]
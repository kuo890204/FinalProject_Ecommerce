-- Note: Not deleting existing products due to foreign key constraints
-- Products will be added to existing data

-- Insert Electronics
INSERT INTO products (name, price, stock, category, image) VALUES
('Apple iPhone 15 Pro', 35900, 25, 'Electronics', 'https://images.unsplash.com/photo-1695048064820-5f846b7b1a4c?w=500'),
('Samsung Galaxy S24 Ultra', 36900, 30, 'Electronics', 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500'),
('MacBook Pro 14 M3', 59900, 15, 'Electronics', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500'),
('iPad Air 11', 19900, 40, 'Electronics', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500'),
('AirPods Pro Gen 2', 7490, 60, 'Electronics', 'https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=500'),
('Sony WH-1000XM5', 11990, 35, 'Electronics', 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500'),
('Canon EOS R6 Mark II', 89900, 8, 'Electronics', 'https://images.unsplash.com/photo-1606980395352-b8c0d8fc8c56?w=500'),
('Nintendo Switch OLED', 10980, 45, 'Electronics', 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=500');

-- Insert Home Appliances
INSERT INTO products (name, price, stock, category, image) VALUES
('Dyson V15 Vacuum', 21900, 20, 'Home', 'https://images.unsplash.com/photo-1558317374-067fb8f8c7df?w=500'),
('Xiaomi Air Purifier 4 Pro', 6995, 30, 'Home', 'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=500'),
('Panasonic Microwave 27L', 4990, 25, 'Home', 'https://images.unsplash.com/photo-1585659722983-3a675dabf23d?w=500'),
('Philips Air Fryer HD9252', 5990, 40, 'Home', 'https://images.unsplash.com/photo-1585515320310-259814833e62?w=500'),
('Electrolux Washing Machine', 19900, 12, 'Home', 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=500'),
('TOSHIBA Refrigerator 508L', 32900, 8, 'Home', 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=500');

-- Insert Sports & Fitness
INSERT INTO products (name, price, stock, category, image) VALUES
('Nike Air Zoom Pegasus 40', 3800, 50, 'Sports', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500'),
('Adidas Ultraboost 23', 5980, 45, 'Sports', 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500'),
('Under Armour Backpack', 1980, 60, 'Sports', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500'),
('Lululemon Yoga Mat', 2300, 70, 'Sports', 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500'),
('BLADEZ Dumbbell Set 24kg', 4990, 30, 'Sports', 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=500'),
('Fitbit Charge 6', 5990, 40, 'Sports', 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=500');

-- Insert Fashion
INSERT INTO products (name, price, stock, category, image) VALUES
('Uniqlo Down Jacket', 2990, 80, 'Fashion', 'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?w=500'),
('Levis 501 Jeans', 2490, 65, 'Fashion', 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500'),
('The North Face Backpack', 3490, 50, 'Fashion', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500'),
('Ray-Ban Sunglasses', 4980, 40, 'Fashion', 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500'),
('Casio G-Shock Watch', 3990, 35, 'Fashion', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500'),
('Samsonite Luggage 28inch', 7990, 25, 'Fashion', 'https://images.unsplash.com/photo-1565026057447-bc90a3dceb87?w=500');

-- Insert Living
INSERT INTO products (name, price, stock, category, image) VALUES
('IKEA Billy Bookcase', 2990, 30, 'Living', 'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500'),
('Muji Storage Box Set', 890, 100, 'Living', 'https://images.unsplash.com/photo-1600353068440-6361ef3a86e8?w=500'),
('Nitori Memory Pillow', 1290, 80, 'Living', 'https://images.unsplash.com/photo-1631049552240-59c37f38802b?w=500'),
('HOLA Nordic Rug', 2490, 45, 'Living', 'https://images.unsplash.com/photo-1600210491892-03d54c0aaf87?w=500'),
('LED Desk Lamp', 1590, 60, 'Living', 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500'),
('Scented Candle Set', 680, 120, 'Living', 'https://images.unsplash.com/photo-1602874801006-e24aa81e35d2?w=500');

-- Insert Beauty
INSERT INTO products (name, price, stock, category, image) VALUES
('SK-II Facial Treatment 230ml', 7680, 40, 'Beauty', 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500'),
('Estee Lauder Advanced Serum', 2680, 55, 'Beauty', 'https://images.unsplash.com/photo-1571875257727-256c39da42af?w=500'),
('Lancome Genifique Serum', 3200, 45, 'Beauty', 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=500'),
('Shiseido Benefiance Cream', 2990, 50, 'Beauty', 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=500'),
('MAC Lipstick', 850, 90, 'Beauty', 'https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=500'),
('NARS Foundation', 1850, 60, 'Beauty', 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=500');

-- Insert Food
INSERT INTO products (name, price, stock, category, image) VALUES
('Meiji Chocolate Gift Box', 580, 150, 'Food', 'https://images.unsplash.com/photo-1511381939415-e44015466834?w=500'),
('Italian Olive Oil 1L', 690, 80, 'Food', 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500'),
('UCC Coffee Beans', 450, 120, 'Food', 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=500'),
('TWININGS Tea Gift Set', 720, 100, 'Food', 'https://images.unsplash.com/photo-1594631661960-377704a0b5b1?w=500'),
('Japanese Cereal Combo', 380, 200, 'Food', 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=500'),
('Korean Seaweed Gift Box', 320, 180, 'Food', 'https://images.unsplash.com/photo-1626200419199-391ae4be7a41?w=500');

-- Insert Stationery
INSERT INTO products (name, price, stock, category, image) VALUES
('Atomic Habits Book', 330, 150, 'Stationery', 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500'),
('The Courage to be Disliked', 300, 120, 'Stationery', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500'),
('LAMY Safari Fountain Pen', 990, 80, 'Stationery', 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500'),
('Moleskine Classic Notebook', 680, 100, 'Stationery', 'https://images.unsplash.com/photo-1531346878377-a5be20888e57?w=500'),
('Pentel Mechanical Pencil Set', 350, 200, 'Stationery', 'https://images.unsplash.com/photo-1598520106830-8c45c2035460?w=500'),
('3M Post-it Note Set', 280, 250, 'Stationery', 'https://images.unsplash.com/photo-1600071186732-633b5f87ff92?w=500');

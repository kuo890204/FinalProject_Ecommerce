-- 清空現有商品資料（可選）
-- DELETE FROM products;

-- 設定字元編碼
SET NAMES utf8mb4;

-- 插入豐富的商品資料
-- 分類：電子產品

INSERT INTO products (name, price, stock, category, image) VALUES
('Apple iPhone 15 Pro', 35900, 25, '電子產品', 'https://images.unsplash.com/photo-1695048064820-5f846b7b1a4c?w=500'),
('Samsung Galaxy S24 Ultra', 36900, 30, '電子產品', 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500'),
('MacBook Pro 14吋 M3', 59900, 15, '電子產品', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500'),
('iPad Air 11吋', 19900, 40, '電子產品', 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500'),
('AirPods Pro 第二代', 7490, 60, '電子產品', 'https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=500'),
('Sony WH-1000XM5 降噪耳機', 11990, 35, '電子產品', 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500'),
('Canon EOS R6 Mark II', 89900, 8, '電子產品', 'https://images.unsplash.com/photo-1606980395352-b8c0d8fc8c56?w=500'),
('Nintendo Switch OLED', 10980, 45, '電子產品', 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=500');

-- 分類：家電用品

INSERT INTO products (name, price, stock, category, image) VALUES
('Dyson V15 無線吸塵器', 21900, 20, '家電用品', 'https://images.unsplash.com/photo-1558317374-067fb8f8c7df?w=500'),
('小米空氣清淨機 4 Pro', 6995, 30, '家電用品', 'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=500'),
('Panasonic 微波爐 27L', 4990, 25, '家電用品', 'https://images.unsplash.com/photo-1585659722983-3a675dabf23d?w=500'),
('飛利浦氣炸鍋 HD9252', 5990, 40, '家電用品', 'https://images.unsplash.com/photo-1585515320310-259814833e62?w=500'),
('Electrolux 洗衣機 11kg', 19900, 12, '家電用品', 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=500'),
('TOSHIBA 變頻冰箱 508L', 32900, 8, '家電用品', 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=500');

-- 分類：運動健身

INSERT INTO products (name, price, stock, category, image) VALUES
('Nike Air Zoom Pegasus 40', 3800, 50, '運動健身', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500'),
('Adidas Ultraboost 23', 5980, 45, '運動健身', 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500'),
('Under Armour 運動背包', 1980, 60, '運動健身', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500'),
('Lululemon 瑜珈墊', 2300, 70, '運動健身', 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500'),
('BLADEZ 可調式啞鈴 24kg', 4990, 30, '運動健身', 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=500'),
('Fitbit Charge 6 智慧手環', 5990, 40, '運動健身', 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=500');

-- 分類：服飾配件

INSERT INTO products (name, price, stock, category, image) VALUES
('Uniqlo 羽絨外套', 2990, 80, '服飾配件', 'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?w=500'),
('Levi''s 501 牛仔褲', 2490, 65, '服飾配件', 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500'),
('The North Face 背包', 3490, 50, '服飾配件', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500'),
('Ray-Ban 太陽眼鏡', 4980, 40, '服飾配件', 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=500'),
('Casio G-Shock 手錶', 3990, 35, '服飾配件', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500'),
('Samsonite 行李箱 28吋', 7990, 25, '服飾配件', 'https://images.unsplash.com/photo-1565026057447-bc90a3dceb87?w=500');

-- 分類：居家生活

INSERT INTO products (name, price, stock, category, image) VALUES
('IKEA Billy 書櫃', 2990, 30, '居家生活', 'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500'),
('muji 收納箱組', 890, 100, '居家生活', 'https://images.unsplash.com/photo-1600353068440-6361ef3a86e8?w=500'),
('Nitori 記憶枕', 1290, 80, '居家生活', 'https://images.unsplash.com/photo-1631049552240-59c37f38802b?w=500'),
('HOLA 北歐風地毯', 2490, 45, '居家生活', 'https://images.unsplash.com/photo-1600210491892-03d54c0aaf87?w=500'),
('特力屋 LED檯燈', 1590, 60, '居家生活', 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500'),
('生活工場 香氛蠟燭組', 680, 120, '居家生活', 'https://images.unsplash.com/photo-1602874801006-e24aa81e35d2?w=500');

-- 分類：美妝保養

INSERT INTO products (name, price, stock, category, image) VALUES
('SK-II 青春露 230ml', 7680, 40, '美妝保養', 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500'),
('Estée Lauder 小棕瓶', 2680, 55, '美妝保養', 'https://images.unsplash.com/photo-1571875257727-256c39da42af?w=500'),
('蘭蔻超未來肌因賦活露', 3200, 45, '美妝保養', 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=500'),
('資生堂 百優精純乳霜', 2990, 50, '美妝保養', 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=500'),
('MAC 時尚專業唇膏', 850, 90, '美妝保養', 'https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=500'),
('NARS 裸光奇肌粉底液', 1850, 60, '美妝保養', 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=500');

-- 分類：食品飲料

INSERT INTO products (name, price, stock, category, image) VALUES
('日本明治巧克力禮盒', 580, 150, '食品飲料', 'https://images.unsplash.com/photo-1511381939415-e44015466834?w=500'),
('義大利進口橄欖油 1L', 690, 80, '食品飲料', 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500'),
('UCC 職人精選咖啡豆', 450, 120, '食品飲料', 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=500'),
('TWININGS 唐寧茶禮盒', 720, 100, '食品飲料', 'https://images.unsplash.com/photo-1594631661960-377704a0b5b1?w=500'),
('日本麥片早餐組合', 380, 200, '食品飲料', 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=500'),
('韓國海苔禮盒', 320, 180, '食品飲料', 'https://images.unsplash.com/photo-1626200419199-391ae4be7a41?w=500');

-- 分類：書籍文具

INSERT INTO products (name, price, stock, category, image) VALUES
('原子習慣（暢銷經典版）', 330, 150, '書籍文具', 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500'),
('被討厭的勇氣', 300, 120, '書籍文具', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500'),
('LAMY Safari 鋼筆', 990, 80, '書籍文具', 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500'),
('Moleskine 經典筆記本', 680, 100, '書籍文具', 'https://images.unsplash.com/photo-1531346878377-a5be20888e57?w=500'),
('Pentel 自動鉛筆組', 350, 200, '書籍文具', 'https://images.unsplash.com/photo-1598520106830-8c45c2035460?w=500'),
('3M 便利貼超值組', 280, 250, '書籍文具', 'https://images.unsplash.com/photo-1600071186732-633b5f87ff92?w=500');

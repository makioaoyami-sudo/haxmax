# Haxmax v1.3.0 - Hướng dẫn cài đặt trên máy tính

## Yêu cầu hệ thống

### Windows
1. **Node.js v20+**
   - Tải từ: https://nodejs.org (chọn LTS)
   - Cài đặt → Next → Next → Finish
   - Kiểm tra: mở CMD → gõ `node -v`

2. **pnpm**
   - Mở CMD → gõ: `npm install -g pnpm`
   - Kiểm tra: `pnpm -v`

3. **Python 3**
   - Tải từ: https://www.python.org/downloads/
   - Khi cài, tick "Add Python to PATH"
   - Kiểm tra: `python --version`

4. **ffmpeg**
   - Tải từ: https://www.gyan.dev/ffmpeg/builds/ (chọn "ffmpeg-release-essentials.zip")
   - Giải nén → copy thư mục `bin` vào `C:\ffmpeg\bin`
   - Thêm `C:\ffmpeg\bin` vào PATH:
     - Tìm "Environment Variables" trong Windows Search
     - System Variables → Path → Edit → New → `C:\ffmpeg\bin`
   - Kiểm tra: mở CMD mới → `ffmpeg -version`

5. **yt-dlp**
   - Mở CMD → gõ: `pip install yt-dlp`
   - Kiểm tra: `yt-dlp --version`

### macOS
```bash
# Cài Homebrew (nếu chưa có)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Cài các công cụ
brew install node python ffmpeg
npm install -g pnpm
pip3 install yt-dlp
```

### Linux (Ubuntu/Debian)
```bash
# Cài Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Cài các công cụ
sudo apt install -y ffmpeg python3 python3-pip
npm install -g pnpm
pip3 install yt-dlp
```

---

## Cài đặt Haxmax

### Bước 1: Tải source code
- Vào https://github.com/makioaoyami-sudo/haxmax
- Nhấn nút xanh **"<> Code"** → **"Download ZIP"**
- Giải nén vào thư mục bạn muốn (ví dụ: `C:\haxmax` hoặc `~/haxmax`)

Hoặc dùng git:
```bash
git clone https://github.com/makioaoyami-sudo/haxmax.git
cd haxmax
```

### Bước 2: Cài dependencies
```bash
cd haxmax
pnpm install
```

### Bước 3: Tạo file biến môi trường
Tạo file `.env` trong thư mục gốc `haxmax/` với nội dung:

```
PORT=3000
NODE_ENV=production
ELEVENLABS_API_KEY=your_elevenlabs_key_here
OPENAI_API_KEY=your_openai_key_here
SONIOX_API_KEY=your_soniox_key_here
VBEE_API_KEY=your_vbee_key_here
```

Thay `your_xxx_key_here` bằng API key thật của bạn.

### Bước 4: Build frontend
```bash
# Windows CMD
set BASE_PATH=/ && set PORT=3000 && pnpm --filter @workspace/video-downloader run build

# macOS/Linux
BASE_PATH="/" PORT=3000 pnpm --filter @workspace/video-downloader run build
```

### Bước 5: Build backend
```bash
pnpm --filter @workspace/api-server run build
```

### Bước 6: Chạy server
```bash
# Windows CMD
set PORT=3000 && set NODE_ENV=production && node --enable-source-maps artifacts/api-server/dist/index.mjs

# macOS/Linux
PORT=3000 NODE_ENV=production node --enable-source-maps artifacts/api-server/dist/index.mjs
```

### Bước 7: Mở trình duyệt
Truy cập: **http://localhost:3000**

API Key để đăng nhập: `HA7-A9F3-K8L2-P0QW`

---

## Tạo file khởi động nhanh (tùy chọn)

### Windows - Tạo file `start.bat`
Tạo file `start.bat` trong thư mục `haxmax/`:
```bat
@echo off
set PORT=3000
set NODE_ENV=production
set ELEVENLABS_API_KEY=your_key
set OPENAI_API_KEY=your_key
set SONIOX_API_KEY=your_key
set VBEE_API_KEY=your_key
echo Dang khoi dong Haxmax...
echo Mo trinh duyet: http://localhost:3000
node --enable-source-maps artifacts/api-server/dist/index.mjs
pause
```

Sau đó chỉ cần double-click `start.bat` để chạy.

### macOS/Linux - Tạo file `start.sh`
```bash
#!/bin/bash
export PORT=3000
export NODE_ENV=production
export ELEVENLABS_API_KEY=your_key
export OPENAI_API_KEY=your_key
export SONIOX_API_KEY=your_key
export VBEE_API_KEY=your_key
echo "Dang khoi dong Haxmax..."
echo "Mo trinh duyet: http://localhost:3000"
node --enable-source-maps artifacts/api-server/dist/index.mjs
```

Chạy: `chmod +x start.sh && ./start.sh`

---

## Tính năng chính

- **Download Video**: Hỗ trợ YouTube, TikTok, Douyin, Instagram, Facebook, Twitter/X, Vimeo, Bilibili...
- **Thư viện Video**: Lưu trữ video đã tải trên server
- **Reup Tools**: 8+ tính năng chống phát hiện (đổi tốc độ, thêm hiệu ứng, xoay, watermark, phụ đề...)
- **Voice AI**: Tạo giọng nói VN (Vbee) / EN (ElevenLabs)
- **AI Script**: Phân tích video + viết kịch bản bằng Gemini + GPT-4o
- **Ngôn ngữ**: Hỗ trợ Tiếng Việt / English

## Khắc phục lỗi thường gặp

| Lỗi | Nguyên nhân | Cách fix |
|-----|-------------|----------|
| `ffmpeg: command not found` | Chưa cài ffmpeg hoặc chưa thêm vào PATH | Cài lại ffmpeg, thêm vào PATH |
| `yt-dlp: command not found` | Chưa cài yt-dlp | Chạy `pip install yt-dlp` |
| `EADDRINUSE: address already in use` | Port 3000 đang bị dùng | Đổi PORT thành 3001 hoặc tắt app đang dùng port 3000 |
| Video tải về lỗi format | yt-dlp cần cập nhật | Chạy `pip install --upgrade yt-dlp` |
| Voice AI không hoạt động | API key sai hoặc hết hạn | Kiểm tra lại API key trong .env |

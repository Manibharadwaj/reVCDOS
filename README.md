# GTA Vice City — HTML5 Port (DOS Zone)

Port made by the DOS.Zone team: [dos.zone/reVCDOS](https://dos.zone/revcdos)
Official implementation: [GitHub](https://github.com/Carter54git/revcdos)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/13GFRIxTwVbixv0Vup9MSVXnB4SLmA3G7?usp=sharing)

Web-based port of GTA: Vice City running in browser via WebAssembly.

---

## 🚀 Quick Start (3 commands)

```bash
git clone https://github.com/Manibharadwaj/reVCDOS.git
cd reVCDOS
python3 server.py
```

That's it. The server auto-downloads the game archive (~1GB, one-time) and starts at **http://localhost:8000**

> **Note:** First run takes 5-15 min to download the game archive. After that it loads instantly from the cached file.

## 📦 Requirements

- **Python 3.8+** (with pip)
- ~1GB disk space for the game archive (auto-downloaded on first run)

## 🛠️ Setup Methods

### Method 1: Python (Easiest — recommended)

```bash
# 1. Clone
git clone https://github.com/Manibharadwaj/reVCDOS.git
cd reVCDOS

# 2. Install deps
pip install -r requirements.txt

# 3. Run (auto-downloads game archive on first run)
python3 server.py
```

Open **http://localhost:8000** in your browser. Done!

If pip gives permission errors, use a virtual env:
```bash
python3 -m venv .venv
source .venv/bin/activate   # Linux/Mac
# OR: .venv\Scripts\activate   # Windows
pip install -r requirements.txt
python3 server.py
```

### Method 2: Docker

```bash
git clone https://github.com/Manibharadwaj/reVCDOS.git
cd reVCDOS
PACKED=https://folder.morgen.qzz.io/revcdos.bin docker compose up -d --build
```

Open **http://localhost:8000**

Docker environment variables:

| Variable | Description |
|----------|-------------|
| `OUT_HOST` | External host (default: `0.0.0.0`) |
| `OUT_PORT` | External port (default: `8000`) |
| `IN_PORT` | Internal container port (default: `8000`) |
| `AUTH_LOGIN` | HTTP Basic Auth username |
| `AUTH_PASSWORD` | HTTP Basic Auth password |
| `CUSTOM_SAVES` | Enable local saves (set to `1`) |
| `PACKED` | Serve from packed archive (URL or filename) |

### Method 3: Google Colab (No install needed)

Click the **Open In Colab** badge above, run the cell, click "Launch Game".

### Method 4: PHP Hosting (No Python needed)

Upload the repo contents to any PHP 8.0+ web host. The `index.php` and `.htaccess` handle everything.

## 🎮 Playing the Game

Just open **http://localhost:8000** in your browser. The game loads in the tab.

### URL Options

Add these to the URL: `http://localhost:8000/?option=value`

| Option | Values | What it does |
|--------|--------|-------------|
| `cheats` | `1` | Enable cheat menu (press **F3** in-game) |
| `lang` | `en`, `ru` | Game language (default: English) |
| `max_fps` | `1-240` | Cap frame rate (e.g. `60`) |
| `configurable` | `1` | Show settings before launching |
| `fullscreen` | `0` | Disable auto-fullscreen |

**Examples:**
- `http://localhost:8000/?cheats=1` — play with cheats
- `http://localhost:8000/?lang=ru&cheats=1` — Russian + cheats
- `http://localhost:8000/?configurable=1` — settings menu first

## 🎮 Cheats

Enable with `?cheats=1` in the URL. Press **F3** in-game to open the cheat menu:

- Memory scanner (find/edit values)
- All classic GTA VC cheats
- AirBreak (noclip mode)
- God mode, money, etc.

## 💾 Saves

### Cloud Saves (default)
Enter any js-dos key on the start page. Saves sync via DOS Zone.

### Local Saves
Run with `--custom_saves` flag:
```bash
python3 server.py --custom_saves
```
Enter any 5+ character key — saves stored in `saves/` on the server.

## ⚙️ Server Options

```bash
python3 server.py [OPTIONS]
```

| Option | Default | Description |
|--------|---------|-------------|
| `--port PORT` | `8000` | Server port |
| `--packed FILE/URL` | auto | Packed archive to serve from (default: auto-downloads) |
| `--custom_saves` | off | Enable local save files |
| `--login USER` | none | HTTP Basic Auth username |
| `--password PASS` | none | HTTP Basic Auth password (auth requires both) |
| `--vcsky_local` | off | Serve vcsky from local `vcsky/` dir |
| `--vcbr_local` | off | Serve vcbr from local `vcbr/` dir |
| `--vcsky_cache` | off | Cache proxied vcsky files locally |
| `--vcbr_cache` | off | Cache proxied vcbr files locally |
| `--unpacked FILE/URL` | off | Unpack archive then serve from local files |
| `--pack DIR` | off | Pack a folder into archive, then serve it |

**Common examples:**
```bash
# Default (auto-downloads game archive)
python3 server.py

# Custom port
python3 server.py --port 3000

# With auth + local saves
python3 server.py --login admin --password secret --custom_saves

# Use a local archive file
python3 server.py --packed revcdos.bin

# Cache CDN files locally (use if CDN works, saves bandwidth)
python3 server.py --vcsky_cache --vcbr_cache
```

> ⚠️ **CDN Proxy mode** (running without `--packed`) relies on `cdn.dos.zone` which may be unavailable. Use `--packed` (now the default) for reliable operation.

## 🖥️ Remote Setup (for a friend)

Want to set this up on someone else's machine? Use **RustDesk** (free, open source remote desktop):

1. **On your machine:** `brew install --cask rustdesk` (Mac) or download from [rustdesk.com](https://rustdesk.com)
2. **On their machine:** Download & install RustDesk from [rustdesk.com](https://rustdesk.com)
3. They share their **ID + Password** with you
4. You connect → see their screen → open their terminal → run the Quick Start commands above

## 📁 Project Structure

```
├── server.py           # FastAPI proxy server
├── index.php           # PHP proxy server (shared hosting)
├── .htaccess           # Apache config for PHP
├── requirements.txt    # Python dependencies
├── additions/          # Server extensions (auth, cache, packed, saves)
├── utils/              # Utility modules (packer, downloader)
├── dist/               # Game client files (HTML, JS, WASM modules)
├── docker-compose.yml  # Docker setup
└── colab_reVCDOS.ipynb # Colab notebook
```

## 📱 Mobile

Touch controls appear automatically on mobile devices — virtual joysticks + action buttons.

## License

MIT. Do what you want (but credit the port authors). Not affiliated with Rockstar Games.

---

**Authors:** DOS Zone ([@specialist003](https://github.com/okhmanyuk-ev), [@caiiiycuk](https://www.youtube.com/caiiiycuk), [@SerGen](https://t.me/ser_var))

**Deobfuscated by:** [@Lolendor](https://github.com/Lolendor)

**Russian translation:** [GamesVoice](https://www.gamesvoice.ru/)

**Community contributions:** PHP Support by [Rohamgames](https://github.com/Rohamgames), Touch controls by [@aboelnazer2010-cmd](https://github.com/aboelnazer2010-cmd)

## Support

If you find this project useful:

- **TON / USDT (TON)** `UQAyBchGEKi9NnNQ3AKMQMuO-SGEhMIAKFAbkwwrsiOPj9Gy`
- **ETH / USDT (ERC-20)** `0x69Ec02715cF65538Bb03725F03Bd4c85D33F8AC0`
- **TRX / USDT (TRC-20)** `THgNWT9MGW52tF8qFHbAWN25UR6WTeLDMY`
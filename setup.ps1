param(
  [Parameter(Mandatory=$true)]
  [string]$RepoUrl
)

# 1. إنشاء المجلدات الأساسية
$folders = @('styles','scripts','assets')
foreach ($f in $folders) {
  if (-not (Test-Path $f)) {
    New-Item -ItemType Directory -Path $f | Out-Null
  }
}

# 2. index.html
@"
<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>TiTaPa – الرئيسية</title>
  <link rel='stylesheet' href='styles/styles.css'>
</head>
<body>
  <header>
    <nav>
      <img src='assets/logo.svg' alt='TiTaPa Logo' class='logo'>
      <ul>
        <li><a href='index.html'>الرئيسية</a></li>
        <li><a href='live.html'>بث مباشر</a></li>
        <li><a href='dashboard.html'>لوحة تحكم</a></li>
        <li><a href='chat.html'>الدردشة الذكية</a></li>
        <li><a href='services.html'>الخدمات</a></li>
        <li><a href='romance.html'>الرومانسية</a></li>
        <li><a href='premium-chat.html'>الدردشة المدفوعة</a></li>
        <li><button id='lang-toggle'>عربي/EN</button></li>
      </ul>
    </nav>
  </header>

  <section id='hero'>
    <div class='background-animation'></div>
    <h1>TiTaPa</h1>
    <p>منصة بث وترجمة متكاملة، مصممة بالكامل خصيصاً لك.</p>
    <div class='hero-buttons'>
      <button>ابدأ الآن</button>
      <button>المزيد</button>
    </div>
  </section>

  <section id='features'>
    <div class='card'>
      <img src='assets/audio.svg' alt='بث صوتي'>
      <h3>بث صوتي</h3>
      <p>تجربة صوتية عالية الجودة.</p>
    </div>
    <div class='card'>
      <img src='assets/video.svg' alt='بث فيديو'>
      <h3>بث فيديو</h3>
      <p>Full HD باستخدام WebRTC وLiveKit.</p>
    </div>
    <div class='card'>
      <img src='assets/translate.svg' alt='ترجمة حية'>
      <h3>ترجمة حية</h3>
      <p>دعم فوري وديناميكي للغات متعددة.</p>
    </div>
    <div class='card'>
      <img src='assets/ai.svg' alt='ذكاء اصطناعي'>
      <h3>ذكاء اصطناعي</h3>
      <p>مساعد ذكي للدردشة والترجمة.</p>
    </div>
  </section>

  <footer>
    <ul>
      <li><a href='#contact'>تواصل معنا</a></li>
      <li><a href='#privacy'>سياسة الخصوصية</a></li>
      <li><a href='#terms'>شروط الاستخدام</a></li>
    </ul>
  </footer>

  <script src='scripts/app.js'></script>
</body>
</html>
"@ | Out-File index.html -Encoding utf8


# 3. live.html
@"
<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>TiTaPa – بث مباشر</title>
  <link rel='stylesheet' href='styles/styles.css'>
  <script src='https://unpkg.com/livekit-client/dist/livekit-client.min.js'></script>
</head>
<body>
  <header>
    <nav>
      <img src='assets/logo.svg' alt='TiTaPa Logo' class='logo'>
      <ul>
        <li><a href='index.html'>الرئيسية</a></li>
        <li><a href='live.html'>بث مباشر</a></li>
        <li><a href='dashboard.html'>لوحة تحكم</a></li>
        <li><button id='lang-toggle'>عربي/EN</button></li>
      </ul>
    </nav>
  </header>

  <div id='video-player' class='player'></div>
  <div class='controls'>
    <button onclick='joinRoom()'>انضم</button>
    <button onclick='toggleCam()'>كتم الكاميرا</button>
    <button onclick='toggleMic()'>كتم الصوت</button>
  </div>

  <script src='scripts/app.js'></script>
  <script>
    async function joinRoom() {
      const url = 'YOUR_LIVEKIT_WS_URL';
      const token = 'YOUR_ACCESS_TOKEN';
      const room = await LiveKit.connect(url, token);
      const track = await room.localParticipant.createCameraTrack();
      room.localParticipant.publishTrack(track);
      const container = document.getElementById('video-player');
      room.on('trackPublished', (pub) => {
        if (pub.track.kind === 'video') {
          container.appendChild(pub.track.attach());
        }
      });
    }
    function toggleCam() { /* ... */ }
    function toggleMic() { /* ... */ }
  </script>
</body>
</html>
"@ | Out-File live.html -Encoding utf8


# 4. dashboard.html
@"
<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>TiTaPa – لوحة تحكم</title>
  <link rel='stylesheet' href='styles/styles.css'>
</head>
<body>
  <aside class='sidebar'>
    <img src='assets/logo.svg' alt='TiTaPa Logo' class='logo-sidebar'>
    <nav>
      <a href='index.html'>الرئيسية</a>
      <a href='live.html'>بث مباشر</a>
      <a href='dashboard.html'>لوحة تحكم</a>
      <a href='chat.html'>الدردشة الذكية</a>
      <a href='services.html'>الخدمات</a>
    </nav>
  </aside>
  <main class='main-content'>
    <section class='card'><h3>إحصائيات عامة</h3></section>
    <section class='card'><h3>إدارة الجلسات</h3></section>
    <section class='card'><h3>التخصيص</h3></section>
  </main>
  <script src='scripts/app.js'></script>
</body>
</html>
"@ | Out-File dashboard.html -Encoding utf8


# 5. chat.html
@"
<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>TiTaPa – الدردشة الذكية</title>
  <link rel='stylesheet' href='styles/styles.css'>
</head>
<body>
  <header>
    <nav>
      <img src='assets/logo.svg' alt='TiTaPa Logo' class='logo'>
      <ul>
        <li><a href='index.html'>الرئيسية</a></li>
        <li><a href='live.html'>بث مباشر</a></li>
        <li><a href='dashboard.html'>لوحة تحكم</a></li>
        <li><a href='chat.html'>الدردشة الذكية</a></li>
        <li><button id='lang-toggle'>عربي/EN</button></li>
      </ul>
    </nav>
  </header>
  <main class='chat-page'>
    <div class='chat-container'>
      <div id='messages' class='messages'></div>
      <form id='chat-form'>
        <input id='chat-input' type='text' placeholder='أرسل رسالة…' autocomplete='off' />
        <button type='submit'>إرسال</button>
      </form>
    </div>
  </main>
  <script src='scripts/app.js'></script>
  <script>
    const form = document.getElementById('chat-form');
    form.addEventListener('submit', e => {
      e.preventDefault();
      const input = document.getElementById('chat-input');
      const msg = input.value.trim();
      if (!msg) return;
      document.getElementById('messages').innerHTML += `<div class='msg user'>أنت: ${msg}</div>`;
      input.value = '';
      // هنا يمكنك استدعاء API ذكاء اصطناعي
      setTimeout(() => {
        document.getElementById('messages').innerHTML += `<div class='msg bot'>TiTaPa: هذا رد تجريبي.</div>`;
      }, 500);
    });
  </script>
</body>
</html>
"@ | Out-File chat.html -Encoding utf8


# 6. services.html
@"
<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>TiTaPa – الخدمات</title>
  <link rel='stylesheet' href='styles/styles.css'>
</head>
<body>
  <header>
    <nav>
      <img src='assets/logo.svg' alt='TiTaPa Logo' class='logo'>
      <ul>
        <li><a href='index.html'>الرئيسية</a></li>
        <li><a href='services.html'>الخدمات</a></li>
        <li><button id='lang-toggle'>عربي/EN</button></li>
      </ul>
    </nav>
  </header>
  <main class='services-page'>
    <h1>خدمات TiTaPa</h1>
    <div class='services-grid'>
      <div class='service-card'><h3>بث صوتي</h3><p>جودة واستقرار عاليان.</p></div>
      <div class='service-card'><h3>بث فيديو</h3><p>Full HD عبر WebRTC.</p></div>
      <div class='service-card'><h3>ترجمة حية</h3><p>دعم لغات فوري.</p></div>
      <div class='service-card'><h3>الدردشة الذكية</h3><p>مساعد آلي متطور.</p></div>
    </div>
  </main>
</body>
</html>
"@ | Out-File services.html -Encoding utf8


# 7. romance.html
@"
<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>TiTaPa – الرومانسية</title>
  <link rel='stylesheet' href='styles/styles.css'>
</head>
<body class='romance-theme'>
  <header>
    <nav>
      <img src='assets/logo.svg' alt='TiTaPa Logo' class='logo'>
      <ul>
        <li><a href='index.html'>الرئيسية</a></li>
        <li><a href='romance.html'>الرومانسية</a></li>
        <li><button id='lang-toggle'>عربي/EN</button></li>
      </ul>
    </nav>
  </header>
  <main class='romance-page'>
    <h1>زاوية الرومانسية</h1>
    <p>تجربة بصرية حالمة بظلال زجاجية.</p>
  </main>
</body>
</html>
"@ | Out-File romance.html -Encoding utf8


# 8. premium-chat.html
@"
<!DOCTYPE html>
<html lang='ar' dir='rtl'>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>TiTaPa – الدردشة المدفوعة</title>
  <link rel='stylesheet' href='styles/styles.css'>
</head>
<body>
  <header>
    <nav>
      <img src='assets/logo.svg' alt='TiTaPa Logo' class='logo'>
      <ul>
        <li><a href='index.html'>الرئيسية</a></li>
        <li><a href='premium-chat.html'>الدردشة المدفوعة</a></li>
        <li><button id='lang-toggle'>عربي/EN</button></li>
      </ul>
    </nav>
  </header>
  <main class='premium-chat-page'>
    <h1>الدردشة المدفوعة</h1>
    <p>ميزات حصرية للمشتركين.</p>
    <!-- دمج بوابة دفع هنا -->
  </main>
</body>
</html>
"@ | Out-File premium-chat.html -Encoding utf8


# 9. styles/styles.css
@"
:root {
  --primary: #ff6f61;
  --secondary: #3f51b5;
  --bg-start: #f5f7fa;
  --bg-end: #c3cfe2;
  --glass: rgba(255,255,255,0.4);
}
* { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI',sans-serif; }
body {
  background: linear-gradient(135deg, var(--bg-start), var(--bg-end));
  min-height:100vh; color:#333;
}
nav ul { list-style:none; display:flex; gap:10px; align-items:center; }
nav a, button { padding:10px 20px; border:none; border-radius:25px; background:var(--primary); color:#fff; cursor:pointer; text-decoration:none; transition:transform .2s; }
nav a:hover, button:hover { transform:translateY(-2px); }
.logo, .logo-sidebar { height:40px; }
#hero { position:relative; text-align:center; padding:80px 20px; background:url('../assets/hero-bg.jpg') center/cover; }
#hero::before { content:''; position:absolute; inset:0; backdrop-filter:blur(6px) brightness(0.7); background:var(--glass); }
.hero-buttons button { margin:0 10px; }
#features, .services-grid { display:flex; flex-wrap:wrap; justify-content:center; gap:20px; padding:40px 20px; }
.card, .service-card {
  background:var(--glass); backdrop-filter:blur(10px);
  border-radius:16px; padding:20px; width:240px; text-align:center;
  box-shadow:0 8px 24px rgba(0,0,0,0.1); transition:transform .3s;
}
.card:hover, .service-card:hover { transform:translateY(-6px); }
.chat-page, .services-page, .romance-page, .premium-chat-page { padding:50px 20px; text-align:center; }
.chat-container { max-width:600px; margin:0 auto; background:var(--glass); backdrop-filter:blur(10px); border-radius:12px; overflow:hidden; }
.messages { max-height:300px; overflow-y:auto; padding:20px; }
.msg { margin-bottom:12px; }
.msg.user { text-align:right; }
.msg.bot { text-align:left; }
#chat-form { display:flex; border-top:1px solid #eee; }
#chat-input { flex:1; padding:10px; border:none; }
#chat-form button { padding:0 20px; background:var(--secondary); border:none; color:#fff; cursor:pointer; }
.romance-theme { background: linear-gradient(135deg, #fbc2eb, #a18cd1); color:#fff; }
.romance-page { padding:100px 20px; backdrop-filter:blur(4px); border-radius:12px; }
.premium-chat-page { padding:80px 20px; }
"@ | Out-File styles/styles.css -Encoding utf8


# 10. scripts/app.js
@"
document.getElementById('lang-toggle')?.addEventListener('click', () => {
  alert('سيتم دعم اللغة الإنجليزية قريباً!');
});
"@ | Out-File scripts/app.js -Encoding utf8


# 11. إنشاء ملفات Assets placeholders
$assets = @('logo.svg','hero-bg.jpg','audio.svg','video.svg','translate.svg','ai.svg','services.svg','romance.svg','premium.svg')
foreach ($a in $assets) {
  $path = Join-Path 'assets' $a
  if (-not (Test-Path $path)) {
    New-Item -ItemType File -Path $path | Out-Null
  }
}

# 12. تهيئة Git ورفع الملفات
git init
git branch -M main
git remote add origin $RepoUrl
git add .
git commit -m 'Initial commit - TiTaPa full design'
git push -u origin main --force

Write-Host 'Done. Check your GitHub repo and Vercel deployment.'

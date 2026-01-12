<%@page import="com.bloodline.entities.Message"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Login — BloodLine Hospital</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>

  <style>
    /* Background */
    .bg-blood-drop {
      background-image: url('assets/img/blood-drop-bg.jpg');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      position: relative;
    }

    .overlay-dark {
      position: absolute;
      inset: 0;
      background: rgba(0,0,0,0.60);
      z-index: 0;
    }

    .bg-pulse::after {
      content: "";
      position: absolute;
      inset: 0;
      background: radial-gradient(circle at 40% 30%, rgba(255, 0, 35, 0.12), transparent 40%),
                  radial-gradient(circle at 70% 70%, rgba(255, 0, 35, 0.06), transparent 40%);
      animation: pulse 8s infinite ease-in-out;
      z-index: 1;
    }
    @keyframes pulse { 0%{opacity:.6}50%{opacity:.85}100%{opacity:.6} }

    /* Glass card */
    .glass {
      background: rgba(255,255,255,0.06);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border: 1px solid rgba(255,255,255,0.12);
      box-shadow: 0 10px 30px rgba(0,0,0,0.5);
      z-index: 10;
    }

    .nav-glass {
      background: rgba(0,0,0,0.45);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255,255,255,0.12);
      z-index: 50;
    }

    /* Container for interactive drops */
    .drops-layer {
      position: absolute;
      inset: 0;
      pointer-events: none; /* so it doesn't block inputs */
      overflow: hidden;
      z-index: 2;
    }

    /* Single drop base style */
    .drop {
      position: absolute;
      width: 34px;
      height: 46px;
      background: radial-gradient(circle at 30% 30%, #ff5466 0%, #b30000 60%);
      border-radius: 45% 45% 50% 50% / 55% 55% 45% 45%;
      transform: rotate(45deg);
      opacity: 0.85;
      will-change: transform, opacity;
      filter: drop-shadow(0 6px 12px rgba(0,0,0,0.35));
    }

    /* subtle bob animation for each drop (independent) */
    @keyframes bob {
      0% { transform: translateY(0) rotate(45deg) }
      50% { transform: translateY(-8px) rotate(45deg) }
      100% { transform: translateY(0) rotate(45deg) }
    }

    /* small screens tune */
    @media (max-width: 640px) {
      .drop { width: 22px; height: 30px; }
    }
  </style>
</head>
<body class="min-h-screen text-gray-100">

  <!-- NAVBAR -->
  <header class="fixed top-0 w-full nav-glass z-50">
    <div class="max-w-7xl mx-auto px-6 py-3 flex items-center justify-between">
      <a href="index.jsp" class="flex items-center gap-3">
        <img src="assets/img/Logo.png" class="h-10 w-10 object-contain" alt="Logo">
        <span class="text-lg font-bold text-red-400">BloodLine</span>
      </a>

      <nav class="hidden md:flex gap-6 text-gray-200 font-medium">
        <a href="index.html" class="hover:text-white">HOME</a>
        <a href="lookingBlood.jsp" class="hover:text-white">LOOKING FOR BLOOD</a>
        <a href="register_page.jsp" class="hover:text-white">REGISTER</a>
        <a href="#contact" class="hover:text-white">CONTACT</a>
      </nav>
    </div>
  </header>

  <!-- MAIN: background + interactive drops -->
  <main class="min-h-screen bg-blood-drop bg-pulse relative flex items-center justify-center pt-24 overflow-hidden">

    <!-- dark overlay for readability -->
    <div class="overlay-dark"></div>

    <!-- Layer where drops will be inserted -->
    <div id="dropsLayer" class="drops-layer" aria-hidden="true"></div>

    <div class="relative z-20 w-full max-w-lg px-6">
      <div class="glass rounded-2xl p-8">

        <h2 class="text-3xl font-bold text-center text-red-300 mb-4">Log in to BloodLine</h2>

        <!-- server-side message -->
        <%
          Message msg = (Message) session.getAttribute("msg");
          if (msg != null) {
        %>
          <div class="mb-4 text-center px-4 py-2 rounded bg-red-600/50 border border-red-400 text-white">
            <%= msg.getContent() %>
          </div>
        <%
            session.removeAttribute("msg");
          }
        %>

        <!-- keep mapping same -->
        <form id="loginForm" action="LogingServlet1" method="POST" class="space-y-4" autocomplete="on">
          <div>
            <label class="block text-sm mb-1">Email address</label>
            <input name="email" type="email" required
                   class="w-full px-3 py-2 rounded-md bg-white/10 border border-white/20 text-white focus:ring-2 focus:ring-red-400"
                   placeholder="you@example.com">
          </div>

          <div>
            <label class="block text-sm mb-1">Password</label>
            <input name="password" type="password" required
                   class="w-full px-3 py-2 rounded-md bg-white/10 border border-white/20 text-white focus:ring-2 focus:ring-red-400"
                   placeholder="Your password">
          </div>

          <div class="flex items-center justify-between text-sm">
            <label class="inline-flex items-center gap-2 text-gray-200">
              <input name="remember" type="checkbox" class="h-4 w-4"> Remember me
            </label>
            <a href="forgot_password.jsp" class="text-red-300 hover:underline">Forgot password?</a>
          </div>

          <button type="submit" id="loginBtn"
                  class="w-full py-2 rounded-md bg-red-500 hover:bg-red-600 text-white font-semibold">
            Log in
          </button>

          <p class="text-sm text-gray-300 text-center mt-3">
            Don't have an account? <a href="register_page.jsp" class="text-red-300 underline">Register</a>
          </p>
        </form>

      </div>
    </div>
  </main>

  <!-- minimal JS: create interactive drops and parallax motion -->
  <script>
    (function () {
      const dropsLayer = document.getElementById('dropsLayer');
      const numDrops = 12; // number of drops
      const dropElements = [];

      // Utility: random number in range
      function rand(min, max) { return Math.random() * (max - min) + min; }

      // Create drops at random positions with independent bob animation
      for (let i = 0; i < numDrops; i++) {
        const d = document.createElement('div');
        d.className = 'drop';
        // random position across the viewport
        const left = rand(2, 96); // percent
        const top = rand(10, 90); // percent
        d.style.left = left + '%';
        d.style.top = top + '%';

        // random size multiplier
        const scale = rand(0.7, 1.25);
        d.style.width = (34 * scale) + 'px';
        d.style.height = (46 * scale) + 'px';

        // animation duration & delay for bobbing (different per drop)
        const dur = rand(4, 8);
        const delay = rand(0, 3);
        d.style.animation = `bob ${dur}s ease-in-out ${delay}s infinite`;

        // give each drop a subtle alpha variation
        d.style.opacity = (rand(0.6, 0.95)).toFixed(2);

        dropsLayer.appendChild(d);
        dropElements.push({
          el: d,
          baseX: left, // percent
          baseY: top,  // percent
          depth: rand(0.2, 1.0) // parallax depth (smaller = farther)
        });
      }

      // Mouse / touch tracking for parallax
      let mouseX = window.innerWidth / 2;
      let mouseY = window.innerHeight / 2;
      let targetX = mouseX, targetY = mouseY;

      function onMove(e) {
        if (e.touches && e.touches.length) {
          targetX = e.touches[0].clientX;
          targetY = e.touches[0].clientY;
        } else {
          targetX = e.clientX;
          targetY = e.clientY;
        }
      }

      window.addEventListener('mousemove', onMove, { passive: true });
      window.addEventListener('touchmove', onMove, { passive: true });

      // smooth follow
      function lerp(a, b, t) { return a + (b - a) * t; }

      function animate() {
        mouseX = lerp(mouseX, targetX, 0.08);
        mouseY = lerp(mouseY, targetY, 0.08);

        const cx = window.innerWidth / 2;
        const cy = window.innerHeight / 2;

        // normalized cursor relative to center (-1 .. 1)
        const nx = (mouseX - cx) / cx;
        const ny = (mouseY - cy) / cy;

        // apply parallax transform based on each drop's depth
        dropElements.forEach((dobj, idx) => {
          const el = dobj.el;
          // compute offset in px: deeper drops move less
          const depth = dobj.depth; // 0.2..1.0
          // x movement (inverse to cursor for subtle parallax)
          const moveX = nx * 20 * depth * -1;
          const moveY = ny * 12 * depth * -1;

          // small rotation depending on index and depth for realism
          const rot = (nx * 6 * depth) + (Math.sin((Date.now() / 1000) + idx) * 1.5 * depth);

          el.style.transform = `translate3d(${moveX}px, ${moveY}px, 0) rotate(${45 + rot}deg)`;
          // optionally change opacity slightly with Y to create depth effect
          const baseOpacity = parseFloat(el.style.opacity || 0.8);
          el.style.opacity = Math.max(0.35, Math.min(1, baseOpacity + (-ny * 0.08 * depth)));
        });

        requestAnimationFrame(animate);
      }

      // start animation loop
      requestAnimationFrame(animate);

      // resize behavior: reposition drops to maintain viewport percent positions
      window.addEventListener('resize', function () {
        // nothing needed because we set positions with percent; keep it responsive
      }, { passive: true });

    })();
  </script>

</body>
</html>

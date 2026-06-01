teclamouse.exe https://github.com/Adaill/Gear/releases/tag/access

    msg .= "═══════════════════════════════`n"
    msg .= "🧭 KEYJOY GEAR - FULL GUIDE`n"
    msg .= "👤 @criadepc`n" BORN IN PC
    msg .= "═══════════════════════════════`n`n"

    msg .= "🔴 MAIN CONTROL`n"
    msg .= "- SHIFT + HOME or Numpad- → Turn script ON / OFF`n"

    ; =========================
    ; MODES
    ; =========================
    msg .= "🟡 SYSTEM MODES`n"

    msg .= "🔴 OFF MODE`n"
    msg .= "- SHIFT + HOME or Numpad- → Allows normal typing and keyboard usage quickly`n`n"
	
    msg .= "🖱️ MOUSE MODE (default)`n"
    msg .= "  • Mouse movement enabled via Numpad`n"
	msg .= "  • Num5 = ft clickL`n"
    msg .= "  • Ctrl = left click`n"
    msg .= "  • Alt = right click`n`n"
	
    msg .= "🖱️ INVERTED MOUSE MODE (INSERT KEY)`n"
    msg .= "  • Mouse movement enabled via WASD`n"
    msg .= "  • E = left click`n"
    msg .= "  • Q = right click`n`n"
	msg .= "  • SHIFT + W = sense up`n"
    msg .= "  • SHIFT + S = sense down`n`n"

    msg .= "🎮 GAME MODE (Shift + J)`n"
    msg .= "  • Adjusts sensitivity (required for some games)`n"
    msg .= "  • Uses direct mouse API (mouse_event)`n"
    msg .= "  • Cursor resets to screen center`n`n"
	
	msg .= "🗽 TRUE CRIME NY MODE (F6)`n"
    msg .= "  • Liberate diagonals 7/9/1/3 for games like TRUE CRIME NY`n`n"
	msg .= "  • That uses them by STANDARD`n`n"

    ; =========================
    ; ENTER CLICK
    ; =========================
    msg .= "⏎ ENTER CLICK MODE (' key)`n"
    msg .= "  • Toggles SenseGear vs Left Click to NumEnter`n"
    msg .= "  • Dectivates arrows as mouse (they become normal arrows)`n`n"
    msg .= "- Ctrl/Alt return to normal when EnterClick is ON`n`n"

    ; =========================
    ; MOVEMENT
    ; =========================
    msg .= "🧭 MOVEMENT (NUMPAD)`n"
    msg .= "- PAGE UP / ↑ → Scroll up`n"
    msg .= "- PAGE DOWN / ↓ → Scroll down`n"
    msg .= "- Numpad8 / ↑ → move up`n"
    msg .= "- Numpad2 / ↓ → move down`n"
    msg .= "- Numpad4 / ← → move left`n"
    msg .= "- Numpad6 / → → move right`n"
    msg .= "- Diagonals supported`n`n"

    ; =========================
    ; SCROLL / SPEED
    ; =========================
    msg .= "⚙️ SPEED / SENSITIVITY`n"
    msg .= "- CapsLock + WheelUp → Increase sensitivity`n"
    msg .= "- CapsLock + WheelDown → Decrease sensitivity`n"
    msg .= "- XButton1 + Wheel → Quick adjustment`n"
    msg .= "- NumpadEnter + Numpad8 → Increase`n"
    msg .= "- NumpadEnter + Numpad2 → Decrease`n`n"

    msg .= "📊 ADJUSTMENT LEVELS`n"
    msg .= "  • 1 = fine (precision)`n"
    msg .= "  • 2 = medium`n"
    msg .= "  • 3 = fast (high gain)`n`n"
	msg .= "  • F7 = decreases burst accel`n`n"
	msg .= "  • F8 = increases burst accel`n`n"
	msg .= "  • Accel serves for aim fast adjustments `n`n"
	msg .= "  • at the first moments of the key being pressed`n`n"

    ; =========================
    ; SPECIAL CONTROLS
    ; =========================
    msg .= "🧩 SPECIAL CONTROLS`n"
    msg .= "- Ctrl → left click`n"
    msg .= "- Alt → right click`n"
    msg .= "- Ctrl/Alt return to normal when EnterClick is ON`n`n"

    ; =========================
    ; STATUS
    ; =========================
    msg .= "📌 CURRENT STATUS`n"
    msg .= "- GameMode: " (IsGameMode ? "ON" : "OFF") "`n"
    msg .= "- EnterClick: " (EnterClickEnabled ? "ON" : "OFF") "`n"
    msg .= "- Sensitivity: " PassoVelocidade "`n`n"

    msg .= "═══════════════════════════════"

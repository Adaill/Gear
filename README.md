Transform your keyboard into a high level joykey controller.

Watch happening https://www.youtube.com/watch?v=OwW92DXjxac

https://www.youtube.com/live/_Ueuq8wz6Xc

Be careful with ANTI CHEATS, spread the world so it becomes normal and developed (I tested in some SAMP servers and wasnt banned).

Needs to be tested in online games with anticheats

just download any of the .exe according to your language open it then CAPSLOCK + Home or Num- (Minus) F1 for help with cursor on DESKTOP

SHIFT J inside a game to lock cursor on center so it becomes live IN Game (also sense stock adjust) F7 and F8 to adjust mouse accel burst (if u hold it for 1sec the sense is totalmente adjustable to aim.

numEnter + num 8 / num 2 - operá-la sense gear adjustmente 

same to capslock + scrollwheel up/down

" ' " makes numEnter a left click disables LCtrl and LAlt from being left and right cliks and they assume normal letra and lalt funciona (also toggle arrowkeys as mouse or normal arrows)
 
LAlt and Num+ are right clicks

num5, and Lctrl and num0 are left clicks

* is mouse 3

- toggle script on or off

Insert makes WASD as mouse too

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

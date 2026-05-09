; ############################################################################
; # MOUSE CAMBIAL - V1.0 OPEN SOURCE- PLUGIN ACESSIBILIDADE ANTICHEAT  🚫   #
; # @criadepc - PROFIT FREE                                                 #
; ############################################################################

#Requires AutoHotkey v2.0
#SingleInstance Force

ListLines 0
ProcessSetPriority "High"

A_MaxHotkeysPerInterval := 1000
A_HotkeyInterval := 10

SetNumLockState "AlwaysOn"

EnterClick() {
    Send "{Enter}"
}

#HotIf (IsActive && !IsTyping)

NumpadDot::Send "{RButton Down}"
NumpadDot Up::Send "{RButton Up}"

*::Send "{MButton}"      
/::Send "{XButton2}"     ; Mouse 4 alternativo (mais seguro)
*Numpad0::Send "{Blind}{LButton Down}"
*Numpad0 Up::Send "{Blind}{LButton Up}"
*Numpad5::Send "{Blind}{LButton Down}"
*Numpad5 Up::Send "{Blind}{LButton Up}"
*NumpadAdd::Send "{Blind}{RButton Down}"
*NumpadAdd Up::Send "{Blind}{RButton Up}"

; =========================================================
; SETAS = MOVIMENTO DO MOUSE
; =========================================================

Up:: {
    global KeyUpHeld := true
}

Up Up:: {
    global KeyUpHeld := false
}

Down:: {
    global KeyDownHeld := true
}

Down Up:: {
    global KeyDownHeld := false
}

Left:: {
    global KeyLeftHeld := true
}

Left Up:: {
    global KeyLeftHeld := false
}

Right:: {
    global KeyRightHeld := true
}

Right Up:: {
    global KeyRightHeld := false
}


#HotIf

; =========================================================
; ESTADOS GLOBAIS
; =========================================================

; =========================================================
; TOPMOST GUARD (ANTI-SOBREPOSIÇÃO)
; =========================================================

global TopMostGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
TopMostGui.Show("NoActivate Hide")

SetTimer(ManterSempreNoTopo, 1000)

ManterSempreNoTopo() {
    global TopMostGui

    hwnd := TopMostGui.Hwnd

    DllCall("SetWindowPos",
        "ptr", hwnd,
        "ptr", -1, ; HWND_TOPMOST
        "int", 0, "int", 0, "int", 0, "int", 0,
        "uint", 0x0001 | 0x0002 ; SWP_NOMOVE | SWP_NOSIZE
    )
}


global IsActive := false
global IsGameMode := false
global IsTyping := false

global PassoVelocidade := 387

; =========================================================
; ESTADOS DAS TECLAS
; =========================================================

global KeyUpHeld := false
global KeyDownHeld := false
global KeyLeftHeld := false
global KeyRightHeld := false
global EnterClickEnabled := false

global KeyUpLeftHeld := false
global KeyUpRightHeld := false
global KeyDownLeftHeld := false
global KeyDownRightHeld := false

; =========================================================
; TIMER
; =========================================================

DefinirProximoCiclo() {
    SetTimer(MotorDeMovimento, 1)
}

; =========================================================
; CONTROLE PRINCIPAL
; =========================================================

AlternarScript() {

    global IsActive
    global IsGameMode
    global IsTyping

    IsActive := !IsActive

    if (!IsActive) {

        IsGameMode := false
        IsTyping := false

        ResetarMovimento()
    }

    ExibirFeedback(
        IsActive
        ? "⚡ @criadepc: ONLINE"
        : "🛑 @criadepc: OFFLINE"
    )

    if (IsActive)
        DefinirProximoCiclo()
}

; =========================================================
; HOTKEYS GLOBAIS
; =========================================================

CapsLock & Home::AlternarScript()
NumpadSub::AlternarScript()

#HotIf IsActive

':: {

    global EnterClickEnabled, IsTyping

    ; 🔒 Se estiver digitando, a tecla funciona normalmente
    if (IsTyping) {
        Send "'"
        return
    }

    ; 🔁 Caso contrário, apenas alterna EnterClick
    EnterClickEnabled := !EnterClickEnabled

    ExibirFeedback(
        EnterClickEnabled
        ? "⏎ EnterClick: ON"
        : "⏎ EnterClick: OFF"
    )
}

+j:: {

    global IsGameMode

    IsGameMode := !IsGameMode

    ExibirFeedback(
        IsGameMode
        ? "🎮 MODO JOGO: TURBO 6x"
        : "🖥️ MODO DESKTOP"
    )
}

#HotIf

; =========================================================
; MOTOR PRINCIPAL
; =========================================================

MotorDeMovimento() {

    global IsActive, IsTyping, IsGameMode, PassoVelocidade
    global KeyUpHeld, KeyDownHeld, KeyLeftHeld, KeyRightHeld
    global KeyUpLeftHeld, KeyUpRightHeld, KeyDownLeftHeld, KeyDownRightHeld

    if (!IsActive || IsTyping)
        return

    local dx := 0
    local dy := 0

    local velocidade := PassoVelocidade / 100
    local forca := IsGameMode ? 6.0 : 1.0

    if (KeyUpHeld)
        dy -= velocidade
    if (KeyDownHeld)
        dy += velocidade
    if (KeyLeftHeld)
        dx -= velocidade
    if (KeyRightHeld)
        dx += velocidade

    if (KeyUpLeftHeld) {
        dx -= velocidade
        dy -= velocidade
    }

    if (KeyUpRightHeld) {
        dx += velocidade
        dy -= velocidade
    }

    if (KeyDownLeftHeld) {
        dx -= velocidade
        dy += velocidade
    }

    if (KeyDownRightHeld) {
        dx += velocidade
        dy += velocidade
    }

    if (dx = 0 && dy = 0)
        return

    local finalX := Round(dx * forca)
    local finalY := Round(dy * forca)

    if (IsGameMode) {

        DllCall("mouse_event", "UInt", 0x0001, "Int", finalX, "Int", finalY, "UInt", 0, "UPtr", 0)

        DllCall("SetCursorPos", "Int", A_ScreenWidth // 2, "Int", A_ScreenHeight // 2)

        return
    }

    MouseMove(finalX, finalY, 0, "R")

    CoordMode "Mouse", "Screen"
    MouseGetPos(&mX, &mY)

    if (mX >= A_ScreenWidth - 1) {
        DllCall("SetCursorPos", "Int", 1, "Int", mY)
    } else if (mX <= 0) {
        DllCall("SetCursorPos", "Int", A_ScreenWidth - 2, "Int", mY)
    }
}

; =========================================================
; RESET
; =========================================================

ResetarMovimento() {

    global KeyUpHeld := false
    global KeyDownHeld := false
    global KeyLeftHeld := false
    global KeyRightHeld := false

    global KeyUpLeftHeld := false
    global KeyUpRightHeld := false
    global KeyDownLeftHeld := false
    global KeyDownRightHeld := false
}

~*CapsLock Up::ResetarMovimento()

; =========================================================
; AJUSTE DE VELOCIDADE
; =========================================================

Ajustar(dir, overrideInc := 0) {

    global PassoVelocidade

    local inc := (
        overrideInc != 0
        ? overrideInc
        : (
            GetKeyState("3", "P") ? 1000 :
            GetKeyState("2", "P") ? 300 :
            GetKeyState("1", "P") ? 100 : 500
        )
    )

    PassoVelocidade := Clamp(PassoVelocidade + (inc * dir), 387, 9000)

    AtualizarSenseWindows()

    local tag := (
        inc = 100 ? "🔍 FINO" :
        inc = 300 ? "⚙️ MÉDIO" :
        inc = 1000 ? "🚀 RÁPIDO" : "⚡ PADRÃO"
    )

    ExibirFeedback("Sense: " tag " (" PassoVelocidade ")")
}

Clamp(v, mi, ma) => (v < mi ? mi : v > ma ? ma : v)

; =========================================================
; SENSE WINDOWS
; =========================================================

AtualizarSenseWindows() {

    global PassoVelocidade

    local speed := Round(1 + ((PassoVelocidade - 387) / 8613) * 19)
    speed := Clamp(speed, 1, 20)

    DllCall("SystemParametersInfo", "UInt", 0x0071, "UInt", 0, "UInt", speed, "UInt", 0)
}

; =========================================================
; TOOLTIP
; =========================================================

ExibirFeedback(msg) {

    try {
        hwnd := WinExist("A")
        classe := WinGetClass(hwnd)

        if (classe = "Progman" || classe = "WorkerW") {
            ToolTip(msg)
            SetTimer(() => ToolTip(), -1200)
        }
    }
}

; =========================================================
; HOTKEYS ATIVOS
; =========================================================

#HotIf (IsActive && !IsTyping)

':: {

    global EnterClickEnabled
    EnterClickEnabled := !EnterClickEnabled

    ExibirFeedback(
        EnterClickEnabled
        ? "⏎ EnterClick: ON"
        : "⏎ EnterClick: OFF"
    )
}

*Enter:: {

    global EnterClickEnabled

    if (EnterClickEnabled)
        EnterClick()
    else
        Send "{Enter}"
}

*NumpadEnter:: {

    global EnterClickEnabled

    if (EnterClickEnabled) {
        Click "Left"
        return
    }

    AlternarScript()
}

; =========================================================
; CTRL / ALT COMPORTAMENTO DINÂMICO
; =========================================================

#HotIf (IsActive && !IsTyping && !EnterClickEnabled)

*Ctrl::Send "{Blind}{LButton Down}"
*Ctrl Up::Send "{Blind}{LButton Up}"

*LAlt::Send "{Blind}{RButton Down}"
*LAlt Up::Send "{Blind}{RButton Up}"

#HotIf (IsActive && !IsTyping && EnterClickEnabled)

; No modo EnterClick -> voltam a ser teclas normais
*Ctrl::Send "{LCtrl}"
*Alt::Send "{LAlt}"

#HotIf





; =========================================================
; SCROLL + SPEED
; =========================================================

CapsLock & WheelUp::Ajustar(1)
CapsLock & WheelDown::Ajustar(-1)

NumpadEnter & WheelUp::Ajustar(1)
NumpadEnter & WheelDown::Ajustar(-1)

XButton1 & WheelUp::Ajustar(1)
XButton1 & WheelDown::Ajustar(-1)

NumpadEnter & Numpad8::Ajustar(1)   ; UP
NumpadEnter & Numpad2::Ajustar(-1)  ; DOWN

; =========================================================
; DIREÇÕES
; =========================================================

*Numpad8::
*NumpadUp:: {
    global KeyUpHeld := true
}

*Numpad8 Up::
*NumpadUp Up:: {
    global KeyUpHeld := false
}

*Numpad2::
*NumpadDown:: {
    global KeyDownHeld := true
}

*Numpad2 Up::
*NumpadDown Up:: {
    global KeyDownHeld := false
}

*Numpad4::
*NumpadLeft:: {
    global KeyLeftHeld := true
}

*Numpad4 Up::
*NumpadLeft Up:: {
    global KeyLeftHeld := false
}

*Numpad6::
*NumpadRight:: {
    global KeyRightHeld := true
}

*Numpad6 Up::
*NumpadRight Up:: {
    global KeyRightHeld := false
}

*Numpad7::
*NumpadHome:: {
    global KeyUpHeld := true
    global KeyLeftHeld := true
}

*Numpad7 Up::
*NumpadHome Up:: {
    global KeyUpHeld := false
    global KeyLeftHeld := false
}

*Numpad9::
*NumpadPgUp:: {
    global KeyUpHeld := true
    global KeyRightHeld := true
}

*Numpad9 Up::
*NumpadPgUp Up:: {
    global KeyUpHeld := false
    global KeyRightHeld := false
}

*Numpad1::
*NumpadEnd:: {
    global KeyDownHeld := true
    global KeyLeftHeld := true
}

*Numpad1 Up::
*NumpadEnd Up:: {
    global KeyDownHeld := false
    global KeyLeftHeld := false
}

*Numpad3::
*NumpadPgDn:: {
    global KeyDownHeld := true
    global KeyRightHeld := true
}

*Numpad3 Up::
*NumpadPgDn Up:: {
    global KeyDownHeld := false
    global KeyRightHeld := false
}

#HotIf

; =========================================================
; MENU
; =========================================================

F1::ExibirMenuAjuda()

ExibirMenuAjuda() {

    global IsActive, IsTyping, IsGameMode, EnterClickEnabled, PassoVelocidade

    msg := ""

    msg .= "═══════════════════════════════`n"
    msg .= "🧭 MOUSE CAMBIAL - GUIA COMPLETO`n"
    msg .= "👤 @criadepc`n"
    msg .= "═══════════════════════════════`n`n"

    ; =========================
    ; LIGA / DESLIGA
    ; =========================
    msg .= "🔴 CONTROLE PRINCIPAL`n"
    msg .= "-  SHIFT + HOME ou Numpad-  → Liga / Desliga o script`n"

    ; =========================
    ; MODOS
    ; =========================
    msg .= "🟡 MODOS DO SISTEMA`n"

    msg .= "🔴 MODO DESLIGADO`n"
    msg .= "-  SHIFT + HOME ou Numpad-  → Te permite digitar e usar o teclado normalmente rapidamente n"
	
    msg .= "🖱️ MODO MOUSE (padrão)`n"
    msg .= "  • Movimento do mouse ativo via Numpad`n"
    msg .= "  • Ctrl = clique esquerdo`n"
    msg .= "  • Alt = clique direito`n`n"

    msg .= "🎮 MODO JOGO (Shift + J)`n"
    msg .= "  • Regula sense (alguns jogos precisam)`n"
    msg .= "  • Usa movimento via API direta (mouse_event)`n"
    msg .= "  • Cursor reseta no centro da tela`n`n"

    ; =========================
    ; ENTER CLICK
    ; =========================
    msg .= "⏎ ENTER CLICK MODE (' key)`n"
    msg .= "  • Alterna Marcha vs clique Esq`n"
    msg .= "  • ON: Enter = clique esquerdo`n"
    msg .= "  • NumpadEnter = clique esquerdo`n"
    msg .= "  • OFF: NumEnter vira Marcha`n`n"
	msg .= "- Ctrl/Alt voltam ao normal no EnterClick OFF`n`n"

    ; =========================
    ; MOVIMENTO
    ; =========================
    msg .= "🧭 MOVIMENTO (NUMPAD)`n"
    msg .= "- Numpad8 / ↑ → mover para cima`n"
    msg .= "- Numpad2 / ↓ → mover para baixo`n"
    msg .= "- Numpad4 / ← → mover esquerda`n"
    msg .= "- Numpad6 / → → mover direita`n"
    msg .= "- Diagonais também`n`n"

    ; =========================
    ; SCROLL / VELOCIDADE
    ; =========================
    msg .= "⚙️ VELOCIDADE / SENSIBILIDADE`n"
    msg .= "- CapsLock + WheelUp → Aumenta sensibilidade`n"
    msg .= "- CapsLock + WheelDown → Diminui sensibilidade`n"
    msg .= "- XButton1 + Wheel → Ajuste rápido`n"
    msg .= "- NumpadEnter + Numpad8 → Aumenta`n"
    msg .= "- NumpadEnter + Numpad2 → Diminui`n`n"

    msg .= "📊 NÍVEIS DE AJUSTE`n"
    msg .= "  • 1 = fino (precisão)`n"
    msg .= "  • 2 = médio`n"
    msg .= "  • 3 = rápido (alto ganho)`n`n"

    ; =========================
    ; CONTROLES ESPECIAIS
    ; =========================
    msg .= "🧩 CONTROLES ESPECIAIS`n"
    msg .= "- Ctrl → clique esquerdo (segurar)`n"
    msg .= "- Alt → clique direito (segurar)`n"
    msg .= "- Ctrl/Alt voltam ao normal no EnterClick OFF`n`n"

    ; =========================
    ; STATUS
    ; =========================
    msg .= "📌 STATUS ATUAL`n"
    msg .= "- Script: " (IsActive ? "ON" : "OFF") "`n"
    msg .= "- GameMode: " (IsGameMode ? "ON" : "OFF") "`n"
    msg .= "- EnterClick: " (EnterClickEnabled ? "ON" : "OFF") "`n"
    msg .= "- Sensibilidade: " PassoVelocidade "`n`n"

    msg .= "═══════════════════════════════"

    ToolTip(msg)
    SetTimer(() => ToolTip(), -5000)
}
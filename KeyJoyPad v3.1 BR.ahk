; ############################################################################
; # KEYJOYPAD GEARSENSE V3 OPEN SOURCE- PLUGIN ACESSIBILIDADE ANTICHEAT  🚫  #
; # @criadepc - PROFIT FREE                                                  #
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
PgUp::
{
    while GetKeyState("PgUp", "P")
    {
        Send "{WheelUp}"
        Sleep 30
    }
}

PgDn::
{
    while GetKeyState("PgDn", "P")
    {
        Send "{WheelDown}"
        Sleep 30
    }
}
*NumpadAdd Up::Send "{Blind}{RButton Up}"

; =========================================================
; SETAS = MOVIMENTO DO MOUSE
; =========================================================
#HotIf (IsActive && !EnterClickEnabled)
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

global PassoVelocidade := 750
global AccelMouse := 0.2
global BaseSense := 750

; =========================================================
; ESTADOS DAS TECLAS
; =========================================================

global InvertedMode := false
global KeyUpHeld := false
global KeyDownHeld := false
global KeyLeftHeld := false
global KeyRightHeld := false
global EnterClickEnabled := false

global TrueCrimeNYMode := false
global MoveStartTick := 0

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

Insert:: {

    global InvertedMode

    InvertedMode := !InvertedMode

    ExibirFeedback(
        InvertedMode
        ? "🔄 MODO INVERTIDO: ON"
        : "🔄 MODO INVERTIDO: OFF"
    )
}

#HotIf (IsActive && InvertedMode)

*w:: {
    global KeyUpHeld := true
}
*w Up:: {
    global KeyUpHeld := false
}

*s:: {
    global KeyDownHeld := true
}
*s Up:: {
    global KeyDownHeld := false
}

*a:: {
    global KeyLeftHeld := true
}
*a Up:: {
    global KeyLeftHeld := false
}

*d:: {
    global KeyRightHeld := true
}
*d Up:: {
    global KeyRightHeld := false
}
q::Send "{RButton Down}"
q Up::Send "{RButton Up}"

e::Send "{LButton Down}"
e Up::Send "{LButton Up}"

#HotIf

CapsLock & Home::AlternarScript()
NumpadSub::AlternarScript()

F6:: {

    global TrueCrimeNYMode

    TrueCrimeNYMode := !TrueCrimeNYMode

    ExibirFeedback(
        TrueCrimeNYMode
        ? "🗽 TRUE CRIME NY MODE: ON"
        : "🗽 TRUE CRIME NY MODE: OFF"
    )
}



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

F7::AjustarAccel(-1)
F8::AjustarAccel(1)

AjustarAccel(dir) {

    global AccelMouse

    AccelMouse += (dir * 0.05)

    ; limites seguros (evita “loucuras”)
    AccelMouse := Clamp(AccelMouse, 0.2, 3.0)

    ExibirFeedback("⚡ ACCEL: " Round(AccelMouse, 2))
}

MotorDeMovimento() {

    global IsActive, IsTyping, IsGameMode, PassoVelocidade
    global KeyUpHeld, KeyDownHeld, KeyLeftHeld, KeyRightHeld
    global KeyUpLeftHeld, KeyUpRightHeld, KeyDownLeftHeld, KeyDownRightHeld
    global MoveStartTick

    if (!IsActive || IsTyping)
        return

    local dx := 0
    local dy := 0

    local velocidade := (PassoVelocidade / BaseSense)
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

if (dx = 0 && dy = 0) {
    MoveStartTick := 0  ; reset quando parar de mover
    return
}

if (MoveStartTick = 0)
    MoveStartTick := A_TickCount

; normaliza diagonal para não ficar mais rápido
if (dx != 0 && dy != 0) {
    dx := dx * 0.7071   ; 1 / √2
    dy := dy * 0.7071
}

global AccelMouse

elapsed := A_TickCount - MoveStartTick

; BURST curto (ajuste fino no início do movimento)
local burstTime := 100  ; base

if (elapsed < burstTime) {
    accel := AccelMouse
}
else {
    ; fator progressivo
    local factor := elapsed / burstTime

    ; limite no QUÁDRUPLO
    factor := Min(factor, 5)

    accel := 1.0 * factor
}

local accel := (elapsed < burstTime)
    ? AccelMouse
    : 1.0

local base := (PassoVelocidade / BaseSense)

local finalX := Round(dx * base * forca * accel)
local finalY := Round(dy * base * forca * accel)

if (IsGameMode) {

    DllCall("mouse_event", "UInt", 0x0001, "Int", finalX, "Int", finalY, "UInt", 0, "UPtr", 0)

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
            GetKeyState("1", "P") ? 100 : 250
        )
    )

    PassoVelocidade := Clamp(PassoVelocidade + (inc * dir), 250, 9000)

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

    local speed := Round(1 + ((PassoVelocidade - 250) / 8613) * 19)
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

#HotIf (IsActive && InvertedMode)

+W::Ajustar(1)
+S::Ajustar(-1)

#HotIf


NumpadEnter & WheelUp::Ajustar(1)
NumpadEnter & WheelDown::Ajustar(-1)

XButton1 & WheelUp::Ajustar(1)
XButton1 & WheelDown::Ajustar(-1)

NumpadEnter & Numpad8::Ajustar(1)   ; UP
NumpadEnter & Numpad2::Ajustar(-1)  ; DOWN

; =========================================================
; DIREÇÕES
; =========================================================

; =========================================================
; DIREÇÕES
; =========================================================

; -------------------------
; CARDINAIS
; -------------------------

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

; -------------------------
; DIAGONAIS
; TRUE CRIME NY SAFE MODE
; -------------------------

#HotIf !TrueCrimeNYMode

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

#HotIf

#HotIf

; =========================================================
; MENU
; =========================================================

F1::ExibirMenuAjuda()

ExibirMenuAjuda() {

    global IsActive, IsTyping, IsGameMode, EnterClickEnabled, PassoVelocidade

    msg := ""

    msg .= "═══════════════════════════════`n"
    msg .= "🧭 KEYJOY GEAR - GUIA COMPLETO`n"
    msg .= "👤 @criadepc`n"
    msg .= "═══════════════════════════════`n`n"

    msg .= "🔴 CONTROLE PRINCIPAL`n"
    msg .= "- SHIFT + HOME ou Numpad- → Liga / Desliga o script`n`n"

    ; =========================
    ; MODOS
    ; =========================
    msg .= "🟡 MODOS DO SISTEMA`n`n"

    msg .= "🔴 MODO DESLIGADO`n"
    msg .= "- SHIFT + HOME ou Numpad- → Permite uso normal do teclado e digitação`n`n"
	
    msg .= "🖱️ MODO MOUSE (padrão)`n"
    msg .= "  • Movimento do mouse via Numpad`n"
    msg .= "  • Ctrl = clique esquerdo`n"
    msg .= "  • Alt = clique direito`n`n"
	
    msg .= "🖱️ MODO MOUSE INVERTIDO (tecla INSERT)`n"
    msg .= "  • Movimento do mouse via WASD`n"
    msg .= "  • E = clique esquerdo`n"
    msg .= "  • Q = clique direito`n`n"
    msg .= "  • SHIFT + W = aumentar sensibilidade`n"
    msg .= "  • SHIFT + S = diminuir sensibilidade`n`n"

    msg .= "🎮 MODO JOGO (Shift + J)`n"
    msg .= "  • Ajusta sensibilidade (necessário para alguns jogos)`n"
    msg .= "  • Usa API direta do mouse (mouse_event)`n"
    msg .= "  • Cursor é reposicionado no centro da tela`n`n"
	
	msg .= "🗽 TRUE CRIME NY MODE (F6)`n"
    msg .= "  • Libera diagonais 7/9/1/3 para jogos como TRUE CRIME NY`n`n"
	msg .= "  • Que já usa estas teclas por padrão`n`n"

    ; =========================
    ; ENTER CLICK
    ; =========================
    msg .= "⏎ MODO ENTER CLICK (tecla ')`n"
    msg .= "  • Alterna entre Gear e clique esquerdo no Enter`n"
    msg .= "  • Desativa as setas como mouse (voltam ao normal)`n`n"
    msg .= "- Ctrl/Alt voltam ao normal quando EnterClick está ativado`n`n"

    ; =========================
    ; MOVIMENTO
    ; =========================
    msg .= "🧭 MOVIMENTO (TECLADO NUMÉRICO)`n"
    msg .= "- PAGE UP / ↑ → rolar para cima`n"
    msg .= "- PAGE DOWN / ↓ → rolar para baixo`n"
    msg .= "- Numpad8 / ↑ → mover para cima`n"
    msg .= "- Numpad2 / ↓ → mover para baixo`n"
    msg .= "- Numpad4 / ← → mover para esquerda`n"
    msg .= "- Numpad6 / → → mover para direita`n"
    msg .= "- Suporte a diagonais`n`n"

    ; =========================
    ; SCROLL / VELOCIDADE
    ; =========================
    msg .= "⚙️ VELOCIDADE / SENSIBILIDADE`n"
    msg .= "- CapsLock + Scroll ↑ → Aumenta sensibilidade`n"
    msg .= "- CapsLock + Scroll ↓ → Diminui sensibilidade`n"
    msg .= "- XButton1 + Scroll → Ajuste rápido`n"
    msg .= "- NumpadEnter + Numpad8 → Aumentar`n"
    msg .= "- NumpadEnter + Numpad2 → Diminuir`n`n"

    msg .= "📊 NÍVEIS DE AJUSTE`n"
    msg .= "  • 1 = fino (precisão)`n"
    msg .= "  • 2 = médio`n"
    msg .= "  • 3 = rápido (alta velocidade)`n`n"
    msg .= "  • F7 = diminui aceleração burst`n"
    msg .= "  • F8 = aumenta aceleração burst`n"
    msg .= "  • A aceleração serve para ajuste fino da mira`n"
    msg .= "  • nos primeiros momentos ao pressionar a tecla`n`n"

    ; =========================
    ; CONTROLES ESPECIAIS
    ; =========================
    msg .= "🧩 CONTROLES ESPECIAIS`n"
    msg .= "- Ctrl → clique esquerdo`n"
    msg .= "- Alt → clique direito`n"
    msg .= "- Ctrl/Alt voltam ao normal quando EnterClick está ativado`n`n"

    ; =========================
    ; STATUS
    ; =========================
    msg .= "📌 STATUS ATUAL`n"
    msg .= "- Modo Jogo: " (IsGameMode ? "ON" : "OFF") "`n"
    msg .= "- EnterClick: " (EnterClickEnabled ? "ON" : "OFF") "`n"
    msg .= "- Sensibilidade: " PassoVelocidade "`n`n"

    msg .= "═══════════════════════════════"

    ToolTip(msg)
    SetTimer(() => ToolTip(), -5000)
}
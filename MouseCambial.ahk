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

; =========================================================
; ESTADOS GLOBAIS
; =========================================================

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
+-::AlternarScript()
+NumpadSub::AlternarScript()

#HotIf IsActive

*NumpadSub:: {

    global IsTyping

    IsTyping := !IsTyping

    ExibirFeedback(
        IsTyping
        ? "⌨️ MODO DIGITAÇÃO"
        : "🖱️ MODO MOUSE"
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

    global IsActive
    global IsTyping
    global IsGameMode
    global PassoVelocidade

    global KeyUpHeld
    global KeyDownHeld
    global KeyLeftHeld
    global KeyRightHeld

    global KeyUpLeftHeld
    global KeyUpRightHeld
    global KeyDownLeftHeld
    global KeyDownRightHeld

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

        DllCall(
            "mouse_event",
            "UInt", 0x0001,
            "Int", finalX,
            "Int", finalY,
            "UInt", 0,
            "UPtr", 0
        )

        DllCall(
            "SetCursorPos",
            "Int", A_ScreenWidth // 2,
            "Int", A_ScreenHeight // 2
        )

        return
    }

    MouseMove(finalX, finalY, 0, "R")

    CoordMode "Mouse", "Screen"

    MouseGetPos(&mX, &mY)

    if (mX >= A_ScreenWidth - 1) {

        DllCall(
            "SetCursorPos",
            "Int", 1,
            "Int", mY
        )

    } else if (mX <= 0) {

        DllCall(
            "SetCursorPos",
            "Int", A_ScreenWidth - 2,
            "Int", mY
        )
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
            GetKeyState("3", "P")
            ? 1000
            : GetKeyState("2", "P")
                ? 300
                : GetKeyState("1", "P")
                    ? 100
                    : 500
        )
    )

    PassoVelocidade := Clamp(
        PassoVelocidade + (inc * dir),
        387,
        9000
    )

    AtualizarSenseWindows()

    local tag := (
        inc = 100
        ? "🔍 FINO"
        : inc = 300
            ? "⚙️ MÉDIO"
            : inc = 1000
                ? "🚀 RÁPIDO"
                : "⚡ PADRÃO"
    )

    ExibirFeedback(
        "Sense: " tag " (" PassoVelocidade ")"
    )
}

Clamp(v, mi, ma) => (
    v < mi
    ? mi
    : v > ma
        ? ma
        : v
)

; =========================================================
; SENSE WINDOWS
; =========================================================

AtualizarSenseWindows() {

    global PassoVelocidade

    local speed := Round(
        1 + ((PassoVelocidade - 387) / 8613) * 19
    )

    speed := Clamp(speed, 1, 20)

    DllCall(
        "SystemParametersInfo",
        "UInt", 0x0071,
        "UInt", 0,
        "UInt", speed,
        "UInt", 0
    )
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

            SetTimer(
                () => ToolTip(),
                -1200
            )
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

    Send "{NumpadEnter}"
}

*Ctrl::Send "{Blind}{LButton Down}"
*Ctrl Up::Send "{Blind}{LButton Up}"

*Alt::Send "{Blind}{RButton Down}"
*Alt Up::Send "{Blind}{RButton Up}"

*Numpad5::Click
*Numpad0::Click
*NumpadDot::Click "Right"
*NumpadAdd::Click "Right"
*NumpadMult::Click "Middle"
*NumpadDiv::XButton1

; =========================================================
; SCROLL + SPEED
; =========================================================

CapsLock & WheelUp::Ajustar(1)
CapsLock & WheelDown::Ajustar(-1)

NumpadEnter & WheelUp::Ajustar(1)
NumpadEnter & WheelDown::Ajustar(-1)

XButton1 & WheelUp::Ajustar(1)
XButton1 & WheelDown::Ajustar(-1)

; =========================================================
; DIREÇÕES
; =========================================================

*Numpad8::
*NumpadUp:: {

    if (
        GetKeyState("CapsLock", "P")
        || GetKeyState("NumpadEnter", "P")
        || GetKeyState("XButton1", "P")
    ) {
        Ajustar(1)
        return
    }

    global KeyUpHeld := true
}

*Numpad8 Up::
*NumpadUp Up:: {
    global KeyUpHeld := false
}

*Numpad2::
*NumpadDown:: {

    if (
        GetKeyState("CapsLock", "P")
        || GetKeyState("NumpadEnter", "P")
        || GetKeyState("XButton1", "P")
    ) {
        Ajustar(-1)
        return
    }

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

; =========================================================
; DIAGONAIS
; =========================================================

*Numpad7::
*NumpadHome:: {
    global KeyUpLeftHeld := true
}

*Numpad7 Up::
*NumpadHome Up:: {
    global KeyUpLeftHeld := false
}

*Numpad9::
*NumpadPgUp:: {
    global KeyUpRightHeld := true
}

*Numpad9 Up::
*NumpadPgUp Up:: {
    global KeyUpRightHeld := false
}

*Numpad1::
*NumpadEnd:: {
    global KeyDownLeftHeld := true
}

*Numpad1 Up::
*NumpadEnd Up:: {
    global KeyDownLeftHeld := false
}

*Numpad3::
*NumpadPgDn:: {
    global KeyDownRightHeld := true
}

*Numpad3 Up::
*NumpadPgDn Up:: {
    global KeyDownRightHeld := false
}

#HotIf

~*LControl:: {
    global IsTyping, IsActive

    if (!IsActive)
        return

    if KeyWait("LControl", "T2") {
        IsTyping := !IsTyping
        ExibirFeedback(IsTyping ? "⌨️ DIGITAÇÃO ON" : "🖱️ DIGITAÇÃO OFF")
    }
}

~*LAlt:: {
    global IsTyping, IsActive

    if (!IsActive)
        return

    if KeyWait("LAlt", "T2") {
        IsTyping := !IsTyping
        ExibirFeedback(IsTyping ? "⌨️ DIGITAÇÃO ON" : "🖱️ DIGITAÇÃO OFF")
    }
}

; =========================================================
; MENU DE AJUDA / CONTROLE DE EMERGÊNCIA (F1)
; =========================================================

F1::ExibirMenuAjuda()

ExibirMenuAjuda() {

    global IsActive, IsTyping, IsGameMode, EnterClickEnabled, PassoVelocidade

    msg := ""

    ; =========================================================
    ; CABEÇALHO / CRÉDITOS
    ; =========================================================
    msg .= "═══════════════════════════════`n"
    msg .= "🧭 MOUSE CAMBIAL - MENU DE AJUDA`n"
    msg .= "👤 @criadepc - ISSO DEVERIA VIR DE FÁBRICA`n"
    msg .= "═══════════════════════════════`n`n"

    ; =========================================================
    ; CONTROLE GERAL
    ; =========================================================
    msg .= "🔴 CONTROLE GERAL (PRIORIDADE MÁXIMA)`n"
    msg .= "- CapsLock + Home → LIGA/DESLIGA SCRIPT`n"
    msg .= "- +- / Shift + NumpadSub → Toggle Geral`n"
    msg .= "- F1 → Abrir este menu`n`n"

    ; =========================================================
    ; MODOS
    ; =========================================================
    msg .= "🟡 MODOS DO SISTEMA`n"

    msg .= "⌨️ MODO DIGITAÇÃO (IsTyping)`n"
    msg .= "- Ctrl (segurar 2s) → Toggle Digitação`n"
    msg .= "- Alt (segurar 2s) → Toggle Digitação`n"
	msg .= "- Tecla Num- → Toggle Digitação`n"
    msg .= "- Bloqueia movimento do mouse`n`n"

    msg .= "🖱️ MODO MOUSE`n"
	msg .= "- Tecla Num- → Toggle Digitação`n"

    msg .= "🎮 MODO JOGO (GameMode)`n"
    msg .= "- Shift + J → Alterna modo jogo (prende o mouse no centro)`n"
    msg .= "- Aumenta força do movimento (Turbo x6 (reajuste na sense))`n`n"

    msg .= "⏎ ENTERCLICK MODE`n"
    msg .= "- Tecla ' (aspas simples) → Liga/Desliga EnterClick`n"
    msg .= "- Enter → envia clique ou Comando de Marcha (Gear)`n"
    msg .= "- Numpad Enter → clique esquerdo (quando EnterClick está ativo)`n`n"

    ; =========================================================
    ; TECLAS IMPORTANTES
    ; =========================================================
    msg .= "⌨️ TECLAS UTILIZADAS`n"
    msg .= "- Numpad8 / ↑ → Cima`n"
    msg .= "- Numpad2 / ↓ → Baixo`n"
    msg .= "- Numpad4 / ← → Esquerda`n"
    msg .= "- Numpad6 / → → Direita`n"
    msg .= "- Numpad7 / 9 / 1 / 3 → Diagonais`n"
    msg .= "- Numpad5 / 0 → Clique esquerdo`n"
    msg .= "- NumpadDot / Numpad+ → Clique direito`n"
    msg .= "- Numpad* → Clique do meio`n"
    msg .= "- Numpad/ → XButton1`n`n"

    ; =========================================================
    ; VELOCIDADE
    ; =========================================================
    msg .= "⚡ VELOCIDADE / SENSIBILIDADE`n"
    msg .= "- Scroll do Mouse → Ajusta velocidade`n"
    msg .= "- CapsLock + Scroll → Ajuste fino`n"
    msg .= "- Valor atual: " PassoVelocidade "`n`n"

    ; =========================================================
    ; STATUS
    ; =========================================================
    msg .= "⚙️ STATUS ATUAL`n"
    msg .= "- Script: " (IsActive ? "ON" : "OFF") "`n"
    msg .= "- Digitação: " (IsTyping ? "ON" : "OFF") "`n"
    msg .= "- GameMode: " (IsGameMode ? "ON" : "OFF") "`n"
    msg .= "- EnterClick: " (EnterClickEnabled ? "ON" : "OFF") "`n`n"

    ; =========================================================
    ; EMERGÊNCIA
    ; =========================================================
    msg .= "⚠️ EM CASO DE PROBLEMAS`n"
    msg .= "- CapsLock + Home → DESLIGA TUDO`n"
    msg .= "- Fechar script pelo ícone da bandeja`n"

    ToolTip(msg)
    SetTimer(() => ToolTip(), -20000)
}
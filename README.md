# Gear
Valve Steam main competitor


Controlador de mouse via teclado + Marcha GearSense , com foco em **acessibilidade** e **jogos**.  
Criado por @criadepc — **OPEN SOURCE #free**

---

Se o jogo bloquear o NUM-, utilize CAPSLOCK + HOME

## ✨ Objetivo
Tenho limitações motoras e de conhecimento, e este projeto nasceu para facilitar meu uso do computador e permitir jogar de forma divertida.  
Quero que seja distribuído livremente, integrado aos **inputs do Windows** e reconhecido de forma legítima em jogos.

---

## 🎮 Recursos principais
- ⏎ **EnterClick Mode**: transforma Enter em clique Esquerdo ou comando de marcha (Gear), além de retornar LCTRL e LALT as suas funções originais.
-   NumEnter + NUM8/NUM2 Aumenta ou diminui a sensibilidade em tempo real.
-   CAPSLOCK + MouseWheel Aumenta ou diminui a sensibilidade em tempo real.
- 🖱️ Controle completo via teclado numérico (direções, diagonais, cliques).
- 🚀 Ajuste de velocidade/sensibilidade com NUMEnter + NUM8/NUM2.
- 🧭 **Menu de ajuda (F1)**: mostra atalhos, status e instruções em tempo real.

---

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
	msg .= "- Ctrl/Alt voltam ao normal no EnterClick ON`n`n"

    ; =========================
    ; MOVIMENTO
    ; =========================
    msg .= "🧭 MOVIMENTO (NUMPAD)`n"
	msg .= "- PAGE UP/ ↑ → SCROLL pra cima`n"
    msg .= "- PAGE DOWN / ↑ → SCROLL pra baixo`n"
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
    msg .= "- Ctrl/Alt voltam ao normal no EnterClick ON`n`n"


## 🔑 Atalhos importantes
- CapsLock + Home ou NUM- → Liga/Desliga script  
- Shift + J → Alterna modo jogo (prende o mouse no centro e ajusta a sensibilidade para alguns jogos fica muito alta ou muito baixa.) 
- ' (aspas simples) → Liga/Desliga EnterClick  
- F1 → Abre menu de ajuda  

---

## ⚠️ Aviso
Este projeto é **experimental**.  
- Não deve ser usado em jogos competitivos online (pode ser bloqueado por sistemas anti-cheat, não testado).  
- É voltado para acessibilidade, diversão e uso pessoal.  

---

## 📦 Instalação
1. Baixe o executável compilado (`MouseCambialv2.exe`).  
2. Execute no Windows (não precisa instalar AutoHotkey).  
3. Use F1 para abrir o menu de ajuda.  

---

## 📜 Licença
Distribuído sob a licença **MIT** — livre para uso, modificação e compartilhamento, venda proibida.

---

## 👤 Créditos
- Autor: @criadepc
- 
=======================================================================================================================================================================================
ENGLISH
=======================================================================================================================================================================================

# Gear
Valve Steam main competitor

Keyboard mouse controller + GearSense March, focusing on **accessibility** and **games**.  
Created by @criadepc — **OPEN SOURCE #free**

---

IF inside THE GAME it BLOCKS NUM-, USE CAPSLOCK + HOME

## ✨ Objective
I have motor and knowledge limitations, and this project was born to make my computer use easier and allow me to play in a fun way.  
I want it to be freely distributed, integrated into **Windows inputs**, and legitimately recognized in games.

---

## 🎮 Main features
- ⏎ **EnterClick Mode**: transforms Enter into Left Click or Gear (March Command), while also restoring LCTRL and LALT to their original functions.  
- NumEnter + NUM8/NUM2 increases or decreases sensitivity in real time.  
- CAPSLOCK + MouseWheel increases or decreases sensitivity in real time.  
- 🖱️ Full keyboard numeric control (directions, diagonals, clicks).  
- 🚀 Speed/sensitivity adjustment with mouse scroll.  
- 🧭 **Help Menu (F1)**: shows shortcuts, status, and instructions in real time.

---

## 🔑 Important shortcuts
- CapsLock + Home or NUM- → Turn script On/Off  
- Shift + J → Toggle game mode (locks mouse to center and adjusts sensitivity — in some games it may feel too high or too low)  
- ' (single quote) → Toggle EnterClick On/Off  
- F1 → Opens help menu  

---

## ⚠️ Notice
This project is **experimental**.  
- Not intended for competitive online games (may be blocked by anti-cheat systems, not tested).  
- Focused on accessibility, fun, and personal use.  

---

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
    msg .= "  • Ctrl = left click`n"
    msg .= "  • Alt = right click`n`n"

    msg .= "🎮 GAME MODE (Shift + J)`n"
    msg .= "  • Adjusts sensitivity (required for some games)`n"
    msg .= "  • Uses direct mouse API (mouse_event)`n"
    msg .= "  • Cursor resets to screen center`n`n"

    ; =========================
    ; ENTER CLICK
    ; =========================
    msg .= "⏎ ENTER CLICK MODE (' key)`n"
    msg .= "  • Toggles Gear vs Left Click`n"
    msg .= "  • ON: Enter = left click`n"
    msg .= "  • NumpadEnter = left click`n"
    msg .= "  • OFF: NumEnter becomes Gear`n`n"
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

    ; =========================
    ; SPECIAL CONTROLS
    ; =========================
    msg .= "🧩 SPECIAL CONTROLS`n"
    msg .= "- Ctrl → left click`n"
    msg .= "- Alt → right click`n"
    msg .= "- Ctrl/Alt return to normal when EnterClick is ON`n`n"

    --

## 📦 Installation
1. Download the compiled executable (`MouseCambialv2.exe`).  
2. Run it on Windows (no need to install AutoHotkey).  
3. Press F1 to open the help menu.  

---

## 📜 License
Distributed under the **MIT license** — free to use, modify, and share. Sale is prohibited.

---

## 👤 Credits
- Author: @criadepc

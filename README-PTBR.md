Transforme seu teclado em um controle JoyKey de alto nível.

Veja acontecendo:
https://www.youtube.com/watch?v=OwW92DXjxac

https://www.youtube.com/live/_Ueuq8wz6Xc

Tenha cuidado com ANTICHEATS, espalhe a ideia para que isso se torne algo normal e desenvolvido (eu testei em alguns servidores SAMP e não fui banido).

Precisa ser testado em jogos online com anticheats.

Basta baixar qualquer um dos .exe de acordo com seu idioma, abrir, depois usar CAPSLOCK + Home ou Num- (Minus).
F1 para ajuda com cursor na ÁREA DE TRABALHO.

SHIFT + J dentro do jogo trava o cursor no centro para funcionar AO VIVO dentro do game
(também ajusta a sensibilidade padrão).
F7 e F8 ajustam o burst de aceleração do mouse
(se segurar por 1 segundo a sensibilidade fica totalmente ajustável para mira).

NumEnter + Num8 / Num2 = ajuste do Sense Gear

O mesmo para CapsLock + scroll do mouse para cima/baixo.

A tecla ' (aspas simples) faz o NumEnter virar clique esquerdo,
desativa LCtrl e LAlt como botões do mouse,
fazendo eles voltarem ao normal,
e também alterna as setas entre mouse e setas normais.

LAlt e Num+ são cliques direitos.

Num5, LCtrl e Num0 são cliques esquerdos.

NumDecimal é Mouse3.

Insert alterna o script ON/OFF.

Insert também faz WASD virar mouse."

msg .= "═══════════════════════════════`n"
msg .= "🧭 KEYJOY GEAR - GUIA COMPLETO`n"
msg .= "👤 @criadepc - BORN IN PC`n"
msg .= "═══════════════════════════════`n`n"

msg .= "🔴 CONTROLE PRINCIPAL`n"
msg .= "- SHIFT + HOME ou Numpad- → Liga / Desliga o script`n`n"

; =========================
; MODOS
; =========================
msg .= "🟡 MODOS DO SISTEMA`n`n"

msg .= "🔴 MODO OFF`n"
msg .= "- SHIFT + HOME ou Numpad- → Permite digitação e uso normal do teclado rapidamente`n`n"

msg .= "🖱️ MODO MOUSE (padrão)`n"
msg .= "  • Movimento do mouse pelo Numpad`n"
msg .= "  • Num5 = clique esquerdo`n"
msg .= "  • Ctrl = clique esquerdo`n"
msg .= "  • Alt = clique direito`n`n"

msg .= "🖱️ MODO MOUSE INVERTIDO (TECLA INSERT)`n"
msg .= "  • Movimento do mouse via WASD`n"
msg .= "  • E = clique esquerdo`n"
msg .= "  • Q = clique direito`n`n"
msg .= "  • SHIFT + W = aumenta sensibilidade`n"
msg .= "  • SHIFT + S = diminui sensibilidade`n`n"

msg .= "🎮 MODO GAME (Shift + J)`n"
msg .= "  • Ajusta sensibilidade (necessário em alguns jogos)`n"
msg .= "  • Usa API direta do mouse (mouse_event)`n"
msg .= "  • Cursor reseta para o centro da tela`n`n"

msg .= "🗽 TRUE CRIME NY MODE (F6)`n"
msg .= "  • Libera diagonais 7/9/1/3 para jogos como TRUE CRIME NY`n`n"
msg .= "  • Que já usa estas teclas por padrão`n`n"

; =========================
; ENTER CLICK
; =========================
msg .= "⏎ MODO ENTER CLICK (tecla ')`n"
msg .= "  • Alterna SenseGear / Clique Esquerdo no NumEnter`n"
msg .= "  • Desativa setas como mouse (voltam a ser setas normais)`n`n"
msg .= "- Ctrl/Alt voltam ao normal quando EnterClick está ON`n`n"

; =========================
; MOVIMENTO
; =========================
msg .= "🧭 MOVIMENTO (NUMPAD)`n"
msg .= "- PAGE UP / ↑ → Scroll para cima`n"
msg .= "- PAGE DOWN / ↓ → Scroll para baixo`n"
msg .= "- Numpad8 / ↑ → mover para cima`n"
msg .= "- Numpad2 / ↓ → mover para baixo`n"
msg .= "- Numpad4 / ← → mover para esquerda`n"
msg .= "- Numpad6 / → → mover para direita`n"
msg .= "- Diagonais suportadas`n`n"

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
msg .= "  • F7 = diminui burst de aceleração`n`n"
msg .= "  • F8 = aumenta burst de aceleração`n`n"
msg .= "  • A aceleração serve para ajustes rápidos de mira`n`n"
msg .= "  • nos primeiros momentos da tecla pressionada`n`n"

; =========================
; CONTROLES ESPECIAIS
; =========================
msg .= "🧩 CONTROLES ESPECIAIS`n"
msg .= "- Ctrl → clique esquerdo`n"
msg .= "- Alt → clique direito`n"
msg .= "- Ctrl/Alt voltam ao normal quando EnterClick está ON`n`n"

; =========================
; STATUS
; =========================
msg .= "📌 STATUS ATUAL`n"
msg .= "- GameMode: " (IsGameMode ? "ON" : "OFF") "`n"
msg .= "- EnterClick: " (EnterClickEnabled ? "ON" : "OFF") "`n"
msg .= "- Sensibilidade: " PassoVelocidade "`n`n"

msg .= "═══════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/game_controller.dart';
import '../models/direction.dart';
import '../models/game_status.dart';
import '../services/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/board_view.dart';
import '../widgets/overlay_panel.dart';
import '../widgets/pill_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final controller = GameController();
  final focus = FocusNode();

  static final Map<LogicalKeyboardKey, Direction> _keys = {
    LogicalKeyboardKey.arrowUp: Direction.up,
    LogicalKeyboardKey.keyW: Direction.up,
    LogicalKeyboardKey.arrowDown: Direction.down,
    LogicalKeyboardKey.keyS: Direction.down,
    LogicalKeyboardKey.arrowLeft: Direction.left,
    LogicalKeyboardKey.keyA: Direction.left,
    LogicalKeyboardKey.arrowRight: Direction.right,
    LogicalKeyboardKey.keyD: Direction.right,
  };

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    super.dispose();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent e) {
    if (e is KeyUpEvent) return KeyEventResult.ignored;
    if (e.logicalKey == LogicalKeyboardKey.escape) {
      if (e is KeyDownEvent) controller.togglePause();
      return KeyEventResult.handled;
    }
    final d = _keys[e.logicalKey];
    if (d == null) return KeyEventResult.ignored;
    if (e is KeyDownEvent) controller.handleMove(d);
    return KeyEventResult.handled;
  }

  void _onSwipe(DragEndDetails details) {
    final v = details.velocity.pixelsPerSecond;
    if (v.distance < 200) return;
    final d = v.dx.abs() > v.dy.abs()
        ? (v.dx > 0 ? Direction.right : Direction.left)
        : (v.dy > 0 ? Direction.down : Direction.up);
    controller.handleMove(d);
  }

  Widget _content() {
    final board = controller.board;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: PillButton(
            label: '',
            icon: Icons.pause,
            width: 90,
            height: 44,
            fontSize: 26,
            onTap: controller.togglePause,
          ),
        ),
        const SizedBox(height: 8),
        Text('Best score: ${AppState.instance.bestScore}',
            style: AppText.white(20, spacing: 3)),
        const SizedBox(height: 14),
        Text('Score: ${controller.score}', style: AppText.white(20, spacing: 3)),
        const SizedBox(height: 14),
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: board.cols / board.rows,
              child: BoardView(board: board),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.gold,
        body: Focus(
          focusNode: focus,
          autofocus: true,
          onKeyEvent: _onKey,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanEnd: _onSwipe,
            child: ListenableBuilder(
              listenable: Listenable.merge([controller, AppState.instance]),
              builder: (context, _) {
                final status = controller.status;
                return Stack(
                  children: [
                    SafeArea(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: _content(),
                          ),
                        ),
                      ),
                    ),
                    if (status == GameStatus.paused)
                      Positioned.fill(
                        child: OverlayPanel(
                          onBackgroundTap: controller.togglePause,
                          children: [
                            PillButton(
                              label: 'Paused',
                              width: 300,
                              height: 110,
                              fontSize: 40,
                              onTap: controller.togglePause,
                            ),
                            const SizedBox(height: 20),
                            PillButton(
                              label: 'Menu',
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    if (status == GameStatus.gameOver)
                      Positioned.fill(
                        child: OverlayPanel(
                          children: [
                            const PillButton(
                              label: 'Game Over',
                              width: 300,
                              height: 110,
                              fontSize: 36,
                            ),
                            const SizedBox(height: 20),
                            PillButton(label: 'Retry', onTap: controller.restart),
                            const SizedBox(height: 16),
                            PillButton(
                              label: 'Menu',
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      );
}

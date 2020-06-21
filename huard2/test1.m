function test1()
    import java.awt.Robot;
    import java.awt.event.*;
    mouse = java.awt.Robot;
    game = Game();
    inp = [
        ['j','c','c','j'];
        ['j','c','c','j'];
        ['j','h','h','0'];
        ['j','b','0','j'];
        ['b','b','b','j'];
    ];
    game.playGame("input",inp);
    figure(gcf);
    mouse.mouseMove(410,300);
    mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
    mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
    pause(1);
    mouse.mouseMove(610,300);
    mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
    mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
    pause(1);
disp("=======================================")
disp(game.board)
disp("=======================================")
end
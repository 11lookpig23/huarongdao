
classdef  unitTestGame < matlab.unittest.TestCase

    methods (Test)
        function testPiece1(testCase)
            import java.awt.Robot;
            import java.awt.event.*;
            mouse = java.awt.Robot;
            game = Game();
            game.playGame("ºáµ¶Á¢Âí",repmat("0",5,4));
            figure(gcf);
            mouse.mouseMove(410,400);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
            mouse.mouseMove(410,500);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
    %%%% =============================
            testCase.verifyEqual(game.board(5,2),"b");
            mouse.mouseMove(410,500);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
            mouse.mouseMove(510,500);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
    %%%% =============================

            testCase.verifyEqual(game.board(5,3),"b");
            mouse.mouseMove(510,400);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);

            mouse.mouseMove(410,400);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
    %%%% =============================

            mouse.mouseMove(510,500);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
            mouse.mouseMove(510,400);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
    %%%% =============================
            %disp()
            expectOUT =  [
                ["j","c","c","j"];
                ["j","c","c","j"];
                ["j","h","h","j"];
                ["j","b","b","j"];
                ["b","0","0","b"];
            ];
            testCase.verifyEqual(game.board,expectOUT);
            close;
        end

        function testPiece2(testCase)
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
    %%%% =============================
            mouse.mouseMove(610,300);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
            mouse.mouseMove(410,300);
            mouse.mousePress  (java.awt.event.InputEvent.BUTTON1_MASK);  
            mouse.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); 
            pause(1);
    %%%% =============================
            expectOUT =  [
                ["j","c","c","j"];
                ["j","c","c","j"];
                ["j","h","h","0"];
                ["j","b","0","j"];
                ["b","b","b","j"];
            ];
            testCase.verifyEqual(game.board,expectOUT);
            close;
        end
    end
end
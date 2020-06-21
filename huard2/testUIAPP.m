classdef  testUIAPP < matlab.uitest.TestCase
    properties 
        App
    end
    methods (TestMethodSetup)
        function  launchApp(testCase)
            testCase.App = hrd;
            testCase.addTeardown(@delete,testCase.App);
        end
    end
    methods (Test)
        function test_SelectButton1(testCase)
%            testCase.App.DropDown.Value = "�ᵶ����";
             disp("=====================")
            disp(testCase.App.DropDown.Items)
            testCase.choose(testCase.App.DropDown,1);
            pause(1);
            testCase.press(testCase.App.Button);
            testCase.verifyEqual(testCase.App.board, [
                ['j','c','c','j'];
                ['j','c','c','j'];
                ['j','h','h','j'];
                ['j','b','b','j'];
                ['b','0','0','b'];
            ]);

        end
    end
end
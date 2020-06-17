classdef  Game < handle
properties
    board = repmat("0",5,4);
end
    methods
        function obj = set.board(obj,val)
            obj.board = val;
        end
        function TF = place(obj,tile)
           allpos =  tile.getPos();
           flag = 'T';
           [r,c] = size(allpos);
            for i=1:r
                pos = allpos(i,:);
                if pos(1)>5 | pos(2)>4
                    flag = 'F';
                    break;
                end
                if obj.board(pos(1),pos(2))~="0"
                    flag = 'F';
                    break;
                end
            end
            if flag == 'F'
                TF = false;
                return;
            else
                A = obj.board;
                for i=1:r
                    pos = allpos(i,:);
                    A(pos(1),pos(2)) = tile.sym;
                end
                obj.board = A;
                TF = true;
            end
        end
        function indlist = getZeroList(obj)
            ind = find(obj.board=="0");
            [r,c] = size(ind);
            randIndex = randperm(r);
            ind = ind(randIndex);
            indlist = zeros(r,2);
            for i = 1:r
                y = mod(ind(i),5);
                if y==0
                    y = 5;
                end
                x = (ind(i)-y)/5;
                indlist(i,:) = [y,x+1];
            end

        end
        function putPiece(obj,sym)
            if sym=="hen" | sym=="cc"
                gshu = 1;
            else
                gshu = 4;
            end
            for i=1:gshu
                zeroList = obj.getZeroList();
                [r,c] = size(zeroList);
                for j= 1:r
                    slide = tile(zeroList(j,:),sym);
                    if obj.place(slide)==true
                        %disp(zeroList(j,:))
                        break
                    else
                        continue
                    end
                end
                %disp(obj.board)
            end
        end
        function guiPos = transfer(obj)
            gameMat = obj.board;
            %% input: array 5*4
            %% 'j','c','h','b'
            %% output: coordinate
            XY0 = [100,100];
            hdlima = [
                ['j','c','c','j'];
                ['j','c','c','j'];
                ['j','h','h','j'];
                ['j','b','b','j'];
                ['b','0','0','b'];
            ];
            guiPos = {};
            cou = 1;
            %gameMat = hdlima;
            for i = 1:5
                for j = 1:4
                    if gameMat(i,j)=='c'
                        gameMat(i+1,j)='0';gameMat(i,j+1)='0';gameMat(i+1,j+1)='0';gameMat(i,j)='0';
                        guiPos{cou} = [ (j-1)*100+XY0(2) (5-(i+1))*100+XY0(1) 200 200];
                        cou = cou+1;
                    elseif  gameMat(i,j)=='j'
                        gameMat(i+1,j)='0';gameMat(i,j)='0';
                        guiPos{cou} = [ (j-1)*100+XY0(2) (5-(i+1))*100+XY0(1) 100 200];
                        cou = cou+1;
                    elseif gameMat(i,j)=='h'
                        gameMat(i,j+1)='0';gameMat(i,j)='0';
                        guiPos{cou} = [ (j-1)*100+XY0(2) (5-i)*100+XY0(1) 200 100];
                        cou = cou+1;
                    elseif gameMat(i,j)=='b'
                        gameMat(i,j)='0';
                        guiPos{cou} = [ (j-1)*100+XY0(2) (5-i)*100+XY0(1) 100 100];
                        cou = cou+1;
                    end
                end
            end
        end
        function newMat = ToMatrix(obj,matInd,newMat)
            [r,c] = size(matInd);
            for i = 1:r
                newMat(matInd(i,1),matInd(i,2)) = 1;
            end
        end
        function  randomGame(obj)
            obj.putPiece("cc");
            obj.putPiece("hen");
            obj.putPiece("jjun");
            obj.putPiece("bin");
        end
        function  startGame(obj,mode)
            switch mode
            case "横刀立马"
                obj.board =  [
                    ['j','c','c','j'];
                    ['j','c','c','j'];
                    ['j','h','h','j'];
                    ['j','b','b','j'];
                    ['b','0','0','b'];
                ];
            case "兵分三路"
                obj.board =  [
                    ['b','c','c','b'];
                    ['j','c','c','j'];
                    ['j','h','h','j'];
                    ['j','b','b','j'];
                    ['j','0','0','j'];
                ];
            case "齐头并进"
                obj.board =  [
                    ['j','c','c','j'];
                    ['j','c','c','j'];
                    ['b','b','b','b'];
                    ['j','h','h','j'];
                    ['j','0','0','j'];
                ];
            case "随机"
                obj.randomGame()
            end

        end
    end
end

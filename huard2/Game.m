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
        function  startGame(obj,mode,initBoard)
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
                obj.randomGame();
            case "input"
                obj.board = initBoard;
            end

        end

        %%%%
        function playGame(obj,mode,initBoard)

            global chessHandle tilePos  step stepHandle 
            global tileHandle   pieceID
            gamewindow = figure('Name','hrd','NumberTitle','off','MenuBar','none',...
                'ToolBar','none','Position',[200 400 580 660],'WindowButtonDownFcn',@movetile,'Resize','off');    
            axes( gamewindow,'Position',[0 0 0 0])  
            axis off  %
            step = 0;

            obj.startGame(mode,initBoard);
            ifGameOver()
            tilePos = obj.transfer();
            colors = repmat("0",1,10);
            for ix = 1:10
                pos = tilePos{ix};
                if pos(3)==100 & pos(4)==100
                    colorid = 'y';
                elseif pos(3)==100 & pos(4)==200
                    colorid = 'g';
                elseif pos(3)==200 & pos(4)==200
                    colorid = 'm';
                else
                    colorid = 'r';
                end
                colors(ix) = colorid;
                uicontrol('parent', gamewindow,'Style','pushbutton',...
                    'Position',tilePos{ix},'FontSize',30,'Callback',@getpiece,'BackgroundColor','r')  %     
            end
            chessHandle = flip(findall(gcf,'Style','pushbutton'));   %       chessHandle
            stepHandle = uicontrol('parent',gamewindow,'Style','pushbutton',...
            'Position',[20 20 100 50],'String','steps: 0','Fontsize',10); 
        
            function getpiece(hObject,event)  
            oldhandle = tileHandle;
            tileHandle = hObject;
            for ix =1:10
                if chessHandle(ix) == oldhandle
                    oldhandle.BackgroundColor = 'r';
                end
            end
            for ix =1:10
                if chessHandle(ix) == tileHandle
                    pieceID = ix;
                    tileHandle.BackgroundColor = 'b';
                    break
                end
            end
            end
            
            function movetile(~,event)
                oldmat = obj.board;
                oldPosition = get(tileHandle,'Position');
                pos_mouse = get(gca,'CurrentPoint');  %%
                XY0 = 100;        
                pos_mouse = pos_mouse(1,1:2)-XY0;
                if (1 < pos_mouse(1) & pos_mouse(1) < 399) & (1 < pos_mouse(2) & pos_mouse(2) < 499)   % 
                    nx = get(tileHandle,'Position');
                    
                    piece = Chess(nx);
                    dire = piece.direction(pos_mouse,nx);
        
                    mv = piece.moveon(nx,dire);
                    set(tileHandle,'Position',[nx(1)+mv(1) nx(2)+mv(2) nx(3) nx(4)]);
                    if dire=="false"
                        %disp("DIRECTION-ERORR!!!!");
                    end
                    %boardmat = obj.board;
                end
                tilePos(pieceID) = {get(tileHandle,'Position')};
                newMat = zeros(5,4);
                newBoard = repmat("0",5,4);
                for id = 1:10
                    nx = tilePos{id};
                    piece = Chess(nx);
                    newMat = obj.ToMatrix(piece.matInd,newMat);
                    newBoard = piece.getBoard(newBoard);
                end
        
                if sum(newMat(:)==0)~=2
                    set(tileHandle,'Position',oldPosition);
                    tilePos(pieceID)={get(tileHandle,'Position')};
                else
                    step = step+1;
                    set(stepHandle,'String',strcat("steps: ")+num2str(step));
                    obj.board = newBoard;
                    ifGameOver();
                end
            end
            
            function ifGameOver()
                matrix = obj.board;
                if matrix(4,2) == 'c' & matrix(4,3) == 'c' & matrix(5,2) == 'c' & matrix(5,3) == 'c'
                    errordlg(strcat('Win!  Total steps: ',num2str(step)),'game over!')
                end
            end
        end

        %%%%
    end
end

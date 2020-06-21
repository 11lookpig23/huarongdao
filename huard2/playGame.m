

function playGame(mode)

    global chessHandle tilePos  step stepHandle 
    global tileHandle   pieceID
    gamewindow = figure('Name','hrd','NumberTitle','off','MenuBar','none',...
        'ToolBar','none','Position',[200 400 580 660],'WindowButtonDownFcn',@movetile,'Resize','off');    
    axes( gamewindow,'Position',[0 0 0 0])  
    axis off  %
    step = 0;
    game = Game();%initVal();
    game.startGame(mode)
    ifGameOver()
    tilePos = game.transfer();
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
        oldmat = game.board;
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
            %boardmat = game.board;
        end
        tilePos(pieceID) = {get(tileHandle,'Position')};
        newMat = zeros(5,4);
        for id = 1:10
            nx = tilePos{id};
            piece = Chess(nx);
            newMat = game.ToMatrix(piece.matInd,newMat);
        end

        if sum(newMat(:)==0)~=2
            set(tileHandle,'Position',oldPosition);
            tilePos(pieceID)={get(tileHandle,'Position')};
        else
            step = step+1;
            set(stepHandle,'String',strcat("steps: ")+num2str(step))
            ifGameOver()
        end
    end
    
    function ifGameOver()
        matrix = game.board;
        if matrix(4,2) == 'c' & matrix(4,3) == 'c' & matrix(5,2) == 'c' & matrix(5,3) == 'c'
            errordlg(strcat('Win!  Total steps: ',num2str(step)),'game over!')
        end
    end
end


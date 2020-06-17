classdef  Chess <handle
properties 
    sym;
    matPos;
end
properties (Dependent)
    dirmat;
    matInd;
end
methods 
    function obj = Chess(nx)
        if nx(3)==100 & nx(4)==100
            shape = 'bin';
        elseif nx(3)==100 & nx(4)==200
            shape = 'jjun';
        elseif nx(3)==200 & nx(4)==100
            shape = 'hen';
        elseif nx(3)==200 & nx(4)==200 
            shape = 'cc';
        end
        obj.sym = shape;
        XY0 = 100;
        obj.matPos = [(nx(2)-XY0)/100+1,(nx(1)-XY0)/100+1];
    end

    function dirmat = get.dirmat(obj)
        if obj.sym == "bin"
            %d1>lim(1) & d1<lim(2) & d2>lim(3) & d2<lim(4)
            %["up","down","left","right"]
            dirmat = [
                [0,100,100,300];
                [0,100,-200,0];
                [-200,0,0,100];
                [100,300,0,100]];
            
        elseif obj.sym == "jjun"
            dirmat = [
            [0,100,200,400];
            [0,100,-200,0];
            [-100,0,0,200];
            [100,200,0,200];
            ];
        elseif obj.sym == "hen"
            dirmat = [
                [0,200,100,200];
                [0,200,-100,0];
                [-200,0,0,100];
                [200,400,0,100];
            ];
        elseif obj.sym == "cc"
            dirmat = [
                [0,200,200,300];
                [0,200,-100,0];
                [-100,0,0,200];
                [200,300,0,200];
            ];
        end
    end

    function matInd = get.matInd(obj)
        if obj.sym == "bin"
            matInd = [[6-obj.matPos(1),obj.matPos(2)]];
        elseif obj.sym == "jjun"
            matInd = [[5-obj.matPos(1),obj.matPos(2)];[6-obj.matPos(1),obj.matPos(2)]];
        elseif obj.sym == "hen"
            matInd = [[6-obj.matPos(1),obj.matPos(2)];[6-obj.matPos(1),obj.matPos(2)+1]];
        elseif obj.sym == "cc"
            matInd = [[5-obj.matPos(1),obj.matPos(2)];[6-obj.matPos(1),obj.matPos(2)];[5-obj.matPos(1),obj.matPos(2)+1];[6-obj.matPos(1),obj.matPos(2)+1]];
        end
    end

    function dire = direction(obj,pos_mouse,nx)
        XY0 = 100;
        d1 = pos_mouse(1)-(nx(1)-XY0);
        d2 = pos_mouse(2)-(nx(2)-XY0);
        dire = "false";
        dirorder = ["up","down","left","right"];
        for i = 1:4
            lim = obj.dirmat(i,:);
            if d1>lim(1) & d1<lim(2) & d2>lim(3) & d2<lim(4)
                dire = dirorder(i);
                break;
            end
        end
    end
    function mv = moveon(obj,nx,direction)
        if direction=="up"
            mv = [0,100];
        elseif direction=="down"
            mv = [0,-100];
        elseif direction=="left"
            mv = [-100,0];
        else
            mv = [100,0];
        end
    end
end
end

             
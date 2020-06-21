classdef  tile
    properties
        XY;
        shape;
    end
    properties (Dependent)
        sym;
    end
    methods
        function obj = tile(XY,shape)
            obj.XY = XY;
            obj.shape = shape;
        end
        function sym = get.sym(obj)
            if  obj.shape == 'cc'
                sym = 'c';
            elseif obj.shape == 'jjun'
                sym = 'j';
            elseif obj.shape == "hen"
                sym = 'h';
            else
                sym = 'b';
            end
        end
        function allpoint = getPos(obj)
            if obj.shape == 'cc'
                allpoint = [obj.XY;[obj.XY(1),obj.XY(2)+1];[obj.XY(1)+1,obj.XY(2)];[obj.XY(1)+1,obj.XY(2)+1]];        
            elseif obj.shape == 'jjun'
                allpoint = [obj.XY;[obj.XY(1)+1,obj.XY(2)]];
            elseif obj.shape == 'hen'
                allpoint =  [obj.XY;[obj.XY(1),obj.XY(2)+1]];
            else
                allpoint = [obj.XY];
            end
        end
    end
end
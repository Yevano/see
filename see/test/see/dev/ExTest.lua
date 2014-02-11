function ExTest.main()
    local A = class("A", { },
    function()
        function A:init(x)
            self.x = x * 2
        end
    end)
    local B = class("B", {
        import = {
            "see.util.Math";
        };
        native = {
            "print";
        };
        extends = ExTest;
    }, function()
        function B:init(x)
            A.init(self, x)
        end

        function B:y(z)
            print(Math.pow(self.x, z))
        end
    end)
    B.new(3):y(4)
end
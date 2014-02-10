--@import see.concurrent.Thread

function ExTest:init(x)
    self.x = x
end

function ExTest.main()
    local c = class("Anon", {
        import = {
            "see.util.Math";
        };
        native = {
            "print";
        };
        extends = ExTest;
    }, function()
        function Anon:init(x)
            ExTest.init(self, x)
        end

        function Anon:y(z)
            print(Math.pow(self.x, z))
        end
    end)
    c.new(22):y(4)
end
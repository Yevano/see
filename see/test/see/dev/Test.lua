--@import see.io.Path
--@import see.io.FileOutputStream
--@import see.io.FileInputStream
--@import see.io.DataOutputStream
--@import see.io.DataInputStream
--@import see.io.ArrayOutputStream
--@import see.io.ArrayInputStream

function Test.main()
    local path = Path.new("/filetest")
    local array = Array.new()

    local dos = DataOutputStream.new(ArrayOutputStream.new(array))
    dos:writeString("Hello!\n")
    local dis = DataInputStream.new(ArrayInputStream.new(array))

    System.write(dis:readString(array:length()))
end
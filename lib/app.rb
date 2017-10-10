class App
    def initialize(input=$stdin, output=$stdout)
        @output = output
        @input = input
    end

    def output(string)
        @output.puts(string)
    end

    def input
        @input.gets.chomp
    end
end

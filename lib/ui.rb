class Ui
    def initialize(input, output)
        @input = input
        @output = output
    end

    def output(string)
        @output.puts(string)
    end
    
    def input
        @input.gets.chomp
    end
end

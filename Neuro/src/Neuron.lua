local neuron = {}

-- Random weight generation function
function neuron.randw()
    -- Returns a double -1 < w < 1
    return (1 - (math.random() * 2))
end

-- Sigmoid activation function
function neuron.sigmoid(input)
    return 1 / (1 + math.exp(-input))
end

-- Initialization function for neuron
function neuron:initialize(num_inputs)
    self.input = {{value = -1, weight = self.randw()}} -- Bias initialization
    if num_inputs then 
        for input_number = 1, num_inputs do 
            local new = {value = 1, weight = self.randw()}
            self:addinput(new)
        end
    end 
end

-- Function to add a new input to the neuron
function neuron:addinput(input)
    assert(input.value, "Input error: no value given")
    assert(input.weight, "Input error: no weight given")
    table.insert(self.input, input) -- Correct insertion into input table
end

-- Function to compute the output signal of the neuron
function neuron:getsignal()
    local sum = 0 
    for _, input in ipairs(self.input) do
        assert(input.value, "Input error: no value given")
        assert(input.weight, "Input error: no weight given")
        sum = sum + input.value * input.weight 
    end 
    return self:sigmoid(sum)
end

-- Factory method to create a new neuron
function neuron.new(num_inputs)
    local self = setmetatable({}, {__index = neuron})
    self:initialize(num_inputs)
    return self
end

-- Optional: Seed the random number generator for reproducibility
math.randomseed(os.time())

return neuron

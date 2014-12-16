class State

  attr_reader :name, :transitions
  
  attr_accessor :enter_context, :leave_context, :default_context, :leave_code, :enter_code, :default_code
  def initialize(name, enter_context = nil, leave_context = nil, leave = nil, enter = nil)
    @name = name
    @transitions = {}
    @enter_context = enter_context
    @leave_context = leave_context
    @leave_code = leave
    @enter_code = enter
  end

  def add_transition(transition)
    @transitions[transition.name] = transition if transition.from == @name
  end

  def next_state 
    transitions = next_state_transition 
    next_state = transitions.map { |transition| transition.to }
    next_state
  end

  def next_state_transition
    @transitions.values.select { |transition| transition.can_transition? }
  end

  def leave
    @leave_code.call(@leave_context) if @leave_code
  end

  def enter
    @enter_code.call(@enter_context) if @enter_code
  end

  def default
    @default_code.call(@default_context) if @default_code
  end

end
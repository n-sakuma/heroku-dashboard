class WorkerMan
  def initialize(name)
    @name
  end

  def run
    puts <<-"EOS"
    ---------------------
     WorkerMan - #{@name}

     ...run
     --------------------
    EOS
  end
end

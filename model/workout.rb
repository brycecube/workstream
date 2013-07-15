class Routine
  include DataMapper::Resource
  storage_names[:default] = "routine"

  property :routine_id, Serial
  property :name, String, :length => 255, :required => true
  property :description, String, :length => 255, :required => false
end

class RoutineSet
  include DataMapper::Resource
  storage_names[:default] = "routine_set"

  property :routine_set_id, Serial
  property :routine_id, Integer
  property :exercise_id, Integer
  property :repetitions, Integer
  property :weight, Float
  property :name, String, :length => 255, :required => true
end



class Routine
  include DataMapper::Resource
  storage_names[:default] = "routine"

  property :id, Serial
  property :user_id, Integer
  property :name, String, :length => 255, :required => true
  property :description, String, :length => 255, :required => false

  has n, :routine_exercises
end

class RoutineExercise
  include DataMapper::Resource
  storage_names[:default] = "routine_exercise"

  property :id, Serial
  property :exercise_id, Integer
  property :sort, Integer
  
  belongs_to :routine
  
  # temporary - until we get real exercises
  property :name, String, :length => 255, :required => true
end



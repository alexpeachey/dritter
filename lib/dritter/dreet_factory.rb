module Dritter
  module DreetFactory
    def self.coin_flip
      sides = [true,false]
      pick_random(sides)
    end

    def self.random_dreet
      "#{random_occur} I #{random_verb} #{random_item}"
    end

    def self.random_occur
      occurs = ['Last Night', 'Yesterday', 'Last Week', 'This morning']
      pick_random(occurs)
    end

    def self.random_verb
      verbs = ['ate', 'saw', 'ran into', 'went out with' ]
      pick_random(verbs)
    end

    def self.random_item
      items = ['a cake', 'a bagel', 'my girlfriend', 'my boyfriend', 'your mom']
      pick_random(items)
    end

    def self.random_first_name
      names = ['Jim', 'Bob', 'Sally', 'Jill', 'Jane', 'George']
      pick_random(names)
    end

    def self.random_last_name
      names = ['Jones', 'Smith', 'Johnson', 'Williams', 'Brown', 'Miller']
      pick_random(names)
    end

    def self.pick_random(a)
      randomize(a).first
    end

    def self.randomize(a)
      a.sort_by {rand}
    end
  end
end
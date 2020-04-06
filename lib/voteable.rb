module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval { establish_votes_relationship }
  end

  module InstanceMethods
    def total_votes
      up_votes - down_votes
    end

    def up_votes
      self.votes.where(vote: true).size
    end
  
    def down_votes
      self.votes.where(vote: false).size
    end
  end

  module ClassMethods
    def establish_votes_relationship
      has_many :votes, as: :voteable
    end
  end
end
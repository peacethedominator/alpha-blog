class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'Blogger'
    belongs_to :followed, class_name: 'Blogger'
end

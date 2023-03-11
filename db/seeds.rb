ApplicationRecord.transaction do 
    User.destroy_all
    ApplicationRecord.connection.reset_pk_sequence!('users')
end
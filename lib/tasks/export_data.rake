namespace :export do
  desc "Export users" 
  task :export_to_seeds => :environment do
    klasses = [Player, Match, Course, Hole, MatchTeam, Score, Team]
    klasses.each do |klass|
      klass.all.each do |model| 
        excluded_keys = ['created_at', 'updated_at', 'id'] 
        serialized = model
          .serializable_hash
          .delete_if{|key,value| excluded_keys.include?(key)} 
        puts "#{klass.name}.create(#{serialized})"
      end 
    end 
  end
end
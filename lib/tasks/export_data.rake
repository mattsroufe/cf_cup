namespace :export do
  desc "Export users" 
  task :export_to_seeds => :environment do
    klasses = [Team, Player, Course, Hole, Match, MatchTeam, Score]
    klasses.each do |klass|
      puts "#{klass.name}.delete_all"
      klass.all.each do |model| 
        excluded_keys = ['created_at', 'updated_at']
        serialized = model.as_json.except(*excluded_keys)
        puts "#{klass.name}.create!(#{serialized})"
      end 
    end 
  end
end

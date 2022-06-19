namespace :export do
  desc "Export users" 
  task :export_to_seeds => :environment do
    klasses = [Score, MatchTeam, TeamPlayer, Team, MatchPlayer, Player, Match, Hole, Course]
    klasses.each do |klass|
      puts "#{klass.name}.delete_all"
    end
    klasses.reverse.each do |klass|
      klass.all.each do |model| 
        excluded_keys = ['created_at', 'updated_at']
        serialized = model.as_json.except(*excluded_keys)
        puts "#{klass.name}.create!(#{serialized})"
      end 
    end 
  end
end

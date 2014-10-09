desc "Static data import"


namespace :db do
task :import_data, [:args] => :environment do |t, args|
  import_plain_data('users', User)
end
def import_plain_data(name, klass)
  File.open("./lib/tasks/data/#{name}", 'r') do |f|
    e = f.each_line
    attr_names = e.next.chomp.split
    klass.transaction do
      loop do
        attrs = (
          tmp = []
          [attr_names, e.next.chomp.split].transpose.each do |pair|
            tmp<<(
              if pair[0].include? '@'
                id_name, id = nil
                pair[0].split('@').tap do |ar|
                  id_name = (ar[0].singularize+'_id').to_sym
                  f_klass = ar[0].classify.constantize
                  id = f_klass.find_by(ar[1].to_sym => pair[1]).id
                end
                [id_name, id]
              else
                [pair[0].to_sym, pair[1]]
              end)
          end
          tmp
        ).to_h
        klass.new(attrs.merge(password: 123, password_confirmation: 123)).save
      end
    end
  end
end

end
namespace :csv do
  desc "TODO"
  task import: :environment do
    # getting all the csv files with in the directory
    csv_files = Dir.glob("db/medsage_csvs/*").sort
    # reading csvs one by one
    csv_files.each do |csv_file|
    # reading csv
    read_csv csv_file
    end
  end
 
  # Method to read csv file
  def read_csv csv_file
    # current model as per csv header
    resource_model = resource_model csv_file
    puts "-------------- Importing #{csv_file} --------------"
    CSV.foreach(csv_file, headers: true) do |row|
      resource_model.insert_or_update(row.to_h)
      puts "    Row #{row.to_h} imported"
    end
    puts "--------------- Imported #{csv_file} --------------"
    puts "---------------------------------------------------"
  end

  # Finding out the resource model
  def resource_model csv_file
    # storing headers
    csv_headers = CSV.read(csv_file, headers: true).headers
    # checking csv headers and finding out the appropriate model
    %w(Patient Order Invoice).each do |model_name|
      resource_model = model_name.constantize
      return resource_model if (csv_headers - resource_model::HEADERS).blank?
    end
    
  end
end

class AddEnvironmentToHosts < ActiveRecord::Migration
  def change
    add_reference :hosts, :environment, index: true
  end
end

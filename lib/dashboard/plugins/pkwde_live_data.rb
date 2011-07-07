require 'dashboard/plugins/database_plugin'

module Dashboard
  module Plugins
    class PkwdeLiveData < DatabasePlugin
      def build_report
        super
        report :count_dealer_cars, how_many?(%{
          SELECT COUNT(*) FROM cars, car_statuses
          WHERE cars.car_status_id  = car_statuses.id
            AND car_statuses.name = "active"
            AND cars.car_status_id = car_statuses.id
            AND cars.commercial = 1})
        report :count_customer_cars, how_many?(%{
          SELECT COUNT(*) FROM cars, car_statuses
          WHERE cars.car_status_id  = car_statuses.id
            AND car_statuses.name = "active"
            AND cars.car_status_id = car_statuses.id
            AND cars.commercial = 0})
        report :count_online_dealers, how_many?(%{
          SELECT COUNT(*) FROM abstract_users
            WHERE type = "Dealer"
            AND dealer_state = "online"})
        report :count_dealer_logins, how_many?(%{
          SELECT SUM(login_count) FROM abstract_users
            WHERE type = "Dealer"})
        report :count_verified_customers, how_many?(%{
          SELECT COUNT(*) FROM abstract_users
            WHERE type = "Customer"
            AND verified = 1})
        report :count_unverified_customers, how_many?(%{
          SELECT COUNT(*) FROM abstract_users
            WHERE type = "Customer"
            AND verified = 0})
        report :count_customer_logins, how_many?(%{
          SELECT SUM(login_count) FROM abstract_users
            WHERE type = "Customer"})
        report :search_orders_executed, how_many?(%{
          SELECT COUNT(*) FROM search_orders
          WHERE expiration_date > NOW()
            AND DATE_ADD(last_execution, INTERVAL 1 DAY) >= NOW()
        })
        report :search_orders_not_executed, how_many?(%{
          SELECT COUNT(*) FROM search_orders
          WHERE expiration_date > NOW()
            AND (last_execution IS NULL
              OR DATE_ADD(last_execution, INTERVAL 1 DAY) < NOW())
        })
      end
    end
  end
end

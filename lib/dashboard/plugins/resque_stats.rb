require 'resque'

module Dashboard
  module Plugins
    class ResqueStats < Dashboard::Plugin
      option :redis_url

      def build_report
        Resque.redis = redis_url
        report_oldest_job
        report_queue_sizes
        report_worker_states
      end

      private

      def report_oldest_job
        working = Resque.working
        worker_jobs = working.zip(working.map(&:job))
        worker_jobs.reject! { |w,| w.idle? }
        jobs = worker_jobs.transpose.last || []
        now = Time.now
        jobs = jobs.map { |j| [ j['run_at'].full? { |ra| Time.parse(ra) } || now, j] }
        oldest = jobs.max { |a, b| a.first <=> b.first }
        if oldest.full?
          time, job = oldest
          report :oldest_worker_job, time.to_f, job['payload'] | job.subhash('queue')
        else
          report :oldest_worker_job, nil
        end
      end

      def report_queue_sizes
        queues = Hash.new(0)
        report :queue_failed, Resque::Failure.count
        queues = Resque.queues
        queues.each do |queue|
          report :"queue_#{queue}", Resque.size(queue), :queues => queues
        end
      end

      def report_worker_states
        workers = Resque.workers.inject(
          Hash.new { |h, k| h[k] = Hash.new(0) }
        ) { |h, w|
          h[w.queues.first][ w.working? ? :working : :waiting ] += 1 ; h
        }
        for (queue, states) in workers
          for (state, count) in states
            report "worker_#{queue}_#{state}", count
          end
        end
      end
    end
  end
end

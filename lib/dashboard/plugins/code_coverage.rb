module Dashboard
  module Plugins
    class CodeCoverage < Plugin
      option :directory
      option :rcov_opts

      def build_report
        directory and File.directory?(directory) or
          raise "#{directory.inspect} isn't a directory" # TODO define an exception hierarchy
        cmd = "rcov --text-summary #{rcov_opts * ' '}"
        debugging and warn "Executing #{cmd.inspect}"
        cd directory do
          `#{cmd}`.each do |line|
            if line =~ /([\d.]+)%\s+(\d+)\s+file\S*/
              coverage, files = $1.to_f, $2.to_i
              report :coverage, coverage, :files => files
            end
          end
        end
      end
    end
  end
end

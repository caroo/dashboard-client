module Dashboard
  module Plugins
    class DiskUsage < Plugin
      def build_report
         `df -P -l -k`.each do |line|
           #/dev/disk0s2   488050672 409126248  78668424    84%    /
           line =~ %r((^/\S+)\s+\d+\s+(\d+)\s+(\d+)\s+\S+\s+(\S+)) or next
           device, used, available, mnt = $1, $2.to_i, $3.to_i, $4
           device = File.basename(device)
           total = used + available
           relative = 100.0 * used / total
           report :"#{device}_abs", used, :max => total, :mnt => mnt
           report :"#{device}_rel", relative, :max => 100.0, :mnt => mnt
         end
      end
    end
  end
end

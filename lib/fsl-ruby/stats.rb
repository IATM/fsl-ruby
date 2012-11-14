module FSL
	class Stats

# Usage: fslstats [-t] <input> [options]

# -t will give a separate output line for each 3D volume of a 4D timeseries
# Note - options are applied in order, e.g. -M -l 10 -M will report the non-zero mean, apply a threshold and then report the new nonzero mean

# -l <lthresh> : set lower threshold
# -u <uthresh> : set upper threshold
# -r           : output <robust min intensity> <robust max intensity>
# -R           : output <min intensity> <max intensity>
# -e           : output mean entropy ; mean(-i*ln(i))
# -E           : output mean entropy (of nonzero voxels)
# -v           : output <voxels> <volume>
# -V           : output <voxels> <volume> (for nonzero voxels)
# -m           : output mean
# -M           : output mean (for nonzero voxels)
# -s           : output standard deviation
# -S           : output standard deviation (for nonzero voxels)
# -w           : output smallest ROI <xmin> <xsize> <ymin> <ysize> <zmin> <zsize> <tmin> <tsize> containing nonzero voxels
# -x           : output co-ordinates of maximum voxel
# -X           : output co-ordinates of minimum voxel
# -c           : output centre-of-gravity (cog) in mm coordinates
# -C           : output centre-of-gravity (cog) in voxel coordinates
# -p <n>       : output nth percentile (n between 0 and 100)
# -P <n>       : output nth percentile (for nonzero voxels)
# -a           : use absolute values of all image intensities
# -n           : treat NaN or Inf as zero for subsequent stats
# -k <mask>    : use the specified image (filename) for masking - overrides lower and upper thresholds
# -h <nbins>   : output a histogram (for the thresholded/masked voxels only) with nbins
# -H <nbins> <min> <max>   : output a histogram (for the thresholded/masked voxels only) with nbins and histogram limits of min and max

# Note - thresholds are not inclusive ie lthresh<allowed<uthresh

		@@command_path = '/usr/local/fsl/bin/fslstats'

			def self.command_path=(path)
				@@command_path = path
			end

			def self.command_path
				@@command_path
			end

@@options_map = {
					low_threshold: '-l', # <lthresh> : set lower threshold
					up_threshold: '-u', # <uthresh> : set upper threshold
					robust_intensity: '-r', # output <robust min intensity> <robust max intensity>
					intensity: '-R', # output <min intensity> <max intensity>
					entropy: '-e', # output mean entropy ; mean(-i*ln(i))
					entropy_nonzero: '-E',# output mean entropy (of nonzero voxels)
					voxels: '-v', # output <voxels> <volume>
					voxels_nonzero: '-V', # output <voxels> <volume> (for nonzero voxels)
					mean: '-m', # output mean
					mean_nonzero: '-M',# output mean (for nonzero voxels)
					stdev: '-s', # output standard deviation
					stdev_nonzero: '-S', # output standard deviation (for nonzero voxels)
					smallest_roi: '-w', # output smallest ROI <xmin> <xsize> <ymin> <ysize> <zmin> <zsize> <tmin> <tsize> containing nonzero voxels
					coord_maxvoxel: '-x', # output co-ordinates of maximum voxel
					coord_minvoxel: '-X', # output co-ordinates of minimum voxel
					cog_mm: '-c', # output centre-of-gravity (cog) in mm coordinates
					cog_voxel: '-C', # output centre-of-gravity (cog) in voxel coordinates
					nth_percentile: '-p', # <n> output nth percentile (n between 0 and 100)
					nth_percentage_nonzero: '-P', # <n> output nth percentile (for nonzero voxels)
					abs: '-a', # use absolute values of all image intensities
					nan_as_zero: '-n', # treat NaN or Inf as zero for subsequent stats
					mask: '-k', #<mask> use the specified image (filename) for masking - overrides lower and upper thresholds
					hist: '-h', #<nbins> output a histogram (for the thresholded/masked voxels only) with nbins
					hist_minmax: '-H' # <nbins> <min> <max>   : output a histogram (for the thresholded/masked voxels only) with nbins and histogram limits of min and max
					}

		def initialize(input_file, separate=false, opt = {})
			@input_file = input_file
			@basename = File.basename(input_file, '.nii.gz')
			@separate = separate
			@opt = opt
		end

		def self.options_map
			@@options_map
		end

		def map_vals(val)
			if val == true || val == false
				''
			else
				val.to_s
			end
		end

		def map_options(opt ={})
			opt.inject({}) { |h, (k, v)| h[k] = (self.class.options_map[k] + ' ' + map_vals(v)); h }
		end

		def argument_list
			map_options(@opt).collect {|k,v| v}.join(' ')
		end

		def command
			sf = @separate ? '-t' : ''
			command_str = "#{self.class.command_path} #{sf} #{@input_file} #{argument_list}"
			puts "Running FSLSTATS with command: #{command_str}..."
			result = `#{command_str}`
			exit_code = $?
			case exit_code
				when 0
					puts "Done running FSLSTATS."
					return result
				else
					puts "An error ocurred while running FSLSTATS"
			        #   exit_error = Dcm2nii::Runner::UnexpectedExitError.new
			        #   exit_error.exit_code = exit_code
			        #   raise exit_error
			        # end
			end
		end

		def get_result
  			# return `find #{@output_dir} -name *_brain.nii*`.chomp
		end

	end
end
module FSL
	class FIRST

# def first(bet_file, id, tmp_dir)
#   `run_first_all -i #{bet_file} -b -s L_Hipp,R_Hipp -o #{tmp_dir}/#{id}`
#   first_files = {}
#   first_files[:origsegs] = `find #{tmp_dir} -name *origsegs.nii*`.chomp
#   first_files[:firstseg] = `find #{tmp_dir} -name *firstseg.nii*`.chomp
#   return first_files
# end

# Usage: run_first_all [options] -i <input_image> -o <output_image>

# Optional arguments:
#   -m <method>      : method must be one of auto, fast, none or a (numerical) threshold value
#   -b               : input is already brain extracted
#   -s <name>        : run only on one specified structure (e.g. L_Hipp) or a comma separated list (no spaces)
#   -a <img2std.mat> : use affine matrix (do not re-run registration)
#   -3               : use 3-stage affine registration (only currently for hippocampus)
#   -d               : do not cleanup image output files (useful for debugging)
#   -v               : verbose output
#   -h               : display this help message

# e.g.:  run_first_all -i im1 -o output_name

		@@command_path = '/usr/local/fsl/bin/run_first_all'

			def self.command_path=(path)
				@@command_path = path
			end

			def self.command_path
				@@command_path
			end


		@@options_map = {
							method: '-m',
							already_bet: '-b',
							structure: '-s',
							affine: '-a',
							threestage: '-3',
							no_cleanup: '-d',
							verbose: '-v',
							help: '-h'
						}

		def initialize(input_file, output_file, opt = {})
			@input_file = input_file
			@basename = File.basename(input_file, '.nii.gz')
			@output_file = output_file
			@output_dir = File.dirname(output_file)
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
			command_string = "#{self.class.command_path} #{argument_list} -i #{@input_file} -o #{@output_file}"
			puts "THIS IS THE COMMAND TO BE RUN: #{command_string}"
			output = `#{command_string}`
			exit_code = $?
			case exit_code
				when 0
					return output
				else
			        #   exit_error = Dcm2nii::Runner::UnexpectedExitError.new
			        #   exit_error.exit_code = exit_code
			        #   raise exit_error
			        # end
			end
		end

		def get_result
			first_files = {}
			first_files[:origsegs] = `find #{@output_dir} -name *origsegs.nii*`.chomp
			first_files[:firstseg] = `find #{@output_dir} -name *firstseg.nii*`.chomp
			return first_files
		end

	end
end
module FSL
	class BET # bet <input> <output> [options]

# Main bet2 options:
	# -o generate brain surface outline overlaid onto original image
	# -m generate binary brain mask
	# -s generate rough skull image (not as clean as what betsurf generates)
	# -n don't generate the default brain image output
	# -f <f> fractional intensity threshold (0->1); default=0.5; smaller values give larger brain outline estimates
	# -g <g> vertical gradient in fractional intensity threshold (-1->1); default=0; positive values give larger brain outline at bottom, smaller at top
	# -r <r> head radius (mm not voxels); initial surface sphere is set to half of this
	# -c < x y z> centre-of-gravity (voxels not mm) of initial mesh surface.
	# -t apply thresholding to segmented brain image and mask
	# -e generates brain surface as mesh in .vtk format.
		@@command_path = '/usr/local/fsl/bin/bet'

			def self.command_path=(path)
				@@command_path = path
			end

			def self.command_path
				@@command_path
			end


		@@options_map = { outline: '-o',
							mask: '-m',
							skull: '-s',
							no_output: '-n',
							fi_threshold: '-f',
							v_gradient: '-g',
							radius: '-r',
							centre: '-c',
							thresholding: '-t',
							mesh: '-e'
						}

		def initialize(input_file, output_dir, opt = {})
			@input_file = input_file
			@basename = File.basename(input_file, '.nii.gz')
			@output_dir = output_dir
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
			command_str = "#{self.class.command_path} #{@input_file} #{@output_dir}/#{@basename}_brain #{argument_list}"
			puts "Running BET with command: #{command_str}..."
			result = `#{command_str}`
			exit_code = $?
			case exit_code
				when 0
					puts "Done running BET."
					return result
				else
					puts "An error ocurred while running BET"
			        #   exit_error = Dcm2nii::Runner::UnexpectedExitError.new
			        #   exit_error.exit_code = exit_code
			        #   raise exit_error
			        # end
			end
		end

		def get_result
  			return `find #{@output_dir} -name *_brain.nii*`.chomp
		end

	end
end
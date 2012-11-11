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

		@@options_map = { outline: '-o',
							mask: '-m',
							skull: '-s',
							no_output: '-n',
							fi_threshold: '-i',
							v_gradient: '-g',
							radius: '-r',
							centre: '-c',
							thresholding: '-t',
							mesh: '-e'
						}

		def initialize(input_dir, output_dir, opt = {})
			@input_dir = input_dir
			@input_dir = input_dir
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

	end
end
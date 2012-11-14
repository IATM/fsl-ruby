module FSL
	class UTILS # Misc FSL utilities grouped under FSLUTILS

		@@FSLHOME= '/usr/local/fsl/bin/'

		def self.roi(input, output, xmin, xsize, ymin, ysize, zmin, zsize)
		# Usage: 	fslroi <input> <output> <xmin> <xsize> <ymin> <ysize> <zmin> <zsize>
		#        		fslroi <input> <output> <tmin> <tsize>
		#        		fslroi <input> <output> <xmin> <xsize> <ymin> <ysize> <zmin> <zsize> <tmin> <tsize>
		# Note: indexing (in both time and space) starts with 0 not 1! Inputting -1 for a size will set it to the full image extent for that dimension.
			command_str = "#{@@FSLHOME}/fslroi #{input} #{output} #{xmin.to_s} #{xsize.to_s} #{ymin.to_s} #{ysize.to_s} #{zmin.to_s} #{zsize.to_s}"
			puts "Running FSLROI with command #{command_str}..."
			result = `#{command_str}`
			puts "Done running FSLROI."
		end

		def self.swapdim(input,axes,output)
		# Usage: fslswapdim <input> <a> <b> <c> [output]

		#   where a,b,c represent the new x,y,z axes in terms of the old axes.  They can take values of -x,x,y,-y,z,-z
		#   or RL,LR,AP,PA,SI,IS (in the case of nifti inputs)  e.g.  fslswapdim invol y x -z outvol
		#   or  fslswapdim invol RL PA IS outvol where the latter will convert to axial slicing  (to match the avg152 images)
			command_str = "#{@@FSLHOME}/fslswapdim #{input} #{axes} #{output}"
			puts "Running FSLSWAPDIM with command #{command_str}..."
			result = `#{command_str}`
			puts "Done running FSLSWAPDIM."
		end

	end
end
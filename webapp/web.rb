$: << ".."
require 'clean.rb' # ../clean.rb
require 'sinatra'
require 'open3'
require 'tempfile'

configure do
    set :public_folder, "public"
end

get '/' do
    haml :form
end

post '/' do
    if not params['pdf']
        return haml :form
    end
    stdin, stdout, stderr = Open3.popen3("pdftotext -layout #{params['pdf'][:tempfile].path} -")
    str = clean(stdout.read()).to_s
    
    # Now pass it to Python by writing it to a temporary file first.
    f = Tempfile.new("ParseMe")
    f.write(str)
    f.close()

    # Now run parse.py
    #return "Running python ../parse.py #{f.path} debug"

    stdin, stdout, stderr = Open3.popen3("cd .. && python parse.py #{f.path}")
    @output = stdout.readlines()

    haml :form
end

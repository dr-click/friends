module Members
  class CreateService < ::BaseService
    attr_reader :params, :member

    def initialize(args = {})
      @params = args
    end

    def _execute
      init_member
      member
    end

    #######
    private
    #######

    def init_member
      @member = Member.new(params)
    end

  end
end
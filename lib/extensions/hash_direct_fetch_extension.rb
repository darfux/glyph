class Hash
  def direct_fetch(chain, default=nil)
    tmp = self
    last_key = chain.pop
    chain.each do |key|
      if (v=tmp[key]) && v.is_a?(Hash)
        tmp = v
      else
        tmp = nil
        break
      end
    end
    (tmp && tmp[last_key]) || default
  end
end
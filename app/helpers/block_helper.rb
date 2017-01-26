module BlockHelper
  def check_current_block(block)
    block.current? ? reset_block(block) : set_block(block)
  end

  private

  def reset_block(block)
    link_to 'Сделать обычной', reset_as_current_block_path(block),
            method: :put
  end

  def set_block(block)
    link_to 'Сделать текущей', set_as_current_block_path(block),
            method: :put
  end
end

# coding: utf-8

# Dialog is a chapter of your interactive book, separated in its own object.
# The class contains tools for use in dialogs (Dialog::Tools, blocks) and
# self-service methods (`set`, `start`, etc).
class Dialog
  include Dialog::IO

  def initialize(&actions)
    @actions = actions if block_given?
    @blocks = {}
    @next_block = :none
  end

  def write(&actions)
    @actions = actions if block_given?
  end

  def start
    instance_eval(&@actions)
  end

  # Block is a small part of a dialog, usually asking or providing choose to
  # user at the end

  # Create/launch a part of a dialog. See examples for more
  def block(name)
    if block_given?
      @blocks[name] = Proc.new
    elsif @blocks.key? name
      @blocks[name].call
    else
      false
    end
  end

  def blocks_start(firstBlock)
    @next_block = firstBlock
    while @next_block
      if @blocks.key? @next_block
        block_start
      else
        break
      end
    end
  end

  def next_block(key)
    @next_block = key
  end

  private

  def block_start
    now_block = @next_block
    @next_block = false
    PIRY::Hooks::Manager.event :beforeBlock, now_block
    block now_block
  end
end

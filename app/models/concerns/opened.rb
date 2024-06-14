module Opened 
  extend ActiveSupport::Concern

  # scopo de aberto e fechado para os formulários
  included do 
    scope :opened, -> { where(opened: true) }
    scope :closed, -> { where(opened: false) }
  end

  # funções de fechar e abrir formulários
  def open 
    update_attribute :opened, true
  end

  def close 
    update_attribute :opened, false
  end


end
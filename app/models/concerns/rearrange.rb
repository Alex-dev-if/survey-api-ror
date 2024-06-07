module Rearrange 
  extend ActiveSupport::Concern

  def rearrange #rearranjando a ordem quando o user cria ou atualiza uma questão (exceto se cria junto com o formulário)
    
    if previously_new_record?
      create_rearrange
    elsif saved_change_to_order?
      update_rearrange
    elsif destroyed?
      delete_rearrange
    end
  end

  def create_rearrange 
    return unless order != form.questions_quantity
    form.questions.where('"order" >= ?', order).where.not(id: id).update_all('"order" = "order" + 1') #rearrajando
  end

  def update_rearrange
    previous_order = saved_change_to_order[0]
    if previous_order > order # se a ordem diminuiu: aumente em um de order até previous_order
      form.questions.where(order: order...previous_order).where.not(id: id).update_all('"order" = "order" + 1')
    elsif previous_order < order # caso inverso
      form.questions.where('"order" between ? and ?', previous_order, order).where.not(id: id).update_all('"order" = "order" - 1')
    end
  end

  def delete_rearrange
    return unless order != form.questions_quantity
    form.questions.where('"order" >= ?', order).update_all('"order" = "order" - 1') 
  end
end
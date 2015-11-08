module LitterBoxesHelper
  def litter_box_link
    link_to litter_box_link_text, litter_box_link_path, class: 'pure-menu-link'
  end

  def litter_box_link_path
    if current_user && (lb = current_user.litter_box) && lb.persisted?
      edit_litter_box_path(lb)
    else
      new_litter_box_path
    end
  end

  def litter_box_link_text
    if current_user && (lb = current_user.litter_box) && lb.persisted?
      'Edit Litter Box'
    else
      'Host a Litter Box'
    end
  end
end

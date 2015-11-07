module LitterBoxesHelper
  def litter_box_link_path(user)
    if user && lb = user.litter_box
      edit_litter_box_path(lb)
    else
      new_litter_box_path
    end
  end
end

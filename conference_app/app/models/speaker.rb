class Speaker < ActiveRecord::Base

  def speechify(blabber_duration=1)
    FFaker::HipsterIpsum.paragraph(blabber_duration)
  end

  def to_s
    # alligator ascii
    "            .-._   _ _ _ _ _ _ _ _\n .-''-.__.-'00  '-' ' ' ' ' ' ' ' '-.\n'.___ '    .   .--_'-' '-' '-' _'-' '._\n V: V 'vv-'   '_   '.       .'  _..' '.'.\n   '=.____.=_.--'   :_.__.__:_   '.   : :\n           (((____.-'        '-.  /   : :\n snd                         (((-'\ .' /\n                           _____..'  .'\n                          '-._____.-'"
  end

end

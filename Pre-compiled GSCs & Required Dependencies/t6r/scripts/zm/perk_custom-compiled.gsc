�GSC
     �  R/  �  X/  �(  �)  �:  �:      @ �  W        perk_custom common_scripts/utility maps/mp/_utility maps/mp/gametypes_zm/_hud_util maps/mp/gametypes_zm/_hud_message maps/mp/zombies/_zm maps/mp/zombies/_zm_utility maps/mp/zombies/_zm_weapons maps/mp/zombies/_zm_stats maps/mp/zombies/_zm_powerups maps/mp/zombies/_zm_perks maps/mp/zombies/_zm_audio maps/mp/zombies/_zm_score maps/mp/zombies/_zm_chugabud init precache onplayerconnect initserverdvars startcustomperkmachines afterlife_give_loadout maps/mp/gametypes_zm/_clientids give_afterlife_loadout playerdamagestub callbackplayerdamage phd_flopper_dmg_check istown end_game disconnect connected player dophddive onplayerdowned onplayerrevived disableallcustomperks mapname zm_prison enablephdflopper customperkmachine zombie_perk_bottle_deadshot p6_zm_al_vending_nuke_on PHD Flopper PHD_FLOPPER zm_highrise zombie_perk_bottle_whoswho zombie_vending_nuke_on_lo zm_buried zombie_perk_bottle_marathon zombie_vending_jugg enabledeadshot zombie_vending_revive Deadshot Daiquiri specialty_deadshot zm_nuked zombie_perk_bottle_revive zombie_perk_bottle_jugg enablestaminup zombie_vending_doubletap2 Stamin-Up specialty_longersprint enablemulekick zombie_vending_sleight Mule Kick specialty_additionalprimaryweapon zm_transit waittill_any player_downed fake_death entering_last_stand unsetperk hasphd hasmulekick hasstaminup hasdeadshot icon1 destroy icon2 icon3 icon4 divetoprone isonground script zm_tomb explosionfx _effect divetonuke_groundhit loadfx explosions/fx_default_explosion playsound zmb_phdflop_explo playfx origin damagezombiesinrange kill range what amount enemy getaiarray zombie_team _a203 _k203 zombie distance dodamage health einflictor eattacker idamage idflags smeansofdeath sweapon vpoint vdir shitloc timeoffset boneindex MOD_SUICIDE MOD_FALLING MOD_PROJECTILE MOD_PROJECTILE_SPLASH MOD_GRENADE MOD_GRENADE_SPLASH MOD_EXPLOSIVE bottle model perkname cost perk angles customperknum collision spawn script_model setmodel collision_geo_cylinder_32x128_standard rotateto rperks lowermessage Custom Perks Hold ^3F ^7for   [Cost:  ] trig trigger_radius setcursorhint HINT_NOICON setlowermessage trigger usebuttonpressed score hasperk zmb_cha_ching hide giveperk show iprintln You already have  ! disableoffhandweapons disableweaponcycling weapona getcurrentweapon weaponb giveweapon switchtoweapon weapon_change_complete enableoffhandweapons enableweaponcycling takeweapon setperk playerexert burp setblur drawcustomperkhud specialty_doubletap_zombies specialty_fastreload_zombies specialty_juggernaut_zombies specialty_quickrevive_zombies ref text zombie_hints precachestring ent default_ref script_hint sethintstring get_zombie_hint drawshader shader x y width height color alpha sort hud newclienthudelem elemtype icon children setparent uiparent setshader precachemodel p6_zm_al_vending_pap_on p6_zm_al_vending_jugg_on p6_zm_al_vending_sleight_on p6_zm_al_vending_doubletap2_on p6_zm_al_vending_ads_on p6_zm_al_vending_three_gun_on precacheshader specialty_deadshot_zombies getdvarintdefault disableAllCustomPerks zombie_vars enablePHDFlopper enableStaminUp enableDeadshot enableMuleKick solo_tombstone_removal tombstone_on turn_tombstone_on machine getentarray vending_tombstone targetname machine_triggers target i machine_assets tombstone off_model do_initial_power_off_callback array_thread set_power_on on_model vibrate zmb_perks_power_on perk_fx tombstone_light play_loop_on_machine specialty_scavenger_power_on power_on_callback tombstone_off power_off_callback turn_perk_off players get_players _a1718 _k1718 hasperkspecialtytombstone perk_machine_spawn_init match_string  location scr_zm_map_start_location default default_start_location scr_zm_ui_gametype _perks_ pos override_perk_targetname structs getstructarray zm_perk_machine _a3578 _k3578 struct script_string tokens strtok   _a3583 _k3583 token zm_collision_perks1 script_noteworthy use_trigger trigger_radius_use zombie_vending triggerignoreteam perk_machine _no_vending_machine_bump_trigs bump_trigger script_activated script_sound zmb_perks_bump_bottle audio_bump_trigger specialty_weapupgrade thread_bump_trigger clip disconnectpaths bump blocker_model script_int turn_on_notify specialty_scavenger specialty_scavenger_upgrade mus_perks_tombstone_jingle tombstone_perk script_label mus_perks_tombstone_sting _custom_perks perk_machine_set_kvps zombiemode_using_tombstone_perk perk_array get_perk_array set_perk_clientfield is_true keep_perks hadphd loadout perks specialty_quickrevive flag solo_game solo_game_free_player_quickrevive arrayremovevalue specialty_finalstand give_perk save_afterlife_loadout spawnstruct afterlife_save_perks _a562 _k562 whos_who_self_revive player_revived fake_revive do_revive_ended_normally al_t L   c   t   �   �   �   �       8  R  l  �  &-.  �  6-4    �  6-2 �  6-2 �  6     !�(  H!7(]  !H(-. s  6 �
 zW
 �W
 �U$ %- 4 �  6- 4   �  6- 4   �  6?��  &  �F; �
 �h
�F;B  �F;5 -^ 
T	 )�D	   �F	   3�E[�
 H
 /
 4    6?�
 �h
`F;D  �F;7 -^ 
T	   �w>E	   �+E	   ���D[�
 H
 �
 l4    6?=
 �h
�F;�  �F;; -[
 T	     pC	   �C	   �{$E[�
 H
 �
 �4    6  �F;5 - [
�	 ���	   ��D[�
  
 �
 �4    6?�
 �h
%F;�  �F;/ -�[
T8 � �[�
 H
 �
 .4      6  �F;1 - J[
 [ d �[�
  
 �
 H4      6  `F;- -�[
 �6  ~[�
 �
 o
 .4    6  �F;- -K[
 �S � �[�
 �
 �
 H4    6?� 
 �h
�F;�  �F;/ -Z[
 T7 6 �[�
 H
 �
 .4      6  �F;- -Z[
 � �[�
  
 �
 H4      6  �F;- -�[
 � 0� }[�
 �
 �
 H4    6 &
�W
 zW-
-
 "
 0      6-
 �0    A  6-
 �0    A  6-
 0    A  6!K(!R(!^(!j(- v0 |  6!v(- �0   |  6!�(- �0   |  6!�(- �0   |  6!�(?P�  �
 �W
 zW �_=  �; � -0 �  =   K_;m  �
 �F>	  �
 �F; 
 � �' (?  -
�.   �  ' (-
 0    6- / .   (  6-
 K�0 6  6	  ���>+	  ��L=+?d�  PV[b��-  s.   h  '('(p'(_;l ' (-7  / 7 /. �  H;? 
 KF;  - 7 / 7 �P 0    �  6? - 7 / 0   �  6q'(?��  ����������
 F> 
 F> 
 'F> 
 6F> 
 LF> 
 XF> 
 kF;	  K_;  - 	
 7/6 y���/���@�
 zW �_9; 
 !�(?  �N! �(-
 �. �  '(-
 �0 �  6-	 ���=0   �  6-
 �.   �  '(-	0   �  6-	 ���=0   �  6-
 %
 5
 >NNNN
 4      6-
 E. �  '(-
 b0 T  6-
 0 n  6
~U$ %- 0  �  = 	  7 �K;� 	     �>+- 0   �  ; � 
 TG= - 0    �  9> 
 TF=  7 K_9; R -
� 0     6 7  �O 7! �(- @0   �  6-
 4 �  6+-  @0 �  6? -
�
 �NN 0 �  6?)�  ���	'	-0   �  6-0    �  6-0    	  '(' (- 0   /	  6- 0  :	  6
I	U%-0  `	  6-0    u	  6- 0  �	  6-0  :	  6-0  �	  6-
 �	0    �	  6-	 ���=0    �	  6	  ���=+-	 ���=0 �	  6
TF;& !K(-	     �>[
 �	4  �	  6?� 
 �F;" !R(-	333?[
�	4    �	  6?] 
 �F; !^(-^(
 
4  �	  6?9 
 F;/ !j(-	    >	      >	      >[
 
4    �	  6 ;
?
 D
_9;  ! D
(- .   Q
  6 ! D
(  `
d
7 p
_; --7 p
. �
  0  |
  6? -- .   �
  0  |
  6 	�
�
�
�
�
�
�
�
�
-.   �
  ' (
�
 7!�
( 7! �
( 7! �
( 7! �
( 7!�
(-  0 �
  6- 0   6 7! �
( 7! �
(   ��
�
� v_9; Z  �'(
�h
�F;$ -d %0    �
  !v(?! -d @0    �
  !v(?) �_9; Z  z'(
�h
�F;$ -d %0    �
  !�(?! -d @0    �
  !�(?�  �_9; Z  \'(
�h
�F;$ -d %0    �
  !�(?! -d @0    �
  !�(?a  �_9; W  >'(
�h
�F;$ -d %0    �
  !�(?! -d @0    �
  !�( &-
 �.     6-
 �.   6-
 �.   6-
 l.   6-
 �.   6-
 %.   6-
 %.   6-
 =.   6-
 V.   6-
 r.   6-
 �.   6-
 /.   6-
 �.   6-
 �.   6-
 o.   6-
 �. �  6 &-
.   �  !�(  �
 !(-
%. �  !�(  �
 %!(-
6. �  !`(  `
 6!(-
E. �  !�(  �
 E!(-
T. �  !�(  �
 T!(  &
z  ����	�; �-
�
 �. �  '(-
 �
 �.   �  '('(SH;$ -
� �7  �0    �  6'A? ��-
�4      6-2  . %  6
zU%'(SH;� -
� �7  ?0    �  6-	   ���>	   ���>d^`0 H  6-
 P0      6-
 k4    c  6-4    {  6'A? w�X
�V-  2  . %  6
� �7  �_; -
� �7  �. %  6
�U%
� �7  �_; -
� �7  �.   %  6- �  . %  6-. �  '('(p'(_; ' ( 7! (q'(?��? 4�  BP�����$+2��^���
 O'(  Y'(
sG= 
 OF=  {_;  {'(  �
 �NN'('(  �_; -
� �.   �  '(? -
�
 �. �  '('(p'(_;t '
(
7 _;N -
"
7 .     '	(	'(p'(_;$ '(F;	 
S'(q'(?��? 	 
S'(q'(?��_9>  SF;  -
 8.   6'(SH;n7  L'(_=  7  �_;E-F(7  /^`N
 j. �  '(
}7!�(7! L(-0 �  6-7  /
 �.   �  '(7 �7!�(-7  �0   �  6  �_=  �;  '(? O -@#7  /
 E. �  '(7! �(
�7!�(
7!�(
G; -4  4  6-7  /
 �. �  ' (7 � 7!�(-
 8 0 �  6
H 7!L(- 0 M  6 7! H(7! �(7! ](7 b_; 7  b7!b(7 p_; 7  p7!p(7 {_; 7  {7!{(
�F> 
 �F;O 
 �7!�(
�7!(
�7!�(
�7!�(
�7!(
�7!�(_;  
 �7!(  _=   7  _; -   7  /6'A? ��  &  /_=  /;  -4 *  6-2 c  6-2 �  6 O��-.  Z  '('(SH;( ' (- 0   A  6- 0 i  6'A? ��-  �. ~  ; 9 -  �. ~  ; ) !K(!�(-	     �>[
 �	4  �	  6  �_=  �=  7  �_=	 7  �SI;,'(7  �SH; -7 �0   �  ;  'A?��7  �
�F=
 -
�. �  ;  !�(7 �
�F;> -
�0    �	  6! ^(-^(
 
4  �	  6-
 �7  �.   �  6?d�7  �
�F;D -
�0  �	  6! R(-	333?[
�	4    �	  6-
 �7  �.   �  6?�7  �
�F; 'A?��-7 �.      6'A	   ��L=+?��! �( &-. 4  !�( �7!�(-.  @   �7!�( `
OU[�-0    Z  '('(p'(_;  ' (- 0  A  6q'(?�� &
�W
 zW-
�
 �
 �
 v
 a0    6+-  �. ~  ; 8 -
T0  �	  6! K(!�(-	   �>[
 �	4  �	  6?  ?��  �:��  �  �f2  �  �g�~r  �  Q��Z  �  :�T3  �  ����  6 ��f  ] �(�B�   �NK�  � ܾN�F   ���5v  n �����  �
 �{A>  �	 -�c��  �  Z_�ך  �  Wo�>   c  (&&�D   �  ���z""  *  �b���%  s  �w�5&     �ەR�'    �wk�(  @ uA$�p(  �  �>   �  �>   �  �>   �  �>         	  ]>     s>   *  �>   N  �>   X  �>   d  >  �    e  �  �  '  a  �  �    Q  >  s  A>  �  �  �  4&  Y(  |>   �  �  �    �>   :  �>  x  >  �  \  /!  (>  �  6>  �  h>  �  �>    �>  7  P  �>  2  d  �#  �>  B  t  �   �   $  �$  �>  T  �  >  �  �>  �  �#  :$  T>  �  n>  �  �>   �    �>  3  �&  �>   |  �>  �  �>   �  �>  �  �>   �  �>   �  	>   �  /	>  �  :	>  	  =  `	>     u	>   #  �	>  1  �	>  I  ''  u'  �(  �	R W  �	>  k  �  �	>  �  �    ;  �(  Q
>  `  �
>  �  �  |
>  �  �  �
>  �  �
>    >    �
>  w  �  �  �  ?  c  �  �  >  �  �  �        &  2  >  J  V  b  n  z  �  V#  �>  �  �>  �  �  �     "   �>  b   t   >  �   2>   �   m!  %>  �   v!  H>  !  c>  C!  {>   S!  %>  �!  �!  �!  �>   �!  �>   �!  �>  �"  �"  >  �"  �>   �#  4>   m$  �>  �$  M>   �$  *>   �%  c>   �%  �>   �%  Z8 &  i>  B&  ~>  V&  f&  �(  �	  �&  A'  �'  �>  '  �>  T'  �'  8 �'  4>   �'  @>  (  Z>  /(  >  �(        �  H  &  7  �  �4    R   (  z 8  b  $    x(  � >  \    r(  � D  �v  �  �  �	 �  �    �  �  Z  �  "  �  � �  ��  �  *  �  �  �  �  T	 �  �  :  �  �  (  D  �  �(  H �    Z  �  �  / �  `   �  ` �  � 
    l      � "  ^  ^  �  &  �  � ^  �  �  �  � b  �  �  �p  �  �  
       �  
  �  �      �      � �       x  % �  . �  ^  �  H $  �    N  `4  �  �  � D  �  �  '  $'  L'  � V  o Z  �  �l  $  *   0   � |  4  �  �  j'  r'  �'  � �  F  � �  J  � �  - h  " l   p  K�  F  �  N  �  t&  �(  R�  �  �'  ^�  �  6'  j�    v�  �  J  �  �  ��  �  �  �  
  ��  �    J  n  �    v  �  �  �  �*  2  �N  Z  � R  � f  �j  � v   �  /
�      *  J  �  �#  �#  4$  �$  K �    P�  V�  [�  b�  �  ��  ��  s�  �0  �h  �j  �l  �n  �p  �r  �t  �v  �x  �z  |   �   �  ' �  6 �  L �  X �  k �  y�  ��  �  �#   $  ��  �  F  ��  ��  �  @  <"  &  ((  ��  �#  �#  �$  �$  ��  D"  �  @   z  �  �       (  � 0  b  �#  �$  � >  �  % �  5 �  > �   �  �  E �  8$  b �  ~ �  �  j  t  � X  � �  � �  	�  '	�  I	   �	 T  �	 �  �&  �(  �	 �  �'   
 �  >'  
 8  ;
H  ?
J  D
N  Z  p  `
x   (  d
z  p
�  �  �
�  �
�  ,  B  �
�  6  �
�  �
�  �
�  �  D  �
�  �  �
�  �  �
�  �
 �  �
�  �
  
  %   $  = 0  V <  r H  � T  � l  � �   �  �  �  �  �     8   % �  �  6 �  �  E        T     4   z @   �   �F   �$  �H   �J   :"  
&  �L   N   	P   � \   �"  �"  � `   r   l%  �%  � n   � �   �   �   ~!  �!  �!  �!  ��   �   �!  �!  �!  �!  ��   ?�   P (!  k <!  � f!  ��!  �!  � �!  ��!  �!  "  B$"  P&"  �("  �*"  �,"  �."  �0"  2"  $4"  +6"  28"  ^>"  �@"  �B"  O H"  b"  YP"  s X"  {j"  r"  �z"  � ~"  ��"  �"  � �"  �"  �"  ^%  |%  �%  " �"  8 T#  �$  Lr#  �#  �$  j �#  } �#  ��#  ^$  �%  �$  $  �J$  � N$  �T$  T%   X$   d$  H �$  H�$  ]�$  b�$  �$  �$  p%  %  %  {"%  0%  6%  � <%  � F%  � N%  � X%  v%  �%  � b%  �h%  �r%  �%  �%  �%  �%  �%  /�%  �%  O&  "(  �T&  �&  �&  �'  �d&  z&  �(  �(  ��&  �&  �&  �&  �&  '  R'  f'  �'  �'  �'  (  � �&  �  '  �'  � �'  ��'  (  (  U$(  [&(  � ~(  � �(  � �(  v �(  a �(  
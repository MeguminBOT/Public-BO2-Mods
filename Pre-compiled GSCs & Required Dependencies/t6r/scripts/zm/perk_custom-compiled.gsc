�GSC
     ^  �*  �  �*  &%  &  05  05      @ �  M        perk_custom common_scripts/utility maps/mp/_utility maps/mp/gametypes_zm/_hud_util maps/mp/gametypes_zm/_hud_message maps/mp/zombies/_zm maps/mp/zombies/_zm_utility maps/mp/zombies/_zm_weapons maps/mp/zombies/_zm_stats maps/mp/zombies/_zm_powerups maps/mp/zombies/_zm_perks maps/mp/zombies/_zm_audio maps/mp/zombies/_zm_score maps/mp/zombies/_zm_chugabud init precache onplayerconnect initserverdvars startcustomperkmachines playerdamagestub callbackplayerdamage phd_flopper_dmg_check istown end_game disconnect connected player dophddive onplayerdowned onplayerrevived disableallcustomperks mapname zm_prison enablephdflopper customperkmachine zombie_perk_bottle_deadshot p6_zm_al_vending_nuke_on PHD Flopper PHD_FLOPPER zm_highrise zombie_perk_bottle_whoswho zombie_vending_nuke_on_lo zm_buried zombie_perk_bottle_marathon zombie_vending_jugg enabledeadshot zombie_vending_revive Deadshot Daiquiri specialty_deadshot zm_nuked zombie_perk_bottle_revive zombie_perk_bottle_jugg enablestaminup zombie_vending_doubletap2 Stamin-Up specialty_longersprint enablemulekick zombie_vending_sleight Mule Kick specialty_additionalprimaryweapon zm_transit waittill_any player_downed fake_death entering_last_stand unsetperk hasphd hasmulekick hasstaminup hasdeadshot icon1 destroy icon2 icon3 icon4 divetoprone isonground script zm_tomb explosionfx _effect divetonuke_groundhit loadfx explosions/fx_default_explosion playsound zmb_phdflop_explo playfx origin damagezombiesinrange kill range what amount enemy getaiarray zombie_team _a205 _k205 zombie distance dodamage health einflictor eattacker idamage idflags smeansofdeath sweapon vpoint vdir shitloc timeoffset boneindex MOD_SUICIDE MOD_FALLING MOD_PROJECTILE MOD_PROJECTILE_SPLASH MOD_GRENADE MOD_GRENADE_SPLASH MOD_EXPLOSIVE bottle model perkname cost perk angles customperknum collision spawn script_model setmodel collision_geo_cylinder_32x128_standard rotateto rperks lowermessage Custom Perks Hold ^3F ^7for   [Cost:  ] trig trigger_radius setcursorhint HINT_NOICON setlowermessage trigger usebuttonpressed score hasperk zmb_cha_ching hide giveperk show iprintln You already have  ! disableoffhandweapons disableweaponcycling weapona getcurrentweapon weaponb giveweapon switchtoweapon weapon_change_complete enableoffhandweapons enableweaponcycling takeweapon setperk playerexert burp setblur drawcustomperkhud specialty_doubletap_zombies specialty_fastreload_zombies specialty_juggernaut_zombies specialty_quickrevive_zombies ref text zombie_hints precachestring ent default_ref script_hint sethintstring get_zombie_hint drawshader shader x y width height color alpha sort hud newclienthudelem elemtype icon children setparent uiparent setshader precachemodel p6_zm_al_vending_pap_on p6_zm_al_vending_jugg_on p6_zm_al_vending_sleight_on p6_zm_al_vending_doubletap2_on p6_zm_al_vending_ads_on p6_zm_al_vending_three_gun_on precacheshader specialty_deadshot_zombies getdvarintdefault disableAllCustomPerks zombie_vars enablePHDFlopper enableStaminUp enableDeadshot enableMuleKick solo_tombstone_removal tombstone_on turn_tombstone_on machine getentarray vending_tombstone targetname machine_triggers target i machine_assets tombstone off_model do_initial_power_off_callback array_thread set_power_on on_model vibrate zmb_perks_power_on perk_fx tombstone_light play_loop_on_machine specialty_scavenger_power_on power_on_callback tombstone_off power_off_callback turn_perk_off players get_players _a1718 _k1718 hasperkspecialtytombstone perk_machine_spawn_init match_string  location scr_zm_map_start_location default default_start_location scr_zm_ui_gametype _perks_ pos override_perk_targetname structs getstructarray zm_perk_machine _a3578 _k3578 struct script_string tokens strtok   _a3583 _k3583 token zm_collision_perks1 script_noteworthy use_trigger trigger_radius_use zombie_vending triggerignoreteam perk_machine _no_vending_machine_bump_trigs bump_trigger script_activated script_sound zmb_perks_bump_bottle audio_bump_trigger specialty_weapupgrade thread_bump_trigger clip disconnectpaths bump blocker_model script_int turn_on_notify specialty_scavenger specialty_scavenger_upgrade mus_perks_tombstone_jingle tombstone_perk script_label mus_perks_tombstone_sting _custom_perks perk_machine_set_kvps zombiemode_using_tombstone_perk whos_who_self_revive player_revived fake_revive do_revive_ended_normally al_t is_true hadphd L   c   t   �   �   �   �       8  R  l  �  &-.   �  6-4    �  6-2 �  6-2 �  6  �!�(  !�(-. %  6 J
 ,W
 5W
 @U$ %- 4 Q  6- 4   [  6- 4   j  6?��  &  zF; �
 �h
�F;B  �F;5 -^ 
	 )�D	   �F	   3�E[�
 �
 �
 �4  �  6?�
 �h
F;D  �F;7 -^ 
	   �w>E	   �+E	   ���D[�
 �
 9
 4  �  6?=
 �h
SF;�  �F;; -[
 	     pC	   �C	   �{$E[�
 �
 y
 ]4  �  6  �F;5 - [
��	 ���	   ��D[�
 �
 �
 ]4  �  6?�
 �h
�F;�  �F;/ -�[
8 � �[�
 �
 y
 �4    �  6  �F;1 - J[
 �[ d �[�
 �
 �
 �4    �  6  F;- -�[
 E6  ~[�
 ;
 !
 �4  �  6  \F;- -K[
 �S � �[�
 �
 k
 �4  �  6?� 
 �h
�F;�  �F;/ -Z[
 7 6 �[�
 �
 y
 �4    �  6  �F;- -Z[
 �� �[�
 �
 �
 �4    �  6  \F;- -�[
 � 0� }[�
 �
 k
 �4  �  6 &
5W
 ,W-
�
 �
 �0    �  6-
 �0    �  6-
 E0    �  6-
 �0    �  6!�(!(!(!(- (0 .  6!((- 60   .  6!6(- <0   .  6!<(- B0   .  6!B(?P�  n
 5W
 ,W H_=  H; � -0 T  =   �_;m  _
 fF>	  _
 SF; 
 � z' (?  -
�.   �  ' (-
 �0  �  6- � .   �  6-
 ��0 �  6	  ���>+	  ��L=+?d�  17=-  %.     '('(p'(_;l ' (-7  � 7 �. D  H;? 
 �F;  - 7 � 7 VP 0    M  6? - 7 � 0   M  6q'(?��  ]hrz�������
 �F> 
 �F> 
 �F> 
 �F> 
 �F> 
 
F> 
 F;	  �_;  - 	
 �/6 +28A�FK`��J
 ,W R_9; 
 !R(?  RN! R(-
 p. j  '(-
 �0 }  6-	 ���=0   �  6-
 p.   j  '(-	0   }  6-	 ���=0   �  6-
 �
 �
 �NNNN
 �4    �  6-
 �. j  '(-
 0   6-
 �0    6
0U$ %- 0  8  = 	  7 IK;� 	     �>+- 0   8  ; � 
 G= - 0    O  9> 
 F=  7 �_9; R -
W 0   �  6 7  IO 7! I(- �0   e  6-
 4 j  6+-  �0 s  6? -
�
 �NN 0 x  6?)�  2F8��-0   �  6-0    �  6-0    �  '(' (- 0   �  6- 0  �  6
�U%-0  	  6-0    '	  6- 0  ;	  6-0  �  6-0  F	  6-
 Z	0    N	  6-	 ���=0    _	  6	  ���=+-	 ���=0 _	  6
F;& !�(-	     �>[
 y	4  g	  6?� 
 �F;" !(-	333?[
�	4    g	  6?] 
 EF; !(-^(
�	4  g	  6?9 
 �F;/ !(-	    >	      >	      >[
 �	4    g	  6 �	�	 �	_9;  ! �	(- .   
  6 ! �	(  

7 "
_; --7 "
. <
  0  .
  6? -- .   <
  0  .
  6 	W
^
`
b
h
o
u
{
�
-.   �
  ' (
�
 7!�
( 7! o
( 7! u
( 7! {
( 7!�
(- �
 0 �
  6- 0 �
  6 7! ^
( 7! `
(   F^
o
8 (_9; Z  �'(
�h
SF;$ -d %0    L
  !((?! -d @0    L
  !((?) 6_9; Z  z'(
�h
SF;$ -d %0    L
  !6(?! -d @0    L
  !6(?�  <_9; Z  \'(
�h
SF;$ -d %0    L
  !<(?! -d @0    L
  !<(?a  B_9; W  >'(
�h
SF;$ -d %0    L
  !B(?! -d @0    L
  !B( &-
 �.   �
  6-
 y. �
  6-
 ]. �
  6-
 . �
  6-
 9. �
  6-
 �
. �
  6-
 �
. �
  6-
 �
. �
  6-
 . �
  6-
 $. �
  6-
 C. �
  6-
 �. �
  6-
 [. �
  6-
 �. �
  6-
 !. �
  6-
 �. y  6 &-
�.   �  !z(  z
 �!�(-
�. �  !�(  �
 �!�(-
�. �  !(  
 �!�(-
�. �  !�(  �
 �!�(-
. �  !\(  \
 !�(  &
,  K|����J; �-
q
 _. S  '(-
 �
 _.   S  '('(SH;$ -
� �7  �0    }  6'A? ��-
�4    �  6-�  . �  6
,U%'(SH;� -
� �7  �0    }  6-	   ���>	   ���>d^`0 �  6-
 0    �  6-
 4      6-4    -  6'A? w�X
BV-  �  . �  6
� �7  __; -
� �7  _. �  6
qU%
� �7  _; -
� �7  .   �  6- �  . �  6-. �  '('(p'(_; ' ( 7! �(q'(?��? 4�  �_|��������FP|`
 '(  '(
%G= 
 F=  -_;  -'(  D
 WNN'('(  c_; -
q c.   �  '(? -
q
 �. �  '('(p'(_;t '
(
7 �_;N -
�
7 �.   �  '	(	'(p'(_;$ '(F;	 
S'(q'(?��? 	 
S'(q'(?��_9>  SF;  -
 �. �
  6'(SH;n7  �'(_=  7  2_;E-F(7  �^`N
 . j  '(
/7!q(7! �(-0 >  6-7  �
 p.   j  '(7 K7!K(-7  20   }  6  ]_=  ];  '(? O -@#7  �
 �. j  '(7! �(
�7!�(
�7!q(
�G; -4  �  6-7  �
 p. j  ' (7 K 7!K(-
 � 0 }  6
� 7!�(- 0 �  6 7! �(7! K(7! (7 _; 7  7!(7 "_; 7  "7!"(7 -_; 7  -7!-(
<F> 
 PF;O 
 l7!�(
�7!�(
�7!�(
_7!�(
�7!�(
_7!q(_;  
 �7!�(  �_=   �7  �_; -   �7  �/6'A? ��  &  �_=  �;  -4 �  6-2   6-2 9  6 &
5W
 ,W-
J
 1
 %
 
 0    �  6+-  W. O  ; 8 -
0  F	  6! �(!W(-	   �>[
 y	4  g	  6?  ?��  8y��  �  Q���  �  �uR�  �  ��}��  [  ��Ԋ�  Q  ��j  � `}8T
   ��}�  � X��f  j �i���  � Q)�    y�*Z  L
 ���h�  g	 ����z  �  ��Ho>  �  U=�z�    4"���  9  o�I��   �  cޝ~$  %  � `Ϊ$  j  �>   �  �>   �  �>   �  �>   �  >   �  %>   �  Q>   �  [>   �  j>     �>  e  �  	  I  �  �    =  �  �  �  �>    �>  '  7  G  .>   n  �  �  �  T>   �  �>    �>  -     �  �>  <  �>  N  >  �  D>  �  M>  �  �  j>  �    �"  }>  �    C  �  �"  J#  �>  �  ,  �>  O  j>  f  J"  �"  >  v   >  �  8>   �  �  O>  �  e>      j>  2  s>   B  x>  Z  �>   t  �>     �>   �  �>  �  �>  �  �  	>   �  '	>   �  ;	>  �  F	>  �  �$  N	R �  _	>    *  g	>  U    �  �  %  
>    <
>  2  H  .
>  9  Q  �
>  p  �
>  �  �
>  �  L
>    ?    �  �    G  k  �
>  �  �  �  �  �  �  �  �  �  �  �        *  �!  y>  6  �>  D  f  �  �  �  S>      �>  [  �>   g     �>  n     �>  �  >  �  ->   �  �>  B   p   �   �>   z   �>   �   �>  @!  V!  �>  �!  >>   j"  �>   #  j>  *#  �>   ^#  �>   �$  >   �$  9>   �$  �>  �$  O>  �$        ��  �  ��  �  J�  �  �  , �    �  �  �$  5 �     �  �$  @ �  z  N  T  �	 $  r  �  V  J  �  b  �  *  � (  �0  ~  �  b  V  n  t  	 <  �  �  r  f  �  �  4  �$  � Z  �  �  �  x  � ^    � b   v  9 �  �   �  �  S �      f  �  .  y   �  |  �  ]   F  �  �  �  �  �  �  � &  �  �  D  �  � >  �  �  � B  �  �    � Z  � �    �  � �  :  �  �  �  �  �  E �  4  �  ; �  ! �  (  \  �  �  �  �    �  $  d  � 2  �  k 6  �  � N  �   �   �   �T  �  j  �  >  �$  Z  n  `  �  f  �  (l  x  �  &  J  6~  �  R  �  �  <�  �  �  �    B�  �    R  v  n�  H�  �  _�  �  f �  � 
  z  �   � *  �
8  �  �  �  �  �  >"  z"  �"  $#  � H  �  l  n  p  r  1t  7v  =x  %~  V�  ]  h  r  z  �  �  �  �  �  �  �   � &  � 0  � :  � D  � N  
 X   b  +�  2�  h  *"  �"  8�  l  �  A�  F�  j  �  �   K�  �"  �"  :#  @#  `�  �   ��  ��    @  R�  �  �  �  p �    ~"  (#  � �  ~  � 8  � >  � D  � L  �  � d  �"   r  0 �  I�      W �  � N  � T  �n  �p  � �  Z	 �  y	 R  %  �	 |  �	 �  �	 �  �	�  �	�  �	�  �    
  
  "
$  0  W
\  ^
^  �  �  `
`  �  b
b  h
d  o
f  �  �  u
h  �  {
j  �  �
l  �
 |  �
�  �
�  �
�  �
 �  �  �
 �   �  $ �  C �  [   � 4  � B  X  �\  |  �  �  �  � d  x  � �  �  � �  �   �  �  , �  v  K�  v#  |�  ��  �   ��  ��  ��  q    :!  P!  _     $  $$  �   � 2  V  �  "   4   P   b   �6  �  &   8   T   f   �<  ��   �   �  B 
   _,   >   q J   Z   l   ��   ��   �   _�   |�   ��   ��   ��   ��   ��   ��   ��   �   P�   |�    �   !  �   % �   -!  !  D!  W "!  c2!  >!  � T!  �|!  �!  $   $  <$  � �!  � �!  F#  �"  d"  X#   H"  / T"  qZ"  #  *$  ]�"  �"  ��"  � �"  ��"  �#  � �"  � #  � R#  �l#  �#  �#  �#  �#  "�#  �#  �#  -�#  �#  �#  < �#  P �#  l �#  � �#  $  6$  � $  �$  �$  �D$  P$  j$  �V$  p$  ��$  �$  J �$  1 �$  % �$   �$   �$  W�$   %  
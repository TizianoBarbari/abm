breed [attachers attacher]
breed [excavators excavator]

patches-own [
  wax?
  excised?
]

globals [
  closest-cluster ;; nearby cluster
  angle
]

to find-closest-cluster
  ;; find the patches with wax, within the excavator's sensing distance
  set closest-cluster other patches in-radius excavator-sensing-distance with [wax?]
end

to remove-shape

  ;; This defines the 'excavator shape':
  ;; the shape of the area (with wax) that the excavator bee is able to excise.

  ;; 360° -> circle; 180° -> semicircle
  if (excavation-shape = "circle" )     [ set angle 360 ]
  if (excavation-shape = "semicircle" ) [ set angle 180 ]
    ask patches in-cone excavation-radius angle
  [
    set wax? false    ;; remove wax
    set excised? true ;; make the excavated area unavailable to any bee
  ]

end


to setup-bees

  create-excavators num-bees * (1 - attacher-excavator-ratio) [
    set shape "bee"
    set color blue
    set size 1.5
    set closest-cluster no-patches
    setxy random-xcor random-ycor
  ]

  create-attachers num-bees * attacher-excavator-ratio [
    set shape "bee"
    set color red
    set size 2
    set closest-cluster no-patches
    setxy random-xcor random-ycor
  ]
end


to setup
  clear-all
  set-patch-size 5
  resize-world 0 160 0 75
  setup-bees
  ask patches [
    set wax? false
    set excised? false
  ]
  ask n-of initial-wax patches  [
    set wax? true      ;; randomly place some wax
  ]

  ;; visualisation
  ask patches [
    set pcolor white   ;; empty patches are white
  ]
  ask patches with [wax?] [
    set pcolor yellow  ;; patches with wax are yellow
  ]

  reset-ticks
end

to go
  ask attachers [

    ;; the attacher bee waits to be on the boundary of the wax cluster
    if ([wax?] of self) = false and (any? neighbors with [wax?])

    ;; black patches have been previously excised by excavators and are no more available to attachers
    and excised? = false

    [
      set wax? true      ;; attach wax
      set pcolor yellow  ;; colorize
    ]

    ;; keep flying nearby
    move-to one-of neighbors
  ]

  ask excavators
  [
    ;; find 'nearby' wax
    find-closest-cluster

    ;; 1) if the excavator bee is on the boundary of the cluster
    ifelse ([wax?] of self) = false and (any? neighbors with [wax?])

    ;; 2) if it faces a thick enough wall
    and ([wax?] of patch-ahead 1) = true and ([wax?] of patch-ahead 2) = true
    and ([wax?] of patch-ahead 3) = true and ([wax?] of patch-ahead 4) = true

    ;; 3) if the wall is indeed a wall, i.e. not simply a line of wax
    and count closest-cluster > wax-quantity-to-be-excavatable

    ;; 4) if there are *zero* unavailable (i.e. black) patches in-vision
    ;; (to prevent overlapping of black regions, which would prevent the tripods from appear)
    and (not (any? patches in-radius (excavation-radius + 1) with [excised? = true]))

    [
    ;; if all of that is true, excise wax!
    remove-shape

    ;; finally, fly away to some free cell and start again
    move-to one-of patches with [wax? = false and excised? = false]
    ]

    ;; if wax isn't found, keep moving forward
    [
      fd 1
    ]
  ]

  ifelse show-excised-areas
  [ask patches with [excised? = true] [set pcolor black]]
  [ask patches with [excised? = true] [set pcolor white]]

  tick
end

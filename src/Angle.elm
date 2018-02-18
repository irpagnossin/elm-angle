module Angle
    exposing
        ( Angle
        , AngleDomain
        , AngleUnit
        , angle
        , fold
        , (<+>)
        )


type
    AngleDomain
    {-
       Symmetric: [-pi, pi[
       Asymmetric: [0, 2pi[
    -}
    = Symmetric
    | Asymmetric


type AngleUnit
    = Radian
    | Degree


type Angle
    = Angle Float AngleUnit AngleDomain


fold : Angle -> Angle
fold angle =
    case angle of
        Angle value Radian Asymmetric ->
            Angle (fold_asymmetric_angle value) Radian Asymmetric

        Angle value Degree Asymmetric ->
            Angle (toDegree <| fold_asymmetric_angle (degrees value)) Degree Asymmetric

        Angle value Radian Symmetric ->
            Angle (fold_symmetric_angle value) Radian Symmetric

        Angle value Degree Symmetric ->
            Angle (toDegree <| fold_symmetric_angle (degrees value)) Degree Symmetric


toDegree radians =
    radians * 180.0 / pi


fold_symmetric_angle radians =
    radians - toFloat (floor ((radians + pi) / (2.0 * pi))) * (2.0 * pi)


fold_asymmetric_angle radians =
    radians - toFloat (floor (radians / (2 * pi))) * (2 * pi)


(<+>) : Angle -> Angle -> Result String Angle
(<+>) (Angle value1 unit1 domain1) (Angle value2 unit2 domain2) =
    if unit1 /= unit2 then
        Err "Angle units do not match!"
    else if domain1 /= domain2 then
        Err "Angle domains do not match!"
    else
        Ok <| fold <| Angle (value1 + value2) unit1 domain1


angle : Float -> Angle
angle radians =
    Angle radians Radian Symmetric

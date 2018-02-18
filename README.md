# Operations over angles

## Examples

Suppose you define:
```elm
a1 = Angle 170 Degree Asymmetric
a2 = Angle 190 Degree Asymmetric
```

Then, `a1 <+> a2` shall produce `Ok (Angle 0 Degree Asymmetric)` as 180 + 190 = 360, which is the same as 0 degrees in asymmetric domain (from 0 up to 359.999...). However, if you define
```elm
a1 = Angle 170 Degree Symmetric
a2 = Angle 20 Degree Symmetric
```

Then `a1 <+> a2` shall produce `Ok (Angle -170 Degree Symmetric)`, because now the domain is symmetric: from -180 degree to +179.999... degree.
# Satellite-motion

A look at satellite motion using classical finite difference numerical schemes

## The differential System

$$\begin{cases} \ddot{q}_1(t) =& Gm\dfrac{q_1(t)}{q_1^2(t) + q_2^2(t)}\\ 
\ddot{q}_2(t) =& Gm\dfrac{q_2(t)}{q_1^2(t) + q_2^2(t)}  \end{cases}$$

## The Explicit Euler Scheme

$$\begin{cases} q_{1,n+1} =& q_{1,n}+h \cdot \dot{q}_{1,n}
\\ 
q_{2,n+1} = & q_{2,n} + h\cdot\dot{q}_{2,n}
\end{cases}$$

## The Semi-Explicit Euler Scheme

$$\begin{cases}
q_{1,n+1}&=\dfrac{q_{1,n}}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}+\dfrac{\dot{q}_{1,n}\cdot h}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}
\\ 
q_{2,n+1}&=\dfrac{q_{2,n}}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}+\dfrac{\dot{q}_{2,n}\cdot h}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}
\\
\dot{q}_{1,n+1}&=\dfrac{-q_{1,n}\cdot \dfrac{h}{ (q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}+\dfrac{\dot{q}_{1,n}}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}
\\
\dot{q}_{2,n+1}&=\dfrac{-q_{2,n}\cdot \dfrac{h}{ (q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}+\dfrac{\dot{q}_{2,n}}{  1+\dfrac{h^2}{(q_{1,n}^2+q_{2,n}^2)^\frac{3}{2}}}
\end{cases}$$

## Difference of the future according to the chosen scheme's type 
![Capture d’écran (15)](https://user-images.githubusercontent.com/93977173/169676449-70d02845-d6df-467d-bd93-823828cb843e.png)

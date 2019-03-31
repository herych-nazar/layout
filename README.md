# Layout

Layout helper, for simplicity using of AutoLayout in code. Can be used for constraining sizes, vertical and horizontal anchors. Also may create constraint for applying to edges of target view.

## Examples:

Set sizes: 

        testView.layout {
            $0.size(.width(300), .height(100))
        }

Constraint testView to edges of view that you want:

        testView.layout {
            $0.constraint(to: view, by: .leading(40), .trailing(-40), .top(100), .bottom(-100))
        }
        
Set center of testView:
        
        testView.layout {
            $0.centerX.constraint(to: view, by: .centerX(0))
            $0.centerY.constraint(to: view, by: .centerY(100))
        }
        
Set manually constraints:

        firstView.layout {
            $0.leading.constraint(to: secondView, by: .trailing(10))
            $0.top.constraint(to: secondView, by: .bottom(20))
        }

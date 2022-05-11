//
//  BFS.swift
//  Trees
//
//  Created by Avinash Dongarwar on 4/7/22.
//

import Foundation
import CoreImage

class BFS {
	//	993. Cousins in Binary Tree
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let root = root else {
            return false
        }
        var px: Int?
        var py: Int?
        
        
        func bfs(_ root: TreeNode) -> Bool {
            var queue = [TreeNode]()
            queue.append(root)
            
            while !(queue.isEmpty) {
                let numNodes = queue.count
                // A level horizontal
                for _ in 0..<numNodes {
                    let node = queue.removeFirst() //pop
                    
                    if let left = node.left {
                        queue.append(left)
                        if left.val == x {
                            px = node.val
                        }
                        if left.val == y {
                            py = node.val
                        }
                    }
                    if let right = node.right {
                        queue.append(right)
                        if right.val == x {
                            px = node.val
                        }
                        if right.val == y {
                            py = node.val
                        }
                    }
                }
                
                if (px != nil && py == nil) || (px == nil && py != nil) {
                    return false
                }
                if (px != nil && py != nil) {
                    return px != py
                }
            }
            return false
        }
        
        return bfs(root)
    }
    
//	116. Populating Next Right Pointers in Each Node
    func connect(_ root: Node?) -> Node? {
        guard let root = root else {
            return nil
        }
        
        func bfs(_ root: Node) {
            var queue = [Node]()
            queue.append(root)
            
            while !(queue.isEmpty) {
                let numNodes = queue.count
                // A level horizontal
                var temp: Node?
                for i in 0..<numNodes {
                    let node = queue.removeFirst()
                    
                    if let temp = temp {
                        temp.next = node
                    }
                    temp = node
                    
                    if i == numNodes - 1 {
                        node.next = nil
                    }
                    
                    if let left = node.left {
                        queue.append(left)
                    }
                    if let right = node.right {
                        queue.append(right)
                    }
                }
            }
        }
        
        bfs(root)
        return root
    }
	
    //623. Add One Row to Tree
    func addOneRow(_ root: TreeNode?, _ val: Int, _ depth: Int) -> TreeNode? {
        guard let root = root else {
            return nil
        }
                
        func bfs(_ root: TreeNode) {
            var queue = [TreeNode]()
            queue.append(root)
            
            var currDepth = 0
            while !(queue.isEmpty) {
                currDepth += 1
                
                let num = queue.count
                
                for _ in 0..<num {
                    let node = queue.removeFirst() //pop
                    
                    if let left = node.left {
                        queue.append(left)
                    }
                    
                    if let right = node.right {
                        queue.append(right)
                    }
                    
                    if currDepth == depth - 1 {
                        let newLeft = TreeNode(val)
                        let newRight = TreeNode(val)
                        newLeft.left = node.left
                        newRight.right = node.right
                        node.left = newLeft
                        node.right = newRight
                    }
                }
            }
        }
        bfs(root)
        return root
    }
    
    func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        
        guard let root = root else {
            return 0
        }
        var global = 0
        func bfs(_ root: TreeNode) {
            var queue = [root]
            while !(queue.isEmpty) {
                let num = queue.count
                var localCount = num
                for _ in 0..<num {
                    let node = queue.removeFirst() //Pop
                    if let left = node.left {
                        queue.append(left)
                    }
                    if let right = node.right {
                        queue.append(right)
                    }
                }
                
                global = max(localCount, global)
            }
            
        }
        bfs(root)
        return global
    }
	
	// 226. Invert Binary Tree
	func invertTree(_ root: TreeNode?) -> TreeNode? {
		guard let root = root else {
			return nil
		}
		
		var queue = [root]
		
		while !queue.isEmpty {
			let numNodes = queue.count
			// Horizontal pass
			for _ in 0..<numNodes {
				let node = queue.removeFirst() //Pop
				let tempLeft = node.left
				node.left = node.right
				node.right = tempLeft
				if let left = node.left {
					queue.append(left)
					
				}
				if let right = node.right {
					queue.append(right)
				}
			}
		}
		
		return root
	}
	
	// 513. Find Bottom Left Tree Value
	func findBottomLeftValue(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 0
		}
		var subject = root
		
		func bfs(_ root: TreeNode) {
			var queue = [TreeNode]()
			queue.append(root)
			while !queue.isEmpty {
				let numNodes = queue.count
				// Horizontal Pass. Level Order
				let localSubject = queue.first
				for _ in 0..<numNodes {
					let node = queue.removeFirst()
					if let left = node.left {
						queue.append(left)
					}
					if let right = node.right {
						queue.append(right)
					}
				}
				if queue.isEmpty {
					subject = localSubject!
				}
			}
		}
		
		bfs(root)
		return subject.val
	}
	
		//156. Binary Tree Upside Down
	
	func upsideDownBinaryTree(_ root: TreeNode?) -> TreeNode?  {
		
		guard let root = root else {
			return nil
		}
		var new: TreeNode? = root

		func bfs(_ root: TreeNode) {
			
			var queue: [(TreeNode, TreeNode?, TreeNode?)] = [(root, nil, nil)]
			while !queue.isEmpty {
				
				var (node, parent, right) = queue.removeFirst()
				let oldL = node.left
				let oldR = node.right
				
				node.left = right
				node.right = parent
				
				if let left = oldL {
					queue.append((left, node, oldR))
				} else {
					new = node
				}
			}
		}
		bfs(root)
		return new
	}
	
	// 101. Symmetric Tree
	func isSymmetric(_ root: TreeNode?) -> Bool {
		guard let root = root else{
			return false
		}
		var global = true
		func bfs(_ root: TreeNode) {
			var queue = [(TreeNode, TreeNode?)]()
			queue.append((root, root))
			while !queue.isEmpty {
				let numNodes = queue.count
				
				for _ in 0..<numNodes {
					let (nodeL, nodeR) = queue.removeFirst()
					
					if let left = nodeL.left, let right = nodeR?.right  {
						queue.append((left, right))
					} else if nodeL.left != nil || nodeR?.right != nil {
						global = false
						return
					}
					
					
					if let right = nodeL.right, let left = nodeR?.left  {
						queue.append((right, left))
					} else if nodeL.right != nil || nodeR?.left != nil {
						global = false
						return
					}
					
					if nodeL.val != nodeR?.val {
						global = false
						return
					}
				}
			}
		}
		bfs(root)
		return global
	}
}
 
 public class Node {
     public var val: Int
     public var left: Node?
     public var right: Node?
     public var next: Node?
	 public var children: [Node]
     public init(_ val: Int) {
         self.val = val
         self.left = nil
         self.right = nil
         self.next = nil
		 self.children = [Node]()
     }
 }
 

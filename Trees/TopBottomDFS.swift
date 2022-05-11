//
//  TopBottomDFS.swift
//  Trees
//
//  Created by Avinash Dongarwar on 4/7/22.
//

import Foundation
import CoreImage

class TopBottomDFS {
    
    //257
    func all_paths_of_a_binary_tree(root: BinaryTreeNode?) -> [String] {
        // Write your code here.
        guard let root = root else {
            return []
        }
        
        var results = [String]()
        var slate = [Int]()
        
        func dfs(_ root: BinaryTreeNode) {
            slate.append(root.value)
            if root.left == nil && root.right == nil {
				results.append(slate.compactMap({ String($0) }).joined(separator: "->"))
            }
            // Recursion
            if let left = root.left {
                dfs(left)
            }
            if let right = root.right {
                dfs(right)
            }
            slate.removeLast()
        }
        dfs(root)
        return results
    }
	
//	Leetcode 112
	func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
		guard let root = root else {
			return false
		}
		
		var result = false
		func dfs(_ root: TreeNode, _ total: Int) {
			
			if root.left == nil && root.right == nil {
				if total == root.val {
					result = true
				}
				return
			}
			
			if let left = root.left {
				dfs(left, total - root.val)
			}
			if let right = root.right {
				dfs(right, total - root.val)
			}
		}
		dfs(root, targetSum)
		return result
	}
	
	//
	func pathSum2(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
		guard let root = root else {
			return []
		}
		var slate = [Int]()
		var results = [[Int]]()
		func dfs(_ root: TreeNode, _ total: Int) {
			slate.append(root.val)
			if root.left == nil && root.right == nil {
				if total == root.val {
					results.append(slate)
				}
			}
			
			if let left = root.left {
				dfs(left, total - root.val)
			}
			if let right = root.right {
				dfs(right, total - root.val)
			}
			slate.removeLast()
		}
		dfs(root, targetSum)
		return results
	}
	
	// 437. Path Sum III
	func pathSum3(_ root: TreeNode?, _ targetSum: Int) -> Int {
		
		guard let root = root else {
			return 0
		}

		var slate = [Int]()
		var globalBag = 0
		
		func dfs(_ root: TreeNode) {
			slate.append(root.val)
			
			var tempSum = 0
			for i in (0..<slate.count).reversed() {
				tempSum += slate[i]
				if tempSum == targetSum {
					globalBag += 1
					break
				}
			}
			
			if let left = root.left {
				dfs(left)
			}
			if let right = root.right {
				dfs(right)
			}
			slate.removeLast()
		}
		dfs(root)
		return globalBag
	}
	

    
	//298. Binary Tree Longest Consecutive Sequence
	func longestConsecutive(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 1
		}
		var globalBag = 0
		var slate = 1
		
		func dfs(_ root: TreeNode, _ parent: TreeNode?) {
			// Leaf Node
			
			if let parent = parent {
				slate = root.val - parent.val == 1 ? slate + 1 : 1
			} else {
				slate = 1
			}
			globalBag = max(globalBag, slate)
			if let left = root.left {
				dfs(left, root)
			}
			if let right = root.right {
				dfs(right, root)
			}
		}
		
		dfs(root, nil)
		return globalBag
	}
    
    // 226. Invert Binary Tree
	func invertTree(_ root: TreeNode?) -> TreeNode? {
		guard let root = root else {
			return nil
		}
			
		func dfs(_ root: TreeNode) {
			
			let temp = root.left
			root.left = root.right
			root.right = temp
			
			if let left = root.left {
				dfs(left)
			}
			if let right = root.right {
				dfs(right)
			}
		}
		dfs(root)
		return root
			
	}
	
//	559. Maximum Depth of N-ary Tree
	func maxDepth(_ root: Node?) -> Int {
		guard let root = root else {
			return 0
		}
		var slate = 0
		var global = 0
		
		func dfs(_ root: Node) {
			slate += 1
			if root.children.isEmpty {
				global = max(global, slate)
			}
			
			for child in root.children {
				dfs(child)
			}

			slate -= 1
		}

		dfs(root)
		return global
	}

    
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        
        guard let root = root else {
            return false
        }
        var px: Int?
        var py: Int?
        var dx: Int?
        var dy: Int?

        func dfs(_ child: TreeNode?, parent: TreeNode?, depth: Int) {
            
            guard let child = child else {
                return
            }
            
            if child.val == x {
                px = parent?.val
                dx = depth
            }
            
            if child.val == y {
                py = parent?.val
                dy = depth
            }
            if let left = child.left {
                dfs(left, parent: child, depth: depth + 1)
            }
            if let right = child.right {
                dfs(right, parent: child, depth: depth + 1)
            }
        }
        
        dfs(root, parent: nil, depth: 0)
        
        return dy == dx && px != py
    }
	
	// 513. Find Bottom Left Tree Value
	func findBottomLeftValue(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return -1
		}
		var leftValues = [Int]()

		func dfs(_ root: TreeNode, _ depth: Int) {
			let myDepth = depth + 1
			if myDepth > leftValues.count {
				leftValues.append(root.val)
			}
			if let left = root.left {
				dfs(left, myDepth)
			}
			if let right = root.right {
				dfs(right, myDepth)
			}
		}
		dfs(root, 0)
		return leftValues.last ?? Int.min
	}
	
	//156. Binary Tree Upside Down
	func upsideDownBinaryTree1(_ root: TreeNode?) -> TreeNode?  {
		guard let root = root else {
			return nil
		}
		var newNode = root
		
		func dfs(_ root: TreeNode, parent: TreeNode?, right: TreeNode?) {
			
			let oldLeft = root.left
			let oldRight = root.right
			
			root.left = right
			root.right = parent
			
			if let left = oldLeft {
				dfs(left, parent: root, right: oldRight)
			} else {
				newNode = root
			}
		}
		
		dfs(root, parent: nil, right: nil)
		return newNode
	}
	
	func upsideDownBinaryTree(_ root: TreeNode?) -> TreeNode?  {
		
		guard let root = root else {
			return nil
		}
		var newNode: TreeNode?
		func dfs(_ root: TreeNode, _ parent: TreeNode?, _ right: TreeNode?) {
			
			let oldL = root.left
			let oldR = root.right
			
			root.left = right
			root.right = parent
			
			if oldL == nil && oldR == nil {
				newNode = root
				return
			}
			
			if let left = oldL {
				dfs(left, root, oldR)
			}
		}
		
		dfs(root, nil, nil)
		return newNode
	}
	
	// 545. Boundary of Binary Tree
	func boundaryOfBinaryTree(_ root: TreeNode?) -> [Int] {
		guard let root = root else {
			return []
		}
		if root.left == nil && root.right == nil {
			return [root.val]
		}
		var leftresults = [Int]()
		leftresults.append(root.val)
		
		var curr: TreeNode?
		// Enter Left
		if let left = root.left {
			curr = left
			while curr != nil {
				leftresults.append(curr!.val)
				if let left = curr?.left {
					curr = left
				} else if let right = curr?.right {
					curr = right
				} else {
					curr = nil
					leftresults.removeLast()
				}
			}
		}
		
		// Enter Right
		var rightResults = [Int]()
		if let right = root.right {
			curr = right
			while curr != nil {
				rightResults.append(curr!.val)
				if let right = curr?.right {
					curr = right
				} else if let left = curr?.left {
					curr = left
				}  else {
					curr = nil
					rightResults.removeLast()
				}
			}
		}
		
		var leaves = [Int]()
		
		func dfs(_ root: TreeNode) {
			if root.left == nil && root.right == nil {
				leaves.append(root.val)
				return
			}
			
			if let left = root.left {
				dfs(left)
			}
			
			if let right = root.right {
				dfs(right)
			}
		}
		
		dfs(root)
		
		return leftresults + leaves + rightResults.reversed()
	}
	
	
	// 314. Binary Tree Vertical Order Traversal
	//	104. Maximum Depth of Binary Tree
}


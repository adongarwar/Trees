//
//  BottomUpDFS.swift
//  Trees
//
//  Created by Avinash Dongarwar on 4/14/22.
//

import Foundation

class BottomUpDFS {
	
//	543. Diameter of Binary Tree
	func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 0
		}
		var diameter = 0
		
		func dfs(_ root: TreeNode) -> Int {
			
			if root.left == nil && root.right == nil {
				return 0
			}
			
			var height = 0
			var diam = 0
			// Recursive case
			if let left = root.left {
				let leftHeight = 1 + dfs(left)
				height = max(height, leftHeight)
				diam += leftHeight
			}
			if let right = root.right {
				let rightHeight = 1 + dfs(right)
				height = max(height, rightHeight)
				diam += rightHeight
			}
			diameter = max(diam, diameter)
			return height
		}
		_ = dfs(root)
		return diameter
	}
	
	// 250. Count Univalue Subtrees
	func isUnival(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 1
		}
		var global = 0
		func dfs(_ root: TreeNode) -> Bool  {
			// Leaf Node
			if root.left == nil && root.right == nil {
				global = global + 1
				return true
			}
			
			var localIsUnival = true
			if let left = root.left {
				if root.val != left.val || dfs(left) == false {
					localIsUnival = false
				}
			}
			if let right = root.right {
				if root.val != right.val || dfs(right) == false {
					localIsUnival = false
				}
			}
			
			if localIsUnival == true {
				global = global + 1
			}
			return localIsUnival
		}
		_ = dfs(root)
		return global
	}
	
		//	236. Lowest Common Ancestor of a Binary Tree
	func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
		guard let root = root, let p = p, let q = q else {
			return nil
		}
		
		var LCA: TreeNode?
		
		func dfs(_ root: TreeNode) -> (Bool, Bool) {
			var pFound = false
			var qFound = false
			
			if root.val == p.val {
				pFound = true
			}
			if root.val == q.val {
				qFound = true
			}
			
			if let left = root.left {
				let (tempP, tempQ) = dfs(left)
				pFound = pFound || tempP
				qFound = qFound || tempQ
			}
			if let right = root.right {
				let (tempP, tempQ) = dfs(right)
				pFound = pFound || tempP
				qFound = qFound || tempQ
			}
			
			if pFound == true && qFound == true && LCA == nil  {
				LCA = root
			}
			
			return (pFound, qFound)
		}
		_ = dfs(root)
		return LCA
	}
	
//	687. Longest Univalue Path
	func longestUnivaluePath(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 1
		}

		var global = 0
		func dfs(_ root: TreeNode) -> Int {
			
			var local = 0
			var height = 0
			if let left = root.left {
				var leftHeight = dfs(left)
				if left.val == root.val {
					leftHeight = 1 + leftHeight
					height = leftHeight
					
					local += leftHeight
				}
			}
			
			if let right = root.right {
				var rightHeight = dfs(right)
				if right.val == root.val {
					rightHeight = 1 + rightHeight
					height = max(height, rightHeight)
					local += rightHeight
				}

				
			}
			
			global = max(global, local)
			return height
		}
		_ = dfs(root)
		return global
	}

	// 110. Balanced Binary Tree
	func isBalanced(_ root: TreeNode?) -> Bool {
		guard let root = root else {
			return true
		}
		var global = true
		
		func dfs(_ root: TreeNode) -> Int {
			
			
			var leftHeight = 0
			var rightHeight = 0
			var amIBal = true
			if let left = root.left {
				leftHeight = 1 + dfs(left)
				if leftHeight > 1 {
					amIBal = false
				}
			}
			
			if let right = root.right {
				rightHeight = 1 + dfs(right)
				
				if abs(leftHeight - rightHeight) > 1 {
					amIBal = false
				} else {
					amIBal = true
				}
			}
			global = global && amIBal
			return max(leftHeight, rightHeight)
		}
		
		_ = dfs(root)
		return global
	}
	
	// 98. Validate Binary Search Tree
	func isValidBST(_ root: TreeNode?) -> Bool {
		guard let root = root else {
			return true
		}

		var global = true
		
		func dfs(_ root: TreeNode) -> (Bool, TreeNode, TreeNode) {
			
			var small = root
			var large = root
			var isBSTLocal = true
			if let left = root.left {
				let (isBST, smallest, largest) = dfs(left)
				
				if large.val < largest.val {
					large = largest
				}

				if small.val > smallest.val {
					small = smallest
				}
				
				if isBST == false || root.val <= largest.val {
					isBSTLocal = false
				}
			}
			
			if let right = root.right {
				let (isBST, smallest, largest) = dfs(right)
				
				if large.val < largest.val {
					large = largest
				}
				
				if small.val > smallest.val {
					small = smallest
				}
				
				if isBST == false || root.val >= smallest.val {
					isBSTLocal = false
				}
			}
			
			global = global && isBSTLocal
			return (isBSTLocal, small, large)
		}
		_ = dfs(root)
		return global
	}
	
	//	333. Largest BST Subtree
	func largestBSTSubtree(_ root: TreeNode?) -> Int {
		
		guard let root = root else {
			return 0
		}
		
		var global = 0
		
		func dfs(_ root: TreeNode) -> (Int, Bool, TreeNode, TreeNode) {
			
			var small = root
			var large = root
			var amIBST = true
			
			var localSize = 1
			
			if let left = root.left {
				let (size, isBST, smallest, largest) = dfs(left)
				localSize += size
				if large.val < largest.val {
					large = largest
				}
				if small.val > smallest.val {
					small = smallest
				}
				if isBST == false || root.val <= largest.val {
					amIBST = false
				}
			}
			
			if let right = root.right {
				let (size, isBST, smallest, largest) = dfs(right)
				localSize += size

				if large.val < largest.val {
					large = largest
				}
				if small.val > smallest.val {
					small = smallest
				}
				if isBST == false || root.val >= smallest.val {
					amIBST = false
				}
			}
			
			if amIBST {
				global = max(global, localSize)
			}
			return (localSize, amIBST, small, large)
		}
		
		_ = dfs(root)
		return global
	}
	
	//124. Binary Tree Maximum Path Sum
	//563. Binary Tree Tilt
//	958. Check Completeness of a Binary Tree
	
	
}

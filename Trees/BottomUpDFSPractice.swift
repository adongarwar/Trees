//
//  BottomUpDFSPractice.swift
//  Trees
//
//  Created by Avinash Dongarwar on 5/1/22.
//

import Foundation

class BottomUpDFSPractice {
	
	func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
		
		guard let root = root else {
			return 0
		}
		var global = 0
		
		func dfs(_ root: TreeNode)  -> Int {
			if root.left == nil && root.right == nil {
				return 0
			}
			
			var height = 0
			var diameter = 0
			if let left = root.left {
				let temp = dfs(left) + 1
				height = max(height, temp)
				diameter += height
			}
			if let right = root.right {
				let temp = dfs(right) + 1
				height = max(height, temp)
				diameter += height
			}
			
			global = max(diameter, global)
			return height
		}
		_ = dfs(root)
		return global
	}
	
	// 250. Count Univalue Subtrees
	func countUnivalSubtrees(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 0
		}
		var global = 0
		func dfs(_ node: TreeNode) -> Bool {
			if node.left == nil && node.right == nil {
				global += 1
				return true
			}
			
			var amIIunival = true
			if let left = node.left {
				amIIunival = left.val == node.val && amIIunival && dfs(left)
//				if left.val != root.val || dfs(left) == false {
//					amIIunival = false
//				}
			}
			
			if let right = node.right {
				amIIunival = right.val == node.val && amIIunival && dfs(right)
//				if right.val != root.val || dfs(right) == false {
//					amIIunival = false
//				}
			}
			
			if amIIunival == true {
				global += 1
			}
			return amIIunival
		}
		_ = dfs(root)
		return global
	}
	
	func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
		guard let root = root, let p = p, let q = q else {
			return nil
		}
		
		var LCA: TreeNode?
		
		func dfs(_ root: TreeNode) -> (Bool, Bool) {
			
			var pFound = root.val == p.val
			var qFound = root.val == q.val
			
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
			return 0
		}
		var global = 0
		
		func dfs(_ node: TreeNode) -> Int {
			guard node.left == nil && node.right == nil else {
				return 1
			}
			
			var height = 0
			var length = 0
			if let left = node.left {
				var leftHeight = dfs(left)
				if node.val == left.val {
					leftHeight +=  1
				}
				length += leftHeight
				height = max(leftHeight, height)
			}
			
			if let right = node.right {
				var rightHeight = dfs(right)
				if node.val == right.val {
					rightHeight +=  1
				}
				length += rightHeight
				height = max(rightHeight, height)
			}
			global = max(global, length)
			return height
		}
		_ = dfs(root)
		return global
	}
	
		// 110. Balanced Binary Tree
	func isBalanced(_ root: TreeNode?) -> Bool {
		
		guard let root = root else {
			return false
		}
		var global = true
		
		func dfs(_ node: TreeNode) -> Int {
			
			var leftHeight = 0
			var rightHeight = 0
			if let left = node.left {
				leftHeight = 1 + dfs(left)
			}
			if let right = node.right {
				rightHeight = 1 + dfs(right)
			}
			
			if abs(leftHeight - rightHeight) > 1 {
				global = global && false
			}
			
			return max(leftHeight, rightHeight)
		}
		return true
	}
		
		func isValidBST(_ root: TreeNode?) -> Bool {
			guard let root = root else {
				return false
			}
			
			var global = true
			
			func dfs(_ node: TreeNode) -> (Bool, Int, Int) {
				
				// Leaf node
				var large = node.val
				var small = node.val
				var amIBST = true
				if let left = node.left {
					let (isBst, largest, smallest) = dfs(left)
					large = max(large, largest)
					small = min(small, smallest)
					if node.val <= largest || isBst == false {
						amIBST = false
					}
				}
				
				if let right = node.right {
					let (isBst, largest, smallest) = dfs(right)
					large = max(large, largest)
					small = min(small, smallest)
					if node.val >= smallest || isBst == false {
						amIBST = false
					}
				}
		
				global = global && amIBST
				return ( amIBST, large, small)
			}
			_ = dfs(root)
			return global
		}
		
		func largestBSTSubtree(_ root: TreeNode?) -> Int {
			guard let root = root else {
				return 0
			}
			
			var global = 0
			
			func dfs(_ node: TreeNode) -> (Int, Bool, Int, Int) {
				
				var large = node.val
				var small = node.val
				var amIBST = true
				var mySize = 1
				if let left = node.left {
					let (size, isBST, largest, smallest) = dfs(left)
					mySize += size
					large = max(large, largest)
					small = min(small, smallest)
					
					if node.val <= largest || !isBST {
						amIBST = false
					}
				}
				
				if let right = node.right {
					let (size, isBST, largest, smallest) = dfs(right)
					mySize += size
					large = max(large, largest)
					small = min(small, smallest)
					if node.val >= smallest || !isBST {
						amIBST = false
					}
				}
				
				if amIBST {
					global = max(global, mySize)
				}
				return (mySize, amIBST, large, small)
			}
			
			_ = dfs(root)
			return global
		}
}




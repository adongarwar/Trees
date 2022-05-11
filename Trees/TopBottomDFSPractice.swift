//
//  TopBottomDFSPractice.swift
//  Trees
//
//  Created by Avinash Dongarwar on 4/30/22.
//

import Foundation

class TopBottomDFSPractice {
	
	//257. Binary Tree Paths
	func binaryTreePaths(_ root: TreeNode?) -> [String] {
		guard let root = root else {
			return []
		}
		var slate = [Int]()
		var results = [String]()
		
		func dfs(_ root: TreeNode) {
			slate.append(root.val)
			
			if root.left == nil && root.right == nil {
				let slateArr = slate.map({"\($0)"}) .joined(separator: "->")
				results.append(slateArr)
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
		return results
	}
	
//	112. Path Sum
	func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
		guard let root = root else {
			return false
		}
		var slate = [Int]()
		var result = false
		
		func dfs(_ root: TreeNode, _ total: Int) {
			
			slate.append(root.val)
			if root.left == nil && root.right == nil {
				if total == root.val {
					result = true
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
		return result
	}
	
//	113. Path Sum II
	func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
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
	func pathSum(_ root: TreeNode?, _ targetSum: Int) -> Int {
		guard let root = root else {
			return 0
		}
		var slate = [Int]()
		var result = 0
		
		func dfs(_ root: TreeNode) {
			slate.append(root.val)
			
			var tempSum = 0
			for i in (0..<slate.count).reversed() {
				tempSum += slate[i]
				if tempSum == targetSum {
					result += 1
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
		return result
	}
	
	// 298. Binary Tree Longest Consecutive Sequence
	func longestConsecutive(_ root: TreeNode?) -> Int {
		
		guard let root = root else {
			return 0
		}
		var global = 0
		var slate = 1
		
		func dfs(_ node: TreeNode, _ parent: TreeNode?, _ slate: inout Int) {
			

			if let parent = parent {
				slate = node.val - parent.val == 1 ? slate + 1 : 1
			} else {
				slate = 1
			}
			
			global = max(global, slate)
			
			if node.left == nil && node.right == nil {
				return
			}
			
			
			if let left = node.left {
				dfs(left, node, &slate)
			}
			
			if let right = node.right {
				dfs(right, node, &slate)
			}
		}
		dfs(root, nil, &slate)
		return global
	}
	
		// 226. Invert Binary Tree
	func invertTree(_ root: TreeNode?) -> TreeNode? {
		
		guard let root = root else {
			return  nil
		}
		
		func dfs(_ root: TreeNode) {
			
			let old = root.left
			root.left = root.right
			root.right = old
			
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
	
//	993. Cousins in Binary Tree
	func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
		
		guard let root = root else {
			return false
		}
		var px: TreeNode?
		var py: TreeNode?
		var depthX = 0
		var depthY = 0
		var global = false
		func dfs(_ node: TreeNode, _ parent: TreeNode?, _ depth: Int) {
			if node.val == x {
				px = parent
				depthX = depth
			}

			if node.val == y {
				py = parent
				depthY = depth
			}
			
			if let px = px, let py = py {
				global = px.val != py.val && depthX == depthY
				return
			}
			
			if let left = node.left {
				dfs(left, node, depth + 1)
			}
			if let right = node.right {
				dfs(right, node, depth + 1)
			}
		}
		dfs(root, nil, 0)
		return global
	}
	
	// 513. Find Bottom Left Tree Value
	func findBottomLeftValue(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 0
		}

		var result = 0
		var globalDepth = 0
		
		func dfs(_ node: TreeNode, _ depth: Int) {
			let tempDepth = depth + 1
			if node.left == nil && node.right == nil {
				if tempDepth > globalDepth {
					globalDepth = tempDepth
					result = node.val
				}
			}
			
			if let left = node.left {
				dfs(left, tempDepth)
			}
			if let right = node.right {
				dfs(right, tempDepth)
			}
		}
		dfs(root, 0)
		return result
	}
	
	func upsideDownBinaryTree(_ root: TreeNode?) -> TreeNode?  {
		guard let root = root else {
			return nil
		}
		var global: TreeNode?
		
		func dfs(_ root: TreeNode, _ parent: TreeNode?, _ right: TreeNode?) {
			
			let oldL = root.left
			let oldR = root.right
			
			root.left = right
			root.right = parent

			if let oldL = oldL {
				dfs(oldL, root, oldR)
			} else {
				global = root
			}
		}

		dfs(root, nil, nil)
		return global
	}
	
	func boundaryOfBinaryTree(_ root: TreeNode?) -> [Int] {
		guard let root = root else {
			return []
		}
		
		if root.left == nil && root.right == nil {
			return [root.val]
		}
		
		var global = [Int]()
		
		var curr: TreeNode?
		var lefts = [Int]()
		lefts.append(root.val)
		
		if let left = root.left {
			curr = left
			while curr != nil {
				lefts.append(curr!.val)
				if let tempL = curr?.left {
					curr = tempL
				} else if let tempR = curr?.right {
					curr = tempR
				} else {
					curr = nil
					lefts.removeLast()
				}
			}
		}
		
		var rights = [Int]()
		if let right = root.right {
			curr = right
			while curr != nil {
				rights.append(curr!.val)
				if let tempR = curr?.right {
					curr = tempR
				} else if let tempL = curr?.left {
					curr = tempL
				} else {
					curr = nil
					rights.removeLast()
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
		
		global =  lefts + leaves + rights.reversed()
		
		return global
	}
}


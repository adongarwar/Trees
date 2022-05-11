//
//  NeetCode.swift
//  Trees
//
//  Created by Avinash Dongarwar on 5/7/22.
//

import Foundation

class NeetCode {
	
	func isBalanced(_ root: TreeNode?) -> Bool {
		
		guard let root = root else {
			return false
		}
		
		var global = true

		func dfs(_ node: TreeNode) -> Int {
			// Leaf nodes - Pass
			var height = 0
			var leftHeight = 0
			var rightHeight = 0
			
			if let left = node.left {
				leftHeight = 1 + dfs(left)
				height = max(height, leftHeight)
			}

			if let right = node.right {
				rightHeight = 1 + dfs(right)
				height = max(height, rightHeight)
			}
			
			if abs(rightHeight - leftHeight) > 1 {
				global = false
			}
			return height
		}
		
		_ = dfs(root)
		return global
	}
	
	func goodNodes(_ root: TreeNode?) -> Int {
		
		guard let root = root else {
			return 0
		}
		
		var slate = [Int]()
		var global = 0
		
		func dfs(_ root: TreeNode) {

			slate.append(root.val)
			
			var iAmGoodNode = true
			for i in 0..<slate.count {
				if i == slate.count - 1 {
					continue
				}
				if slate[i] > root.val {
					iAmGoodNode =  false
					break
				}
			}
			if iAmGoodNode {
				global += 1
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
		return global
	}
	
	func invertTree1(_ root: TreeNode?) -> TreeNode? {
		
		guard let root = root else {
			return nil
		}
		
		func bfs(_ root: TreeNode) {
			var queue = [TreeNode]()
			queue.append(root)
			
			while !(queue.isEmpty) {
				let numNodes = queue.count
				
				for _ in 0..<numNodes {
					let node = queue.removeFirst() //Pop
					let temp = node.left
					node.left = node.right
					node.right = temp
					
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
	
	func invertTree(_ root: TreeNode?) -> TreeNode? {
		guard let root = root else {
			return nil
		}
		
		func dfs(_ node: TreeNode) {
			
			let temp = node.left
			node.left = node.right
			node.right = temp
			
			if let left = node.left {
				dfs(left)
			}
			if let right = node.right {
				dfs(right)
			}
		}
		
		dfs(root)
		return root
	}
	
	func isValidBST(_ root: TreeNode?) -> Bool {
		guard let root = root else {
			return false
		}
		
		var global = true
		
		func dfs(_ root: TreeNode) -> (Bool, Int, Int) {
			
			var amIBST = true
			var smallest = root.val
			var largest = root.val
			
			if let left = root.left {
				let (isBST, small, large) = dfs(left)
				if isBST == false || large >= root.val {
					amIBST = false
				}
				smallest = min(smallest, small)
				largest = max(largest, large)
			}

			if let right = root.right {
				let (isBST, small, large) = dfs(right)
				if isBST == false || small <= root.val {
					amIBST = false
				}
				smallest = min(smallest, small)
				largest = max(largest, large)
			}
			if amIBST == false {
				global = false
			}
			return (amIBST, smallest, largest)
		}
		_ = dfs(root)
		return global
	}
	
	func sumNumbers(_ root: TreeNode?) -> Int {
		guard let root = root else {
			return 0
		}
		
		var slate = [Int]()
		var result = 0
		
		
		func dfs(_ root: TreeNode) {
			slate.append(root.val)
			
			if root.left == nil && root.right == nil {
				result +=  Int(slate.compactMap({String($0)}).joined()) ?? 0
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
	
	func rightSideView1(_ root: TreeNode?) -> [Int] {
		
		guard let root = root else {
			return []
		}
		var results = [Int]()
		func bfs(_ root: TreeNode) {
			
			var queue = [TreeNode]()
			queue.append(root)
			
			while !queue.isEmpty {
				let numNodes = queue.count
				results.append(queue.last!.val)
				for _ in 0..<numNodes {
					let node = queue.removeFirst()
					
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
		return results
	}
	
	func rightSideView(_ root: TreeNode?) -> [Int] {
		guard let root = root else {
			return []
		}
		
		var results = [Int]()
		var slate = [Int]()
		
		func dfs(_ root: TreeNode) {
			slate.append(root.val)
			if root.left == nil && root.right == nil {
				results = slate
			}
				// Recursion
			
			if let right = root.right {
				dfs(right)
			} else if let left = root.left {
				dfs(left)
			}
			slate.removeLast()
		}
		dfs(root)
		return results
	}
	
	// 951. Flip Equivalent Binary Trees
	func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
		guard let root1 = root1, let root2 = root2, root1.val == root2.val else {
			return root1?.val == root2?.val
		}

		var queue: [(TreeNode?, TreeNode?)] = [(root1, root2)]
		
		while !queue.isEmpty {
			
			let numNodes = queue.count
			
			for _ in 0..<numNodes {
				let (node1, node2) = queue.removeFirst()
				
				if node1 == nil && node2 == nil {
					continue
				} else if node1?.left?.val == node2?.left?.val && node1?.right?.val == node2?.right?.val {
					queue.append((node1?.left, node2?.left))
					queue.append((node1?.right, node2?.right))
				} else if node1?.left?.val == node2?.right?.val && node1?.right?.val == node2?.left?.val {
					queue.append((node1?.left, node2?.right))
					queue.append((node1?.right, node2?.left))
				} else  {
					return false
				}
			}
		}
		return true
	}
	
	// 894. All Possible Full Binary Trees
	func allPossibleFBT(_ n: Int) -> [TreeNode?] {
		
		var dp = [Int: [TreeNode]]()
		dp[0] = [TreeNode]()
		dp[1] = [TreeNode(0)]
		
		func dfs(_ n: Int) -> [TreeNode] {
			if let res = dp[n] {
				return res
			}
			var results = [TreeNode]()
			for l in 0..<n {
				let r = n - 1 - l
				let leftTress = dfs(l)
				let rightTress = dfs(r)
				
				for t1 in leftTress {
					for t2 in rightTress {
						results.append(TreeNode(0, t1, t2))
					}
				}
			}
			dp[n] = results
			return results
		}
		return dfs(n)
	}
	
//	572. Subtree of Another Tree
	func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
		
		// Same tree
		var global =  false
		func dfs(_ root: TreeNode?, _ subRoot: TreeNode?) {
			guard let root = root, let subRoot = subRoot else {
				global = root?.val == subRoot?.val
				return
			}
			global = root.val == subRoot.val
			dfs(root.left, subRoot.left)
			dfs(root.right, subRoot.right)
		}
		dfs(root, subRoot)
		return global
	}
	
	func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
		guard let p = p, let q = q else {
			return p?.val == q?.val
		}
		var global = true
		func dfs(_ p: TreeNode?, _ q: TreeNode?) {
			if (p != nil && q == nil) || (p == nil && q != nil) {
				global = false
			}
			if  let p = p, let q = q, p.val != q.val {
				global = false
			}

			dfs(p?.left, q?.left)
			dfs(p?.right, q?.right)
		}
		dfs(p, q)
		return global
	}
	
	
		// 114. Flatten Binary Tree to Linked List
	
	
}


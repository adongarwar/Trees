//
//  ConstructTrees.swift
//  Trees
//
//  Created by Avinash Dongarwar on 5/7/22.
//

import Foundation
class ConstructTrees {
	func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
		
		if root1 == nil, root2 == nil {
			return nil
		}
	
		var root = TreeNode((root1?.val ?? 0) + (root2?.val ?? 0))
		root.left = mergeTrees( root1?.left ?? nil , root2?.left ?? nil)
		root.right = mergeTrees( root1?.right ?? nil , root2?.right ?? nil)
		return root
	}
	
	func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
		
		func helper(start: Int, end: Int) -> TreeNode? {

			if start > end {
				return nil
			}
			if start == end {
				return TreeNode(nums[start])
			}
			
			// Recursion
			let mid = start + (end - start)/2
			let root = TreeNode(nums[mid])
			root.left = helper(start: start, end: mid - 1)
			root.right = helper(start: mid + 1, end: end)
			return root
		}
		
		return helper(start: 0, end: nums.count - 1)
	}
	
	func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
	
		func helper(pStart: Int, pEnd: Int, iStart:Int, iEnd: Int) -> TreeNode? {
			if pStart > pEnd {
				return nil
			}
			if pStart == pEnd {
				return TreeNode(inorder[pStart])
			}
			
			let rootIndex = inorder.firstIndex(of: preorder[pStart])
			let numLeft = rootIndex! - iStart
			let numRight = iEnd - rootIndex!
			
			let root = TreeNode(inorder[rootIndex!])
			root.left = helper(pStart: pStart + 1, pEnd: pStart + numLeft,
							   iStart: iStart, iEnd: rootIndex! - 1)
			
			root.right = helper(pStart: pStart + numLeft + 1,
								pEnd: pStart + numLeft + numRight,
							   iStart: rootIndex! + 1,
								iEnd: rootIndex! + numRight)
			return root
		}
		
		return helper(pStart: 0, pEnd: preorder.count - 1, iStart: 0, iEnd: inorder.count - 1)
	}
}

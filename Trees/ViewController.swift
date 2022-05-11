//
//  ViewController.swift
//  Trees
//
//  Created by Avinash Dongarwar on 4/4/22.
//

import UIKit

class ViewController: UIViewController {
	
	let str: [Any]  = ["1", 1]

    override func viewDidLoad() {
        super.viewDidLoad()
		let first = [1, 2]
		let second = [1, 3]
		var results = 0
		
		for i in [first, second] {
			results += Int( i.compactMap({String($0)}).joined()) ?? 0
		}
		
		
        // Do any additional setup after loading the view.
        let prob = [1,2,3,4,5]
        let tree = [TreeNode]()
    }
}


class Solution {
	func allPathsOfABinaryTree(root: TreeNode?) -> [String] {
		guard let root = root else {
			return []
		}
		var results = [String]()
		var slate = [Int]()
		
		func dfs(root: TreeNode) {
			// Leaf Node
			if root.left == nil && root.right == nil {
				slate.append(root.val)
				results.append(slate.compactMap({ String($0) }).joined(separator: "->"))
				slate.removeLast()
				return
			}
			
			slate.append(root.val)
			if let left = root.left {
				dfs(root: left)
			}
			if let right = root.right {
				dfs(root: right)
			}
			slate.removeLast()
		}
		dfs(root: root)
		return results
	}
    
    // 543 - Diameter of Binary tree
    func diameterOfBinaryTree(root: TreeNode?) -> Int {
        
        guard let node = root else {
            return 0
        }
        
        var global = 0
        
        func helper(_ root: TreeNode) -> Int {
            // Leaf node
            if root.left == nil && root.right == nil {
                return 0
            }
            
            var lhs = 0
            var rhs = 0
            var myDia = 0

            if let left = root.left {
                lhs = helper(left)
                myDia += lhs + 1
            }
            
            if let right = root.right {
                rhs = helper(right)
                myDia += rhs + 1
            }
            global = max(global, myDia)
            
            return max(lhs, rhs) + 1
        }
        
        _ = helper(node)
        return global
    }
  
    // 250. Count Univalue Subtrees
    
    func find_single_value_trees(root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }
        
        var global = 0
        
        func helper(_ root: TreeNode) -> Bool {
            //Leaf Node
            if root.left == nil && root.right == nil {
                global += 1
                return true
            }
            
            //Recursion
            var amIUnival = true
            if let left = root.left {
                if helper(left) == false || root.val != left.val {
                    amIUnival = false
                }
            }
            
            if let right = root.right {
                if helper(right) == false || root.val != right.val {
                    amIUnival = false
                }
            }
            
            if amIUnival {
                global += 1
            }
            return amIUnival
        }
        _ = helper(node)
        return global
    }
    
	func isValidBST(_ root: TreeNode?) -> Bool {
        guard let node = root else {
            return true
        }
        
        func helper(_ root: TreeNode) -> Bool {
            
            var queue = [TreeNode]()
            queue.append(root)
            
            while !queue.isEmpty {

                for _ in 0 ..< queue.count {
                    let node = queue.removeFirst()
                    if let left = node.left {
                        if left.val > node.val {
                            return false
                        }
                        queue.append(left)
                    }
                    if let right = node.right {
                        if right.val < node.val {
                            return false
                        }
                        queue.append(right)
                    }
                }
            }
            return true
        }
        
        return helper(node)
    }
    
    //649 · Binary Tree Upside Down
    func flip_upside_down(root: BinaryTreeNode?) -> BinaryTreeNode? {
        guard let node = root else {
            return root
        }
        var newNode: BinaryTreeNode?
        
        func helper(_ root: BinaryTreeNode, _ prev: BinaryTreeNode?) {
            
            if root.left == nil && root.right == nil {
                newNode = root
            }
            if let left = root.left {
                helper(left, nil)
                left.left = node.right
                left.right = node
                node.left = nil
                node.right = nil
            }
        }
        
        helper(node, nil)
        return newNode
    }
    
    
    func flip_upside_down1(root: BinaryTreeNode?) -> BinaryTreeNode? {
        guard let node = root else {
            return root
        }
        var newNode = BinaryTreeNode(value: node.value) //BinaryTreeNode(value: 0)
        
        func helper(_ root: BinaryTreeNode) {
            if root.left == nil && root.right == nil {
                return
            }
            
            let tempNode = root.left! //BinaryTreeNode(value: root.left!.value)
            tempNode.left = root.right! //BinaryTreeNode(value: root.right!.value)
            tempNode.right = newNode
            newNode = tempNode
            helper(root.left!)
        }
        
        helper(node)
        return newNode
    }
    
}

final class BinaryTreeNode {
    var value: Int
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?

    public init(value: Int) {
        self.value = value
    }
}

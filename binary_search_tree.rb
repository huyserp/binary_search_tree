require 'pry'

class Node
attr_accessor :data, :left, :right

    def initialize(data)
        @data = data
        @left_child = nil
        @right_child = nil
    end
end

class Tree
    attr_reader :root

    def initialize(array)
        @array = array.sort.uniq
        @root = build_tree
    end

    def build_tree(array = @array)
        return if array.empty?

        middle = array[array.length / 2]
        left_half = array[0...array.index(middle)]
        right_half = array[(array.index(middle) + 1)..array.length]

        root = Node.new(middle)
        root.left = build_tree(left_half)
        root.right = build_tree(right_half)
        return root
    end

    def insert(root = @root, value)
        #accepts data to be inserted into the BST
        new_node = Node.new(value)
        root = new_node if root.nil?
        if root.data < new_node.data
            root.right.nil? ? root.right = new_node : insert(root.right, value)
        else
            root.left.nil? ? root.left = new_node : insert(root.left, value)
        end
    end

    def minimum_value_node(data)
        current_value = data
        until current_value.left.nil?
            current_value = current_value.left
        end
        return current_value
    end

    def delete(root = @root, data)
        #accpets data to be removed from the BST
        return root if root.nil?

        if data < root.data
            root.left = delete(root.left, data)
        elsif data > root.data
            root.right = deleteNode(root.right, data)
        else
            if root.left.nil?
                temp_root = root.right
                root = nil
                return temp_root
            elsif root.right.nil?
                temp_root = root.left
                root = nil
                return temp_root
            end
            temp_root = minimum_value_node(root.right)
            root.key = temp_root.data
            root.right = delete(root.right, temp_root.data)
        end
        return root
    end

    def find(data)
        #accepts data and returns the node which contains this data
            
            
    end

    def level_order
        #returns an aray of values 
        #This method should traverse the tree in breadth-first level order. 
        #This method can be implemented using either iteration or recursion (try implementing both!)
    end

    def preorder(root = @root)
        #returns an array of values. Should traverse the tree in its respective depth-first order.
        values = []
        unless root.nil?
            values << root.data
            preorder(root.left)
            preorder(root.right)
        end
        values
    end
    
    def inorder(root = @root)
        #returns an array of values. Should traverse the tree in its respective depth-first order.
        values = []
        unless root.nil?
            inorder(root.left)
            values << root.data
            inorder(root.right)
        end
        values
    end
    
    def postorder(root = @root)
        #returns an array of values. Should traverse the tree in its respective depth-first order.
        values = []
        unless root.nil?
            postorder(root.left)
            postorder(root.right)
            values << root.data
        end
        values
    end

    def depth
        #accepts a node and returns the depth(number of levels) beneath the node
    end

    def balanced?
        #checks if the tree is balanced. 
        #The difference between heights of left subtree and right subtree of every node is not more than 1.
    end

    def rebalance
        #rebalances an unbalanced tree.
        #Tip: You’ll want to create a level-order array of the tree before passing the array back into the #build_tree method.
    end

    def pretty_print(node = @root, prefix="", is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
        puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
        pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
    end
end

bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])





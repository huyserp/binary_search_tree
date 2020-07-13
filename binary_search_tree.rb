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

    def minimum_value_node(node)
        current = node
        until current.left.nil?
            current = current.left
        end
        return current
    end

    def delete(root = @root, data)
        #accpets data to be removed from the BST
        return root if root.nil?

        #look through the tree to identify the node to be deleted by its data value
        if data < root.data
            root.left = delete(root.left, data)
        elsif data > root.data
            root.right = delete(root.right, data)
        else
            if root.left.nil? #if there is one child to the right replace the node to be deleted with it
                temp_root = root.right
                root = nil
                return temp_root
            elsif root.right.nil? #if there is one childe to the left, replace the node to be deleted with it
                temp_root = root.left
                root = nil
                return temp_root
            end
            #find the smallest value node that is larger than the one being deleted to replace it
            temp_root = minimum_value_node(root.right)
            root.data = temp_root.data
            root.right = delete(root.right, temp_root.data)
        end
        return root #the deleted node
    end

    def find(root = @root, data)
        #accepts data and returns the node which contains this data
        if root.data < data
            if root.right.data == data
                return root.right
            else
                find(root.right, data)
            end
        else
            if root.left.data == data
                return root.left
            else
                find(root.left, data)
            end
        end
    end

    def level_order(root = @root)
        #returns an aray of values This method traverses the tree in breadth-first level order. 
        return if root.nil?
        queue = []
        values = []
        queue << root
        until queue.empty?
           current = queue.first
           values << current.data #store the data from the frist node in the queue
           queue << current.left unless current.left.nil? #if this node has a left child, load it into the queue
           queue << current.right unless current.right.nil? #if this node has a right child, load it into the queue
           queue.shift #remove the first node, thus creating a new first node
        end
        values
    end

    def preorder(root = @root, values = [])
        #returns an array of data values in the tree arranged preorder depth first traversal
        return if root.nil?

        values << root.data
        preorder(root.left, values)
        preorder(root.right, values)
        values
    end
    
    def inorder(root = @root, values = [])
        #returns an array of data values in the tree arranged inorder depth first traversal
        return if root.nil?

        inorder(root.left, values)
        values << root.data
        inorder(root.right, values)
        values
    end
    
    def postorder(root = @root, values = [])
        #returns an array of data values in the tree arranged postorder depth frist traveral
        return if root.nil?

        postorder(root.left, values)
        postorder(root.right, values)
        values << root.data
        values
    end

    def depth(root = @root, depth = 0, data)
        return depth if @root.data == data
        if root.data < data
            if root.right.data == data
                return depth += 1
            else
                depth +=1
                depth(root.right, depth, data)
            end
        else
            if root.left.data == data
                return depth += 1
            else
                depth += 1
                depth(root.left, depth, data)
            end
        end

    end

    def balanced?(root = @root, depth_left = 0, depth_right = 0)
        #checks if the tree is balanced. 
        #The difference between heights of left subtree and right subtree of every node is not more than 1.
        return true if root.nil?

        root.left ? depth_left = depth(root.left.data) : depth_left
        root.right ? depth_right = depth(root.right.data) : depth_right
        difference = (depth_left - depth_right).abs
        
        if difference <= 1 && balanced?(root.left, depth_left, depth_right) && balanced?(root.right, depth_left, depth_right)
            return true
        else
            return false
        end
    end

    def rebalance
        #rebalances an unbalanced tree. Take the sorted list returned from inorder transversal and re-bulid the object
        initialize(self.inorder)
    end

    def pretty_print(node = @root, prefix="", is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
        puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
        pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
    end
end

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.balanced?
print tree.preorder
puts
print tree.inorder
puts
print tree.postorder
puts
puts tree.insert(101)
puts tree.insert(102)
puts tree.insert(103)
puts tree.insert(104)
puts tree.insert(105)
puts tree.insert(117)
puts tree.pretty_print
puts tree.balanced?
tree.rebalance
puts tree.pretty_print
puts tree.balanced?
print tree.preorder
print tree.inorder
print tree.postorder




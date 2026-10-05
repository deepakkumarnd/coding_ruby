require 'trie'

describe TrieNode do
  context '#new' do
    it 'Initializes a new TrieNode with default values' do
      trie_node = TrieNode.new
      expect(trie_node).not_to be_nil
      expect(trie_node.child_nodes).to eq(Array.new(26) { nil })
      expect(trie_node.value).to be_nil
      expect(trie_node.leafnode?).to be false
    end

    it 'Initializes a new TrieNode with assigned values' do
      trie_node = TrieNode.new(value: 'abc')
      expect(trie_node.child_nodes).to eq Array.new(26) { nil }
      expect(trie_node.leafnode?).to be true
      expect(trie_node.value).to eq('abc')
    end

    it 'Attribute leafnode should be a boolean' do
      expect do
        TrieNode.new(leafnode: nil)
      end.to raise_error(ArgumentError)
    end

    it 'Responds to leafnode?' do
      expect(TrieNode.new.leafnode?).to be false
    end
  end
end

describe Trie do
  context '#new' do
    it 'creates initializes a new trie' do
      trie = Trie.new
      expect(trie).not_to be nil
      expect(trie.nodes_count).to eq(1)
      expect(trie.word_count).to eq(0)
    end
  end

  context '#insert' do
    it 'insert a new word to trie' do
      trie = Trie.new
      trie.insert('welcome')
      expect(trie.nodes_count).to eq(8)
      expect(trie.word_count).to eq(1)
    end

    it 'does not insert a new word to trie twice' do
      trie = Trie.new
      trie.insert('welcome')
      trie.insert('welcome')
      expect(trie.nodes_count).to eq(8)
      expect(trie.word_count).to eq(1)
    end
  end

  context '#has?' do
    it 'check if a word is present in the trie' do
      trie = Trie.new
      trie.insert('welcome')
      expect(trie.has?('welcome')).to be true
      expect(trie.has?('wel')).to be false
      expect(trie.has?('cow')).to be false
    end
  end

  context '#has_prefix?' do
    it 'check if a word prefix is present in the trie' do
      trie = Trie.new
      trie.insert('welcome')
      expect(trie.has_prefix?('welcome')).to be true
      expect(trie.has_prefix?('wel')).to be true
      expect(trie.has_prefix?('cow')).to be false
      expect(trie.has_prefix?('welcomeback')).to be false
    end
  end

  context '#find' do
    it 'check if a word is present in the trie' do
      trie = Trie.new
      trie.insert('welcome')
      expect(trie.find('welcome')).to eq 'welcome'
      expect(trie.find('wel')).to eq nil
      expect(trie.find('cow')).to eq nil
      expect(trie.find('welcomeback')).to eq nil
    end
  end

  context '#remove' do
    it 'removes a word from trie if it is present' do
      trie = Trie.new
      trie.insert('welcome')
      expect do
        trie.remove('welcome')
      end.to change(trie, :nodes_count).by(-7)
                                       .and change(trie, :word_count).by(-1)

      expect(trie.find('welcome')).to eq nil
    end

    it 'deleting the deleted word does not change anything' do
      trie = Trie.new
      trie.insert('welcome')
      trie.remove('welcome')

      expect do
        trie.remove('welcome')
      end.to change(trie, :nodes_count).by(0)
                                       .and change(trie, :word_count).by(0)

      expect(trie.find('welcome')).to eq nil
    end
  end

  context '#each' do
    it 'iterates over each leaf nodes' do
      trie = Trie.new
      trie.insert('welcome')
      trie.insert('welldone')
      trie.insert('any')
      expect do
        trie.each do |value|
          print value.length
        end
      end.to output('378').to_stdout
    end
  end

  context '#to_array' do
    it 'iterates over each leaf nodes and creates a value array' do
      trie = Trie.new
      trie.insert('welcome')
      trie.insert('welldone')
      trie.insert('any')
      expect(trie.to_array).to eq(%w[any welcome welldone])
    end
  end

  context '#from_array' do
    it 'creates a trie from an array of values' do
      trie = Trie.from_array(%w[welcome hello river])
      expect(trie.to_array).to eq(%w[hello river welcome])
    end
  end
end

# frozen_string_literal: true

class MemoDB
  JSON_FILE = './database.json'

  class << self
    def read_memos
      memos = {}
      memos = JSON.parse(File.read(JSON_FILE)) unless File.zero?(JSON_FILE)
      memos
    end

    def write_memos(memos)
      File.open(JSON_FILE, 'w') do |file|
        JSON.dump(memos, file)
      end
    end

    def select(memo_id)
      memos = MemoDB.read_memos
      memos[memo_id]
    end

    def select_all
      MemoDB.read_memos
    end

    def insert(title, body)
      memos = MemoDB.read_memos
      memos[SecureRandom.uuid] = { 'title' => title, 'body' => body }
      MemoDB.write_memos(memos)
    end

    def delete(memo_id)
      memos = MemoDB.read_memos
      memos.delete(memo_id)
      MemoDB.write_memos(memos)
    end

    def update(memo_id, title, body)
      memos = MemoDB.read_memos
      memos[memo_id] = { 'title' => title, 'body' => body }
      MemoDB.write_memos(memos)
    end
  end
end

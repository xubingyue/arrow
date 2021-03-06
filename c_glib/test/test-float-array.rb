# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

class TestFloatArray < Test::Unit::TestCase
  include Helper::Buildable

  def test_new
    assert_equal(build_float_array([-1.1, 2.2, nil]),
                 Arrow::FloatArray.new(3,
                                       Arrow::Buffer.new([-1.1, 2.2].pack("f*")),
                                       Arrow::Buffer.new([0b011].pack("C*")),
                                       -1))
  end

  def test_buffer
    builder = Arrow::FloatArrayBuilder.new
    builder.append(-1.1)
    builder.append(2.2)
    builder.append(-4.4)
    array = builder.finish
    assert_equal([-1.1, 2.2, -4.4].pack("f*"), array.buffer.data.to_s)
  end

  def test_value
    builder = Arrow::FloatArrayBuilder.new
    builder.append(1.5)
    array = builder.finish
    assert_in_delta(1.5, array.get_value(0))
  end
end

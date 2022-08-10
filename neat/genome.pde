float activation(float x) {
  return 1.0 / (1.0 + exp(-x));
}

float[] activate_genome(genome gen, int layer) {
  ArrayList<node> node_layer = gen.nodes.get(layer);
  float[] outs = new float[node_layer.size()];
  for (int i=0; i<node_layer.size(); i++) {
    node neuron = node_layer.get(i);
    float out = neuron.activate();
    if (layer==gen.nodes.size()-1) {
      outs[i] = out;
    }
  }
  if (layer!=gen.nodes.size()-1) {
    outs = activate_genome(gen, layer+1);
  }
  for (node i : node_layer) {
    i.value = 0;
  }
  return outs;
}

class genome {
  int input, output, node_number;
  ArrayList<ArrayList<node>> nodes;
  ArrayList<node> biasses;
  float fitness, weight_range;
  genome(int input, int output, float weight_range, boolean child) {
    this.input = input;
    this.output = output;
    this.weight_range = weight_range;
    nodes = new ArrayList<ArrayList<node>>();
    biasses = new ArrayList<node>();
    node_number = 0;
    fitness = 0;
    ArrayList<node> layer = new ArrayList<node>();
    for (int i=0; i<input; i++) {
      layer.add(new node(types.input, this.node_number+i, this.weight_range));
    }
    nodes.add(layer);
    layer = new ArrayList<node>();
    for (int i=0; i<output; i++) {
      layer.add(new node(types.output, node_number+i+input, weight_range));
    }
    nodes.add(layer);
    node_number += input+output;
    if (!child) {
      for (int i=0; i<100; i++) {
        mutate();
      }
    }
  }
  float[] activate(float[] inputs) {
    ArrayList<node> layer = nodes.get(0);
    for (int i=0; i<layer.size(); i++) {
      layer.get(i).value = inputs[i];
    }
    return activate_genome(this, 0);
  }

  void add_conn(int layer1, int index1, int layer2, int index2) {
    ArrayList<node> node_layer1, node_layer2;
    node node1, node2;
    if (layer1==-1) {
      layer1 = floor(random(0, nodes.size()-1));
      node_layer1 = nodes.get(layer1);
      index1 = floor(random(0, node_layer1.size()));
      layer2 = floor(random(layer1+1, this.nodes.size()));
      node_layer2 = nodes.get(layer2);
      index2 = floor(random(0, node_layer2.size()));
      node1 = node_layer1.get(index1);
      node2 = node_layer2.get(index2);
    } else {
      node_layer1 = nodes.get(layer1);
      node_layer2 = nodes.get(layer2);
      node1 = node_layer1.get(index1);
      node2 = node_layer2.get(index2);
    }
    if (node2.type!=types.bias) {
      int code = node2.name;
      if (!node1.conn_indexes.contains(code)) {
        node1.conn_indexes.add(code);
        node1.conns.add(new conn(node1, node2, weight_range));
      }
    }
  }
  void add_node() {
    int layer1 = floor(random(0, nodes.size()-1));
    ArrayList<node> node_layer = nodes.get(layer1);
    int index1 = floor(random(0, node_layer.size()));
    node node1 = node_layer.get(index1);
    if (node1.conns.size()!=0) {
      int index2 = floor(random(0, node1.conns.size()));
      int[] index = this.get_index_of_node(node1.conns.get(index2).to);
      if (index[0]==layer1+1) {
        if (random(0, 100)<30) {
          nodes.add(layer1+1, new ArrayList<node>());
          index[0]++;
        } else {
          return ;
        }
      }
      ArrayList<node> node_layer2 = nodes.get(layer1+1);
      node_layer2.add(new node(types.hidden, this.node_number, this.weight_range));
      this.node_number++;
      this.add_conn(layer1, index1, layer1+1, node_layer2.size()-1);
      this.add_conn(layer1+1, node_layer2.size()-1, index[0], index[1]);
      node1.conns.remove(index2);
      node1.conn_indexes.remove(index2);
    }
  }

  void mutate_conn() {
    int layer1 = floor(random(0, nodes.size()-1));
    ArrayList<node> node_layer = nodes.get(layer1);
    int index1 = floor(random(0, node_layer.size()));
    node node1 = node_layer.get(index1);
    if (node1.conns.size()!=0) {
      int index2 = floor(random(0, node1.conns.size()));
      node1.conns.get(index2).mutate();
    }
  }

  void add_bias() {
    if (nodes.size()>2) {
      int layer = floor(random(1, nodes.size()-1));
      ArrayList<node> node_layer = nodes.get(layer);
      int index = floor(random(0, node_layer.size()+1));
      node addthis = new node(types.bias, node_number, weight_range);
      node_layer.add(index, addthis);
      node_number++;
      biasses.add(addthis);
    }
  }

  void mutate_bias() {
    if (biasses.size()>0) {
      node selected = biasses.get(floor(random(0, biasses.size())));
      selected.mutate();
    }
  }

  int[] get_index_of_node(node search) {
    for (int i=0; i<nodes.size(); i++) {
      int index = this.nodes.get(i).indexOf(search);
      if (index!=-1) {
        return new int[] {i, index};
      }
    }
    return null;
  }

  void remove_conn() {
    int layer = floor(random(0, nodes.size()));
    ArrayList<node> node_layer = nodes.get(layer);
    int neuron = floor(random(0, node_layer.size()));
    node node1 = node_layer.get(neuron);
    if (node1.conns.size()!=0) {
      int index = floor(random(0, node1.conns.size()));
      node1.conns.remove(index);
      node1.conn_indexes.remove(index);
    }
  }

  void mutate() {
    if (random(0, 100)<5) {
      add_node();
    }
    if (random(0, 100)<1) {
      add_bias();
    }
    if (random(0, 100)<25) {
      add_conn(-1, -1, -1, -1);
    }
    if (random(0, 100)<10) {
      mutate_conn();
    }
    if (random(0, 100)<10) {
      mutate_bias();
    }
    if (random(0, 100)<5) {
      remove_conn();
    }
  }
  void show_genome(int x, int y, float w, float h, float neuron_size) {
    float xr=w/(nodes.size());
    float yr;
    strokeWeight(1);
    stroke(0);
    for (int layer=nodes.size()-1; layer>=0; layer--) {
      ArrayList<node> node_layer = nodes.get(layer);
      yr = h/node_layer.size();
      for (int i=0; i<node_layer.size(); i++) {
        node node1 = node_layer.get(i);
        node1.x = x+xr*layer+xr/2;
        node1.y = y+i*yr+yr/2;
      }
    }
    for (int layer=nodes.size()-1; layer>=0; layer--) {
      ArrayList<node> node_layer = nodes.get(layer);
      for (int i=0; i<node_layer.size(); i++) {
        node node1 = node_layer.get(i);
        for (conn connection : node1.conns) {
          stroke(0);
          if (!connection.enabled) {
            stroke(255, 0, 0);
          }
          line(connection.from.x, connection.from.y, connection.to.x, connection.to.y);
        }
      }
    }
    for (int layer=nodes.size()-1; layer>=0; layer--) {
      ArrayList<node> node_layer = nodes.get(layer);
      for (int i=0; i<node_layer.size(); i++) {
        node node1 = node_layer.get(i);
        stroke(0);
        fill(255);
        if (node1.type==types.bias) {
          fill(0, 255, 0);
        }
        ellipse(node1.x, node1.y, neuron_size,neuron_size);
        /*fill(0);
         textSize(neuron_size-str(this.nodes[layer][i].name).length*(neuron_size/5));
         textAlign(CENTER,CENTER);
         text(this.nodes[layer][i].name,this.nodes[layer][i].x,this.nodes[layer][i].y);
         */
      }
    }
  }
  genome get_clone() {
    genome child = new genome(input, output, weight_range, true);
    child.output = output;
    child.biasses = new ArrayList<node>();
    child.fitness = 0;
    child.weight_range = weight_range;
    child.input = input;
    child.nodes = new ArrayList<ArrayList<node>>();
    for (int i=0; i<nodes.size(); i++) {
      child.nodes.add(new ArrayList<node>());
    }
    for (int layer=nodes.size()-1; layer>=0; layer--) {
      ArrayList<node> node_layer = nodes.get(layer),child_layer = child.nodes.get(layer);
      for (int neuron=0; neuron<node_layer.size(); neuron++) {
        node node1 = node_layer.get(neuron);
        node newnode = new node(node1.type, node1.name, weight_range);
        child_layer.add(newnode);
        if (node1.type==types.bias) {
          newnode.value = node1.value;
          child.biasses.add(newnode);
        }
        child.node_number++;
        node1.layer = layer;
        node1.index = neuron;
        for (conn i : node1.conns) {
          if (i.to.type!=types.bias) {
            child.add_conn(layer, neuron, i.to.layer, i.to.index);
            conn newconn = newnode.conns.get(newnode.conns.size()-1);
            newconn.weight = i.weight;
            newconn.enabled = i.enabled;
          }
        }
      }
    }
    child.node_number = this.node_number;
    return child;
  }
}

function Layout(id, geometry) {
  var layouts = ["2x2", "1x2", "1x3"];
  switch (layouts[id]) {
    case "2x2":
      return new QuarterLayout(geometry, 4);
    case "1x2":
      return new QuarterLayout(geometry, 3);
    case "1x3":
      return new MasterLayout(geometry, 4);
  }
}

function QuarterLayout(geometry, max) {
  this.geometry = geometry;
  this.max = max;

  this.gaps = KWin.readConfig("gaps", 8);

  this.pane = {
    x: this.geometry.width / 2,
    y: this.geometry.height / 2
  };

  this.tiles = [];
  for (var i = 0; i < this.max; i++) {
    this.tiles.push(Qt.rect(0, 0, 0, 0));
  }

  this.tile = function(count) {
    for (var i = 0; i < this.tiles.length; i++) {
      this.tiles[i].x =
        i === 0 || i === 3
          ? this.geometry.x + this.gaps
          : this.geometry.x + this.pane.x + this.gaps / 2;
      this.tiles[i].y =
        i === 0 || i === 1
          ? this.geometry.y + this.gaps
          : this.geometry.y + this.pane.y + this.gaps / 2;
      this.tiles[i].width =
        i === 0 || i === 3
          ? this.pane.x - this.gaps * 1.5
          : this.geometry.width - this.pane.x - this.gaps * 1.5;
      this.tiles[i].height =
        i === 0 || i === 1
          ? this.pane.y - this.gaps * 1.5
          : this.geometry.height - this.pane.y - this.gaps * 1.5;
    }

    // Fill missing

    if (count !== 4)
      this.tiles[0].height +=
        this.geometry.height - this.pane.y - this.gaps / 2;

    switch (count) {
      case 1:
        this.tiles[0].width +=
          this.geometry.width - this.pane.x - this.gaps / 2;
        break;
      case 2:
        this.tiles[1].height +=
          this.geometry.height - this.pane.y - this.gaps / 2;
        break;
    }
  };

  this.move = function(client, index) {
    this.pane.x +=
      index === 0 || index === 3
        ? client.geometry.width - this.tiles[index].width
        : this.tiles[index].width - client.geometry.width;
    this.pane.y +=
      index === 0 || index === 1
        ? client.geometry.height - this.tiles[index].height
        : this.tiles[index].height - client.geometry.height;

    // Baby-proofing

    if (this.pane.x < 80) this.pane.x = 80;

    if (this.pane.x > this.geometry.width - 80)
      this.pane.x = this.geometry.width - 80;

    if (this.pane.y < 80) this.pane.y = 80;

    if (this.pane.y > this.geometry.height - 80)
      this.pane.y = this.geometry.height - 80;
  };
}

function MasterLayout(geometry, max) {
  this.geometry = geometry;
  this.max = max;

  this.gaps = KWin.readConfig("gaps", 8);

  this.pane = {
    x: this.geometry.width / 2,
    yt: this.geometry.height / 3,
    yb: this.geometry.height / 1.5
  };

  this.tiles = [];
  for (var i = 0; i < this.max; i++) {
    this.tiles.push(Qt.rect(0, 0, 0, 0));
  }

  this.tile = function(count) {
    for (var i = 0; i < this.tiles.length; i++) {
      this.tiles[i].x =
        i === 0
          ? this.geometry.x + this.gaps
          : this.geometry.x + this.pane.x + this.gaps / 2;

      this.tiles[i].y =
        i === 0 || i === 1
          ? this.geometry.y + this.gaps
          : i === 2
            ? this.geometry.y + this.pane.yt + this.gaps / 1.5
            : this.pane.yb + this.gaps / 3;

      this.tiles[i].width =
        i === 0
          ? this.pane.x - this.gaps * 1.5
          : this.geometry.width - this.pane.x - this.gaps * 1.5;

      this.tiles[i].height =
        i === 0
          ? this.geometry.height - this.gaps * 2
          : i === 1
            ? this.pane.yt - this.gaps * 1.333
            : i === 2
              ? this.pane.yb - this.pane.yt - this.gaps * 1.333
              : this.geometry.height - this.pane.yb - this.gaps * 1.33;
    }

    // Fill missing

    switch (count) {
      case 1:
        this.tiles[0].width +=
          this.geometry.width - this.pane.x - this.gaps / 2;
        break;
      case 2:
        this.tiles[1].height +=
          this.geometry.height - this.pane.yt - this.gaps / 1.5;
        break;
      case 3:
        this.tiles[1].height +=
          (this.geometry.height - this.pane.yb - this.gaps / 1.5) / 2;
        this.tiles[2].height +=
          (this.geometry.height - this.pane.yb - this.gaps / 1.5) / 2;
        this.tiles[2].y += (this.geometry.height - this.pane.yb) / 2;
        break;
    }
  };

  this.move = function(client, index) {
    this.pane.x +=
      index === 0
        ? client.geometry.width - this.tiles[index].width
        : this.tiles[index].width - client.geometry.width;

    switch (index) {
      case 1:
        this.pane.yt += client.geometry.height - this.tiles[index].height;
        break;
      case 2:
        if (client.geometry.y !== this.tiles[index].y)
          this.pane.yt += client.geometry.y - this.tiles[index].y;
        else this.pane.yb += client.geometry.height - this.tiles[index].height;
        break;
      case 3:
        this.pane.yb += this.tiles[index].height - client.geometry.height;
        break;
    }

    // Baby-proofing

    if (this.pane.x < 80) this.pane.x = 80;

    if (this.pane.x > this.geometry.width - 80)
      this.pane.x = this.geometry.width - 80;

    if (this.pane.yt < 80) this.pane.yt = 80;

    if (this.pane.yb > this.geometry.height - 80)
      this.pane.yb = this.geometry.height - 80;

    if (this.pane.yb < this.pane.yt) {
      this.pane.yt = this.geometry.height / 3;
      this.pane.yb = this.geometry.height / 1.5;
    }

    if (this.pane.yt > this.pane.yb) {
      this.pane.yt = this.geometry.height / 3;
      this.pane.yb = this.geometry.height / 1.5;
    }
  };
}

Qt.include("desktop.js");
Qt.include("screen.js");
Qt.include("layouts.js");

// Disable some default options that don't play nicely with the script
options.windowSnapZone = 0;
options.electricBorderMaximize = false;
options.electricBorderTiling = false;

function Activity() {
  // TL;DR: this.desktops[i].screens[j].clients[l].geometry = this.desktops[i].screens[j].layout.tiles[l]

  // A hack to access this from the inner functions
  var self = this;

  this.ignored = [
    "albert",
    "kazam",
    "krunner",
    "ksmserver",
    "lattedock",
    "pinentry",
    "Plasma",
    "plasma",
    "plasma-desktop",
    "plasmashell",
    "plugin-container",
    "simplescreenrecorder",
    "yakuake"
  ];

  this.id = workspace.currentActivity.toString();

  this.desktops = [];
  for (var i = 1; i <= workspace.desktops; i++) {
    this.desktops[i] = new Desktop(i);
  }

  // Store original positions & sizes
  this.original = [];

  this.tile = function() {
    for (var i = 1; i <= this.desktops.length; i++) {
      this.desktops[i].tile();
    }
  };

  // Hire me?
  this.find = function(client) {
    for (var i = 1; i <= this.desktops.length; i++) {
      for (var j = 0; j < this.desktops[i].screens.length; j++) {
        for (var l = 0; l < this.desktops[i].screens[j].clients.length; l++) {
          if (
            this.desktops[i].screens[j].clients[l].windowId ===
              client.windowId ||
            this.desktops[i].screens[j].frameId === client.frameId
          ) {
            return { screen: this.desktops[i].screens[j], index: l };
          }
        }
      }
    }

    return { screen: -1, index: -1 };
  };

  // Checks whether a client is eligible for tiling or not
  this.eligible = function(client) {
    return client.comboBox ||
      client.desktopWindow ||
      client.dialog ||
      client.dndIcon ||
      client.dock ||
      client.dropdownMenu ||
      client.menu ||
      client.notification ||
      client.popupMenu ||
      client.specialWindow ||
      client.splash ||
      client.toolbar ||
      client.tooltip ||
      client.utility ||
      client.transient ||
      this.ignored.indexOf(client.resourceClass.toString()) > -1 ||
      this.ignored.indexOf(client.resourceName.toString()) > -1 ||
      client.geometry ===
        self.desktops[client.desktop].screens[client.screen].geometry ||
      this.desktops[client.desktop].screens[client.screen].clients.length >
        this.desktops[client.desktop].screens[client.screen].layout.max - 1
      ? false
      : true;
  };

  this.add = function(client) {
    if (!self.eligible(client)) return;

    self.original[client.windowId] = Qt.rect(
      client.geometry.x,
      client.geometry.y,
      client.geometry.width,
      client.geometry.height
    );

    client.clientFinishUserMovedResized.connect(self.move);
    if (KWin.readConfig("live", false).toString() === "true")
      client.clientStepUserMovedResized.connect(self.resize);

    var screen = self.desktops[client.desktop].screens[client.screen];
    screen.clients.push(client);
    screen.tile();
  };

  this.remove = function(client) {
    self.reset(client);

    client.clientFinishUserMovedResized.disconnect(self.move);
    if (KWin.readConfig("live", false).toString() === "true")
      client.clientStepUserMovedResized.disconnect(self.resize);

    var p = self.find(client);
    p.screen.clients.splice(p.index, 1);
    p.screen.tile();
  };

  this.reset = function(client) {
    // Note: The older instance has to be removed, since it will not be overwritten
    var original = this.original.splice(client.windowId, 1)[0];

    client.geometry.width = original.width;
    client.geometry.height = original.height;
  };

  this.resize = function(client) {
    var p = self.find(client);

    if (
      !client.geometry.width === p.screen.layout.tiles[p.index].width &&
      !client.geometry.height === p.screen.layout.tiles[p.index].height
    ) {
      p.screen.layout.move(client, p.index);
    }

    p.screen.tile(p.screen.clients.length);
  };

  this.move = function(client) {
    var p = self.find(client);

    if (
      client.geometry.width ===
        Math.round(p.screen.layout.tiles[p.index].width) &&
      client.geometry.height ===
        Math.round(p.screen.layout.tiles[p.index].height)
    ) {
      if (client.screen !== p.screen.id) {
        self.relocate(client);
      } else {
        p.screen.move(client, p.index);
      }
    } else {
      p.screen.layout.move(client, p.index);
    }

    p.screen.tile(p.screen.clients.length);
  };

  this.relocate = function(client) {
    var p = self.find(client);
    p.screen.clients.splice(p.index, 1);
    p.screen.tile();

    if (self.eligible(client)) {
      var screen = self.desktops[client.desktop].screens[client.screen];
      screen.clients.push(client);
      screen.tile();
    } else {
      self.reset(client);

      client.clientFinishUserMovedResized.disconnect(self.move);
      if (KWin.readConfig("live", false).toString() === "true")
        client.clientStepUserMovedResized.disconnect(self.resize);
    }
  };

  if (KWin.readConfig("auto", false).toString() === "true") {
    workspace.clientAdded.connect(function(client) {
      self.add(client);
    });
  }

  workspace.clientRemoved.connect(function(client) {
    self.remove(client);
  });

  workspace.desktopPresenceChanged.connect(function(client, desktop) {
    self.relocate(client);
  });

  workspace.currentDesktopChanged.connect(function(desktop, client) {
    self.tile();
  });

  workspace.activitiesChanged.connect(function(client) {
    self.remove(client);
  });

  workspace.clientMinimized.connect(function(client) {
    // TODO
  });

  workspace.clientMaximizeSet.connect(function(client, h, v) {});

  workspace.numberDesktopsChanged(function(oldDesktops) {
    // TODO
  });

  this.toggle = function() {
    var client = workspace.activeClient;

    try {
      self.remove(client);
    } catch (error) {
      self.add(client);
    }
  };

  KWin.registerShortcut(
    "Quarter: Float On/Off",
    "Quarter: Float On/Off",
    "Meta+F",
    this.toggle
  );
}

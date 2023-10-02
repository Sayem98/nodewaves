const Web3 = require("web3");

contract("NodeWaves", (accounts) => {
  before(async () => {
    usdt = await artifacts.require("USDT").deployed();
    nodeWaves = await artifacts.require("NodeWaves").deployed();
    // console.log("USDT address: ", usdt.address);
    // console.log("NodeWaves address: ", nodeWaves.address);
  });
  it("should distribute tokens", async () => {
    const trx = await nodeWaves.distribute({
      from: accounts[0],
    });
    assert.equal(trx.receipt.status, true);

    // get total supply
    const totalSupply = await nodeWaves.totalSupply();
    assert.equal(
      Number(Web3.utils.fromWei(totalSupply, "ether")),
      10e9 + 10000
    );
  });

    it("should return pos", async () => {
      // get pos
      // wait 1.5 minutes
      await new Promise((resolve) => setTimeout(resolve, 90000));
      let pos = await nodeWaves.pos();

      console.log("pos: ", pos);

      pos = Web3.utils.fromWei(pos, "ether");
      console.log("pos: ", pos);
    });
    it("should withdraw pos token", async () => {
      const trx2 = await nodeWaves.setPayoutaddress(
        [
          accounts[1],
          accounts[1],
          accounts[1],
          accounts[1],
          accounts[1],
          accounts[1],
          accounts[1],
          accounts[1],
          accounts[1],
          accounts[1],
        ],
        {
          from: accounts[0],
        }
      );
      const trx = await nodeWaves.withdrawToken(0, {
        from: accounts[1],
      });

      assert.equal(trx.receipt.status, true);
    });

  it("should buy node with usdt", async () => {
    // aprove
    const trx = await usdt.approve(
      nodeWaves.address,
      Web3.utils.toWei("1000", "ether"),
      {
        from: accounts[0],
      }
    );
    const trx1 = await nodeWaves.buyNode(
      [
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
      ],
      1,
      Web3.utils.toWei("1000", "ether"),
      {
        from: accounts[0],
      }
    );

    // const get node
    const node = await nodeWaves.nodes(0);
    assert.equal(node.owner, accounts[0]);
  });

  it("should buy node with nodewaves", async () => {
    // aprove
    const trx = await nodeWaves.approve(
      nodeWaves.address,
      Web3.utils.toWei("1000", "ether"),
      {
        from: accounts[0],
      }
    );
    const trx1 = await nodeWaves.buyNode(
      [
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
      ],
      2,
      Web3.utils.toWei("1000", "ether"),
      {
        from: accounts[0],
      }
    );
    // const get node
    const node = await nodeWaves.nodes(1);
    assert.equal(node.owner, accounts[0]);
  });

  it("should buy membership with usdt", async () => {
    // approve token
    const trx = await usdt.approve(
      nodeWaves.address,
      Web3.utils.toWei("10", "ether"),
      {
        from: accounts[0],
      }
    );
    assert.equal(trx.receipt.status, true);

    // buy membership
    const trx1 = await nodeWaves.buyMembership(
      [
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
      ],
      1,
      Web3.utils.toWei("10", "ether"),
      {
        from: accounts[0],
      }
    );
    assert.equal(trx1.receipt.status, true);
  });
  it("should buy membership with nodewaves", async () => {
    // approve token
    // const trx = await nodeWaves.approve(
    //   nodeWaves.address,
    //   Web3.utils.toWei("10", "ether"),
    //   {
    //     from: accounts[0],
    //   }
    // );
    // assert.equal(trx.receipt.status, true);

    // buy membership
    const trx1 = await nodeWaves.buyMembership(
      [
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
      ],
      2,
      Web3.utils.toWei("10", "ether"),
      {
        from: accounts[0],
      }
    );
    assert.equal(trx1.receipt.status, true);
  });

  it("should burn to get burn pakages", async () => {
    // burn
    const trx = await nodeWaves.burn(
      Web3.utils.toWei("2000", "ether"),
      [
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
        accounts[0],
      ],
      {
        from: accounts[0],
      }
    );
    // assart error
    assert.equal(trx.receipt.status, true);
    // const burnIDs = await nodeWaves.burnIds(accounts[0]);
    // console.log("burnIDs: ", burnIDs);
    const burn = await nodeWaves.burning(0);
    assert.equal(burn.amount, Web3.utils.toWei("2000", "ether"));
  });

  it("should swap prevNodeWaves for new NodeWaves", async () => {
    // should approve token first
    const balance1 = Web3.utils.fromWei(
      await usdt.balanceOf(accounts[0]),
      "ether"
    );
    const trx = await usdt.approve(
      nodeWaves.address,
      Web3.utils.toWei("1000", "ether"),
      {
        from: accounts[0],
      }
    );
    const trx1 = await nodeWaves.swap(Web3.utils.toWei("1000", "ether"), {
      from: accounts[0],
    });
    const balance2 = Web3.utils.fromWei(
      await usdt.balanceOf(accounts[0]),
      "ether"
    );
    assert.equal(Number(balance1) - Number(balance2), 1000);
  });
});

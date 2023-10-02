/**
 *Submitted for verification at Etherscan.io on 2023-07-31
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
// File: @openzeppelin/contracts/access/Ownable.sol

// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol

// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol

// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(
        address account
    ) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(
        address owner,
        address spender
    ) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(
        address spender,
        uint256 amount
    ) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(
            fromBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= amount,
                "ERC20: insufficient allowance"
            );
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

// File: contracts/MyToken1.sol

// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/extensions/ERC20Burnable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */

abstract contract ERC20Burnable is Context, ERC20 {
    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance.
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `amount`.
     */
    function burnFrom(address account, uint256 amount) public virtual {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
}

contract ReEntrancyGuard {
    bool internal locked;

    modifier noReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }
}

contract Nodewaves is ERC20, ERC20Burnable, Ownable, ReEntrancyGuard {
    struct Nodes {
        uint256 amount;
        uint256 lastWithdraw;
        address[] affiliate;
        uint reward;
        address owner;
    }

    struct Burn {
        uint256 amount;
        uint256 lastwithdraw;
        address[10] affiliates;
        address burner;
        uint reward;
        uint apy;
    }


    mapping(uint => Nodes) public nodes;
    mapping(address => uint[]) nodeIds;

    uint256 public numberOfNodes;
    mapping(address => uint256) public nodeAffiliateRewards;

    uint256 decimal = 3;
    uint256 public maxSupply = 10e9 * 10 ** decimals();

    

    // state variables for tokens distribution amount
    uint256 public tokenForDistribuition;
    uint256 tokenForSP;
    uint256 tokenForNode;
    uint256 tokenForPoB;
    uint256 tokenForPoS;
    uint256 tokenForTeam;
    uint256 tokenForAdvisors;
    uint256 tokenForTreasure;
    uint256 tokenForP2E;
    uint256 tokenForM2E;
    uint256 tokenForLiquidity;
    uint256 tokenForDevAndEco;

    uint256 totalTokenForSP;
    uint256 totalTokenForNode;
    uint256 totalTokenForPoB;
    uint256 totalTokenForPoS;
    uint256 totalTokenForTeam;
    uint256 totalTokenForAdvisors;
    uint256 totalTokenForTreasure;
    uint256 totalTokenForP2E;
    uint256 totalTokenForM2E;
    uint256 totalTokenForLiquidity;
    uint256 totalTokenForDevAndEco;

    address[10] public payoutAddresses;

    uint256[] public percentages = [
        300,
        2500,
        2500,
        500,
        200,
        300,
        2500,
        500,
        500,
        1500,
        1500
    ];

    //  state variables for distribution date
    uint256 public distributedateSP;
    uint256 public distributedateNode;
    uint256 public distributedatePoB;
    uint256 public distributedatePoS;
    uint256 public distributedateTeam;
    uint256 public distributedateAdvisors;
    uint256 public distributedateTreasure;
    uint256 public distributedateP2E;
    uint256 public distributedateM2E;
    uint256 public distributedateLiquidity;
    uint256 public distributedateDevAndEco;

    uint256 public distributePercentage = 1000;

    uint256 public distributionTime = 365;

    uint256 public payoutTime = 1 minutes; // 1 days;

    ERC20 public usdt;

    uint256 public nodePriceWithUsdt = 1000 * 10 ** 18;
    uint256 public nodePriceWithNws = 1000 * 10 ** 18;

    uint256 public membershipPriceWithUsdt = 10 * 10 ** 18;
    uint256 public membershipPriceWithNws = 10 * 10 ** 18;

    uint256 public paymentSplit = 500; // 50%

    mapping(address => bool) public isMember;
    mapping(address => uint256) public timestamp;
    uint256 public totalUser;
    uint256 public dailyReward = 100 * 10 ** decimals();

    uint256[10] public f_percentages = [
        100,
        50,
        30,
        20,
        10,
        10,
        10,
        10,
        10,
        10
    ];
    uint8[10] public nodeRewardPercentages = [
        100,
        100,
        100,
        100,
        100,
        100,
        100,
        100,
        100,
        100
    ];

    mapping(uint => Burn) public burning;
    mapping(address => uint[]) public burnIds;
    uint public totalNumberOfBurns;
    mapping(address => uint256) public burnAffiliateRewards;

    uint256 public burnAffiliatePercentage = 2500;

    uint256 public poolReward = 0;
    address public poolAddress;
    uint256 public polRewardPercentage = 100;
    uint256 public development = 0;
    address public developmentAddress;
    uint256 public developmentPercentage = 300;
    uint256 public systemOperation = 0;
    address public systemOperationAddress;
    uint256 public systemOperationPercentage = 200;

    uint256[10] public burnAfflilatePercentages = [
        1000,
        500,
        300,
        200,
        100,
        100,
        100,
        100,
        100,
        100
    ];

    uint256[5] public burnPakages = [1000, 2000, 3000, 4000, 5000];
    uint256[5] public burnRewardsAPYs = [4, 5, 6, 8, 9];
    mapping(address => uint) public nodeBuyAffiliateReward;
    mapping(address => uint) public nodeBuyAffiliateRewardUsdt;
    ERC20 public previousNWS;

    constructor(address _usdt, address _pNws) ERC20("Nodewaves", "NWS") {
        usdt = ERC20(_usdt);
        previousNWS = ERC20(_pNws);
    }

    function setNodeBuyAffilateReward(
        address _addr,
        uint _amount
    ) public onlyOwner {
        nodeAffiliateRewards[_addr] = nodeAffiliateRewards[_addr] + _amount;
    }

    function setNodeBuyAffiliateRewardUsdt(
        address _addr,
        uint _amount
    ) public onlyOwner {
        nodeBuyAffiliateRewardUsdt[_addr] =
            nodeBuyAffiliateRewardUsdt[_addr] +
            _amount;
    }

    function setNodeBuyAffilateRewardMultiple(
        address[] memory _addr,
        uint[] memory _amount
    ) public onlyOwner {
        for (uint i = 0; i < _addr.length; i++) {
            setNodeBuyAffilateReward(_addr[i], _amount[i]);
        }
    }

    function setNodeBuyAffilateRewardMultipleUsdt(
        address[] memory _addr,
        uint[] memory _amount
    ) public onlyOwner {
        for (uint i = 0; i < _addr.length; i++) {
            setNodeBuyAffiliateRewardUsdt(_addr[i], _amount[i]);
        }
    }

    function withdrawNodeBuyAffilateReward(uint _amount) public {
        require(nodeAffiliateRewards[msg.sender] >= _amount, "Invalid amount");
        nodeBuyAffiliateReward[msg.sender] =
            nodeBuyAffiliateReward[msg.sender] -
            _amount;
        _transfer(address(this), msg.sender, _amount);
    }

    function withdrawNodeBuyAffilateRewardUsdt(uint _amount) public {
        require(
            nodeBuyAffiliateRewardUsdt[msg.sender] >= _amount,
            "Invalid amount"
        );
        nodeBuyAffiliateRewardUsdt[msg.sender] =
            nodeBuyAffiliateRewardUsdt[msg.sender] -
            _amount;
        usdt.transfer(msg.sender, _amount);
    }

    mapping(address => uint) public membershipBuyAffiliateReward;
    mapping(address => uint) public membershipBuyAffiliateRewardUsdt;

    function setMembershipBuyAffilateReward(
        address _addr,
        uint _amount
    ) public onlyOwner {
        membershipBuyAffiliateReward[_addr] =
            membershipBuyAffiliateReward[_addr] +
            _amount;
    }

    function setMembershipBuyAffiliateRewardUsdt(
        address _addr,
        uint _amount
    ) public onlyOwner {
        membershipBuyAffiliateRewardUsdt[_addr] =
            membershipBuyAffiliateRewardUsdt[_addr] +
            _amount;
    }

    function setMembershipBuyAffilateRewardMultiple(
        address[] memory _addr,
        uint[] memory _amount
    ) public onlyOwner {
        for (uint i = 0; i < _addr.length; i++) {
            setMembershipBuyAffilateReward(_addr[i], _amount[i]);
        }
    }

    function setMembershipBuyAffilateRewardMultipleUsdt(
        address[] memory _addr,
        uint[] memory _amount
    ) public onlyOwner {
        for (uint i = 0; i < _addr.length; i++) {
            setMembershipBuyAffiliateRewardUsdt(_addr[i], _amount[i]);
        }
    }

    function withdrawMembershipBuyAffilateReward(uint _amount) public {
        require(
            membershipBuyAffiliateReward[msg.sender] >= _amount,
            "Invalid amount"
        );
        membershipBuyAffiliateReward[msg.sender] =
            membershipBuyAffiliateReward[msg.sender] -
            _amount;
        _transfer(address(this), msg.sender, _amount);
    }

    function withdrawMembershipBuyAffilateRewardUsdt(uint _amount) public {
        require(
            membershipBuyAffiliateRewardUsdt[msg.sender] >= _amount,
            "Invalid amount"
        );
        membershipBuyAffiliateRewardUsdt[msg.sender] =
            membershipBuyAffiliateRewardUsdt[msg.sender] -
            _amount;
        usdt.transfer(msg.sender, _amount);
    }

    function swap(uint _amount) public {
        require(_amount > 0, "Amount must be greater than 0");
        require(
            previousNWS.balanceOf(msg.sender) >= _amount,
            "Insufficient balance"
        );

        previousNWS.transferFrom(msg.sender, address(this), _amount);
        _transfer(address(this), msg.sender, _amount);
    }

    function distribute() external onlyOwner {
        _mint(msg.sender, 10000 * 10 ** decimals());
        _distribute();
    }

    function _distribute() private {
        

        // setting distribution times.
        distributedateSP = block.timestamp;
        distributedateNode = block.timestamp;
        distributedatePoB = block.timestamp;
        distributedatePoS = block.timestamp;
        distributedateTeam = block.timestamp;
        distributedateAdvisors = block.timestamp;
        distributedateTreasure = block.timestamp;
        distributedateP2E = block.timestamp;
        distributedateM2E = block.timestamp;
        distributedateLiquidity = block.timestamp;
        distributedateDevAndEco = block.timestamp;

        // calculating tokens for distribution
        tokenForDistribuition =
            (maxSupply * distributePercentage) /
            10 ** decimal;

        _mint(address(this), tokenForDistribuition);
        // calculating tokens for SP
        tokenForSP =
            tokenForSP +
            (tokenForDistribuition * percentages[0]) /
            10 ** decimal;
        totalTokenForSP = tokenForSP;
        // calculating tokens for Node
        tokenForNode =
            tokenForNode +
            (tokenForDistribuition * percentages[1]) /
            10 ** decimal;
        totalTokenForNode = tokenForNode;
        // calculating tokens for PoB
        tokenForPoB =
            tokenForPoB +
            (tokenForDistribuition * percentages[2]) /
            10 ** decimal;
        totalTokenForPoB = tokenForPoB;
        // calculating tokens for PoS
        tokenForPoS =
            tokenForPoS +
            (tokenForDistribuition * percentages[3]) /
            10 ** decimal;
        totalTokenForPoS = tokenForPoS;
        // calculating tokens for Team
        tokenForTeam =
            tokenForTeam +
            (tokenForDistribuition * percentages[4]) /
            10 ** decimal;
        totalTokenForTeam = tokenForTeam;
        // calculating tokens for Advisors
        tokenForAdvisors =
            tokenForAdvisors +
            (tokenForDistribuition * percentages[5]) /
            10 ** decimal;
        totalTokenForAdvisors = tokenForAdvisors;
        // calculating tokens for Treasure
        tokenForTreasure =
            tokenForTreasure +
            (tokenForDistribuition * percentages[6]) /
            10 ** decimal;
        totalTokenForTreasure = tokenForTreasure;
        // calculating tokens for P2E
        tokenForP2E =
            tokenForP2E +
            (tokenForDistribuition * percentages[7]) /
            10 ** decimal;
        totalTokenForP2E = tokenForP2E;
        // calculating tokens for M2E
        tokenForM2E =
            tokenForM2E +
            (tokenForDistribuition * percentages[8]) /
            10 ** decimal;
        totalTokenForM2E = tokenForM2E;
        // calculating tokens for Liquidity
        tokenForLiquidity =
            tokenForLiquidity +
            (tokenForDistribuition * percentages[9]) /
            10 ** decimal;
        totalTokenForLiquidity = tokenForLiquidity;

        // calculating tokens for DevAndEco
        tokenForDevAndEco =
            tokenForDevAndEco +
            (tokenForDistribuition * percentages[10]) /
            10 ** decimal;

        totalTokenForDevAndEco = tokenForDevAndEco;
    }

    function withdrawToken(uint256 _index) public {
        require(_index <= 9, "Invalid index");
        require(
            payoutAddresses[_index] != address(0),
            "Payout address is not set"
        );

        if (_index == 0) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = pos();
            //reduce  token for pos

            tokenForPoS = tokenForPoS - _temp;

            distributedatePoS = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 1) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = team();

            tokenForTeam = tokenForTeam - _temp;
            distributedateTeam = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 2) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = advisors();
            tokenForAdvisors = tokenForAdvisors - _temp;
            distributedateAdvisors = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 3) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );

            uint _temp = treasure();
            tokenForTreasure = tokenForTreasure - _temp;
            distributedateTreasure = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 4) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = p2e();
            tokenForP2E = tokenForP2E - _temp;
            distributedateP2E = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 5) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );

            uint _temp = m2e();
            tokenForM2E = tokenForM2E - _temp;
            distributedateM2E = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 6) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = liquidity();
            tokenForLiquidity = tokenForLiquidity - _temp;
            distributedateLiquidity = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 7) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = devAndEco();
            tokenForDevAndEco = tokenForDevAndEco - _temp;
            distributedateDevAndEco = block.timestamp;
            _transfer(address(this), msg.sender, _temp);
        }
        if (_index == 8) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = sp();

            distributedateSP = block.timestamp;
            tokenForSP = 0;
            _transfer(address(this), msg.sender, _temp);
        }

        if (_index == 9) {
            require(
                msg.sender == payoutAddresses[_index],
                "You are not allowed to withdraw"
            );
            uint _temp = node();
            distributedateNode = block.timestamp;
            tokenForNode = 0;
            _transfer(address(this), msg.sender, _temp);
        }
    }

    function  (
        address[10] memory _friend,
        uint256 _paymentType,
        uint _amount,
        uint _numberOfNodes
    ) public {
        require(_paymentType == 1 || _paymentType == 2, "Invalid payment type");
        uint _price = _amount;
        if (_paymentType == 1) {
            require(_amount == nodePriceWithUsdt, "Not a valid price");
            require(_amount>=nodePriceWithUsdt * _numberOfNodes, "Not a valid price");

            usdt.transferFrom(msg.sender, address(this), _amount);
            usdt.transfer(owner(), (_amount * paymentSplit) / 10 ** decimal);

            for (uint256 i = 0; i < 10; i++) {
                if (_friend[i] != address(0)) {
                    uint _friendAnount = (_price * f_percentages[i]) /
                        10 ** decimal;
                    nodeBuyAffiliateRewardUsdt[msg.sender] += _friendAnount;
                }
            }
        } else {
            require(_amount >= nodePriceWithNws, "Not a valid price");
            require(_amount>=nodePriceWithNws * _numberOfNodes, "Not a valid price");


            _transfer(msg.sender, address(this), _amount);
            _transfer(
                address(this),
                owner(),
                (_amount * paymentSplit) / 10 ** decimal
            );
            for (uint256 i = 0; i < 10; i++) {
                if (_friend[i] != address(0)) {
                    uint _friendAmount = (_price * f_percentages[i]) /
                        10 ** decimal;
                    nodeBuyAffiliateReward[msg.sender] += _friendAmount;
                }
            }
        }

       

        Nodes storage _node = nodes[numberOfNodes];
        nodeIds[msg.sender].push(numberOfNodes);
        _node.amount = _amount;
        _node.affiliate = _friend;
        _node.lastWithdraw = block.timestamp;
        _node.amount = _node.amount + 1;
        _node.owner = msg.sender;

        numberOfNodes += 1;
    }

    function nodeWithdrawByAddress() public {
        uint[] memory _nodeIds = nodeIds[msg.sender];
        uint _amount = 0;

        for (uint256 i = 0; i < _nodeIds.length; i++) {
            Nodes storage _node = nodes[_nodeIds[i]];
            require(_node.owner == msg.sender, "Not Authorized");

            if (_node.reward != 0) {
                _amount += _node.reward;
                _node.reward = 0;

                for (uint256 j = 0; j < _node.affiliate.length; j++) {
                    if (_node.affiliate[i] != address(0)) {
                        uint256 _affiliateAmount = (_amount *
                            nodeRewardPercentages[j]) / (10 ** decimal);
                        nodeAffiliateRewards[_node.affiliate[j]] =
                            nodeAffiliateRewards[_node.affiliate[j]] +
                            _affiliateAmount;
                    }
                }
                _node.lastWithdraw = block.timestamp;
            }
        }

        require(_amount > 0, "You don't have any rewards");
        require(tokenForNode >= _amount, "Not enough tokens in node pool");

        tokenForNode -= _amount;
        _transfer(address(this), msg.sender, _amount);
    }

    function withdrawNodeAffiliateRewards(uint _amount) public {
        uint256 _total = nodeAffiliateRewards[msg.sender];
        require(_amount >= _total, "You don't have any rewards");
        nodeAffiliateRewards[msg.sender] =
            nodeAffiliateRewards[msg.sender] -
            _amount;
        _transfer(address(this), msg.sender, _amount);
    }

    function nodeWithdrawByID(uint _id) public {
        Nodes storage _node = nodes[_id];
        require(_node.owner == msg.sender, "Not Authorized");

        uint256 _amount = _node.reward;
        _node.reward = 0;

        require(_amount > 0, "You don't have any rewards");
        require(tokenForNode >= _amount, "Not enough tokens in node pool");

        require(
            _amount <= balanceOf(address(this)),
            "Not enough token to send"
        );

        tokenForNode -= _amount;

        for (uint256 i = 0; i < _node.affiliate.length; i++) {
            if (_node.affiliate[i] != address(0)) {
                uint256 _affiliateAmount = (_amount *
                    nodeRewardPercentages[i]) / (10 ** decimal);
                nodeAffiliateRewards[_node.affiliate[i]] =
                    nodeAffiliateRewards[_node.affiliate[i]] +
                    _affiliateAmount;
            }
        }
        _transfer(address(this), msg.sender, _amount);
        _node.lastWithdraw = block.timestamp;
    }

    function addNode(
        uint[] memory _amounts,
        address[] memory _owners,
        address[10][] memory _payoutAddresses,
        uint[] memory _rewards,
        address[] memory _addresses
    ) public onlyOwner {
        for (uint256 i = 0; i < _amounts.length; i++) {
            addNodeByID(
                _amounts[i],
                _owners[i],
                _payoutAddresses[i],
                _rewards[i],
                _addresses[i]
            );
        }
    }

    function addNodeByID(
        uint _amount,
        address _owner,
        address[10] memory _payoutAddresses,
        uint _reward,
        address _address
    ) public onlyOwner {
        // get the nodes
        Nodes storage _node = nodes[numberOfNodes];

        _node.reward = _reward;
        _node.lastWithdraw = block.timestamp;
        _node.owner = _owner;
        _node.amount = _amount;
        _node.affiliate = _payoutAddresses;
        nodeIds[_address].push(numberOfNodes);

        numberOfNodes += 1;
    }

    function addNodeRewardById(uint _id, uint _amount) public onlyOwner {
        Nodes storage _node = nodes[_id];
        _node.reward = _amount;
    }

    function addNodeReward(
        uint[] memory _ids,
        uint[] memory _amounts
    ) public onlyOwner {
        for (uint256 i = 0; i < _ids.length; i++) {
            addNodeRewardById(_ids[i], _amounts[i]);
        }
    }

    function getNodeRewardByAddress() public view returns (uint) {
        uint[] storage _ids = nodeIds[msg.sender];
        uint _reward = 0;
        for (uint i; i < _ids.length; i++) {
            Nodes storage _node = nodes[_ids[i]];
            _reward += _node.reward;
        }
        return _reward;
    }

    function getNodeRewardById(uint _id) public view returns (uint) {
        Nodes storage _node = nodes[_id];
        return _node.reward;
    }

    function buyMembership(
        address[10] memory _friends,
        uint256 _paymentType,
        uint _amount
    ) public {
        require(_paymentType == 1 || _paymentType == 2, "Invalid payment type");
        uint _price;

        if (_paymentType == 1) {
            require(_amount == membershipPriceWithUsdt, "Not valid amount");
            usdt.transferFrom(
                msg.sender,
                address(this),
                membershipPriceWithUsdt
            );
            usdt.transfer(
                owner(),
                (membershipPriceWithUsdt * paymentSplit) / 10 ** decimal
            );
            _price = membershipPriceWithUsdt;
            for (uint256 i = 0; i < 10; i++) {
                if (_friends[i] != address(0)) {
                    uint _friendAmount = (_price * f_percentages[i]) /
                        10 ** decimal;
                    membershipBuyAffiliateRewardUsdt[
                        msg.sender
                    ] += _friendAmount;
                }
            }
        } else {
            require(_amount >= membershipPriceWithNws, "Not valid amount");

            _transfer(msg.sender, address(this), _amount);
            _transfer(
                address(this),
                owner(),
                (_amount * paymentSplit) / 10 ** decimal
            );
            _price = _amount;

            for (uint256 i = 0; i < 10; i++) {
                if (_friends[i] != address(0)) {
                    uint _friendAmount = (_price * f_percentages[i]) /
                        10 ** decimal;
                    membershipBuyAffiliateReward[msg.sender] += _friendAmount;
                }
            }
        }

        isMember[msg.sender] = true;
        timestamp[msg.sender] = block.timestamp;
        totalUser += 1;
    }

    function addMembership(
        address[] memory _address,
        uint256[] memory _timestamp
    ) public onlyOwner {
        for (uint256 i; i < _address.length; i++) {
            isMember[_address[i]] = true;
            timestamp[_address[i]] = _timestamp[i];
            totalUser += 1;
        }
    }

    // Burn functionality
    function burn(uint256 amount, address[10] memory _affliliates) public {
        require(isMember[msg.sender], "You are not a member");
        require(
            amount == burnPakages[0] * 10 ** 18 ||
                amount == burnPakages[1] * 10 ** 18 ||
                amount == burnPakages[2] * 10 ** 18 ||
                amount == burnPakages[3] * 10 ** 18 ||
                amount == burnPakages[4] * 10 ** 18,
            "Not a valid burn pakage"
        );
        _burn(msg.sender, amount); // Burning the amount of tokens.

        uint _apy = 0;
        if (amount == burnPakages[0] * 10 ** 18) {
            _apy = burnRewardsAPYs[0];
        } else if (amount == burnPakages[1] * 10 ** 18) {
            _apy = burnRewardsAPYs[1];
        } else if (amount == burnPakages[2] * 10 ** 18) {
            _apy = burnRewardsAPYs[2];
        } else if (amount == burnPakages[3] * 10 ** 18) {
            _apy = burnRewardsAPYs[3];
        } else if (amount == burnPakages[4] * 10 ** 18) {
            _apy = burnRewardsAPYs[4];
        }

        Burn storage _burning = burning[totalNumberOfBurns];

        _burning.amount = amount;
        _burning.lastwithdraw = block.timestamp;
        _burning.affiliates = _affliliates;
        _burning.burner = msg.sender;
        _burning.apy = _apy;
        burnIds[msg.sender].push(totalNumberOfBurns);
        totalNumberOfBurns += 1;
    }

    function withdrawBurnRewardByAddress() public {
        uint[] storage _ids = burnIds[msg.sender];
        for (uint i; i < _ids.length; i++) {
            withdrawBurnRewardByID(_ids[i]);
        }
    }

    function withdrawBurnRewardByID(uint _id) public {
        Burn storage _burning = burning[_id];
        uint256 _amount = _burning.amount;

        require(_burning.burner == msg.sender, "You are not the burner");

        require(_amount > 0, "You don't have any burning amount");
        uint _reward = _burning.reward;
        require(_reward > 0, "You don't have any reward");
        _burning.reward = 0;
        require(_reward <= tokenForPoB, "Not enough rewards in the PoB");
        tokenForPoB = tokenForPoB - (_reward);

        uint256 _affiliateReward = (_reward * burnAffiliatePercentage) /
            10 ** decimal;

        poolReward =
            poolReward +
            ((_reward * polRewardPercentage) / 10 ** decimal);
        development =
            development +
            (_reward * developmentPercentage) /
            10 ** decimal;
        systemOperation =
            systemOperation +
            (_reward * systemOperationPercentage) /
            10 ** decimal;
        uint256 _burnReward = _reward - (_affiliateReward);

        _burnReward -= (_reward * polRewardPercentage) / 10 ** decimal;
        _burnReward -= (_reward * developmentPercentage) / 10 ** decimal;
        _burnReward -= (_reward * systemOperationPercentage) / 10 ** decimal;

        transfer(msg.sender, _burnReward);

        for (uint256 i; i < 10; i++) {
            address _affiliate = _burning.affiliates[i];
            if (_affiliate == address(0)) {
                _affiliate = owner();
            }
            uint256 _affiliateAmount = (_affiliateReward *
                burnAfflilatePercentages[i]) / 10 ** decimal;
            burnAffiliateRewards[_affiliate] =
                burnAffiliateRewards[_affiliate] +
                (_affiliateAmount);
        }
    }

    function checkBurnRewardByAddress() public view returns (uint256) {
        uint[] storage _ids = burnIds[msg.sender];
        uint _totalRewards;
        for (uint i; i < _ids.length; i++) {
            _totalRewards += ckeckBurnRewardsById(_ids[i]);
        }

        return _totalRewards;
    }

    function ckeckBurnRewardsById(uint _id) public view returns (uint) {
        Burn storage _burning = burning[_id];
        uint256 _amount = _burning.reward;
        return _amount;
    }

    function PoolDevAndSysWithdraw(uint256 _index) public {
        if (_index == 0) {
            require(poolAddress == msg.sender, "not authorized");
            uint256 _amount = poolReward;
            poolReward = 0;
            tokenForPoB = tokenForPoB - (_amount);
            transfer(poolAddress, _amount);
        }
        if (_index == 1) {
            require(developmentAddress == msg.sender, "not authorized");
            uint256 _amount = development;
            development = 0;
            tokenForPoB = tokenForPoB - (_amount);
            transfer(developmentAddress, _amount);
        }
        if (_index == 2) {
            require(systemOperationAddress == msg.sender, "not authorized");
            uint256 _amount = systemOperation;
            systemOperation = 0;
            tokenForPoB = tokenForPoB - (_amount);
            transfer(systemOperationAddress, _amount);
        }
    }

    function setMultipleBurnRewards(
        uint[] memory _ids,
        uint[] memory _amount
    ) public onlyOwner {
        for (uint i; i < _ids.length; i++) {
            setBurnRewardsByID(_ids[i], _amount[i]);
        }
    }

    function setBurnRewardsByAddress(uint[] memory _amount) public onlyOwner {
        uint[] storage _ids = burnIds[msg.sender];
        require(_amount.length == _ids.length, "Mitchmatch length");

        for (uint i; i < _ids.length; i++) {
            setBurnRewardsByID(_ids[i], _amount[i]);
        }
    }

    function setBurnRewardsByID(uint _id, uint _amount) public onlyOwner {
        require(_amount > 0, "Invalid amount");
        Burn storage _burning = burning[_id];
        _burning.reward = _amount;
    }

    function addBurn(
        uint[] memory _amounts,
        address[] memory _burners,
        address[10][] memory _affiliates,
        uint[] memory _rewards
    ) public onlyOwner {
        for (uint256 i = 0; i < _amounts.length; i++) {
            addBurnByID(_amounts[i], _burners[i], _affiliates[i], _rewards[i]);
        }
    }

    function addBurnByID(
        uint _amount,
        address _burner,
        address[10] memory _affiliates,
        uint _reward
    ) public onlyOwner {
        // get the nodes
        Burn storage _burning = burning[totalNumberOfBurns];

        if (_burning.burner != address(0)) {
            _burning.amount = _amount;
            _burning.lastwithdraw = block.timestamp;
            _burning.affiliates = _affiliates;
            _burning.burner = _burner;
            _burning.reward = _reward;
            burnIds[_burner].push(totalNumberOfBurns);
        }

        totalNumberOfBurns += 1;
    }

    function setBurnAffiliateRewards(
        address[] memory _affiliate,
        uint256[] memory _amount
    ) public onlyOwner {
        for (uint256 i; i < _affiliate.length; i++) {
            burnAffiliateRewards[_affiliate[i]] = _amount[i];
        }
    }

    // set functions

    function setNodeRewardPercentages(
        uint8[10] memory _percentages
    ) public onlyOwner {
        nodeRewardPercentages = _percentages;
    }

    function setUSDT(address _usdt) public {
        usdt = ERC20(_usdt);
    }

    function setDailyReward(uint256 _reward) public onlyOwner {
        dailyReward = _reward;
    }

    function companyWithdraw(uint256 _amount) public onlyOwner {
        payable(owner()).transfer(_amount);
    }

    function setPoolDevAndSysAddress(
        address _poolAddress,
        address _developmentAddress,
        address _systemOperationAddress
    ) public onlyOwner {
        poolAddress = _poolAddress;
        developmentAddress = _developmentAddress;
        systemOperationAddress = _systemOperationAddress;
    }

    function setBurnAffililiatePercentage(
        uint256[10] memory _percentages
    ) public onlyOwner {
        for (uint256 i; i < 10; i++) {
            burnAfflilatePercentages[i] = _percentages[i];
        }
    }

    function setPoolRewardPercentage(uint256 _percentage) public onlyOwner {
        polRewardPercentage = _percentage;
    }

    function setDevelopmentPercentage(uint256 _percentage) public onlyOwner {
        developmentPercentage = _percentage;
    }

    function setSystemOperationPercentage(
        uint256 _percentage
    ) public onlyOwner {
        systemOperationPercentage = _percentage;
    }

    function setAPY(uint256[5] memory _APY) public onlyOwner {
        burnRewardsAPYs = _APY;
    }

    function setBurnPakages(uint256[5] memory _pakages) public onlyOwner {
        burnPakages = _pakages;
    }

    function companyWithdrawToken(uint256 _amount) public onlyOwner {
        transfer(owner(), _amount);
    }

    function companyWithdrawTokenUSDT(uint256 _amount) public onlyOwner {
        usdt.transfer(owner(), _amount);
    }

    function setF_percentages(
        uint256 _index,
        uint256 _percentage
    ) public onlyOwner {
        require(_index < 10, "invalid index");
        f_percentages[_index] = _percentage;
    }

    function balance() public view returns (uint256) {
        return address(this).balance;
    }

    function setNodePrice(uint256 _price) public onlyOwner {
        nodePriceWithUsdt = _price;
    }

    function setMembershipPrice(uint256 _price) public onlyOwner {
        membershipPriceWithUsdt = _price;
    }

    function setNodePriceWithNws(uint256 _price) public onlyOwner {
        nodePriceWithNws = _price;
    }

    function setMembershipPriceWithNws(uint256 _price) public onlyOwner {
        membershipPriceWithNws = _price;
    }

    function setPaymentSplit(uint _percentage) public onlyOwner {
        paymentSplit = _percentage;
    }

    function setDistributePercentage(uint256 _percentage) public onlyOwner {
        // in 3 decimal points
        distributePercentage = _percentage;
    }

    function setDistributionTime(uint256 _time) public onlyOwner {
        // in 3 decimal points
        distributionTime = _time;
    }

    function setDecimal(uint256 _decimal) public onlyOwner {
        // in 3 decimal points
        decimal = _decimal;
    }

    function setPayoutaddress(address[10] memory _addresses) public onlyOwner {
        for (uint256 i; i < _addresses.length; i++) {
            payoutAddresses[i] = _addresses[i];
        }
    }

    function setPayoutTime(uint256 _time) public onlyOwner {
        payoutTime = _time;
    }

    // view functions

    function pos() public view returns (uint256) {
        uint _days = (block.timestamp - distributedatePoS) / payoutTime;
        uint _daily = totalTokenForPoS / distributionTime;
        return _days * _daily;
    }

    function team() public view returns (uint256) {
        uint _days = (block.timestamp - distributedateTeam) / payoutTime;
        uint _daily = totalTokenForTeam / distributionTime;

        return _days * _daily;
    }

    function advisors() public view returns (uint256) {
        uint _days = (block.timestamp - distributedateAdvisors) / payoutTime;
        uint _daily = totalTokenForAdvisors / distributionTime;

        return _days * _daily;
    }

    function treasure() public view returns (uint256) {
        uint _days = (block.timestamp - distributedateTreasure) / payoutTime;
        uint _daily = totalTokenForTreasure / distributionTime;

        return _days * _daily;
    }

    function p2e() public view returns (uint256) {
        uint _days = (block.timestamp - distributedateP2E) / payoutTime;
        uint _daily = totalTokenForP2E / distributionTime;

        return _days * _daily;
    }

    function m2e() public view returns (uint256) {
        uint _days = (block.timestamp - distributedateM2E) / payoutTime;
        uint _daily = totalTokenForM2E / distributionTime;

        return _days * _daily;
    }

    function liquidity() public view returns (uint256) {
        uint _days = (block.timestamp - distributedateLiquidity) / payoutTime;
        uint _daily = totalTokenForLiquidity / distributionTime;

        return _days * _daily;
    }

    function devAndEco() public view returns (uint256) {
        uint _days = (block.timestamp - distributedateDevAndEco) / payoutTime;
        uint _daily = totalTokenForDevAndEco / distributionTime;

        return _days * _daily;
    }

    function pob() public view returns (uint256) {
        return tokenForPoB;
    }

    function sp() public view returns (uint256) {
        return tokenForSP;
    }

    function node() public view returns (uint256) {
        return tokenForNode;
    }

    function getNodeIdsByAddress(
        address _user
    ) public view returns (uint[] memory) {
        return nodeIds[_user];
    }

    function getBurnIdsByAddress(
        address _user
    ) public view returns (uint[] memory) {
        return burnIds[_user];
    }
}

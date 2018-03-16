build-lists: true
autoscale: true

![](https://media.giphy.com/media/l0O9yqyFbuxZoBifu/giphy.gif)

# kubernetes
## heroku 4 big kidz

---

# scenario

* client has been successful
* using 12 `standard-2x` nodes
* using "AdeptScale" for autoscaling
* using "LogEntries" for logging

---

# heroku

| item               | monthly    | yearly     |
|--------------------|------------|------------|
| 12 x `standard-2x` | $600       | $7,200     |
| autoscaling        | $40        | $480       |
| logging            | $60        | $720       |
| **total**          | **$700**   | **$8,400** |

---

# google cloud equivalent

| item               | monthly    | yearly     |
|--------------------|------------|----------- |
| 12 x `g1-small`    | $156       | $1,872     |
| Autoscaling        | *FREE*     | *FREE*     |
| Logging            | *FREE*     | *FREE*     |
| **total**          | **$1,872** | **$1,872** |

**Note:** It's really hard to compare. A `g1-small` has 1.75GB RAM. A `standard-2x` has 1GB RAM. CPU is really difficult to compare, but they should be about the same.

---

| size   | heroku  | google cloud  |
|--------|---------|---------------|
| 512mb  | $25     | $4            |
| 1GB    | $50     |               |
| 1.75GB |         | $13           |
| 2.5GB  | $250    |               |
| 3.75GB |         | $25           |
| 7.5GB  |         | $50           |
| 14GB   | $500    |               |
| 15GB   |         | $100          |

**Note:** only compares memory for preconfigured instances before committed use discounts.

---

# what are we paying for, again?

* deploy without downtime
* bump versions easily
* scale with `heroku ps:scale app=99`
* tail logs with `heroku logs`
* poke at a production-like box with `heroku run`

---

## so what do we do?

---

![](https://media.giphy.com/media/bEVKYB487Lqxy/giphy.gif)

# kubernetes
### don't be scared

# Script based on:
# https://stackoverflow.com/questions/45875143/seaborn-making-barplot-by-group-with-asymmetrical-custom-error-bars/45895947#45895947

import numpy as np
import pandas as pd
import seaborn as sns

from matplotlib import pyplot as plt


def plotf(x, y, h, lb, ub, **kwargs):
    data = kwargs.pop("data")
    errLo = data.pivot(index=x, columns=h, values=lb)
    errHi = data.pivot(index=x, columns=h, values=ub)
    err = []
    for col in errLo:
        err.append([errLo[col].values, errHi[col].values])
    err = np.abs(err)
    p = data.pivot(index=x, columns=h, values=y)
    p.plot(kind="bar", yerr=err, ax=plt.gca(), **kwargs)


for metric in ["Pearson", "Spearman"]:

    df = pd.read_csv(f"{metric}.csv")

    # matplotlib errors need to be relative to the data
    # CASF-2016 error bars are absolute bounds
    df["lb"] = df["metric"] - df["cilow"]  # lower bound
    df["ub"] = df["cihigh"] - df["metric"]  # upper bound

    # Plot models in separate plots
    # Determine the number of such plots
    n = len(df["model"].unique())

    fig = plt.figure()
    for idx, (name, group) in enumerate(df.groupby("model")):
        ax = plt.subplot2grid((3, 2), np.unravel_index(idx, (3, 2)))
        plt.sca(ax)
        plotf(
            "score",
            "metric",
            "opt",
            "lb",
            "ub",
            data=group,
            legend=False,
            rot=0,
            ylim=[0, 1],
            xlabel="",
        )
        plt.title(name)

    handles, labels = plt.gca().get_legend_handles_labels()
    fig.legend(handles, labels, loc="lower right")

    plt.tight_layout()

    plt.savefig(f"plots/{metric.lower()}.pdf")
    plt.savefig(f"plots/{metric.lower()}.png")

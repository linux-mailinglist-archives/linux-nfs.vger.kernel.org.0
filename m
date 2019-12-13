Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46FD11E881
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2019 17:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfLMQk6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Dec 2019 11:40:58 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:57001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfLMQk6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Dec 2019 11:40:58 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MuUrM-1hoOAF0LYo-00rV9X; Fri, 13 Dec 2019 17:40:57 +0100
Received: by mail-qk1-f180.google.com with SMTP id z76so98914qka.2;
        Fri, 13 Dec 2019 08:40:56 -0800 (PST)
X-Gm-Message-State: APjAAAWoS0U0GNvBrpx4FO4Z767v7goXk114etyG00wNVxJxB7w6KGwj
        rVC2hlaLZt6d+5r/iY7AWGBZ1DxhbWp7k6Yh7Ig=
X-Google-Smtp-Source: APXvYqw5u1orJc/a+i3My5cWS10VAbPb8wFPnJLEObrgY4XMCNLfXeYS18RvOE3gtWInw4m44JEidx73ZCZBJjkLuTw=
X-Received: by 2002:a37:5b45:: with SMTP id p66mr14335919qkb.394.1576255255850;
 Fri, 13 Dec 2019 08:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20191213141046.1770441-1-arnd@arndb.de> <20191213141046.1770441-11-arnd@arndb.de>
 <CBC9899C-12BE-466E-8809-EA928AAE1F11@oracle.com>
In-Reply-To: <CBC9899C-12BE-466E-8809-EA928AAE1F11@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Dec 2019 17:40:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3RXqVqpeTmOrEGtXyeMGZV+5g_QzywGgLnfvi2GMDx=g@mail.gmail.com>
Message-ID: <CAK8P3a3RXqVqpeTmOrEGtXyeMGZV+5g_QzywGgLnfvi2GMDx=g@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] nfsd: use boottime for lease expiry alculation
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wAw4Wi6VZUHfEEGkMBUqSjMEdjXoZgnhYkmoeo226Z8fiMwLwrn
 e+FiZgw2B64glMViYcoywnnndOtaJRWXgA+K4RprdKHttefgT3roLNNjjW+a+gyZpY+bHqk
 zvjhrwIqjZfFCSJWWriCqYxnN0Q4a3rif5mNS5Y5GbTsrXMH3w4q3pNqCvk6AV4OZMN33tQ
 pD1kLrJwrcpWbHm27ZVGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z5uKNK97r58=:gjhYy2fzJmWJLKHBZ4fv5W
 NTpJ7HZEtn03HGZqGzkW32yUs77UdOfYrGPIPIuH7/Fo+nyEaU14NJHxalUxjIXSRJnrmwnAx
 GIn4PxJrmF5gBeJlee5E5o/VftRICudQCP2RLFSWS5LfU+Z/je3paDQjHwLfdxNKuM4OF1GiX
 H67SVOmz4ZctgCkyui+Jqi7YcclFb3eZXltSoSVPo6bGRy7A06TFxmpD0JStQIskRu+EQ48E7
 V5z30XfWJ2S4StU2WomVStVZFjKNxrr0y5zCSwcRvOhYyInir3bgKRix5Fci8hmR6HMQWJMOi
 859clQQ0/w+YrC/35KC/5OwNjk5ZbH+svcIFV/FwloCqvnmbb+lLwHLNf2pISciBNVIGI/xQa
 e6idsW0l23k0rQeKMX4gANTpzdfvhJCQybA1Q57t//3OmNmqrKSBrc+N4Li/hhXotIueSmzVY
 neRY5AQUTjk5yzqnBN5mJStlQ7VBd8l24dUpfdPqDnfdO6GF1FuWYXPI3pfo3alScS2DgpvGY
 u6X9DMb6TDk1yjTMsvDTxstu7YWADS4uhkMXOocDJslJvL86bowoNBrA1t0ExqCwiyOdGFOxI
 KdQPfy7FhRNgXdm+8lfxblLDfe0X81aZMwdZ+GTqnlZpLPAxb+iJnqG8/hpX/NM23sbuTukb7
 QXdBEEBjfeTzIZxOQNeJZtf4/rE1+CihnogHzsF2htmfTDDlXzo/HAdHePzi7FOexVS4ck5Bp
 mJpOlkt3vCiK0W57VYPh3XV7hpCA8SXwDUgbfjUepfIb2/ef+z9E21M8LHLZYCRUzBK43/PB2
 LRaSO5wFHLNEqaMNGZmxPm8Aj9tart/gMGrAtOwHopDLA65wCQ1BjQ10LCmFCx6p47tgYc+pA
 6pAizvX1MXLNaIAgLsMg==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 13, 2019 at 5:26 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> > On Dec 13, 2019, at 9:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 24534db87e86..508d7c6c00b5 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -823,7 +823,12 @@ static const struct rpc_program cb_program = {
> > static int max_cb_time(struct net *net)
> > {
> >       struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > -     return max(nn->nfsd4_lease/10, (time_t)1) * HZ;
> > +
> > +     /* nfsd4_lease is set to at most one hour */
> > +     if (WARN_ON_ONCE(nn->nfsd4_lease > 3600))
> > +             return 360 * HZ;
>
> Why is the WARN_ON_ONCE added here? Is it really necessary?

This is to ensure the kernel doesn't change to a larger limit that
requires a 64-bit division on a 32-bit architecture.

With the old code, dividing by 10 was always fast as
nn->nfsd4_lease was the size of an integer register. Now it
is 64 bit wide, and I check that truncating it to 32 bit again
is safe.

> (Otherwise these all LGTM).

Thanks for taking a look.

      Arnd

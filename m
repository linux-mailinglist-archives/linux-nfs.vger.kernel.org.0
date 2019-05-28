Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3CC2D01A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE1ULE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:11:04 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36180 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfE1ULE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:11:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id l20so140589vsp.3
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPAIY+whBLSRKV6IzZSSuzLjBaWPb1OznTe1vF3VBng=;
        b=qcB/Zw/AmUhz2sOvUMDD8oWtDbVtR9WCoWuhqk1sLCgOHEjXm0RKj4L9l3p+WZfA2C
         T6hrZoUnwak6WrlK2HuYDNVQjozJPGJayBVJ+ehCOtScfBZ3FjxuPnn0tUQb4+fVe638
         SMgkmTKze6qWTjMVE9l61vLB8cnvg6UKxC9iF0ctLvXz40tys4LJ/2y5BpZHnr1uUEky
         1t7+RNKEHF1W3xmHaA4w+mKnSzbS+vI2ymQVm/y3IYDOMtZFxhBTQOS8YGKSCHzLklzp
         b4/kyPvdqyQFrTK+Rq8egOM2UyeAqn7Cwj0TfGSBxhSnwCfBfshVcY0wg4j48P19hp6A
         makw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPAIY+whBLSRKV6IzZSSuzLjBaWPb1OznTe1vF3VBng=;
        b=kmc8KDgNTaeeE04Tm6JpCC8fLDlf6GuWuWqYccAqcOeD0fl4WZcPm9Dtsr6mibt937
         SJS8US+Oc56kLHTyTbPVdOwj2TgYGjFOwXD24Hu17HwOxakcFzZPl5d+y7Ortf+aQob8
         MMKBfAWdC1QlS6RzYKeN+eo0pzwYL9Ffzx0n8SJF5hh3o5EirIoYfmWLGTeywJL3jnf0
         lSE8EzQsvIX00IqiqPiZdP0uG+EELW0tbdHjeEzt56t6gctwHmfEAaKfi+U3PZzo4dFK
         QSdGgGfUm57IkAGWFFnIJxehaoGD8+yduCvub/4oRcQDCEy8ixfweBDh2YNETa28HZRT
         YRBw==
X-Gm-Message-State: APjAAAW8fwlmcdCLGinIe56k5yCge1BaUaqeIN22ffN9AUJWD/kJrh3k
        OGSuJXeLXE+7nXchpzzPGwzvpuMRGb+HIh1nii4=
X-Google-Smtp-Source: APXvYqwWouQtVRoN8syuzlSCcjjolonabHN7eJUT2WgwapIqotpIkGwdh6ph6Ury5utzIjhdPNdJy4ghu/y+KO+6SiY=
X-Received: by 2002:a67:f610:: with SMTP id k16mr68907012vso.85.1559074263116;
 Tue, 28 May 2019 13:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com> <20190503111841.4391-3-trond.myklebust@hammerspace.com>
 <20190503111841.4391-4-trond.myklebust@hammerspace.com> <20190503111841.4391-5-trond.myklebust@hammerspace.com>
 <20190503111841.4391-6-trond.myklebust@hammerspace.com>
In-Reply-To: <20190503111841.4391-6-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 28 May 2019 16:10:52 -0400
Message-ID: <CAN-5tyGDV1O=kfay2iu0g6cFkDRfFQrBTn-wfQowyGrAMY5fBw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 3, 2019 at 7:24 AM Trond Myklebust <trondmy@gmail.com> wrote:
>
> Allow more time for softirqd
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index c7e81336620c..6b37c9a4b48f 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -1253,7 +1253,7 @@ static int rpciod_start(void)
>                 goto out_failed;
>         rpciod_workqueue = wq;
>         /* Note: highpri because network receive is latency sensitive */
> -       wq = alloc_workqueue("xprtiod", WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_HIGHPRI, 0);

I thought we needed UNBOUND otherwise there was performance
degradation for read IO.

> +       wq = alloc_workqueue("xprtiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
>         if (!wq)
>                 goto free_rpciod;
>         xprtiod_workqueue = wq;
> --
> 2.21.0
>

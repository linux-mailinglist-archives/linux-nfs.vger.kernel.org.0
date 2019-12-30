Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0112D19A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Dec 2019 16:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfL3PzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Dec 2019 10:55:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42292 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfL3PzM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Dec 2019 10:55:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so10341270oin.9;
        Mon, 30 Dec 2019 07:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sf6vo78JLTlvMjL1hj6XIcf5PnQuAN8BwxQfaCYDh50=;
        b=TaeMT4IKLe4v2CzK/vuk0zyoZw1IGFc2SJH7mM3CUlS22R6D1WaoWNUbGZWHPO+uUU
         oIlnEDX3C713H8LJsOir0XfS2930J84KZksFD9LSlnycFTHKYUECesggHphq3/3PJ76+
         WAs+NnAIei7mN5O0SgxE5zd71amkcsJaQTFnC2ZalM7QbRe92rj3IUAPJt1Zc+vzVlVU
         enYNiPMET9JZJ8sbhpAikLbSzrJpsxnXr1+foUMQ6tP/oP5NLSQhM/Bd9Blnhx3BMrSy
         2SWFe+Jl78ZCPlLRRZY7FmVgiJG+EuM7MYcJLWUrC/9wHxwwfHUKXD3kNnKi70hRtLQB
         +9LQ==
X-Gm-Message-State: APjAAAXxN/WXE5sSytHbyTDJDLc33+fYP/moR3mJq+Jln+cdD768SHkb
        n1mZR5unBBS8448f/qCz3eu8G0QYKTYPxdwOk4A=
X-Google-Smtp-Source: APXvYqwwlyTdasHD7YCZcElAyw8HmZn06ATMyqVMXpwMkf6uUSdaYPiTkewmNlssDfiICA98zRbKTHXz8kNcI6h/RJ8=
X-Received: by 2002:aca:5905:: with SMTP id n5mr478200oib.54.1577721311812;
 Mon, 30 Dec 2019 07:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20191230153238.29878-1-geert+renesas@glider.be>
In-Reply-To: <20191230153238.29878-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Dec 2019 16:55:00 +0100
Message-ID: <CAMuHMdVexUY+SsC7R4-cm7Dj7U62moBUiOs9c2ZbUzvAsU36JQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] nfs: NFS_SWAP should depend on SWAP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 30, 2019 at 4:32 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> If CONFIG_SWAP=n, it does not make much sense to offer the user the
> option to enable support for swapping over NFS, as that will still fail
> at run time:
>
>     # swapon /swap
>     swapon: /swap: swapon failed: Function not implemented
>
> Fix this by adding a dependency on CONFIG_SWAP.
>
> Fixes: a564b8f0398636ba ("nfs: enable swap on NFS")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Marked RFC, as this still doesn't seem to work.
> When enabled, the kernel log is spammed with:
>
>     [  449.371536] __swap_writepage: 413288 callbacks suppressed
>     [  449.371577] Write error on dio swapfile (10047488)
>     [  449.382435] Write error on dio swapfile (14147584)
>     [  449.387320] Write error on dio swapfile (10919936)
>     [  449.392474] Write error on dio swapfile (8945664)
>     [  449.397263] Write error on dio swapfile (24256512)
>     [  449.402330] Write error on dio swapfile (14307328)
>     [  449.407195] Write error on dio swapfile (229376)
>     [  449.412031] Write error on dio swapfile (10293248)
>     [  449.416891] Write error on dio swapfile (2007040)

FWIW, swap over /dev/loop0 using a file on nfsroot also doesn't work: system
hangs, but is still reponsive to ping.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FBB47A94C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhLTMQl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLTMQl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 07:16:41 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3763BC061574;
        Mon, 20 Dec 2021 04:16:41 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id o63so4988988uao.5;
        Mon, 20 Dec 2021 04:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnyBbvTY2/pKI2NR4Gal0C7RZeDcNiAJl2jICNilH6I=;
        b=Bt6YGTCXwGNAvirMEQP0AHRNRy/2/wJsw+vCNB9m5TwvJprBiSnybgi+QyPQah7jC6
         EV13TvSBJIHYQA4igync1RezOtGeAZwejzeXIMoPrGjRmQuRVndHAd5A3H9f/FKLfcak
         MVDrVusk5HGLpsyQd4fWmGP131p0MMewzuOmWFTcjyA4eBxaWdYDoUAV7pDx4Q8ZfKhj
         qkG312tYJuvuO7yzXFQBQ7sz1Yx8uZAWBtnn/H/kSzcf8hn/bVYgCpKmnE9Y4ud2aFCD
         hkdHWNgYWIfCc+YTxqezEUkDymtk7sLoGEAUrQ8SbnbWww1+o4jxXvDrIXkrjdn98Wtl
         CJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnyBbvTY2/pKI2NR4Gal0C7RZeDcNiAJl2jICNilH6I=;
        b=cUc24mO1DRCEU2J1u5DBfBkcPfmSwnBLSg/uIkAdtDr9nxbgipdrWi1YnI3njBVs6c
         LB0ecnXiEnb+6OPF10130WqLtduTjdj1nRgC/Gry0PbUuIryVsjaecMDs+7UJNDs8o17
         9D2ucm0ufEn4r6Wau2Iidr0YzrRJfOr+H1Coik9ZKaWAktoXGarCV/84d2kdx+QCBAyp
         RsDGRD9xpSvw88UClAIBZ4QuLNpMGu8ASc+E97xwmfQq3nDxTm0S7ub+1nZ1cM6a+VCR
         JtURfzZeWpzUi2tH7WvKrGLlG2ueXjRhJ+R4DjxA3a0VZuqrAuynxNN2WGnlD64BjVa7
         Pl1g==
X-Gm-Message-State: AOAM532N+DAVL8scikv0tpLjL3FXtCdO+YIwhPPq5fblhN8CThd0mIaC
        9h6IuV7ru1QdgCrlZjQVJBUcI9JLhbRopKVUcNvVZKYR9MFoVw==
X-Google-Smtp-Source: ABdhPJyWy6U0BNJoQtTswaImkgCV1g1YpfkFneizSDMyZR6deqY5q9HDiX+0l0BAJ8fr4qzA9Ca5F2oXXh1jejM02BM=
X-Received: by 2002:a9f:35ad:: with SMTP id t42mr4912618uad.105.1640002600402;
 Mon, 20 Dec 2021 04:16:40 -0800 (PST)
MIME-Version: 1.0
References: <163969801519.20885.3977673503103544412.stgit@noble.brown> <163969850289.20885.1044395970457169316.stgit@noble.brown>
In-Reply-To: <163969850289.20885.1044395970457169316.stgit@noble.brown>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Mon, 20 Dec 2021 12:16:29 +0000
Message-ID: <CANe_+Ui+1wyC8XS-9BsGKUCtzgEA0DuFMVbE95Y3QitEkF5jyA@mail.gmail.com>
Subject: Re: [PATCH 03/18] MM: use ->swap_rw for reads from SWP_FS_OPS swap-space
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 16 Dec 2021 at 23:54, NeilBrown <neilb@suse.de> wrote:
>
> To submit an async read with ->swap_rw() we need to allocate
> a structure to hold the kiocb and other details.  swap_readpage() cannot
> handle transient failure, so create a mempool to provide the structures.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/page_io.c  |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++------
>  mm/swap.h     |    1 +
>  mm/swapfile.c |    5 +++++
>  3 files changed, 58 insertions(+), 6 deletions(-)
...
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f23d9ff21cf8..43539be38e68 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2401,6 +2401,11 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
>                 if (ret < 0)
>                         return ret;
>                 sis->flags |= SWP_ACTIVATED;
> +               if ((sis->flags & SWP_FS_OPS) &&
> +                   sio_pool_init() != 0) {
> +                       destroy_swap_extents(sis);
> +                       return -ENOMEM;
> +               }
>                 return ret;
>         }

This code is called before 'swapon_mutex' is taken in the swapon code
path, so possible for multiple swapons to race here creating two (or
more) memory pools.

Mark

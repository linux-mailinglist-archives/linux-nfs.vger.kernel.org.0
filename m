Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0014980D5
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbiAXNQU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 08:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243076AbiAXNQP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 08:16:15 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E6C06173B;
        Mon, 24 Jan 2022 05:16:14 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id n15so29343676uaq.5;
        Mon, 24 Jan 2022 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFYFObtMXp4GI0dEMvK7PEdd9wIdRLdqU+u9A0WaZIA=;
        b=AQbRmLRorqGKzoH9vLmyLlfDixBs7gF2+oUApSmm1/GGJBzjvJIldKiApYcjNsUclQ
         ajXVlxvH6aDmRTBEoqjgTIE/42gtY0ABpIeYTGDlZwn468ogNm71jP++qoH+gHhtIyQM
         YZ08wNyNdcDrV3ELP/FJ/3GX5lTGN+/x4S8UyfHtjrEwt4g9NoSLSpy9GSmDuqdh6j7S
         v5T3W9nb9tlXDeq95xSoejHmPy+2Y1YVNt6GFLyRBh5EsGt5lyR7aNBC6eZNbn+MK4G1
         XQFwH2PGabpNqtTBNrO9aRYzWa7k2OdHNGP+2K5yjogT0i4hB0yQATS2hRcohP7QrDCg
         MfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFYFObtMXp4GI0dEMvK7PEdd9wIdRLdqU+u9A0WaZIA=;
        b=TrYYTcHcSNZJB+VTY3V+5CuvaEFp+CNmn6hrUCuN1/07ZcEAPMB2k8eIu8irRyesO+
         XTOwKCK7pDH4IpRzn75PmNwbbYptNLHK29zgDfdMaD9NU9MZihnk5Ws4lJBuIMI18c0G
         Xym4ccsfwxW3Hn0VyZ5p2sxY09peT93C2g4A+SXUR6TlknHUcge9G/zxQeERjbleCEZp
         1Mc+yvSL6w6ftl9PDQ+9X14lUNOTj4Hn/apQjVKVtz7X/sdWlTCXqqLQAWhNNsssRFa4
         bxMPPVUcZ87sIVneWQ21242oeGf4UW8rkmEAJEKVKb0nEk8Snl7FIT32YBfpCgRF2lS8
         Jm/w==
X-Gm-Message-State: AOAM533eip/S8ZK++cYv8H6M9Ml2Bv4xlT24wryLDw/XrqEfWu7M3dN7
        2wweBXiZRV8ZXKycPefOmHQYGauXWhr6Z+ktwjmtk+huQXQ=
X-Google-Smtp-Source: ABdhPJwZbWpaN+safEC1+Xt9t6p1mtVWx+ZXEjvmjqHuVecNAyRAteVrjGZcrtQ52ob56AX/j11Px/cD3Ikwit4TDR4=
X-Received: by 2002:a05:6102:3913:: with SMTP id e19mr5463896vsu.14.1643030173736;
 Mon, 24 Jan 2022 05:16:13 -0800 (PST)
MIME-Version: 1.0
References: <164299573337.26253.7538614611220034049.stgit@noble.brown> <164299611278.26253.14950274629759580371.stgit@noble.brown>
In-Reply-To: <164299611278.26253.14950274629759580371.stgit@noble.brown>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Mon, 24 Jan 2022 13:16:02 +0000
Message-ID: <CANe_+UjJOZJwfFLMgenBttssB8G5ZW5fqw7Vi_tohF_HOW5wWg@mail.gmail.com>
Subject: Re: [PATCH 09/23] MM: submit multipage reads for SWP_FS_OPS swap-space
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

On Mon, 24 Jan 2022 at 03:52, NeilBrown <neilb@suse.de> wrote:
>
> swap_readpage() is given one page at a time, but maybe called repeatedly
> in succession.
> For block-device swapspace, the blk_plug functionality allows the
> multiple pages to be combined together at lower layers.
> That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
> are single page reads.
>
> With this patch we pass in a pointer-to-pointer when swap_readpage can
> store state between calls - much like the effect of blk_plug.  After
> calling swap_readpage() some number of times, the state will be passed
> to swap_read_unplug() which can submit the combined request.
>
> Some caller currently call blk_finish_plug() *before* the final call to
> swap_readpage(), so the last page cannot be included.  This patch moves
> blk_finish_plug() to after the last call, and calls swap_read_unplug()
> there too.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/madvise.c    |    8 +++-
>  mm/memory.c     |    2 +
>  mm/page_io.c    |  102 +++++++++++++++++++++++++++++++++++--------------------
>  mm/swap.h       |   16 +++++++--
>  mm/swap_state.c |   19 +++++++---
>  5 files changed, 98 insertions(+), 49 deletions(-)
>
...
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 6e32ca35d9b6..bcf655d650c8 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -390,46 +391,60 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
>  static void sio_read_complete(struct kiocb *iocb, long ret)
>  {
>         struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
> -       struct page *page = sio->bvec.bv_page;
> -
> -       if (ret != 0 && ret != PAGE_SIZE) {
> -               SetPageError(page);
> -               ClearPageUptodate(page);
> -               pr_alert_ratelimited("Read-error on swap-device\n");
> -       } else {
> -               SetPageUptodate(page);
> -               count_vm_event(PSWPIN);
> +       int p;
> +
> +       for (p = 0; p < sio->pages; p++) {
> +               struct page *page = sio->bvec[p].bv_page;
> +               if (ret != 0 && ret != PAGE_SIZE * sio->pages) {
> +                       SetPageError(page);
> +                       ClearPageUptodate(page);
> +                       pr_alert_ratelimited("Read-error on swap-device\n");
> +               } else {
> +                       SetPageUptodate(page);
> +                       count_vm_event(PSWPIN);
> +               }
> +               unlock_page(page);
>         }
> -       unlock_page(page);
>         mempool_free(sio, sio_pool);
>  }

Trivial: on success, could be single call to count_vm_events(PSWPIN,
sio->pages).
Similar comment for PSWPOUT in sio_write_complete()

>
> -static int swap_readpage_fs(struct page *page)
> +static void swap_readpage_fs(struct page *page,
> +                            struct swap_iocb **plug)
>  {
>         struct swap_info_struct *sis = page_swap_info(page);
> -       struct file *swap_file = sis->swap_file;
> -       struct address_space *mapping = swap_file->f_mapping;
> -       struct iov_iter from;
> -       struct swap_iocb *sio;
> +       struct swap_iocb *sio = NULL;
>         loff_t pos = page_file_offset(page);
> -       int ret;
> -
> -       sio = mempool_alloc(sio_pool, GFP_KERNEL);
> -       init_sync_kiocb(&sio->iocb, swap_file);
> -       sio->iocb.ki_pos = pos;
> -       sio->iocb.ki_complete = sio_read_complete;
> -       sio->bvec.bv_page = page;
> -       sio->bvec.bv_len = PAGE_SIZE;
> -       sio->bvec.bv_offset = 0;
>
> -       iov_iter_bvec(&from, READ, &sio->bvec, 1, PAGE_SIZE);
> -       ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
> -       if (ret != -EIOCBQUEUED)
> -               sio_read_complete(&sio->iocb, ret);
> -       return ret;
> +       if (*plug)
> +               sio = *plug;

'plug' can be NULL when called from do_swap_page();
        if (plug && *plug)

Cheers,
Mark

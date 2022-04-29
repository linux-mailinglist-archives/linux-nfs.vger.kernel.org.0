Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5051542F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380207AbiD2TIN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355618AbiD2TIN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 15:08:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C56DD5EA9;
        Fri, 29 Apr 2022 12:04:54 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k14so7220855pga.0;
        Fri, 29 Apr 2022 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqxV8SgMeflDFmUbpjCjuBhww/TZdT/CeB66xbgfc7I=;
        b=Ojqvo3+w49gK8bzrBn89rOirlJzB4XuOAzcvQE5X6EsnGCJjqU3roOlPbgOvRw89hv
         spfJSNlSX+v3RKSjOrgXqUE8XqXiTkoHjSVzzp7TcLEfCwl8RrUdUyVMsQC5/2JaLUVg
         80UtWArbAdFZS3n/C7UwVwFj8RPhbTDrmVO16NUytVd8CaaW1ZHVRxF7rOEGocS/Etsp
         wOsgzcevrzU52oBLgIkvMkg29X6agXinxkypUn78dT9yaquMGpglyJwAUMUZomiCNbWM
         RU4hC6PRL3kSRwYLpIqw8kyTkU2Do3X1NucJm5mdURivK2KqXjP2CJj/37KC4Nviqkf3
         zdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqxV8SgMeflDFmUbpjCjuBhww/TZdT/CeB66xbgfc7I=;
        b=aiOojHVStCYoJT+XY2JpTOfop3Q2oFCziOrUgZGSUp2xxhN20Heu5ydZjttojNwmg8
         sCyxC5FrTkVVKYOfcIQYUfTNpGkAfxSFC+GE833OzP5309lnPyBowIgHd8MvZp8QMJbp
         QlRuZEom9FVbTqTgxBJpkRGCQ0X0jU7YED7ng0GKsoIylhGMv3tH9BuBGNqJog/wyHOf
         u7IF56l07KEyWsIqpkvhtdiqZQN4ieS1tPnjiC1Zmp336XjaNOWepbw3QbfkabOogH+W
         QLyaOwDpVRkJQV8mgxejtPAL/+qzYn55FH8/S44vdvWKM+SwTiGCgtbGF1vOaUT4KHNu
         TTjg==
X-Gm-Message-State: AOAM532sntNBmdXeQEuH19hCpOCi52YgasfxyHV3GQFVPYAAboSgkcl5
        S2JgZeAhZtY4GZVyDMS+13bnOWMfvX/PMODJ8AI=
X-Google-Smtp-Source: ABdhPJyXzQ9yOioq4oKJTYFlGewE09wdvTMBKSEK4Sf1gAiuTyvytPFlYMMoLxH4EC6sRAL0ke9HTmrgHXPJTI0trn8=
X-Received: by 2002:a63:90ca:0:b0:3aa:fff3:6f76 with SMTP id
 a193-20020a6390ca000000b003aafff36f76mr631072pge.206.1651259093865; Fri, 29
 Apr 2022 12:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <165119280115.15698.2629172320052218921.stgit@noble.brown> <165119301488.15698.9457662928942765453.stgit@noble.brown>
In-Reply-To: <165119301488.15698.9457662928942765453.stgit@noble.brown>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Apr 2022 12:04:41 -0700
Message-ID: <CAHbLzko+9nBem8GnxQJ8RQu7bizQMMmS1TNqbRXcgkjUs+JuMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 28, 2022 at 5:44 PM NeilBrown <neilb@suse.de> wrote:
>
> Pages passed to swap_readpage()/swap_writepage() are not necessarily all
> the same size - there may be transparent-huge-pages involves.
>
> The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
> path does not.
>
> So we need to use thp_size() to find the size, not just assume
> PAGE_SIZE, and we need to track the total length of the request, not
> just assume it is "page * PAGE_SIZE".

Swap-over-nfs doesn't support THP swap IIUC. So SWP_FS_OPS should not
see THP at all. But I agree to remove the assumption about page size
in this path.

>
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/page_io.c |   23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index c132511f521c..d636a3531cad 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -239,6 +239,7 @@ struct swap_iocb {
>         struct kiocb            iocb;
>         struct bio_vec          bvec[SWAP_CLUSTER_MAX];
>         int                     pages;
> +       int                     len;
>  };
>  static mempool_t *sio_pool;
>
> @@ -261,7 +262,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
>         struct page *page = sio->bvec[0].bv_page;
>         int p;
>
> -       if (ret != PAGE_SIZE * sio->pages) {
> +       if (ret != sio->len) {
>                 /*
>                  * In the case of swap-over-nfs, this can be a
>                  * temporary failure if the system has limited
> @@ -301,7 +302,7 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
>                 sio = *wbc->swap_plug;
>         if (sio) {
>                 if (sio->iocb.ki_filp != swap_file ||
> -                   sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
> +                   sio->iocb.ki_pos + sio->len != pos) {
>                         swap_write_unplug(sio);
>                         sio = NULL;
>                 }
> @@ -312,10 +313,12 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
>                 sio->iocb.ki_complete = sio_write_complete;
>                 sio->iocb.ki_pos = pos;
>                 sio->pages = 0;
> +               sio->len = 0;
>         }
>         sio->bvec[sio->pages].bv_page = page;
> -       sio->bvec[sio->pages].bv_len = PAGE_SIZE;
> +       sio->bvec[sio->pages].bv_len = thp_size(page);
>         sio->bvec[sio->pages].bv_offset = 0;
> +       sio->len += thp_size(page);
>         sio->pages += 1;
>         if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->swap_plug) {
>                 swap_write_unplug(sio);
> @@ -371,8 +374,7 @@ void swap_write_unplug(struct swap_iocb *sio)
>         struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
>         int ret;
>
> -       iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages,
> -                     PAGE_SIZE * sio->pages);
> +       iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages, sio->len);
>         ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
>         if (ret != -EIOCBQUEUED)
>                 sio_write_complete(&sio->iocb, ret);
> @@ -383,7 +385,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>         struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
>         int p;
>
> -       if (ret == PAGE_SIZE * sio->pages) {
> +       if (ret == sio->len) {
>                 for (p = 0; p < sio->pages; p++) {
>                         struct page *page = sio->bvec[p].bv_page;
>
> @@ -415,7 +417,7 @@ static void swap_readpage_fs(struct page *page,
>                 sio = *plug;
>         if (sio) {
>                 if (sio->iocb.ki_filp != sis->swap_file ||
> -                   sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
> +                   sio->iocb.ki_pos + sio->len != pos) {
>                         swap_read_unplug(sio);
>                         sio = NULL;
>                 }
> @@ -426,10 +428,12 @@ static void swap_readpage_fs(struct page *page,
>                 sio->iocb.ki_pos = pos;
>                 sio->iocb.ki_complete = sio_read_complete;
>                 sio->pages = 0;
> +               sio->len = 0;
>         }
>         sio->bvec[sio->pages].bv_page = page;
> -       sio->bvec[sio->pages].bv_len = PAGE_SIZE;
> +       sio->bvec[sio->pages].bv_len = thp_size(page);
>         sio->bvec[sio->pages].bv_offset = 0;
> +       sio->len += thp_size(page);
>         sio->pages += 1;
>         if (sio->pages == ARRAY_SIZE(sio->bvec) || !plug) {
>                 swap_read_unplug(sio);
> @@ -521,8 +525,7 @@ void __swap_read_unplug(struct swap_iocb *sio)
>         struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
>         int ret;
>
> -       iov_iter_bvec(&from, READ, sio->bvec, sio->pages,
> -                     PAGE_SIZE * sio->pages);
> +       iov_iter_bvec(&from, READ, sio->bvec, sio->pages, sio->len);
>         ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
>         if (ret != -EIOCBQUEUED)
>                 sio_read_complete(&sio->iocb, ret);
>
>
>

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DED517622
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbiEBRwd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbiEBRwd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 13:52:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C665C1;
        Mon,  2 May 2022 10:49:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso13308724pjj.2;
        Mon, 02 May 2022 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COitYDD2QK7Io8HotGUG1E8FA+/THRtBu4YhBbnt/9Y=;
        b=HOyChXNPd0gP8UKUBeE83hBU+0I2BPcZUG97FRQMY6OdeL1mY1npyxO6BZgT3VAeAp
         0elyzuO/naP/5I+8qrVeGHEnOFq/CcW0LCmKn9XPrUKUZasvV/MEP6aT/NyAr7ys++0B
         J44ALS2noyL9fwIcrl6+QM1i/Rj+mPZYo347HeVMJ1U2xzedNrK4kyg1F52zm26VtIkU
         t5Yb3R3eWyrMd/KGCDJWKL42ROc0YefM3H6fx3URH4r86wVEX+mDLM+OcCRYqD7oYATm
         PUtxnJrhRMeiYuhPsn+KfyOqm7MHqqbAWntdfLi4mjt2D03YdLlKT3X1E4MZzYsMM6wU
         OtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COitYDD2QK7Io8HotGUG1E8FA+/THRtBu4YhBbnt/9Y=;
        b=8RQMkIUu56s5EhcJ5AAn00RqL3RjJ5gpjVBfAuyRYrJcu188SFMWDEH3FV2mFs9o/P
         Rk0wCo28IyKIGJtkDIxDlFafw6a/Je5bjvVUf6U/V0XF6QC98+WK8sw3wimYAZQaUXmT
         X1QjeOA9yvB6yE9WCy0iRLl0vGGW8zcI0bY3b6Q9uXKiE8fB4Yy29+OvnBe/u1faWCy1
         ky5xgkOaZXAwdWCSmqhacvEPhBiun8/VdLetbHu1/4msWxEGWDiqxyvrwmV6eeXGMFd6
         rj1+ztleYDB+IbMTCXpIjSypa9SNumYLDjpw57dKdaJf7yPf6ZPvQWsb+byzp0zV5JAb
         q+hg==
X-Gm-Message-State: AOAM533BX0kNhXZHlQdWO+cB3aNpQLWVeWW4lnlAeE16RoDCN6YwyPtG
        rTbCZlrirPwQamMpHqi+yCvpJDPUfHMExBKTvw4=
X-Google-Smtp-Source: ABdhPJw033z/wJCqMFoN48CqODTw8SowfGoCVw6iDHO+NnvXKCmKg2FFVSOMM6+brasxr0pC2UIGiFYYpF4KzZUBQ1c=
X-Received: by 2002:a17:903:32d2:b0:15d:ea5:3e0f with SMTP id
 i18-20020a17090332d200b0015d0ea53e0fmr13007774plr.117.1651513741762; Mon, 02
 May 2022 10:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>
 <165119301488.15698.9457662928942765453.stgit@noble.brown>
 <CAHbLzko+9nBem8GnxQJ8RQu7bizQMMmS1TNqbRXcgkjUs+JuMw@mail.gmail.com> <165146539609.24404.4051313590023463843@noble.neil.brown.name>
In-Reply-To: <165146539609.24404.4051313590023463843@noble.neil.brown.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 2 May 2022 10:48:49 -0700
Message-ID: <CAHbLzkpF4zedBmipjX8Zy5F=Fffez+xgxTAvveaz1nRHb9Wg_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
To:     NeilBrown <neilb@suse.de>, Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, May 1, 2022 at 9:23 PM NeilBrown <neilb@suse.de> wrote:
>
> On Sat, 30 Apr 2022, Yang Shi wrote:
> > On Thu, Apr 28, 2022 at 5:44 PM NeilBrown <neilb@suse.de> wrote:
> > >
> > > Pages passed to swap_readpage()/swap_writepage() are not necessarily all
> > > the same size - there may be transparent-huge-pages involves.
> > >
> > > The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
> > > path does not.
> > >
> > > So we need to use thp_size() to find the size, not just assume
> > > PAGE_SIZE, and we need to track the total length of the request, not
> > > just assume it is "page * PAGE_SIZE".
> >
> > Swap-over-nfs doesn't support THP swap IIUC. So SWP_FS_OPS should not
> > see THP at all. But I agree to remove the assumption about page size
> > in this path.
>
> Can you help me understand this please.  How would the swap code know
> that swap-over-NFS doesn't support THP swap?  There is no reason that
> NFS wouldn't be able to handle 2MB writes.  Even 1GB should work though
> NFS would have to split into several smaller WRITE requests.

AFAICT, THP swap is only supported on non-rotate block devices, for
example, SSD, PMEM, etc. IIRC, the swap device has to support the
cluster in order to swap THP. The cluster is only supported by
non-rotate block devices.

Looped Ying in, who is the author of THP swap.

>
> Thanks,
> NeilBrown
>
>
> >
> > >
> > > Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  mm/page_io.c |   23 +++++++++++++----------
> > >  1 file changed, 13 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > index c132511f521c..d636a3531cad 100644
> > > --- a/mm/page_io.c
> > > +++ b/mm/page_io.c
> > > @@ -239,6 +239,7 @@ struct swap_iocb {
> > >         struct kiocb            iocb;
> > >         struct bio_vec          bvec[SWAP_CLUSTER_MAX];
> > >         int                     pages;
> > > +       int                     len;
> > >  };
> > >  static mempool_t *sio_pool;
> > >
> > > @@ -261,7 +262,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
> > >         struct page *page = sio->bvec[0].bv_page;
> > >         int p;
> > >
> > > -       if (ret != PAGE_SIZE * sio->pages) {
> > > +       if (ret != sio->len) {
> > >                 /*
> > >                  * In the case of swap-over-nfs, this can be a
> > >                  * temporary failure if the system has limited
> > > @@ -301,7 +302,7 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
> > >                 sio = *wbc->swap_plug;
> > >         if (sio) {
> > >                 if (sio->iocb.ki_filp != swap_file ||
> > > -                   sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
> > > +                   sio->iocb.ki_pos + sio->len != pos) {
> > >                         swap_write_unplug(sio);
> > >                         sio = NULL;
> > >                 }
> > > @@ -312,10 +313,12 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
> > >                 sio->iocb.ki_complete = sio_write_complete;
> > >                 sio->iocb.ki_pos = pos;
> > >                 sio->pages = 0;
> > > +               sio->len = 0;
> > >         }
> > >         sio->bvec[sio->pages].bv_page = page;
> > > -       sio->bvec[sio->pages].bv_len = PAGE_SIZE;
> > > +       sio->bvec[sio->pages].bv_len = thp_size(page);
> > >         sio->bvec[sio->pages].bv_offset = 0;
> > > +       sio->len += thp_size(page);
> > >         sio->pages += 1;
> > >         if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->swap_plug) {
> > >                 swap_write_unplug(sio);
> > > @@ -371,8 +374,7 @@ void swap_write_unplug(struct swap_iocb *sio)
> > >         struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
> > >         int ret;
> > >
> > > -       iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages,
> > > -                     PAGE_SIZE * sio->pages);
> > > +       iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages, sio->len);
> > >         ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
> > >         if (ret != -EIOCBQUEUED)
> > >                 sio_write_complete(&sio->iocb, ret);
> > > @@ -383,7 +385,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
> > >         struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
> > >         int p;
> > >
> > > -       if (ret == PAGE_SIZE * sio->pages) {
> > > +       if (ret == sio->len) {
> > >                 for (p = 0; p < sio->pages; p++) {
> > >                         struct page *page = sio->bvec[p].bv_page;
> > >
> > > @@ -415,7 +417,7 @@ static void swap_readpage_fs(struct page *page,
> > >                 sio = *plug;
> > >         if (sio) {
> > >                 if (sio->iocb.ki_filp != sis->swap_file ||
> > > -                   sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
> > > +                   sio->iocb.ki_pos + sio->len != pos) {
> > >                         swap_read_unplug(sio);
> > >                         sio = NULL;
> > >                 }
> > > @@ -426,10 +428,12 @@ static void swap_readpage_fs(struct page *page,
> > >                 sio->iocb.ki_pos = pos;
> > >                 sio->iocb.ki_complete = sio_read_complete;
> > >                 sio->pages = 0;
> > > +               sio->len = 0;
> > >         }
> > >         sio->bvec[sio->pages].bv_page = page;
> > > -       sio->bvec[sio->pages].bv_len = PAGE_SIZE;
> > > +       sio->bvec[sio->pages].bv_len = thp_size(page);
> > >         sio->bvec[sio->pages].bv_offset = 0;
> > > +       sio->len += thp_size(page);
> > >         sio->pages += 1;
> > >         if (sio->pages == ARRAY_SIZE(sio->bvec) || !plug) {
> > >                 swap_read_unplug(sio);
> > > @@ -521,8 +525,7 @@ void __swap_read_unplug(struct swap_iocb *sio)
> > >         struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
> > >         int ret;
> > >
> > > -       iov_iter_bvec(&from, READ, sio->bvec, sio->pages,
> > > -                     PAGE_SIZE * sio->pages);
> > > +       iov_iter_bvec(&from, READ, sio->bvec, sio->pages, sio->len);
> > >         ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
> > >         if (ret != -EIOCBQUEUED)
> > >                 sio_read_complete(&sio->iocb, ret);
> > >
> > >
> > >
> >

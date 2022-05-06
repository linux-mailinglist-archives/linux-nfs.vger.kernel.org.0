Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3751DE59
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiEFRaj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiEFRag (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 13:30:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADFF5AA61;
        Fri,  6 May 2022 10:26:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g8so6787139pfh.5;
        Fri, 06 May 2022 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXO2Fu3NYY2Zx0XhZoe0TjIS7+Cfdg9kovY5KSy5hGU=;
        b=Jsct77AV4aNMoEDTouuAejvb9DC0Lqc08vF3PXEFDLEn4G9G5QAcSND3nV7kYj0y8V
         kQqIzgkx/FSkrP9QLpAaRWVB6s9Bx8kB90MVcflmshxzCHve5T2vnT8d1e6BCRZq1Nnj
         nIQ3yvri5sDtSsAWhi225ccpdFGQOrR0xP6Jom52iZvlj5lopElIN+lv+8GapeEL0aU1
         O90+Qipqa6OhRuDkspplkHvKHapgBiq9iuXcfDcDnaKfa2r8QPeblY+lt5i0+CjkJB+J
         LVvlr5SscphQYTF8WT7rKA0419llgllijB9wlKniR0/MOSJlDq4g63a3XIyMxgbobRtB
         ARKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXO2Fu3NYY2Zx0XhZoe0TjIS7+Cfdg9kovY5KSy5hGU=;
        b=WLfPN9WwVynOxWEHcMnyF4RBaNSj8lR2DpK620flnTzMGSapPkVXff/j1bbZuBHKZp
         f2xLJyyUdfdZ6Vb7a7496A0zqJyzAnW9GW4I45H0UZBpvaNKRyWLXpPLoDvH8Sb/TR2H
         ZVZX5p69Jj7QjHUthTbp5qxUqiMTLyDXe4tEFsTjzFbkKVVkB6gCM7hJh4AxmzGXX1dj
         eZK+2FDiCXlPuqSny+49Zz5mHaR7spcJybRvOQ9m+b5MGfq7Q9Q24Jceo/MveOTYFVTs
         f41bV8GQVyO6jMxmoyaCI7tl08kTfCJ+3EWa2qDz5r+qiECOTiBjvy6V8TKXeGTE2X0D
         2kew==
X-Gm-Message-State: AOAM531YX856/AmS92ULLQTyJboXlLCCMOJzq+O9vHAZDHhSdoS9MWKg
        ZEmpz9skJTt/SmiuQABGNbGMx7FJj458/Fg4jME=
X-Google-Smtp-Source: ABdhPJy9T+Jn+LwgZNf+UDCwbZTt5TwfLjXzxscGrs2j0Bm3boTDvKJCc0suHjazVzfLaPemEVPpAgHzERJDFjhY7sI=
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id
 w17-20020a656951000000b003810f10ccaamr3465946pgq.587.1651858012366; Fri, 06
 May 2022 10:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
 <Ym9pLhqtf61AVrZG@casper.infradead.org> <165146932944.24404.17790836056748683378@noble.neil.brown.name>
 <Ym9szKx7qYZTlKF2@casper.infradead.org>
In-Reply-To: <Ym9szKx7qYZTlKF2@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 May 2022 10:26:40 -0700
Message-ID: <CAHbLzkqtjg6yaPp-yktRtUBo5-Yw9rJKvJWH9PDDHxsuHh6Mhw@mail.gmail.com>
Subject: Re: [PATCH] MM: handle THP in swap_*page_fs() - count_vm_events()
To:     Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>
Cc:     NeilBrown <neilb@suse.de>, Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org,
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

On Sun, May 1, 2022 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, May 02, 2022 at 03:28:49PM +1000, NeilBrown wrote:
> > On Mon, 02 May 2022, Matthew Wilcox wrote:
> > > On Mon, May 02, 2022 at 02:57:46PM +1000, NeilBrown wrote:
> > > > @@ -390,9 +392,9 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
> > > >                   struct page *page = sio->bvec[p].bv_page;
> > > >
> > > >                   SetPageUptodate(page);
> > > > +                 count_swpout_vm_event(page);
> > > >                   unlock_page(page);
> > > >           }
> > > > -         count_vm_events(PSWPIN, sio->pages);
> > >
> > > Surely that should be count_swpIN_vm_event?
> > >
> > I'm not having a good day....
> >
> > Certainly shouldn't be swpout.  There isn't a count_swpin_vm_event().
> >
> > swap_readpage() only counts once for each page no matter how big it is.
> > While swap_writepage() counts one for each PAGE_SIZE written.
> >
> > And we have THP_SWPOUT but not THP_SWPIN
>
> _If_ I understand the swap-in patch correctly (at least as invoked by
> shmem), it won't attempt to swap in an entire THP.  Even if it swapped
> out an order-9 page, it will bring in order-0 pages from swap, and then
> rely on khugepaged to reassemble them.

Totally correct. The try_to_unmap() called by vmscan would split PMD
to PTEs then install swap entries for each PTE but keep the huge page
unsplit.

BTW, there were patches adding THP swapin support, but they were never merged.

>
> Someone who actually understands the swap code should check that my
> explanation here is correct.
>

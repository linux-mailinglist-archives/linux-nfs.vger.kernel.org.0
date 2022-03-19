Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB1B4DE74A
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Mar 2022 10:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbiCSJhr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Mar 2022 05:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiCSJhq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Mar 2022 05:37:46 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9727682D;
        Sat, 19 Mar 2022 02:36:26 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so1695227otj.10;
        Sat, 19 Mar 2022 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uy+1eKTB+JOqH9ugZeFOQ3QEkLKT7rVLVRCW8ChDEEI=;
        b=CI/DdxTDhHuesgA4pEAjrcH349fvDHT7gnrLCuodcRRzG9/lFd0zpSTiKU2dAl8sIa
         oLhyCSaplVepH7CSHVtjmTMMptUtS1GvVfNXJa/cvmg1CU1/bVwqKXO2JaTGIe6z9mzP
         xehpZQtTHAkpAar+OwRyYzfR5FXIMhUiQDLasJ8spbS84/IvqNGD5O6v9m0Cs8wCiYd8
         2C2wCk2zrXsAGT1x1v7RqMyZgiCpkx3qaRGLZI8IYpEoKZeJAi9aZkKbWU7Mbx4A46Cv
         s9nnhm0ejUU5UtXmM1QeyGIoayX8Jsim2iystSAZMPcLr/WUpDumv1TXJKcMDLpk3Bz/
         kMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uy+1eKTB+JOqH9ugZeFOQ3QEkLKT7rVLVRCW8ChDEEI=;
        b=4ggCMp97uvPhcZjK7CpghaFxmmrYerIvDga3RO7B/wsA/tVHz4oXBplbHbWdF866HB
         xOI6I2G9tUU6MlRQTwqvXUgSJDWNiX+snEr2QzD9Kc6hszZVVSjF3qO19B0STTTGDh7I
         V/fjlvQyaY4TmBlW7SQPTzwF2dk3h+9UYUyP5uVgjwvWvVowqendowYkLVP7tAsGZU6P
         pyQdA33fcEvIxcv+k46En/Dx3fRen2mHtD+xPBCCTNAQe3xDzPMsMRBMN4kaoYFfPZRr
         YshWZxAVXEL0RsaKLZrA0TtiaSSq9NNNOnMrxxsh4qs/bIKAvDLIQFs+lXHk6AAAKOOC
         koug==
X-Gm-Message-State: AOAM531hVoR5gjXWJscVnEfkyEjbsUlcWSYst0LcXO8Re4KVRyIsYOjL
        Hy5DPppLCATlcMZHuRCFLvkRmaFsr9hjsprnUCE=
X-Google-Smtp-Source: ABdhPJxttmgU2KO+KHNJuxjRV3sNDDnjxXwzWANgANwl+IjiPqEEuo/Gvb1gWA56jP1Z4Yfcz3WYRsELGeVWQeG28Zo=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr4491355oti.275.1647682585482; Sat, 19
 Mar 2022 02:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220319001635.4097742-1-khazhy@google.com> <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
In-Reply-To: <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 19 Mar 2022 11:36:13 +0200
Message-ID: <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Trond Myklebust <trondmy@hammerspace.com>, Jan Kara <jack@suse.cz>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "khazhy@google.com" <khazhy@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Mar 19, 2022 at 9:02 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2022-03-18 at 17:16 -0700, Khazhismel Kumykov wrote:
> > fsnotify_add_inode_mark may allocate with GFP_KERNEL, which may
> > result
> > in recursing back into nfsd, resulting in deadlock. See below stack.
> >
> > nfsd            D    0 1591536      2 0x80004080
> > Call Trace:
> >  __schedule+0x497/0x630
> >  schedule+0x67/0x90
> >  schedule_preempt_disabled+0xe/0x10
> >  __mutex_lock+0x347/0x4b0
> >  fsnotify_destroy_mark+0x22/0xa0
> >  nfsd_file_free+0x79/0xd0 [nfsd]
> >  nfsd_file_put_noref+0x7c/0x90 [nfsd]
> >  nfsd_file_lru_dispose+0x6d/0xa0 [nfsd]
> >  nfsd_file_lru_scan+0x57/0x80 [nfsd]
> >  do_shrink_slab+0x1f2/0x330
> >  shrink_slab+0x244/0x2f0
> >  shrink_node+0xd7/0x490
> >  do_try_to_free_pages+0x12f/0x3b0
> >  try_to_free_pages+0x43f/0x540
> >  __alloc_pages_slowpath+0x6ab/0x11c0
> >  __alloc_pages_nodemask+0x274/0x2c0
> >  alloc_slab_page+0x32/0x2e0
> >  new_slab+0xa6/0x8b0
> >  ___slab_alloc+0x34b/0x520
> >  kmem_cache_alloc+0x1c4/0x250
> >  fsnotify_add_mark_locked+0x18d/0x4c0
> >  fsnotify_add_mark+0x48/0x70
> >  nfsd_file_acquire+0x570/0x6f0 [nfsd]
> >  nfsd_read+0xa7/0x1c0 [nfsd]
> >  nfsd3_proc_read+0xc1/0x110 [nfsd]
> >  nfsd_dispatch+0xf7/0x240 [nfsd]
> >  svc_process_common+0x2f4/0x610 [sunrpc]
> >  svc_process+0xf9/0x110 [sunrpc]
> >  nfsd+0x10e/0x180 [nfsd]
> >  kthread+0x130/0x140
> >  ret_from_fork+0x35/0x40
> >
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> > ---
> >  fs/nfsd/filecache.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > Marking this RFC since I haven't actually had a chance to test this,
> > we
> > we're seeing this deadlock for some customers.
> >
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index fdf89fcf1a0c..a14760f9b486 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -121,6 +121,7 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > *nf)
> >         struct fsnotify_mark    *mark;
> >         struct nfsd_file_mark   *nfm = NULL, *new;
> >         struct inode *inode = nf->nf_inode;
> > +       unsigned int pflags;
> >
> >         do {
> >                 mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
> > @@ -149,7 +150,10 @@ nfsd_file_mark_find_or_create(struct nfsd_file
> > *nf)
> >                 new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
> >                 refcount_set(&new->nfm_ref, 1);
> >
> > +               /* fsnotify allocates, avoid recursion back into nfsd
> > */
> > +               pflags = memalloc_nofs_save();
> >                 err = fsnotify_add_inode_mark(&new->nfm_mark, inode,
> > 0);
> > +               memalloc_nofs_restore(pflags);
> >
> >                 /*
> >                  * If the add was successful, then return the object.
>
> Isn't that stack trace showing a slab direct reclaim, and not a
> filesystem writeback situation?
>
> Does memalloc_nofs_save()/restore() really fix this problem? It seems
> to me that it cannot, particularly since knfsd is not a filesystem, and
> so does not ever handle writeback of dirty pages.
>

Maybe NOFS throttles direct reclaims to the point that the problem is
harder to hit?

This report came in at good timing for me.

It demonstrates an issue I did not predict for "volatile"' fanotify marks [1].
As far as I can tell, nfsd filecache is currently the only fsnotify backend that
frees fsnotify marks in memory shrinker. "volatile" fanotify marks would also
be evictable in that way, so they would expose fanotify to this deadlock.

For the short term, maybe nfsd filecache can avoid the problem by checking
mutex_is_locked(&nfsd_file_fsnotify_group->mark_mutex) and abort the
shrinker. I wonder if there is a place for a helper mutex_is_locked_by_me()?

Jan,

A relatively simple fix would be to allocate fsnotify_mark_connector in
fsnotify_add_mark() and free it, if a connector already exists for the object.
I don't think there is a good reason to optimize away this allocation
for the case of a non-first group to set a mark on an object?

Thanks,
Amir.



[1] https://lore.kernel.org/linux-fsdevel/20220307155741.1352405-1-amir73il@gmail.com/

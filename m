Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F294C3105
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiBXQJ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiBXQJz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:09:55 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE8E1986F2
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:09:15 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d19so3249952ioc.8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/LlsLd8z7GeWZnuwXH1W4lXRTKUURvFfzpD6XKlVVo=;
        b=auKlPO+SDPFxrpfy5zGmGJUafT25kBSGGsY8fyQYI3wg/fYch6uV1dBjzMtCbIz3v5
         5A7mC5tB4kicbXtoz7Y/vVcatSS2gkdGSY9ThtGF5t2mtSiW2Cx02w0s1jLDYefvVqk2
         LHuFyVYhimARJv507GZs0uHi+5X/paop5UuVgUKC9TdY6d5xcLpEtvamuS7iu5E79hax
         d7ReMUdd9E8Mma5Hrz/sXJrVJozP7c40DRp7QTZNuidljWTZp+sgs0tQi7+ncfG2dViK
         Ha96eNM07vxL/sHng2r+9rqcZDvqB0SKYloVlnI1Fs322vNKY5tKiRYP1yoo5GiAbTo9
         XcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/LlsLd8z7GeWZnuwXH1W4lXRTKUURvFfzpD6XKlVVo=;
        b=G839jZ2oqu0TM1Oq7FRQlVFTBpq17Vc3gbHuvekJ5h+24nlsXBZvZn0iS77eCSg9wW
         AbKmZORJOcMwnoX0A56RD7HGmfSgWKvpi9VR7iXW3NenjX5pKJ/sdxdfy23kHxgegGzN
         GX+6i8GoSaRiixYXiHnKWvHBogAvRDPyvVj4xGL1cngUpRsOa+uNRlqt0YF9ojbOBIUB
         RrLyYFeFB59/fvvjOkRNoJ0zAN2pyX3eV+otNnJaIlUl1ForxaGtlGihxQ0JLU3hUzV6
         dYU//uiSkx1fz+01sd7pngkO/3VVjkOKC2Le3KGmqU4/baGwC+WNEwhuHAbxhb6vBTN/
         LnAw==
X-Gm-Message-State: AOAM530gp6nMngVZYX6z6nbbgZ2oz82aGq5I18+wPGjUcyBNI6EdZoZi
        rFrM4ELY/3rB0T1xwpX5jrMMMTacmm/FOoS1T7k=
X-Google-Smtp-Source: ABdhPJysf3qDho0Bq2QUXLWUHW1ENyyt632BCtNF/5uhmfcFcVv1A/OgaY8E3SfDp5F1wstKMLId7c7rvo+HWVsu86A=
X-Received: by 2002:a02:716d:0:b0:315:292f:2a2f with SMTP id
 n45-20020a02716d000000b00315292f2a2fmr2670123jaf.188.1645718929266; Thu, 24
 Feb 2022 08:08:49 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxhYsci9-ADNTH6RZmnzBQoxy0ek4+Hgi9sK8HpF2ftrow@mail.gmail.com>
 <e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org>
 <C5BCCA52-9269-46D2-9972-EF59232B4E24@oracle.com> <878848dcb0970cf1595aeea869fe9d5296bdeeb4.camel@kernel.org>
In-Reply-To: <878848dcb0970cf1595aeea869fe9d5296bdeeb4.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Feb 2022 18:08:38 +0200
Message-ID: <CAOQ4uxi+D6ag81sD_FXXRcQR_7esK5ZoRECb40wF12Zp+=m3mw@mail.gmail.com>
Subject: Re: nfsd: unable to allocate nfsd_file_hashtbl
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
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

On Thu, Feb 24, 2022 at 5:53 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2022-02-24 at 15:14 +0000, Chuck Lever III wrote:
> >
> > > On Feb 24, 2022, at 6:07 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Thu, 2022-02-24 at 12:13 +0200, Amir Goldstein wrote:
> > > > Hi Jeff,
> > > >
> > > > I got some reports from customers about failure to allocate the
> > > > nfsd_file_hashtbl on nfs server restart on a long running system,
> > > > probably due to memory fragmentation.
> > > >
> > > > A search in Google for this error message yields several results of
> > > > similar reports [1][2].
> > > >
> > > > My question is, does nfsd_file_cache_init() have to be done on server
> > > > startup?
> > > >
> > > > Doesn't it make more sense to allocate all the memory pools and
> > > > hash table on init_nfsd()?
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://unix.stackexchange.com/questions/640534/nfs-cannot-allocate-memory
> > > > [2] https://askubuntu.com/questions/1365821/nfs-crashing-on-ubuntu-server-20-04
> > >
> > > That is a big allocation. On my box, nfsd_fcache_bucket is 80 bytes, so
> > > we end up needing 80 contiguous pages to allocate the whole table. It
> > > doesn't surprise me that it fails sometimes.
> > >
> > > We could just allocate it on init_nfsd, but that happens when the module
> > > is plugged in and we'll lose 80 pages when people plug it in (or build
> > > it in) and don't actually use nfsd.
> >
> > Reducing the bucket count might also help, especially if nfb_head
> > were to be replaced with an rb_tree to allow more items in each
> > bucket.
> >
> >
>
> I don't think you can do RCU traversal of an rbtree (can you?), and
> you'd lose that ability if you switch to one. OTOH, maybe it doesn't buy
> much, if you're looking to redesign that table for other reasons.
>
> > > The other option might be to just use kvcalloc? It's not a frequent
> > > allocation, so I don't think performance would be an issue. We had
> > > similar reports several years ago with nfsd_reply_cache_init, and using
> > > kvzalloc ended up taking care of it.
> >
> > A better long-term solution would be to not require a large
> > allocation at all. Maybe we could consider some alternative
> > data structures.
> >
>
> Sure, you could build it up from pages or something. That's a lot more
> hassle though.
>
> I don't see a problem with vmalloc here. This allocation only happens
> when the nfs server is started, which is an infrequent occurrence. A
> modest performance hit at that time to fix up the kernel pagetables
> doesn't seem too awful.
>
> This is almost exactly the same problem that 8f97514b423a (nfsd: more
> robust allocation failure handling in nfsd_reply_cache_init) was
> intended to fix, and that was suggested by the head penguin himself.
>
> Here's what I'd suggest, but I haven't had time to test it out:

You raced me to sending a patch, but my patch is broken
(forgot to change to kvfree :-/)

Thanks,
Amir.

>
> ---------------------8<--------------------
>
> [RFC PATCH] nfsd: use kvcalloc to allocate nfsd_file_hashtbl
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..cc2831cec669 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -632,7 +632,7 @@ nfsd_file_cache_init(void)
>         if (!nfsd_filecache_wq)
>                 goto out;
>
> -       nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
> +       nfsd_file_hashtbl = kvcalloc(NFSD_FILE_HASH_SIZE,
>                                 sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
>         if (!nfsd_file_hashtbl) {
>                 pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
> @@ -700,7 +700,7 @@ nfsd_file_cache_init(void)
>         nfsd_file_slab = NULL;
>         kmem_cache_destroy(nfsd_file_mark_slab);
>         nfsd_file_mark_slab = NULL;
> -       kfree(nfsd_file_hashtbl);
> +       kvfree(nfsd_file_hashtbl);
>         nfsd_file_hashtbl = NULL;
>         destroy_workqueue(nfsd_filecache_wq);
>         nfsd_filecache_wq = NULL;
> @@ -811,7 +811,7 @@ nfsd_file_cache_shutdown(void)
>         fsnotify_wait_marks_destroyed();
>         kmem_cache_destroy(nfsd_file_mark_slab);
>         nfsd_file_mark_slab = NULL;
> -       kfree(nfsd_file_hashtbl);
> +       kvfree(nfsd_file_hashtbl);
>         nfsd_file_hashtbl = NULL;
>         destroy_workqueue(nfsd_filecache_wq);
>         nfsd_filecache_wq = NULL;
> --
> 2.35.1
>
>

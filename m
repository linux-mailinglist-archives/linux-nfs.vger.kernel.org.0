Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA152584211
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiG1Oom (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiG1Ooi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:44:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EEB1570F
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:44:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w5so2435170edd.13
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uO+AD3f4Yg8B/1yAviUMpnGCzYKXCX3D5PANyzksIKk=;
        b=Dn/Nh0H9z7Clyaj99dvLUMp4glkOSOjEhZT95eEurVJaDmVTBi6qF+Hzow8hYqJ4zN
         rNzTA8PGB5XI84rnMXesAIzrUnyOEDTGBe4WZzkm3GU3f6Mrujr/OyVHa2RTwySbu943
         W5Gz14xypFNpFHW9yOIxyfEzI70yCFYKdd7G2GUydq5WD9hBo4KmU4yLTA4a75STak5m
         PAIQ6KxK/eGtgJsRtH35/43t4cvUc0yyUmqd1LWJdaK34kmn73TRMCYJlCBr3kZL2XQq
         sV4kDHwaWbE8f1u6GFvJ5eC7qNsvH7KZr0pG+gacQoNUWN4R2cmIhiL6tmu/KznyC69m
         ebmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uO+AD3f4Yg8B/1yAviUMpnGCzYKXCX3D5PANyzksIKk=;
        b=dUxvVqqftunHnx9f6QMpHyYZfEgRDji4TnCkjh0I3nrhrEVWi1LAY2CI0vuu8CBETd
         yu8anL5jO4MTUCuQx4AZJomk0f4J2OFG6rc+eecLyTDkJAyH/e1lZ4SLmY1sW39vemNe
         hm4tuHHbkoZCb3jx8zlTgjQUkDx5LK2buljo1rZeZXNu632imobMAV5mDt6h4POlFl1v
         4xAJ6fSebOQysvJkEVq/TnvJFzvs52f6mrHDYepHj/F5sWYjAeQyy/ioWuQ4cQfPl/De
         oIA4S7tx40XIeiesNfE2auY40A08IieoXcEyKAdvV08rZzZEnHHcbKR0DxKUtlXD0tj2
         uVuQ==
X-Gm-Message-State: AJIora838I1Tpv7XEjPjQA+YFmLWTOM8DLFwwXjye6bg57PppNlwopdt
        JP3Hla8Zf6rwrvIal2ktUOmbNhGJjB43aJ5VyS0=
X-Google-Smtp-Source: AGRyM1t6tsjH88LOH8qV/6xLleRo36yAwQ/bB8+g9Eqqe/2l/pNRPvmEzX2LCIjm7ByNmxJDGDTJYRKWspzA5xNfMfE=
X-Received: by 2002:a05:6402:11c9:b0:43b:b905:cb88 with SMTP id
 j9-20020a05640211c900b0043bb905cb88mr27739545edw.102.1659019474376; Thu, 28
 Jul 2022 07:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220728142406.91832-1-jlayton@kernel.org>
In-Reply-To: <20220728142406.91832-1-jlayton@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 28 Jul 2022 10:44:23 -0400
Message-ID: <CAN-5tyEEeVgG3b6tjvUQaGk1uMmibjYcv2++y+r6jU8cjOzy5Q@mail.gmail.com>
Subject: Re: [RFC PATCH] nfs: don't skip CTO on v2/3 mounts, regardless of
 order of reference puts
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>, anna@kernel.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Ben Coddington <bcodding@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 28, 2022 at 10:30 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> Olga reported a case of data corruption in a situation where two clients
> (v3 and v4) were alternately doing open/write/close the same file.

My thoughts: I did report it but this problem has been impossible to
reproduce. Thus perhaps this proposal might be the right thing that
needs to be done anyway and that's fine but it's still unclear to me
why the problem isn't more reproducible and whether or not this
proposal will fix it.

> Looking at captures, the v3 client failed to perform any of the GETATTR
> calls for CTO during one of the events, leading it to overwrite some
> data that had been written by the v4 client.
>
> We have two calls that work similarly: put_nfs_open_context and
> put_nfs_open_context_sync. The only difference is the is_sync parameter
> that gets passed to close_context. The only caller of the _sync variant
> is in the close codepath.
>
> On a v2/3 mount, if the last reference is not put by
> put_nfs_open_context_sync, then CTO revalidation never happens. Fix this
> by adding a new flag to nfs_open_context and set that in
> put_nfs_open_context_sync. In nfs_close_context, check for that flag
> when we're checking is_sync and treat them as equivalent.
>
> Cc: Scott Mayhew <smayhew@redhat.com>
> Cc: Ben Coddington <bcodding@redhat.com>
> Reported-by: Olga Kornieskaia <kolga@netapp.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/inode.c         | 3 ++-
>  include/linux/nfs_fs.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> I'm not sure this is the right fix. Maybe we'd be better off just
> ignoring the is_sync parameter in nfs_close_context? It's probably
> functionally equivalent anyway.
>
> Thoughts?
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index b4e46b0ffa2d..58b506a0a2f2 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1005,7 +1005,7 @@ void nfs_close_context(struct nfs_open_context *ctx, int is_sync)
>
>         if (!(ctx->mode & FMODE_WRITE))
>                 return;
> -       if (!is_sync)
> +       if (!is_sync && !test_bit(NFS_CONTEXT_DO_CLOSE, &ctx->flags))
>                 return;
>         inode = d_inode(ctx->dentry);
>         if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
> @@ -1091,6 +1091,7 @@ EXPORT_SYMBOL_GPL(put_nfs_open_context);
>
>  static void put_nfs_open_context_sync(struct nfs_open_context *ctx)
>  {
> +       set_bit(NFS_CONTEXT_DO_CLOSE, &ctx->flags);
>         __put_nfs_open_context(ctx, 1);
>  }
>
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index a17c337dbdf1..faff0d60aad2 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -85,8 +85,9 @@ struct nfs_open_context {
>         unsigned long flags;
>  #define NFS_CONTEXT_RESEND_WRITES      (1)
>  #define NFS_CONTEXT_BAD                        (2)
> -#define NFS_CONTEXT_UNLOCK     (3)
> +#define NFS_CONTEXT_UNLOCK             (3)
>  #define NFS_CONTEXT_FILE_OPEN          (4)
> +#define NFS_CONTEXT_DO_CLOSE           (5)
>         int error;
>
>         struct list_head list;
> --
> 2.37.1
>

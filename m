Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DEC75C762
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjGUNK4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGUNKz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 09:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FCBE68
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689945012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRuuam55kdQA4uTTCcFH99bBDP1ucNXuZ2EnP+sxN5A=;
        b=Zsy0ndguvGUQp4N+ee+Ye3YiTwKeld7dgwTYxqOI8FhEA5dCuggIEYcR59fxq5PiKcevVL
        WQMvpEu9xJjHu3jFS23uEPF6pB56ejUeXZ/DDcFvHSGhANa1Uwzma3L1wTFYPE+G/D/yt6
        ul6l5PasQWqv4w7/87lcIjQj5PIlnKg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Mtt3TXJ6Pb2p5I3wUDRqZA-1; Fri, 21 Jul 2023 09:10:11 -0400
X-MC-Unique: Mtt3TXJ6Pb2p5I3wUDRqZA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-583312344e7so18665657b3.1
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 06:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689945011; x=1690549811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRuuam55kdQA4uTTCcFH99bBDP1ucNXuZ2EnP+sxN5A=;
        b=ksA7BPOx+JFguZRLgI5yxUaZRbwr3w0UJ9Jht7LiTy4aRBD7wtdohWKEcoTJCJPLDo
         BcnOY7HYTIQ79pZq/lZ9qSD95EsBJWiloVRzL5egH4niXREcSZETeAdzgI3LPYs7CBcV
         QlpkxHO1mwDNC9THG2m8bpVn592zYupddg8SQCGW5S3ploTbQGfcRu9thd+zGr7aTKrW
         s5Wtkc8xPRusezZZRgkF5Id+/wDN/e1JtIqCumKkEUSoA+EP5oYHya+TAAOVQ4cF2oQu
         rD+drOab5L8/Mu2X224CcPM5L5pmv79ri16uoDyyI85pHBQzwLH6INPaeOJ0jc5xFbky
         1WvQ==
X-Gm-Message-State: ABy/qLaSvTAMLIjtFP6TacmpZqhHCMJHjitSARbHIFZbzt5SVaJjDs3v
        0/vU9aqqeZ+2Rv1pkdtckLipR7pmZpORwh7NPb03/Jl0RmaNm9sLKHsN1yixuGzN+5xNiI88uj6
        BGHGlTzWTqL2krj9QBPpaOyBpwrxcAXEctYs9
X-Received: by 2002:a81:730b:0:b0:573:44b3:bf7f with SMTP id o11-20020a81730b000000b0057344b3bf7fmr1905183ywc.41.1689945010742;
        Fri, 21 Jul 2023 06:10:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHv8lG+/kKHBBkb4NMfFTdZxi2alLLHEwvMnnmxA1OL8LKq26vNXtveX0RTe+phaj2EJLEcU43p8ZkHvX88Mu4=
X-Received: by 2002:a81:730b:0:b0:573:44b3:bf7f with SMTP id
 o11-20020a81730b000000b0057344b3bf7fmr1905160ywc.41.1689945010438; Fri, 21
 Jul 2023 06:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230720125806.1385279-1-aahringo@redhat.com> <20230720125806.1385279-2-aahringo@redhat.com>
In-Reply-To: <20230720125806.1385279-2-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 21 Jul 2023 09:09:59 -0400
Message-ID: <CAK-6q+gaX6v0aiaKB=STd_QWCyujX_bh-7uJ+Kfsu2GRVCCc6g@mail.gmail.com>
Subject: Re: [RFC v6.5-rc2 2/3] fs: lockd: fix race in async lock request handling
To:     chuck.lever@oracle.com
Cc:     jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Thu, Jul 20, 2023 at 8:58=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> This patch fixes a race in async lock request handling between adding
> the relevant struct nlm_block to nlm_blocked list after the request was
> sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of the
> nlm_block in the nlm_blocked list. It could be that the async request is
> completed before the nlm_block was added to the list. This would end
> in a -ENOENT and a kernel log message of "lockd: grant for unknown
> block".
>
> To solve this issue we add the nlm_block before the vfs_lock_file() call
> to be sure it has been added when a possible nlmsvc_grant_deferred() is
> called. If the vfs_lock_file() results in an case when it wouldn't be
> added to nlm_blocked list, the nlm_block struct will be removed from
> this list again.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c          | 80 +++++++++++++++++++++++++++----------
>  include/linux/lockd/lockd.h |  1 +
>  2 files changed, 60 insertions(+), 21 deletions(-)
>
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 28abec5c451d..62ef27a69a9e 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -297,6 +297,8 @@ static void nlmsvc_free_block(struct kref *kref)
>
>         dprintk("lockd: freeing block %p...\n", block);
>
> +       WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
> +
>         /* Remove block from file's list of blocks */
>         list_del_init(&block->b_flist);
>         mutex_unlock(&file->f_mutex);
> @@ -543,6 +545,12 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>                 goto out;
>         }
>
> +       if (block->b_flags & B_PENDING_CALLBACK)
> +               goto pending_request;
> +
> +       /* Append to list of blocked */
> +       nlmsvc_insert_block(block, NLM_NEVER);
> +
>         if (!wait)
>                 lock->fl.fl_flags &=3D ~FL_SLEEP;
>         mode =3D lock_to_openmode(&lock->fl);
> @@ -552,9 +560,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file =
*file,
>         dprintk("lockd: vfs_lock_file returned %d\n", error);
>         switch (error) {
>                 case 0:
> +                       nlmsvc_remove_block(block);

reacting here with nlmsvc_remove_block() assumes that the block was
not being added to the nlm_blocked list before nlmsvc_insert_block()
was called. I am not sure if this is always the case here.

Does somebody see a problem with that?

>                         ret =3D nlm_granted;
>                         goto out;
>                 case -EAGAIN:
> +                       if (!wait)
> +                               nlmsvc_remove_block(block);
> +pending_request:
>                         /*
>                          * If this is a blocking request for an
>                          * already pending lock request then we need
> @@ -565,6 +577,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>                         ret =3D async_block ? nlm_lck_blocked : nlm_lck_d=
enied;
>                         goto out;
>                 case FILE_LOCK_DEFERRED:
> +                       block->b_flags |=3D B_PENDING_CALLBACK;
> +
>                         if (wait)
>                                 break;
>                         /* Filesystem lock operation is in progress
> @@ -572,17 +586,16 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
>                         ret =3D nlmsvc_defer_lock_rqst(rqstp, block);
>                         goto out;
>                 case -EDEADLK:
> +                       nlmsvc_remove_block(block);
>                         ret =3D nlm_deadlock;
>                         goto out;
>                 default:                        /* includes ENOLCK */
> +                       nlmsvc_remove_block(block);
>                         ret =3D nlm_lck_denied_nolocks;
>                         goto out;
>         }
>
>         ret =3D nlm_lck_blocked;
> -
> -       /* Append to list of blocked */
> -       nlmsvc_insert_block(block, NLM_NEVER);
>  out:
>         mutex_unlock(&file->f_mutex);
>         nlmsvc_release_block(block);
> @@ -739,34 +752,59 @@ nlmsvc_update_deferred_block(struct nlm_block *bloc=
k, int result)
>                 block->b_flags |=3D B_TIMED_OUT;
>  }

- Alex


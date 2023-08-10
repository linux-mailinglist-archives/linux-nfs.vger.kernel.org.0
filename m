Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862E577827C
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHJVBv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHJVBu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 17:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540FD12B
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691701263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPfzR5oh7RHGXQHB7rxXi5hSEsWl0cGVSEeqGFCdSFg=;
        b=BkhmX87ozbH7IC1r3D/DjrlLVIQOX8pkzm6wAY5XyEZyn7UzQq9EELNU3Inza7ZsR9xF9w
        Pb1FfanrvwJugcn29q9lWdO5xgaG/9YmUgO60l/1zBlwd+xoi9RFqA1nzhc8ESQrXnfvOQ
        /xhTfGOtEOJfgVbgLr6Ab+y/cFg/jmk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-GjXmWpIhNx6dj8n_F-7WJQ-1; Thu, 10 Aug 2023 17:01:02 -0400
X-MC-Unique: GjXmWpIhNx6dj8n_F-7WJQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5236977ccfdso927794a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 14:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691701261; x=1692306061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPfzR5oh7RHGXQHB7rxXi5hSEsWl0cGVSEeqGFCdSFg=;
        b=BPjO5OPJgrUyC8eE9KXOdvdck1Ks6tzngLvJ/MfbT9th3rdL+QxKEe4nFYWpUxfVSm
         yvjYLTeIDKGYwaD1XEXiKfNiVgRGXc91WCe3UH7DxmF+jSrE5uEtDDXqeZYFOQzIPzf9
         zbnHHaDtHcyY7HpAggSMt7vpv5dKKAgIO6eMFu47gfDS1BsB9g5FbX5P33h/Y2rkkHOp
         1BHVOXbtETOYu8jkODMZ16CcX4IquJ8fz76fllwD+EyYuLwzs8Abm13XT5aDgFjgbJCF
         UZNlGJSfs5feldpbVFTExCiq2O5iGmpoBztBn+XKlhgqeKgDT6Avh3NF584VyeFh8yJ0
         uC8Q==
X-Gm-Message-State: AOJu0YzQXTXVLnQgTI6atl4tL9PBXeMuO1BoVfZhAW0YsbST/X4lZRO9
        nvLDxOGrvs/4qyLa78gLCtH1rNjkDpJbSuOC2KI3pARWzIqgiJmBYm++UcGlnOVDcd15fULsQz7
        7G/eiviLCyDyc6TYOYyETVQiNd9YdPycMtEB5
X-Received: by 2002:aa7:d84f:0:b0:51e:5322:a642 with SMTP id f15-20020aa7d84f000000b0051e5322a642mr116433eds.27.1691701260980;
        Thu, 10 Aug 2023 14:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7OKMjl8kLRMzVEGxjsaYW5xMayj13hMZQeSni3N6MzMEN29dWfRFa9FakIzxPD75hDfcG+yeM4I08TRciiZE=
X-Received: by 2002:aa7:d84f:0:b0:51e:5322:a642 with SMTP id
 f15-20020aa7d84f000000b0051e5322a642mr116416eds.27.1691701260704; Thu, 10 Aug
 2023 14:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230720125806.1385279-1-aahringo@redhat.com> <20230720125806.1385279-2-aahringo@redhat.com>
 <CAK-6q+gaX6v0aiaKB=STd_QWCyujX_bh-7uJ+Kfsu2GRVCCc6g@mail.gmail.com> <44d48d5a78159bcf8d52d3213ac6d684e148ebfd.camel@kernel.org>
In-Reply-To: <44d48d5a78159bcf8d52d3213ac6d684e148ebfd.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 10 Aug 2023 17:00:49 -0400
Message-ID: <CAK-6q+gBnuQ9LkfM04SCtOkRsqjjQLseh+wZ5B_K4Sxmr2FQsw@mail.gmail.com>
Subject: Re: [RFC v6.5-rc2 2/3] fs: lockd: fix race in async lock request handling
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Fri, Jul 21, 2023 at 12:43=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2023-07-21 at 09:09 -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Thu, Jul 20, 2023 at 8:58=E2=80=AFAM Alexander Aring <aahringo@redha=
t.com> wrote:
> > >
> > > This patch fixes a race in async lock request handling between adding
> > > the relevant struct nlm_block to nlm_blocked list after the request w=
as
> > > sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of =
the
> > > nlm_block in the nlm_blocked list. It could be that the async request=
 is
> > > completed before the nlm_block was added to the list. This would end
> > > in a -ENOENT and a kernel log message of "lockd: grant for unknown
> > > block".
> > >
> > > To solve this issue we add the nlm_block before the vfs_lock_file() c=
all
> > > to be sure it has been added when a possible nlmsvc_grant_deferred() =
is
> > > called. If the vfs_lock_file() results in an case when it wouldn't be
> > > added to nlm_blocked list, the nlm_block struct will be removed from
> > > this list again.
> > >
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >  fs/lockd/svclock.c          | 80 +++++++++++++++++++++++++++--------=
--
> > >  include/linux/lockd/lockd.h |  1 +
> > >  2 files changed, 60 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > index 28abec5c451d..62ef27a69a9e 100644
> > > --- a/fs/lockd/svclock.c
> > > +++ b/fs/lockd/svclock.c
> > > @@ -297,6 +297,8 @@ static void nlmsvc_free_block(struct kref *kref)
> > >
> > >         dprintk("lockd: freeing block %p...\n", block);
> > >
> > > +       WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
> > > +
> > >         /* Remove block from file's list of blocks */
> > >         list_del_init(&block->b_flist);
> > >         mutex_unlock(&file->f_mutex);
> > > @@ -543,6 +545,12 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
> > >                 goto out;
> > >         }
> > >
> > > +       if (block->b_flags & B_PENDING_CALLBACK)
> > > +               goto pending_request;
> > > +
> > > +       /* Append to list of blocked */
> > > +       nlmsvc_insert_block(block, NLM_NEVER);
> > > +
> > >         if (!wait)
> > >                 lock->fl.fl_flags &=3D ~FL_SLEEP;
> > >         mode =3D lock_to_openmode(&lock->fl);
> > > @@ -552,9 +560,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_f=
ile *file,
> > >         dprintk("lockd: vfs_lock_file returned %d\n", error);
> > >         switch (error) {
> > >                 case 0:
> > > +                       nlmsvc_remove_block(block);
> >
> > reacting here with nlmsvc_remove_block() assumes that the block was
> > not being added to the nlm_blocked list before nlmsvc_insert_block()
> > was called. I am not sure if this is always the case here.
> >
> > Does somebody see a problem with that?
> >
>
> The scenario is: we have a block on the list already and now another
> lock request comes in for the same thing: the client decided to just re-
> poll for the lock. That's a plausible scenario. I think the Linux NLM
> client will poll for locks periodically.
>
> In this case though, the lock request was granted by the filesystem, so
> this is likely racing with (and winning vs.) a lm_grant callback. Given
> that the client decided to repoll for it, we're probably safe to just
> dequeue the block and respond here, and not worry about sending a grant
> callback.
>
> Ditto for the other cases where the block is removed.
>

ok.

> > >                         ret =3D nlm_granted;
> > >                         goto out;
> > >                 case -EAGAIN:
> > > +                       if (!wait)
> > > +                               nlmsvc_remove_block(block);
>
> I was thinking that it would be best to not insert a block at all in the
> !wait case, but it looks like DLM just returns DEFERRED and almost
> always does a callback, even when it's not a blocking lock request?
>
> Anyway, I think we probably do have to handle this like you are.
>

I would prefer to have !wait blocked. We even don't do that in DLM, it
causes problems with cancellation as a cancellation will only do
something (at least in DLM) when there is a waiter that the lock
request waits to be granted, which is only being the case for wait
lock requests.

A !wait is only a trylock, the answer should be back being mostly
immediate and it also makes no sense for me to make them async,
because we have the same problems with cancellation/unlock which are
not being offered to be handled in an asynchronous way. As I said, the
answer should be back mostly immediately. We are somehow doing this
optimization for !wait lock requests only, but operations like unlock
are also being called by lockd and are not being handled
asynchronously. That means we probably don't care about this
optimization, it looks different on wait lock requests.

We should update the documentation and only do async lock requests on
wait only. Is this okay?

- Alex


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29E975CFEE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGUQn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGUQn4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 12:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5263A92
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 09:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE6C61D32
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 16:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF2AC433C8;
        Fri, 21 Jul 2023 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689957811;
        bh=x9l5F2erriKUq50eX6NJasDP7XZ6/2zWQ0qw4yKt/hg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WRYU7pxWKV35GvbePxoJnS+6sstakcOFx8MdJIdhQ39AqEle1Mf3enj87IJlV+OnN
         af+wnfFCEkobjsrgg3UBMuj2u5L6x5rmKdFRc3l+FtCUfmAydEduCwPXGdElm4cO+k
         2KAp4y+BtYpNAEH50h26GJsJPIUPNlKd8lAwblYNmZvj09BY4Smhr76NtaOpqvus16
         0rYSPvRB/alAE+ECE7X3Tg1Og+fvl3tN0fuI7w3FxGQH0CqLYKUv1RDH96bzlYpkJ1
         vsuaObFG3hl+UJUNvClbyACPjq/SbzH3aoRrX24dr+1jEUvnwW4XFC6wPFqETf2sNJ
         hKCP7yHir3P8A==
Message-ID: <44d48d5a78159bcf8d52d3213ac6d684e148ebfd.camel@kernel.org>
Subject: Re: [RFC v6.5-rc2 2/3] fs: lockd: fix race in async lock request
 handling
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, chuck.lever@oracle.com
Cc:     neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Date:   Fri, 21 Jul 2023 12:43:29 -0400
In-Reply-To: <CAK-6q+gaX6v0aiaKB=STd_QWCyujX_bh-7uJ+Kfsu2GRVCCc6g@mail.gmail.com>
References: <20230720125806.1385279-1-aahringo@redhat.com>
         <20230720125806.1385279-2-aahringo@redhat.com>
         <CAK-6q+gaX6v0aiaKB=STd_QWCyujX_bh-7uJ+Kfsu2GRVCCc6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-07-21 at 09:09 -0400, Alexander Aring wrote:
> Hi,
>=20
> On Thu, Jul 20, 2023 at 8:58=E2=80=AFAM Alexander Aring <aahringo@redhat.=
com> wrote:
> >=20
> > This patch fixes a race in async lock request handling between adding
> > the relevant struct nlm_block to nlm_blocked list after the request was
> > sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of th=
e
> > nlm_block in the nlm_blocked list. It could be that the async request i=
s
> > completed before the nlm_block was added to the list. This would end
> > in a -ENOENT and a kernel log message of "lockd: grant for unknown
> > block".
> >=20
> > To solve this issue we add the nlm_block before the vfs_lock_file() cal=
l
> > to be sure it has been added when a possible nlmsvc_grant_deferred() is
> > called. If the vfs_lock_file() results in an case when it wouldn't be
> > added to nlm_blocked list, the nlm_block struct will be removed from
> > this list again.
> >=20
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/lockd/svclock.c          | 80 +++++++++++++++++++++++++++----------
> >  include/linux/lockd/lockd.h |  1 +
> >  2 files changed, 60 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index 28abec5c451d..62ef27a69a9e 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -297,6 +297,8 @@ static void nlmsvc_free_block(struct kref *kref)
> >=20
> >         dprintk("lockd: freeing block %p...\n", block);
> >=20
> > +       WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
> > +
> >         /* Remove block from file's list of blocks */
> >         list_del_init(&block->b_flist);
> >         mutex_unlock(&file->f_mutex);
> > @@ -543,6 +545,12 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fil=
e *file,
> >                 goto out;
> >         }
> >=20
> > +       if (block->b_flags & B_PENDING_CALLBACK)
> > +               goto pending_request;
> > +
> > +       /* Append to list of blocked */
> > +       nlmsvc_insert_block(block, NLM_NEVER);
> > +
> >         if (!wait)
> >                 lock->fl.fl_flags &=3D ~FL_SLEEP;
> >         mode =3D lock_to_openmode(&lock->fl);
> > @@ -552,9 +560,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fil=
e *file,
> >         dprintk("lockd: vfs_lock_file returned %d\n", error);
> >         switch (error) {
> >                 case 0:
> > +                       nlmsvc_remove_block(block);
>=20
> reacting here with nlmsvc_remove_block() assumes that the block was
> not being added to the nlm_blocked list before nlmsvc_insert_block()
> was called. I am not sure if this is always the case here.
>=20
> Does somebody see a problem with that?
>=20

The scenario is: we have a block on the list already and now another
lock request comes in for the same thing: the client decided to just re-
poll for the lock. That's a plausible scenario. I think the Linux NLM
client will poll for locks periodically.

In this case though, the lock request was granted by the filesystem, so
this is likely racing with (and winning vs.) a lm_grant callback. Given
that the client decided to repoll for it, we're probably safe to just
dequeue the block and respond here, and not worry about sending a grant
callback.

Ditto for the other cases where the block is removed.

> >                         ret =3D nlm_granted;
> >                         goto out;
> >                 case -EAGAIN:
> > +                       if (!wait)
> > +                               nlmsvc_remove_block(block);

I was thinking that it would be best to not insert a block at all in the
!wait case, but it looks like DLM just returns DEFERRED and almost
always does a callback, even when it's not a blocking lock request?

Anyway, I think we probably do have to handle this like you are.

> > +pending_request:
> >                         /*
> >                          * If this is a blocking request for an
> >                          * already pending lock request then we need
> > @@ -565,6 +577,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
> >                         ret =3D async_block ? nlm_lck_blocked : nlm_lck=
_denied;
> >                         goto out;
> >                 case FILE_LOCK_DEFERRED:
> > +                       block->b_flags |=3D B_PENDING_CALLBACK;
> > +
> >                         if (wait)
> >                                 break;
> >                         /* Filesystem lock operation is in progress
> > @@ -572,17 +586,16 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> >                         ret =3D nlmsvc_defer_lock_rqst(rqstp, block);
> >                         goto out;
> >                 case -EDEADLK:
> > +                       nlmsvc_remove_block(block);
> >                         ret =3D nlm_deadlock;
> >                         goto out;
> >                 default:                        /* includes ENOLCK */
> > +                       nlmsvc_remove_block(block);
> >                         ret =3D nlm_lck_denied_nolocks;
> >                         goto out;
> >         }
> >=20
> >         ret =3D nlm_lck_blocked;
> > -
> > -       /* Append to list of blocked */
> > -       nlmsvc_insert_block(block, NLM_NEVER);
> >  out:
> >         mutex_unlock(&file->f_mutex);
> >         nlmsvc_release_block(block);
> > @@ -739,34 +752,59 @@ nlmsvc_update_deferred_block(struct nlm_block *bl=
ock, int result)
> >                 block->b_flags |=3D B_TIMED_OUT;
> >  }
>=20
> - Alex
>=20

--=20
Jeff Layton <jlayton@kernel.org>

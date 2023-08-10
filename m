Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CF77823C
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHJUi4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjHJUiz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 16:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085AF90
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691699882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIni07KyJce7xxuw2QLVT5cpv2HHxiYwf+IdLolCCXY=;
        b=QWHV4vXpBRr2ADLinGbgO1pLl97bU7N7Wukk2giekH/FicUc5u25W54gs/C7Suvs7f3/80
        2SnLKEbWqKpGHUOjUVywJPdWYRJu226dW8jhbmuLHkIrdUhi1x7Bu3xBG5U7askhgPQxgO
        9qjYZmTziWmUrsHyh3ufq9SaJjwQVKg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-RBSOskQaNJ2D7pislGGAkw-1; Thu, 10 Aug 2023 16:38:00 -0400
X-MC-Unique: RBSOskQaNJ2D7pislGGAkw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52310058f1eso3463066a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 13:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699879; x=1692304679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIni07KyJce7xxuw2QLVT5cpv2HHxiYwf+IdLolCCXY=;
        b=EAcKa7uGMq2US2j/32GDVVG2eqz4TdWapUiAj/+HrI1qP04fKuqy8rUJctUwS97cZK
         MxSCkzqYmgqkAf9aFaL3xASBg4TSXd2OUReatNhKLW7fIgriIWv3fn6d5vnPzYOGKzRv
         rUqPFXDG9+fSdKK+xOJ22e8r3/sra11sjd6qUfxh/x+G5NTKiwQmirbqIaL5Dk0NuSOr
         LqnYg4w8ou/TOvJmvdVH9rxQQJv9ztjQlzCe24lXJEUR9DSPUPIA2TV9L1pstSpLcgVM
         Z1Wd1EbOCGQaPwAiyGhNvhTDMbxSfaABRuGXaGwGJvzhOz+g5zVltZfhzluHNzuUUCUy
         27xA==
X-Gm-Message-State: AOJu0YxTKArkhLrWNR3MRpH+sPXFxAIvRyRqsEJoWBSwJ0LKBEjsPiZI
        S8TnuwjffVRDDZL7iqWkCifqIvyt3CKJSgr7BSz029QAneXgT9W1hSha1gG3wdpdpNVr+iNVnbB
        iBf/EVyJFr4uuEZ6rc/0T0OTbD8qukTY9JNkV
X-Received: by 2002:a05:6402:2793:b0:51f:ef58:da87 with SMTP id b19-20020a056402279300b0051fef58da87mr3780699ede.2.1691699879342;
        Thu, 10 Aug 2023 13:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtyfF/rZBCKNCFMZqumNdBbqxsmDl7zLHcIbu3ah5OjXYkk27PzRjmI6/9s/gxl4lkuZpq+rLAuxBfb7ABrHE=
X-Received: by 2002:a05:6402:2793:b0:51f:ef58:da87 with SMTP id
 b19-20020a056402279300b0051fef58da87mr3780687ede.2.1691699879039; Thu, 10 Aug
 2023 13:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230720125806.1385279-1-aahringo@redhat.com> <20230720125806.1385279-2-aahringo@redhat.com>
 <af8586c743be551c3f939455368fc288856abe11.camel@kernel.org>
In-Reply-To: <af8586c743be551c3f939455368fc288856abe11.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 10 Aug 2023 16:37:47 -0400
Message-ID: <CAK-6q+gH0Rd36peoGTnGyggFq+oUVh_z+uUdKKE3=CZ9MWkYnQ@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Fri, Jul 21, 2023 at 11:45=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Thu, 2023-07-20 at 08:58 -0400, Alexander Aring wrote:
> > This patch fixes a race in async lock request handling between adding
> > the relevant struct nlm_block to nlm_blocked list after the request was
> > sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of th=
e
> > nlm_block in the nlm_blocked list. It could be that the async request i=
s
> > completed before the nlm_block was added to the list. This would end
> > in a -ENOENT and a kernel log message of "lockd: grant for unknown
> > block".
> >
> > To solve this issue we add the nlm_block before the vfs_lock_file() cal=
l
> > to be sure it has been added when a possible nlmsvc_grant_deferred() is
> > called. If the vfs_lock_file() results in an case when it wouldn't be
> > added to nlm_blocked list, the nlm_block struct will be removed from
> > this list again.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/lockd/svclock.c          | 80 +++++++++++++++++++++++++++----------
> >  include/linux/lockd/lockd.h |  1 +
> >  2 files changed, 60 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index 28abec5c451d..62ef27a69a9e 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -297,6 +297,8 @@ static void nlmsvc_free_block(struct kref *kref)
> >
> >       dprintk("lockd: freeing block %p...\n", block);
> >
> > +     WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
> > +
> >       /* Remove block from file's list of blocks */
> >       list_del_init(&block->b_flist);
> >       mutex_unlock(&file->f_mutex);
> > @@ -543,6 +545,12 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fil=
e *file,
> >               goto out;
> >       }
> >
> > +     if (block->b_flags & B_PENDING_CALLBACK)
> > +             goto pending_request;
> > +
> > +     /* Append to list of blocked */
> > +     nlmsvc_insert_block(block, NLM_NEVER);
> > +
> >       if (!wait)
> >               lock->fl.fl_flags &=3D ~FL_SLEEP;
> >       mode =3D lock_to_openmode(&lock->fl);
> > @@ -552,9 +560,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fil=
e *file,
> >       dprintk("lockd: vfs_lock_file returned %d\n", error);
> >       switch (error) {
> >               case 0:
> > +                     nlmsvc_remove_block(block);
> >                       ret =3D nlm_granted;
> >                       goto out;
> >               case -EAGAIN:
> > +                     if (!wait)
> > +                             nlmsvc_remove_block(block);
> > +pending_request:
> >                       /*
> >                        * If this is a blocking request for an
> >                        * already pending lock request then we need
> > @@ -565,6 +577,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file=
 *file,
> >                       ret =3D async_block ? nlm_lck_blocked : nlm_lck_d=
enied;
> >                       goto out;
> >               case FILE_LOCK_DEFERRED:
> > +                     block->b_flags |=3D B_PENDING_CALLBACK;
> > +
> >                       if (wait)
> >                               break;
> >                       /* Filesystem lock operation is in progress
> > @@ -572,17 +586,16 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> >                       ret =3D nlmsvc_defer_lock_rqst(rqstp, block);
>
> When the above function is called, it's going to end up reinserting the
> block into the list. I think you probably also need to remove the call
> to nlmsvc_insert_block from nlmsvc_defer_lock_rqst since it could have
> been granted before that occurs.
>

it cannot be granted during this time because the f_mutex is held. We
insert it in the first place to have a way to get the block lookup
working when a lm_grant() is really fast. Then lm_grant() will lookup
the lock and have a way to get f_mutex to hold it. Then lm_grant()
will only run when nobody is in this critical area (on a per nlm_file
basis).

There is a difference in the call between NLM_NEVER and NLM_TIMEOUT in
nlmsvc_defer_lock_rqst(), when nlmsvc_defer_lock_rqst() it will just
update the timeout value. I am not sure about the consequences when it
does a nlmsvc_insert_block() with NLM_NEVER instead of NLM_TIMEOUT.
But as I said it should not be possible to grant the block when
f_mutex is held.

> >                       goto out;
> >               case -EDEADLK:
> > +                     nlmsvc_remove_block(block);
> >                       ret =3D nlm_deadlock;
> >                       goto out;
> >               default:                        /* includes ENOLCK */
> > +                     nlmsvc_remove_block(block);
> >                       ret =3D nlm_lck_denied_nolocks;
> >                       goto out;
> >       }
> >
> >       ret =3D nlm_lck_blocked;
> > -
> > -     /* Append to list of blocked */
> > -     nlmsvc_insert_block(block, NLM_NEVER);
> >  out:
> >       mutex_unlock(&file->f_mutex);
> >       nlmsvc_release_block(block);
> > @@ -739,34 +752,59 @@ nlmsvc_update_deferred_block(struct nlm_block *bl=
ock, int result)
> >               block->b_flags |=3D B_TIMED_OUT;
> >  }
> >
> > +static int __nlmsvc_grant_deferred(struct nlm_block *block,
> > +                                struct file_lock *fl,
> > +                                int result)
> > +{
> > +     int rc =3D 0;
> > +
> > +     dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
> > +                                     block, block->b_flags);
> > +     if (block->b_flags & B_QUEUED) {
> > +             if (block->b_flags & B_TIMED_OUT) {
> > +                     rc =3D -ENOLCK;
> > +                     goto out;
> > +             }
> > +             nlmsvc_update_deferred_block(block, result);
> > +     } else if (result =3D=3D 0)
> > +             block->b_granted =3D 1;
> > +
> > +     nlmsvc_insert_block_locked(block, 0);
> > +     svc_wake_up(block->b_daemon);
> > +out:
> > +     return rc;
> > +}
> > +
> >  static int nlmsvc_grant_deferred(struct file_lock *fl, int result)
> >  {
> > -     struct nlm_block *block;
> > -     int rc =3D -ENOENT;
> > +     struct nlm_block *block =3D NULL;
> > +     int rc;
> >
> >       spin_lock(&nlm_blocked_lock);
> >       list_for_each_entry(block, &nlm_blocked, b_list) {
> >               if (nlm_compare_locks(&block->b_call->a_args.lock.fl, fl)=
) {
> > -                     dprintk("lockd: nlmsvc_notify_blocked block %p fl=
ags %d\n",
> > -                                                     block, block->b_f=
lags);
> > -                     if (block->b_flags & B_QUEUED) {
> > -                             if (block->b_flags & B_TIMED_OUT) {
> > -                                     rc =3D -ENOLCK;
> > -                                     break;
> > -                             }
> > -                             nlmsvc_update_deferred_block(block, resul=
t);
> > -                     } else if (result =3D=3D 0)
> > -                             block->b_granted =3D 1;
> > -
> > -                     nlmsvc_insert_block_locked(block, 0);
> > -                     svc_wake_up(block->b_daemon);
> > -                     rc =3D 0;
> > +                     kref_get(&block->b_count);
> >                       break;
> >               }
> >       }
> >       spin_unlock(&nlm_blocked_lock);
> > -     if (rc =3D=3D -ENOENT)
> > -             printk(KERN_WARNING "lockd: grant for unknown block\n");
> > +
> > +     if (!block) {
> > +             pr_warn("lockd: grant for unknown pending block\n");
> > +             return -ENOENT;
> > +     }
> > +
> > +     /* don't interfere with nlmsvc_lock() */
> > +     mutex_lock(&block->b_file->f_mutex);
>
>
> This is called from lm_grant, and Documentation/filesystems/locking.rst
> says that lm_grant is not allowed to block. The only caller though is
> dlm_plock_callback, and I don't see anything that would prevent
> blocking.
>
> Do we need to fix the documentation there?
>

You are right and I think it should not call any sleepable API.
However DLM is the only one upstream user and I have no other idea how
to make the current situation better.

We should update the documentation but be open to make it
non-sleepable in future?

>
> > +     block->b_flags &=3D ~B_PENDING_CALLBACK;
> > +
>
> You're adding this new flag when the lock is deferred and then clearing
> it when the lock is granted. What about when the lock request is
> cancelled (e.g. by signal)? It seems like you also need to clear it then
> too, correct?
>

correct. I add code to clear it when the block is getting removed from
nlm_blocked in nlmsvc_remove_block().

> > +     spin_lock(&nlm_blocked_lock);
> > +     WARN_ON_ONCE(list_empty(&block->b_list));
> > +     rc =3D __nlmsvc_grant_deferred(block, fl, result);
> > +     spin_unlock(&nlm_blocked_lock);
> > +     mutex_unlock(&block->b_file->f_mutex);
> > +
> > +     nlmsvc_release_block(block);
> >       return rc;
> >  }
> >
> > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> > index f42594a9efe0..a977be8bcc2c 100644
> > --- a/include/linux/lockd/lockd.h
> > +++ b/include/linux/lockd/lockd.h
> > @@ -189,6 +189,7 @@ struct nlm_block {
> >  #define B_QUEUED             1       /* lock queued */
> >  #define B_GOT_CALLBACK               2       /* got lock or conflictin=
g lock */
> >  #define B_TIMED_OUT          4       /* filesystem too slow to respond=
 */
> > +#define B_PENDING_CALLBACK   8       /* pending callback for lock requ=
est */
> >  };
> >
> >  /*
>
> --
> Jeff Layton <jlayton@kernel.org>
>


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84F55E154
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiF0Msv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiF0Msu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 08:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3B6C2ED
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656334128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSmF3t+/5saL6d7NN8XoNU7DlVsyL/Yhf6ANU75cpBs=;
        b=ILkPfd86+lkV2B6HYgB+fJ/hUtcbnbElsZ1wbzLuywzqw0QCHEabimTaA+POkVtnP0XeqN
        CE5+ndCz9PT7Z9VnAEFz7e2xITUWNoTpdToYFMGp1ivpbTV5qDynjwrLWgxQ3rviMWLqHO
        ukUr6yaVDoq1sizuvWTeyEUTJkaQfn8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-WkTzD4qrPq6CNUxfEeXdvw-1; Mon, 27 Jun 2022 08:48:48 -0400
X-MC-Unique: WkTzD4qrPq6CNUxfEeXdvw-1
Received: by mail-ej1-f69.google.com with SMTP id 7-20020a170906310700b007263068d531so2366547ejx.15
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jun 2022 05:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSmF3t+/5saL6d7NN8XoNU7DlVsyL/Yhf6ANU75cpBs=;
        b=rBIcqcGBnqufETxL8/OZEQiQvFvjYyLgU8w6p0DFYGCrwAVwx5WIPLypa0eXqy8DvJ
         TOzlYgt0G787E/QStHDdakMS0N/qpfdDfH3qXGJ0/K7c5KTmVHTgR++3JSpCB5K2wlin
         PwkBYUknah888qrtZ95ci0iu2d44tjjqZSklS72TQso42w1+gcPHdNbh/Md65mMFyztX
         oSXlz/1pl2fURd3ZnZTa/81GG3WLcuLHhABn+2fOLbpCyhrqqH9hQbSNltEN6uiIW2mF
         zN9SXM3pbdDoBvHAGBeKL+et78obCoTv3bxQY2FFVwZahZfcgpe6lVAwbW8/F4xLUNpO
         TzHw==
X-Gm-Message-State: AJIora/yZPoTpiLgiYJl0ZJt6TpC/WG3/PPZwjSgaTfTgDUdMBo2sAE1
        5Ti0PdcUZRd3FKkVca2H5EPM/Befj9iicpE48PyUeNRr8R8qo3Iw5NoatA65swFZ68i0GZtjgIZ
        RyQXo2L0JkB0i5NE8NUME5fSWVAKIRwILDJq6
X-Received: by 2002:a17:906:5d0d:b0:726:be8f:becc with SMTP id g13-20020a1709065d0d00b00726be8fbeccmr1351572ejt.323.1656334126573;
        Mon, 27 Jun 2022 05:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1soGMC67xyxlo9iQoexbbF1iaz173iZoowmYDjN4aweojJyHMluZ8BiiTutHYPuSMwVCaO2A5gytjYFOSJEWrA=
X-Received: by 2002:a17:906:5d0d:b0:726:be8f:becc with SMTP id
 g13-20020a1709065d0d00b00726be8fbeccmr1351558ejt.323.1656334126329; Mon, 27
 Jun 2022 05:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <9688295e35c07d3b3d6c71970b6996348c2d8f1e.1654798464.git.bcodding@redhat.com>
 <53767203-004C-4538-8E29-1241CFB19F43@oracle.com>
In-Reply-To: <53767203-004C-4538-8E29-1241CFB19F43@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 27 Jun 2022 08:48:10 -0400
Message-ID: <CALF+zO=JaHByPPVphXNZO8X5fTGniOCHZXWBgw_z=ObfyOC0QQ@mail.gmail.com>
Subject: Re: [PATCH] NLM: Defend against file_lock changes after vfs_test_lock()
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 13, 2022 at 4:01 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 13, 2022, at 9:40 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
> >
> > Instead of trusting that struct file_lock returns completely unchanged
> > after vfs_test_lock() when there's no conflicting lock, stash away our
> > nlm_lockowner reference so we can properly release it for all cases.
> >
> > This defends against another file_lock implementation overwriting fl_owner
> > when the return type is F_UNLCK.
> >
> > Reported-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> > Tested-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>
> LGTM. Applied internally for more testing. Comment period
> still open.
>

Chuck,

Are you planning to take this in the next merge window, or what is the
status of this patch?


>
> > ---
> > fs/lockd/svc4proc.c         |  4 +++-
> > fs/lockd/svclock.c          | 10 +---------
> > fs/lockd/svcproc.c          |  5 ++++-
> > include/linux/lockd/lockd.h |  1 +
> > 4 files changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > index 176b468a61c7..4f247ab8be61 100644
> > --- a/fs/lockd/svc4proc.c
> > +++ b/fs/lockd/svc4proc.c
> > @@ -87,6 +87,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
> >       struct nlm_args *argp = rqstp->rq_argp;
> >       struct nlm_host *host;
> >       struct nlm_file *file;
> > +     struct nlm_lockowner *test_owner;
> >       __be32 rc = rpc_success;
> >
> >       dprintk("lockd: TEST4        called\n");
> > @@ -96,6 +97,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
> >       if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
> >               return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
> >
> > +     test_owner = argp->lock.fl.fl_owner;
> >       /* Now check for conflicting locks */
> >       resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
> >       if (resp->status == nlm_drop_reply)
> > @@ -103,7 +105,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
> >       else
> >               dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
> >
> > -     nlmsvc_release_lockowner(&argp->lock);
> > +     nlmsvc_put_lockowner(test_owner);
> >       nlmsvc_release_host(host);
> >       nlm_release_file(file);
> >       return rc;
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index cb3658ab9b7a..9c1aa75441e1 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -340,7 +340,7 @@ nlmsvc_get_lockowner(struct nlm_lockowner *lockowner)
> >       return lockowner;
> > }
> >
> > -static void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
> > +void nlmsvc_put_lockowner(struct nlm_lockowner *lockowner)
> > {
> >       if (!refcount_dec_and_lock(&lockowner->count, &lockowner->host->h_lock))
> >               return;
> > @@ -590,7 +590,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
> >       int                     error;
> >       int                     mode;
> >       __be32                  ret;
> > -     struct nlm_lockowner    *test_owner;
> >
> >       dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
> >                               nlmsvc_file_inode(file)->i_sb->s_id,
> > @@ -604,9 +603,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
> >               goto out;
> >       }
> >
> > -     /* If there's a conflicting lock, remember to clean up the test lock */
> > -     test_owner = (struct nlm_lockowner *)lock->fl.fl_owner;
> > -
> >       mode = lock_to_openmode(&lock->fl);
> >       error = vfs_test_lock(file->f_file[mode], &lock->fl);
> >       if (error) {
> > @@ -635,10 +631,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
> >       conflock->fl.fl_end = lock->fl.fl_end;
> >       locks_release_private(&lock->fl);
> >
> > -     /* Clean up the test lock */
> > -     lock->fl.fl_owner = NULL;
> > -     nlmsvc_put_lockowner(test_owner);
> > -
> >       ret = nlm_lck_denied;
> > out:
> >       return ret;
> > diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> > index 4dc1b40a489a..b09ca35b527c 100644
> > --- a/fs/lockd/svcproc.c
> > +++ b/fs/lockd/svcproc.c
> > @@ -116,6 +116,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
> >       struct nlm_args *argp = rqstp->rq_argp;
> >       struct nlm_host *host;
> >       struct nlm_file *file;
> > +     struct nlm_lockowner *test_owner;
> >       __be32 rc = rpc_success;
> >
> >       dprintk("lockd: TEST          called\n");
> > @@ -125,6 +126,8 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
> >       if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
> >               return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
> >
> > +     test_owner = argp->lock.fl.fl_owner;
> > +
> >       /* Now check for conflicting locks */
> >       resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
> >       if (resp->status == nlm_drop_reply)
> > @@ -133,7 +136,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
> >               dprintk("lockd: TEST          status %d vers %d\n",
> >                       ntohl(resp->status), rqstp->rq_vers);
> >
> > -     nlmsvc_release_lockowner(&argp->lock);
> > +     nlmsvc_put_lockowner(test_owner);
> >       nlmsvc_release_host(host);
> >       nlm_release_file(file);
> >       return rc;
> > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> > index fcef192e5e45..70ce419e2709 100644
> > --- a/include/linux/lockd/lockd.h
> > +++ b/include/linux/lockd/lockd.h
> > @@ -292,6 +292,7 @@ void                nlmsvc_locks_init_private(struct file_lock *, struct nlm_host *, pid_t);
> > __be32                  nlm_lookup_file(struct svc_rqst *, struct nlm_file **,
> >                                       struct nlm_lock *);
> > void            nlm_release_file(struct nlm_file *);
> > +void           nlmsvc_put_lockowner(struct nlm_lockowner *);
> > void            nlmsvc_release_lockowner(struct nlm_lock *);
> > void            nlmsvc_mark_resources(struct net *);
> > void            nlmsvc_free_host_resources(struct nlm_host *);
> > --
> > 2.31.1
> >
>
> --
> Chuck Lever
>
>
>


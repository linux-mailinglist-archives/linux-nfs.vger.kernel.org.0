Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213531E6F96
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437349AbgE1Wu3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 18:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437347AbgE1Wu1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 May 2020 18:50:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C73FC08C5C6
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2020 15:50:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k19so194590edv.9
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2020 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKR9Erwy2v8oWVrUnk1ZtjmoojOqRG3CDFNH2m/3wp4=;
        b=UQyaGeHaHlhtGCoHWS/5JKRDBHr6xSpLhP6jPQWFkfCx1ln0kHMWSj7qR7qSy9/RXu
         Z926t6ThfoXMiuOTTjlAfHoZxvm0in1MVmbkQaNIZGQLXaW0PoK4U1fL8sRRyl32cghE
         Wc8hypPXefdM/y0Of+yytayq2QaFo6auNqr9320dBosEnLzZU0z6euictk23yE10rFKd
         TfMkYxgq2usR61mbG33a0muTfHXjkxkwVcuzO86jjewTDgz8rjPaECLx1T3M+AI+xxFU
         /cKO9TrGJThhdacSdnlKVeX6TJ+MkeXt/HST0X5fYRElAGCI9Rad8YrSHgDo6Pycb4XY
         6Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKR9Erwy2v8oWVrUnk1ZtjmoojOqRG3CDFNH2m/3wp4=;
        b=VtMUjx/QXBaPkbg2ez1SVfu3XyxS1sB2mKjKAd3qF1dLQ8vL3vmuRuM6UB53/r2ip9
         pQZrgtzFnAVAweVuQAPC8+p+2PZNwI0o3ciimlTUB/IqHOhePB+IhsmrD88FF+w8+tMs
         w+YeGoZY76lyqPxCui5L016EolOtB6pIOPxKmcJNKrj+R7+gGyQ/ZlpmoWSKiWJEf7SC
         uVQrYJlCLbLNBZCyODq5plIf/Cte7RT8sHegDa7uG1xjDNoosz5HvxwPODyPHALVFKd1
         l8EPvNAJEY26cVes5bn79+ITgtIWAQfRdJxYfXFv1Qg2X1jqum1Zi/lHthRaARM0pHi4
         u9BQ==
X-Gm-Message-State: AOAM532CKzI7v+TP0crH7+nYi2EBnXn511F1i9yxSCL+pir6wTwj/O+i
        YkVaEhhXLozyv6IDbU3O/FPDiQkhm84pkC+7jNplRw==
X-Google-Smtp-Source: ABdhPJy49CHziGUkgYHSL9osczsErsYHjR+jshrzjc7sDedwKA/g7+uzJuyN68+5MsXnri41SQmc5v48tS4HMwXtjWI=
X-Received: by 2002:aa7:d650:: with SMTP id v16mr5277432edr.267.1590706225161;
 Thu, 28 May 2020 15:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE-hr2Fd1dKt=DUrVh-FJXzgGx5zhWr17SSbM1LOZ-pGQ@mail.gmail.com>
 <85234f9bde1c419e1a8d7e8a677e5d324325c56b.camel@hammerspace.com>
 <CAN-5tyHcExq5CqwrU3F4nRptt1=X917jzceUqLCTCUDYQsdsMA@mail.gmail.com> <f2f43e89d259c9bc447f2a7b885f236e88d9b6b3.camel@hammerspace.com>
In-Reply-To: <f2f43e89d259c9bc447f2a7b885f236e88d9b6b3.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 28 May 2020 18:50:13 -0400
Message-ID: <CAN-5tyFtBM=U=GvFVeon_jb2OqPu1rAjaWAkjQ8-zLkuZgAa+g@mail.gmail.com>
Subject: Re: How to handle revocation of locking state
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 28, 2020 at 6:24 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2020-05-28 at 17:43 -0400, Olga Kornievskaia wrote:
> > On Thu, May 28, 2020 at 5:10 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > Hi Olga,
> > >
> > > On Thu, 2020-05-28 at 16:42 -0400, Olga Kornievskaia wrote:
> > > > Hi folks,
> > > >
> > > > Looking for recommendation on what the client is suppose to be
> > > > doing
> > > > in the following situation. Client opens a file and has a byte-
> > > > range
> > > > lock which returned a locking state. Client is acquiring another
> > > > byte
> > > > range lock. It uses the returned locking stated for the 2nd lock.
> > > > Server returns ADMIN_REVOKED.
> > > >
> > > > Currently the client goes into an infinite loop of just resending
> > > > the
> > > > same LOCK operation with
> > > > the same locking stateid.
> > > >
> > > > Is this a recoverable situation? The fact that the lock state was
> > > > revoked, should it be an automatic EIO since previous lock is
> > > > lost
> > > > (so
> > > > why bother going forward)? Or should the client retry the lock
> > > > but
> > > > send it with the open stateid?
> > > >
> > > > Thank you.
> > >
> > > I think the right behaviour should be to just call
> > > nfs_inode_find_state_and_recover(). In principle that will end up
> > > either recovering the lock (if the user set the
> > > nfs.recover_lost_locks
> > > kernel parameter to 'true') or marking it as a lost lock, using
> > > NFS_LOCK_LOST.
> >
> > Why should acquiring of the 2nd lock depend on recovering the lock
> > who's stateid it was trying to use? I think the 1st stateid is lost
> > unrecoverable?
>
> Agreed. However that means the application needs to know that it may
> have corrupt data on its hands. We do know that this is the same
> application that took the first lock, because any close of the file
> (including due to application crashes) would result in the locks being
> returned.
>
> Some *NIX implementations have a special SIGLOST signal that their NFS
> clients can use to let the application know its state was lost. Linux
> unfortunately does not have such a signal, so we have to rely on error
> codes.
>
> > Right now what happens is code initiates recovery. open is sent. But
> > the retry of the 2nd lock has the INITIALIZED_LOCK set and so it
> > takes
> > the bad lock stateid (how about instead letting it use the recovered
> > open stateid?). How about instead do the follow.
>
> NFSv4.1 requires us to call FREE_STATEID on any stateid that is
> revoked, in order to let the server know when we've discovered that the
> lock was lost. So we also have to go through the recovery machinery to
> ensure that happens before we can deal with taking the second lock.

Please bear with me I'm still loss:
1. If you say "application needs to know", the only outcome of this I
see is failing with EIO the 2nd lock. Which was my initial suggestion
saying if this is at all recoverable or should this be a failure
(instead of the infinite loop).
2. In nfs4_handle_setlk_error() we already call
nfs4_schedule_stateid_recovery(), I interpret this as "recovery was
initiated". I'm not sure what you envision the recovery steps are
suppose to be (or are missing. I guess the only one I see is lack of
free_stateid of the 1st lock). If you're saying the recovery includes
recovery of the 1st lock, then that's step#1 (but we don't send
free_stateid() for say a delegation stateid if it was revoked either
(or at least I don't think we do, I can test that)).  But after all
the recovery is done, the 2nd lock request needs to be re-tried and
what I see unless we change something about NFS_LOCK_INITALIZED
setting, it will once again pick a bad locking stateid.

>
> Cheers
>   Trond
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD981E844A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgE2RG5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 May 2020 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2RG4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 May 2020 13:06:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C4C03E969
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 10:06:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q13so2281635edi.3
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iH3Z/HS3OaMXu8gOj8vIIc0UAdJThzpDg9N31yw/0KA=;
        b=MCzHWiYtFdvUywz31c4zbpdR1BAaFWycROnaMDS025KKvJCIJN0il52lj34M/g7zvQ
         oePx/FBVQS7xPzvMHMblse42CwA/CHgwyBImgDXeIPVaJ33EXJDGOD+0ioHp6xL7c61E
         qmy2JgD1LCSYf6fq0a7CmaXbmtgG7N8BqhLw43LpQljoLw3gUBt5nNguPE7B1ELHVH/J
         En8qGuD90AXLLu0nLNY3VmZHLDQVKgfRyeSHzyCa+So6giorg85PgUHtX2F1QGEjaQxU
         clnlJXwtRfHCPQQr3Hdk5J6f7bCR1oThfEFaG+y2QNMtSt/BZ0R0YKPe5/q/LIyfF9Iu
         0cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iH3Z/HS3OaMXu8gOj8vIIc0UAdJThzpDg9N31yw/0KA=;
        b=O/mTW2ygEFJijp2iBNlkfjOaMzaETkA82bc0chhpF+jUUhvF0m89gUVUSHWSXs0KaN
         mp9LRuU0fX2hREU9NfcqcWmp9UMedhbtcDugOYiJo789THtxikosQcbhb89bWuXjH7mM
         z6jQ0OGS/dcPzFCbVDx22qfnJRb/MiO36iHNLBjda+Pz2CcmKDq0qzeAFdHN2AnpMtM1
         yu8ptoir9+27oejEt3cIwKQKB/dfjHhvUWnC81QRPz/7/Ey/KAUHzTClD2p0/zfcjIAt
         Mn53quPG/2OIoxGw9fQ6YO406Kq6+9O4gAmHAiTs+S0wvizaQndL+mFyLpS7hyqciXxJ
         ewtQ==
X-Gm-Message-State: AOAM533v090kTC8M0aktzthvvwwrL4QB/1GmAONIEo2WsG6ixYj/Aj2I
        vLDiP9KQCF1AHwb6pobnvyCkxNV0XimqW/0kJ85vtw==
X-Google-Smtp-Source: ABdhPJxYW+bW+po1kXC+Tw9ove/aeM8w4wjQJ2HEMpuSxYAkMU2Fmi9ibkGhtRM7fC/jDs9tnRjK3rrsGg1WHSiV+yQ=
X-Received: by 2002:a05:6402:17af:: with SMTP id j15mr9004639edy.67.1590772014743;
 Fri, 29 May 2020 10:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE-hr2Fd1dKt=DUrVh-FJXzgGx5zhWr17SSbM1LOZ-pGQ@mail.gmail.com>
 <85234f9bde1c419e1a8d7e8a677e5d324325c56b.camel@hammerspace.com>
 <CAN-5tyHcExq5CqwrU3F4nRptt1=X917jzceUqLCTCUDYQsdsMA@mail.gmail.com>
 <f2f43e89d259c9bc447f2a7b885f236e88d9b6b3.camel@hammerspace.com>
 <CAN-5tyFtBM=U=GvFVeon_jb2OqPu1rAjaWAkjQ8-zLkuZgAa+g@mail.gmail.com> <c379e52a767493b088e5d7b755e7ffdab6a83a47.camel@hammerspace.com>
In-Reply-To: <c379e52a767493b088e5d7b755e7ffdab6a83a47.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 29 May 2020 13:06:43 -0400
Message-ID: <CAN-5tyG5gQwA0Urpcvh3FOeJhnK6=xByET57urSAjD9ZnzcBtQ@mail.gmail.com>
Subject: Re: How to handle revocation of locking state
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 28, 2020 at 7:54 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2020-05-28 at 18:50 -0400, Olga Kornievskaia wrote:
> > On Thu, May 28, 2020 at 6:24 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Thu, 2020-05-28 at 17:43 -0400, Olga Kornievskaia wrote:
> > > > On Thu, May 28, 2020 at 5:10 PM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > > Hi Olga,
> > > > >
> > > > > On Thu, 2020-05-28 at 16:42 -0400, Olga Kornievskaia wrote:
> > > > > > Hi folks,
> > > > > >
> > > > > > Looking for recommendation on what the client is suppose to
> > > > > > be
> > > > > > doing
> > > > > > in the following situation. Client opens a file and has a
> > > > > > byte-
> > > > > > range
> > > > > > lock which returned a locking state. Client is acquiring
> > > > > > another
> > > > > > byte
> > > > > > range lock. It uses the returned locking stated for the 2nd
> > > > > > lock.
> > > > > > Server returns ADMIN_REVOKED.
> > > > > >
> > > > > > Currently the client goes into an infinite loop of just
> > > > > > resending
> > > > > > the
> > > > > > same LOCK operation with
> > > > > > the same locking stateid.
> > > > > >
> > > > > > Is this a recoverable situation? The fact that the lock state
> > > > > > was
> > > > > > revoked, should it be an automatic EIO since previous lock is
> > > > > > lost
> > > > > > (so
> > > > > > why bother going forward)? Or should the client retry the
> > > > > > lock
> > > > > > but
> > > > > > send it with the open stateid?
> > > > > >
> > > > > > Thank you.
> > > > >
> > > > > I think the right behaviour should be to just call
> > > > > nfs_inode_find_state_and_recover(). In principle that will end
> > > > > up
> > > > > either recovering the lock (if the user set the
> > > > > nfs.recover_lost_locks
> > > > > kernel parameter to 'true') or marking it as a lost lock, using
> > > > > NFS_LOCK_LOST.
> > > >
> > > > Why should acquiring of the 2nd lock depend on recovering the
> > > > lock
> > > > who's stateid it was trying to use? I think the 1st stateid is
> > > > lost
> > > > unrecoverable?
> > >
> > > Agreed. However that means the application needs to know that it
> > > may
> > > have corrupt data on its hands. We do know that this is the same
> > > application that took the first lock, because any close of the file
> > > (including due to application crashes) would result in the locks
> > > being
> > > returned.
> > >
> > > Some *NIX implementations have a special SIGLOST signal that their
> > > NFS
> > > clients can use to let the application know its state was lost.
> > > Linux
> > > unfortunately does not have such a signal, so we have to rely on
> > > error
> > > codes.
> > >
> > > > Right now what happens is code initiates recovery. open is sent.
> > > > But
> > > > the retry of the 2nd lock has the INITIALIZED_LOCK set and so it
> > > > takes
> > > > the bad lock stateid (how about instead letting it use the
> > > > recovered
> > > > open stateid?). How about instead do the follow.
> > >
> > > NFSv4.1 requires us to call FREE_STATEID on any stateid that is
> > > revoked, in order to let the server know when we've discovered that
> > > the
> > > lock was lost. So we also have to go through the recovery machinery
> > > to
> > > ensure that happens before we can deal with taking the second lock.
> >
> > Please bear with me I'm still loss:
> > 1. If you say "application needs to know", the only outcome of this I
> > see is failing with EIO the 2nd lock. Which was my initial suggestion
> > saying if this is at all recoverable or should this be a failure
> > (instead of the infinite loop).
>
> It should be a failure unless the nfs.recover_lost_locks kernel
> parameter is set, in which case it should silently recover the lost
> lock. The default behaviour should therefore be failure.

Ok got it. Let me figure out how to make it fail.

> > 2. In nfs4_handle_setlk_error() we already call
> > nfs4_schedule_stateid_recovery(), I interpret this as "recovery was
> > initiated". I'm not sure what you envision the recovery steps are
> > suppose to be (or are missing. I guess the only one I see is lack of
> > free_stateid of the 1st lock). If you're saying the recovery includes
> > recovery of the 1st lock, then that's step#1 (but we don't send
> > free_stateid() for say a delegation stateid if it was revoked either
> > (or at least I don't think we do, I can test that)).  But after all
> > the recovery is done, the 2nd lock request needs to be re-tried and
> > what I see unless we change something about NFS_LOCK_INITALIZED
> > setting, it will once again pick a bad locking stateid.
> >
>
> Recovery of the lost lock only happens in the non-default case
> described previously. However whether or not we recover the lock, we
> need to call FREE_STATEID on the stateid that is returning
> NFS4ERR_ADMIN_REVOKED (or NFS4ERR_DELEG_REVOKED if the stateid is a
> delegation).
> After the call to FREE_STATEID, the server will start returning
> NFS4ERR_BAD_STATEID if we ever present the revoked lock stateid again.
>
>
> So yes, once we're done sending FREE_STATEID, we can clear
> NFS_LOCK_INITIALIZED and start new locking requests from scratch.

But the latter would happen only if the previous lost lock would be
recovered. And if it's recovered then we don't need to clear anything
and let the 2nd lock again use the locking state as before?

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

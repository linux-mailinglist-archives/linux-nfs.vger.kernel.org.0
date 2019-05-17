Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0941021FD8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 May 2019 23:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfEQVpj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 May 2019 17:45:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55772 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfEQVpj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 May 2019 17:45:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so8166043wmb.5
        for <linux-nfs@vger.kernel.org>; Fri, 17 May 2019 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yXqqOUIRgPLvRdCXc9Tq5YDqKJRUmjq3jkGsgAglrZY=;
        b=HPiWTgNyi3vAXyICb8qPUFcElPmNnbX7tHXq0thCkPGA2tUimOtFDeK2ie6Gax6xt1
         66qWW6JZZD7QKSTzH1TwXfPXvM/IfVFnOIYF8MX5BAdDQbJdHkmi16JCpwmmkq4uEtFb
         vmk7w0CZvq9L1/R7BS3Bh9N1MAiTOySC1SnTE3Det2GOvpbAHdRoIsDanZjuGQvfibAR
         Kla2b9Ls45327q2lBcxHhWKWJLuXXHwffFUggrL+7h60A/KbRjKUp/bbtMQ3INnIrTTX
         vgWcSTIoTwS1gcDxwJOOnGkuBeJjqLcdO77CVp3vjY1/HVcZ1oL6mmL3oL+JehvjF0UK
         zKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yXqqOUIRgPLvRdCXc9Tq5YDqKJRUmjq3jkGsgAglrZY=;
        b=IGKuTnXw1idoKPpxSjcP1wJBwhPO+RYgbJDiOiX1nd+mOQwl4prXUWpoCfIbQyJLfs
         D3wlSwaSZ1tpU2M33ls45IcFdCDSzgpb7UV8ofe/e9WuhNF4pSAugVsLxqzoP3SPdDp7
         l5c7QkIwiXGkolzinqzR9FNutctAZ4ViFttvUU2Eaq//yETipF9XFMPxz1M7ZSdOy6CG
         IvsnkST1KGVoQ61W5YSyRr+aW4w8aJvo4oxwt/xkxc3PjqX6ukrA9g+4FjhqFHxABMLC
         /+elmvFp+T/SiNyyCkvfX3TNew4nZPiIW2Fi1GMaIMQK8Ft40JrrrOSoLR69tN0npkqv
         i84g==
X-Gm-Message-State: APjAAAXMxhF2/0nMOQu5cdIX54bJO7vllhh695wGkng2IKUyp2r0aasf
        FSuqi2Igh94/DekmGZT39+J9pnR4jcnUa0SEMw47Hw==
X-Google-Smtp-Source: APXvYqxLaV9BgRwmGPUbDnpFUIIAw0nO3VU10Dz3UhG19Xnu2B+OPVVq9I58KyLnehTlKJtyw3lGnhiI7G6bPbnI9yg=
X-Received: by 2002:a1c:1903:: with SMTP id 3mr32513807wmz.103.1558129536121;
 Fri, 17 May 2019 14:45:36 -0700 (PDT)
MIME-Version: 1.0
From:   Xuewei Zhang <xueweiz@google.com>
Date:   Fri, 17 May 2019 14:45:25 -0700
Message-ID: <CAPtwhKrJw54DmfVdP4ADd3w5QPv0cRP+kr1Atn58QOFL5xBGbA@mail.gmail.com>
Subject: Re: Re: [PATCH] lockd: Show pid of lockd for remote locks
To:     bfields@fieldses.org, bcodding@redhat.com,
        Grigor Avagyan <grigora@google.com>,
        Trevor Bourget <bourget@google.com>,
        Nauman Rafique <nauman@google.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jlayton@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Fri, Nov 02, 2018 at 02:45:16PM -0400, J. Bruce Fields wrote:
> > On Thu, Nov 01, 2018 at 01:39:49PM -0400, Benjamin Coddington wrote:
> > > Commit 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid
> > > for remote locks") specified that the l_pid returned for F_GETLK on a local
> > > file that has a remote lock should be the pid of the lock manager process.
> > > That commit, while updating other filesystems, failed to update lockd, such
> > > that locks created by lockd had their fl_pid set to that of the remote
> > > process holding the lock.  Fix that here to be the pid of lockd.
> > >
> > > Also, fix the client case so that the returned lock pid is negative, which
> > > indicates a remote lock on a remote file.

Seems this patch introduced a bug in how lock protocol handles
GRANTED_MSG in nfs.

For example under this scenario:
1. Client1 takes an exclusive lock on a file and holds it
   (client1 sends LOCK request, and server replies with success)
2. Client2 attempts to take an exclusive lock on the same file and gets blocked
   (client2 sends LOCK request, and server replies with NLM_BLOCKED)
3. Client1 release the lock
   (client1 sends UNLOCK request, and server replies with success)
4. Server grant the lock to Client
   (server sends GRANTED_MSG to clients)
5. Client2 looks at all currently blocked locks and see if the
   fl_blocked->fl_u.nfs_fl.owner->pid matches lock->svid [1]
6. The owner->pid and lock->svid *should* match, and Client2 will then
take the lock.

Looking closely of how the matching at step 5 is implemented:
https://github.com/torvalds/linux/blob/e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd/fs/lockd/clntlock.c#L186
The comment says that the owner->pid should be the lockowner's PID, rather
than lock manager process(lockd)'s PID.

This patch b8eee0e90f97 ("lockd: Show pid of lockd for remote locks") changed
the behavior of lockd so that it sends the PID of lockd instead of lockowner's
PID at lock->svid, which results in the bug in the lock protocol.

The bug can be reproduced by opening two nfs clients on /nfs. And do this:
1. On client1: sudo flock /nfs/lock -c read
2. On client2: sudo flock /nfs/lock -c date
3. Now quit client 1 by ctrl-D.

You will see that client2 will take ~30 seconds before taking the lock (this is
because the GRANTED_MSG got discarded by client2 since svid doesn't match.
And then client2 retries after 30 seconds). The expected behavior is client2
should take the lock immediately.

On a kernel built with this b8eee0e90f97 ("lockd: Show pid of lockd for remote
locks") reverted, it shows the expected behavior.

I suspect 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for
remote locks") probably chose to not update lockd for this reason.

Should we consider maybe reverting or fixing b8eee0e90f97 ("lockd:
Show pid of lockd
for remote locks")?

Thanks!
Xuewei

[1] https://github.com/torvalds/linux/blob/e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd/fs/lockd/clntlock.c#L186

> >
> > ACK.
> >
> > Uh, I guess I'll take this if nobody else speaks up.
>
> Applied for 4.21.--b.
>
> >
> > --b.
> >
> > >
> > > Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific...")
> > > Cc: stable@vger.kernel.org
> > >
> > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > > ---
> > >  fs/lockd/clntproc.c | 2 +-
> > >  fs/lockd/xdr.c      | 4 ++--
> > >  fs/lockd/xdr4.c     | 4 ++--
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > index d20b92f271c2..0a67dd4250e9 100644
> > > --- a/fs/lockd/clntproc.c
> > > +++ b/fs/lockd/clntproc.c
> > > @@ -442,7 +442,7 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
> > >   fl->fl_start = req->a_res.lock.fl.fl_start;
> > >   fl->fl_end = req->a_res.lock.fl.fl_end;
> > >   fl->fl_type = req->a_res.lock.fl.fl_type;
> > > - fl->fl_pid = 0;
> > > + fl->fl_pid = -req->a_res.lock.fl.fl_pid;
> > >   break;
> > >   default:
> > >   status = nlm_stat_to_errno(req->a_res.status);
> > > diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
> > > index 7147e4aebecc..9846f7e95282 100644
> > > --- a/fs/lockd/xdr.c
> > > +++ b/fs/lockd/xdr.c
> > > @@ -127,7 +127,7 @@ nlm_decode_lock(__be32 *p, struct nlm_lock *lock)
> > >
> > >   locks_init_lock(fl);
> > >   fl->fl_owner = current->files;
> > > - fl->fl_pid   = (pid_t)lock->svid;
> > > + fl->fl_pid   = current->tgid;
> > >   fl->fl_flags = FL_POSIX;
> > >   fl->fl_type  = F_RDLCK; /* as good as anything else */
> > >   start = ntohl(*p++);
> > > @@ -269,7 +269,7 @@ nlmsvc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
> > >   memset(lock, 0, sizeof(*lock));
> > >   locks_init_lock(&lock->fl);
> > >   lock->svid = ~(u32) 0;
> > > - lock->fl.fl_pid = (pid_t)lock->svid;
> > > + lock->fl.fl_pid = current->tgid;
> > >
> > >   if (!(p = nlm_decode_cookie(p, &argp->cookie))
> > >   || !(p = xdr_decode_string_inplace(p, &lock->caller,
> > > diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> > > index 7ed9edf9aed4..70154f376695 100644
> > > --- a/fs/lockd/xdr4.c
> > > +++ b/fs/lockd/xdr4.c
> > > @@ -119,7 +119,7 @@ nlm4_decode_lock(__be32 *p, struct nlm_lock *lock)
> > >
> > >   locks_init_lock(fl);
> > >   fl->fl_owner = current->files;
> > > - fl->fl_pid   = (pid_t)lock->svid;
> > > + fl->fl_pid   = current->tgid;
> > >   fl->fl_flags = FL_POSIX;
> > >   fl->fl_type  = F_RDLCK; /* as good as anything else */
> > >   p = xdr_decode_hyper(p, &start);
> > > @@ -266,7 +266,7 @@ nlm4svc_decode_shareargs(struct svc_rqst *rqstp, __be32 *p)
> > >   memset(lock, 0, sizeof(*lock));
> > >   locks_init_lock(&lock->fl);
> > >   lock->svid = ~(u32) 0;
> > > - lock->fl.fl_pid = (pid_t)lock->svid;
> > > + lock->fl.fl_pid = current->tgid;
> > >
> > >   if (!(p = nlm4_decode_cookie(p, &argp->cookie))
> > >   || !(p = xdr_decode_string_inplace(p, &lock->caller,
> > > --
> > > 2.14.3

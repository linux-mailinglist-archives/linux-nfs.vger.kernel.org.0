Return-Path: <linux-nfs+bounces-8012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06779CF23C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251001F21092
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558F01D5172;
	Fri, 15 Nov 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exh8cdkB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32D847C;
	Fri, 15 Nov 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689911; cv=none; b=LlQe3UU7HUZpSyAdQXz9EoT16RFBp2mcWwURzoUDByIGeEhv5Q1vvNYTrk/iFJkL6a9vq3y2QdoTr5m6jDb7Pt9RoY3zsBwDG7NuKUBhNjHk0PgYyGuWQmHzCL6Fg72P3eWm4GL7zEHRx3tf6xcq4XiGJL9Vr45fGvsiAnM9uF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689911; c=relaxed/simple;
	bh=+diPlS6drHYTTbEBscxwjk98t3Tr5UjD7fLgAqRxsFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC3lzoWMmWYlnhBozCKLV82x6Cf6R+sCRBOjs2gh7NhXV0iTyorBFnQMIlz/n4d1cGXE4ruOUeDH88z0YFnuAj5Lte2p8W3ZVnoRVdenpQAf3srvkMG6Orzys+qHEKVAaNL6S4PB5ocwqdYHpiaEz0/1xWdDkqezl4Zxi45Px1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exh8cdkB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so1679448a91.2;
        Fri, 15 Nov 2024 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731689909; x=1732294709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpNGtLDGMDR9feWtepju5qrqLCKQ8PwkgbQnookjB1M=;
        b=exh8cdkBYgnX5m0EoKu2dR4o99WoL8Od7k4S6xdH1KFdsA1j1uQ03e9cXIqOAcQ3Dz
         pgzyVNO6/gRpYXw6vs2CUqYJFNWvt6KzAMCUcKqyJ8yTRs9fQZOkd8Fn634wvmb2bgW+
         5cJHZ+9jwcsx0UM/v50LFVNB2QJ5gwg22HNOrtx1sihSA8T5bkmwzr8YP77eFTcpZstU
         QlPaCfqTaWKn7JH+8yFxxV+nT2yQStpz05MuGm91rq16jDvco8wcIqmef6HLom7wlGAk
         kUjzFQdocBBLDzNdW5VhAmK4ICcAy00L/hFF0uws0hOOKQnyPGXQRtHdJ4csK/XZTmwW
         gi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731689909; x=1732294709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpNGtLDGMDR9feWtepju5qrqLCKQ8PwkgbQnookjB1M=;
        b=dFelKbzEgeIHnl84Qpg0b1IvTe/mbIK3fX1l6d4MxD5HiIdcIEWnj9ZC3pq29wRxzq
         Yr8dqgp56hlt+njrZ5hSpCHPv5NtC3kDNigodPNln9kv5jOMOT1G66J2XjI/9Bhr6YIg
         1eM2d53XxpCJV9LR77dWTekbuUVeuismRSCOcWwbLwUwPIk1YYprNxCdZKZKWVrluUAz
         pgumdu0miV9hzTodDUjBn5MicguPGnPK07lm41e7OZDHo+bjyxarHJX1uKU15/oBuUX4
         THt2Gpn4tFWBOmHrlZtKjcqk25kjM32UBYfdUlq0j8Ouft0KMZXrBB/K34Tb6vm2aJO8
         C8WA==
X-Forwarded-Encrypted: i=1; AJvYcCUbDQwnHmePGuQihjlqAc5ADG3ZHkCyRJcKplC1tFhQNByBQz6qyqPd9FyLKFhsHmZn7dZygHpl@vger.kernel.org, AJvYcCX5KARTu0zWv1iSkyFkwziirTqqJ/FHtxF7lK/JKOuXcRWVH/mzzWXaZSNSVfJZNr3ZL5ZfKHm0shA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRwnASMopFtmKxdC89f59j1RzKCh8ZUlfGxbhx47z+0CykBdV
	XK3duEc9CM7lm2Vs8C4bXwlAXawDwWcSx4Fp2To8Da/qgo9O12L6VsGnB8ec4YISK/Q1vOKLHOv
	StL6h29w98Yp6VVemtgGxDS9MzyhUzyQ8BAk=
X-Google-Smtp-Source: AGHT+IGe/R9bUVI3bNg2/fNPfBs74Nk+DV6SSIg8JJE7gAmbz+OwtjrcXhiCgVaEjiLNzNi5VoxGkOxgRBd/sMxPlaE=
X-Received: by 2002:a17:90b:48d1:b0:2ea:10de:1ceb with SMTP id
 98e67ed59e1d1-2ea15589e04mr3806636a91.25.1731689908784; Fri, 15 Nov 2024
 08:58:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net> <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
 <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com> <Zzd5YaI99+hieQV+@tissot.1015granger.net>
In-Reply-To: <Zzd5YaI99+hieQV+@tissot.1015granger.net>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 16 Nov 2024 01:58:17 +0900
Message-ID: <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
Subject: Re: tmpfs hang after v6.12-rc6
To: Chuck Lever <chuck.lever@oracle.com>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-nfs@vger.kernel.org, hughd@google.com, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On Sat, Nov 16, 2024 at 01:33:19AM +0900, Jeongjun Park wrote:
> > 2024=EB=85=84 11=EC=9B=94 16=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 1:=
25, Chuck Lever <chuck.lever@oracle.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > On Fri, Nov 15, 2024 at 11:04:56AM -0500, Chuck Lever wrote:
> > > > I've found that NFS access to an exported tmpfs file system hangs
> > > > indefinitely when the client first performs a GETATTR. The hanging
> > > > nfsd thread is waiting for the inode lock in shmem_getattr():
> > > >
> > > > task:nfsd            state:D stack:0     pid:1775  tgid:1775  ppid:=
2      flags:0x00004000
> > > > Call Trace:
> > > >  <TASK>
> > > >  __schedule+0x770/0x7b0
> > > >  schedule+0x33/0x50
> > > >  schedule_preempt_disabled+0x19/0x30
> > > >  rwsem_down_read_slowpath+0x206/0x230
> > > >  down_read+0x3f/0x60
> > > >  shmem_getattr+0x84/0xf0
> > > >  vfs_getattr_nosec+0x9e/0xc0
> > > >  vfs_getattr+0x49/0x50
> > > >  fh_getattr+0x43/0x50 [nfsd]
> > > >  fh_fill_pre_attrs+0x4e/0xd0 [nfsd]
> > > >  nfsd4_open+0x51f/0x910 [nfsd]
> > > >  nfsd4_proc_compound+0x492/0x5d0 [nfsd]
> > > >  nfsd_dispatch+0x117/0x1f0 [nfsd]
> > > >  svc_process_common+0x3b2/0x5e0 [sunrpc]
> > > >  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> > > >  svc_process+0xcf/0x130 [sunrpc]
> > > >  svc_recv+0x64e/0x750 [sunrpc]
> > > >  ? __wake_up_bit+0x4b/0x60
> > > >  ? __pfx_nfsd+0x10/0x10 [nfsd]
> > > >  nfsd+0xc6/0xf0 [nfsd]
> > > >  kthread+0xed/0x100
> > > >  ? __pfx_kthread+0x10/0x10
> > > >  ret_from_fork+0x2e/0x50
> > > >  ? __pfx_kthread+0x10/0x10
> > > >  ret_from_fork_asm+0x1a/0x30
> > > >  </TASK>
> > > >
> > > > I bisected the problem to:
> > > >
> > > > d949d1d14fa281ace388b1de978e8f2cd52875cf is the first bad commit
> > > > commit d949d1d14fa281ace388b1de978e8f2cd52875cf
> > > > Author:     Jeongjun Park <aha310510@gmail.com>
> > > > AuthorDate: Mon Sep 9 21:35:58 2024 +0900
> > > > Commit:     Andrew Morton <akpm@linux-foundation.org>
> > > > CommitDate: Mon Oct 28 21:40:39 2024 -0700
> > > >
> > > >     mm: shmem: fix data-race in shmem_getattr()
> > > >
> > > > ...
> > > >
> > > >     Link: https://lkml.kernel.org/r/20240909123558.70229-1-aha31051=
0@gmail.com
> > > >     Fixes: 44a30220bc0a ("shmem: recalculate file inode when fstat"=
)
> > > >     Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > >     Reported-by: syzbot <syzkaller@googlegroup.com>
> > > >     Cc: Hugh Dickins <hughd@google.com>
> > > >     Cc: Yu Zhao <yuzhao@google.com>
> > > >     Cc: <stable@vger.kernel.org>
> > > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > >
> > > > which first appeared in v6.12-rc6, and adds the line that is waitin=
g
> > > > on the inode lock when my NFS server hangs.
> > > >
> > > > I haven't yet found the process that is holding the inode lock for
> > > > this inode.
> > >
> > > It is likely that the caller (nfsd4_open()-> fh_fill_pre_attrs()) is
> > > already holding the inode semaphore in this case.
> >
> > Thanks for letting me know!
> >
> > It seems that the previous patch I wrote was wrong in how to prevent da=
ta-race.
> > It seems that the problem occurs in nfsd because nfsd4_create_file() al=
ready
> > holds the inode_lock.
> >
> > After further analysis, I found that this data-race mainly occurs when
> > vfs_statx_path does not acquire the inode_lock, and in other filesystem=
s,
> > it is confirmed that inode_lock is acquired in many cases, so I will se=
nd a
> > new patch that fixes this problem right away.
>
> Thanks for your quick response!
>
> My brief sample of file system ->getattr methods shows that these
> functions do not grab the inode semaphore at all when calling
> generic_fillattr(). Likely they expect the method's caller to take
> it.
>
> I strongly prefer to see this commit reverted for v6.12-rc first,
> and then the new fix should be merged via a normal merge window to
> permit a lengthy period of testing.
>

Hmm... Of course, revert this patch is not a bad idea, but I think that
patching it like below can effectively prevent data-race without causing
recursive locking:

---
 mm/shmem.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e87f5d6799a7..d061f8b34d49 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1153,6 +1153,12 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 {
    struct inode *inode =3D path->dentry->d_inode;
    struct shmem_inode_info *info =3D SHMEM_I(inode);
+   bool inode_locked =3D NULL;
+
+   if (!inode_is_locked(inode)) {
+       inode_lock_shared(inode);
+       inode_locked =3D true;
+   }

    if (info->alloced - info->swapped !=3D inode->i_mapping->nrpages)
        shmem_recalc_inode(inode, 0, 0);
@@ -1166,9 +1172,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
    stat->attributes_mask |=3D (STATX_ATTR_APPEND |
            STATX_ATTR_IMMUTABLE |
            STATX_ATTR_NODUMP);
-   inode_lock_shared(inode);
    generic_fillattr(idmap, request_mask, inode, stat);
-   inode_unlock_shared(inode);

    if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
        stat->blksize =3D HPAGE_PMD_SIZE;
@@ -1179,6 +1183,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
        stat->btime.tv_nsec =3D info->i_crtime.tv_nsec;
    }

+   if (inode_locked)
+       inode_unlock_shared(inode);
+
    return 0;
 }

--

What do you think?

Regards,

Jeongjun Park

>
> > > > Because this commit addresses only a KCSAN splat that has been
> > > > present since v4.3, and does not address a reported behavioral
> > > > issue, I respectfully request that this commit be reverted
> > > > immediately so that it does not appear in v6.12 final.
> > > > Troubleshooting and testing should continue until a fix to the KCSA=
N
> > > > issue can be found that does not deadlock NFS exports of tmpfs.
> > > >
> > > >
> > > > --
> > > > Chuck Lever
> > > >
> > >
> > > --
> > > Chuck Lever
>
> --
> Chuck Lever


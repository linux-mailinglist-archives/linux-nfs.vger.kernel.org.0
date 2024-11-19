Return-Path: <linux-nfs+bounces-8117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA49D2879
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 15:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84090283813
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0988D1CC8AB;
	Tue, 19 Nov 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+96kdDK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E81C2DB2;
	Tue, 19 Nov 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027585; cv=none; b=q+YCtlhMeHPUdh7bU69W860HtzHfbR0+5z8o/gJcCeIa2i9OAMGcoyL2E6gcNTy7T4l28ObNr8vpDMK+nzMaf9B8Expt2j8Oe0CV3rxvPK3l6SEhLOU2/prERH5DY3b2oAoaljnhTWepnv/LP9ZdjgW68p6kQyI0N7L5WiRJIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027585; c=relaxed/simple;
	bh=1yNxkJQIBNUNkxUhuuUzU9DOqF1PO5OhW9mBW+AFj04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfNOdb/1cJWshXxFKK3eHEFUhoBZXIR1ekHkCNVc9uhA5i38BWthC8XJWzsi/MysGZOFKBjf+WBEeUuTpKvmp5ci010nuxcnt67QYl30DBALeN6gq6Nn70DtggZIIkZQgGh3kLZrRTFAKVE/HNlwk3huzA0jRvpZdnsCJcDcnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+96kdDK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e59746062fso3541083a91.2;
        Tue, 19 Nov 2024 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732027584; x=1732632384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhU4UilIbYdrDrjypSuw/NhypySpnJk2d5j9Supd8xQ=;
        b=c+96kdDKTDkiRJeec7e9st4AKHyZGORMPL+t0QZSahvWBrVbc3K01LJyFBPiZji68h
         vPndw2o8BgWVzEKNiuFIerXR7nsQ3BRxGoVbm2PFkJpp67Xg3L4k/r3MftUcc5y5o6w+
         nCTlK1rNQXOB/fdDxp4klL0aHn/Fty4BrewlAajIYguMgIZQfkpu4W35Ai/IJ0WSIdx1
         AxF5BUyFACQRhwMKj3z3p1H9iO9+VPfX8g5huDQ5X9K3EAz95pPt02dC6qNLqlcFE66v
         XKHjscsZ0SuBEk8CTixdMzJbpGYWg7k5K4NBh3aW13cuLDVQkxMCwGhIqjDzQNbOfvRz
         ekPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732027584; x=1732632384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhU4UilIbYdrDrjypSuw/NhypySpnJk2d5j9Supd8xQ=;
        b=rQZyqXxSRRC85mjoPZ6ydgqh67aV3/Ozp8dIGtPgop68gRS2vRbkPaSLJbEXWXj0p8
         wyJH/RB+1EpC2eoYvskJ31a/bDxrdZh7dYabczoa1h0r6r4d85m03y2kitCeK7pRESDf
         Zd9vEiM0SheLTWh8Xm8LPy7X3TJ5LV+qp8B+qemT/R8iG2jwejRPmCzAOkmSeU4E2Zdu
         wSFWe0yQfGcClUVio0QqyiXbgMPNR28s7Dm1GtPxvKS5uvr605cW3D3pLz0sty+QANJP
         HZzyYKtQLkvXReMATYPdQO3pHDGfSaoGxweEHGa1R/FUzaqCARI69kk4u1J7XHpr2ca+
         zAhA==
X-Forwarded-Encrypted: i=1; AJvYcCVuJZN/pkvOa4Q7Gy64dnc+Ieb0FFWJWuHZ+BVxzt9G6vI/moc/pmauOjMDcWpnms/3zCMMMpXr@vger.kernel.org, AJvYcCWXZRLhXK+hXP8vT1GqradwgnOhjBYVBJFTsCj1cqE+phg5R9W81N6MrtrkhSlAMLLdbaaDesqW/pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc97GTQBXNlJAo1nOK4lC+uJZh5sCaNZPruLjtVgOhJwQFRc81
	gN2GBN9+RBTN3wJRfa4nYMAxlrdMTZJMtJXwUuTjhLQpCvGtyomD/aspWhwZWQVt+0xtXk/PNn3
	TcCm17AjD+wyGqhXL0+YG+47Q9uA89ew2YX4=
X-Google-Smtp-Source: AGHT+IHX13fgLUBERLbH2f3ZiLxcE1cawE1SueBDGN5MbTxakABaYJ135yJMPvCn1quBjgJd+2xGOMJ4hvO2sExvc10=
X-Received: by 2002:a17:90b:2d8c:b0:2ea:6f96:6504 with SMTP id
 98e67ed59e1d1-2ea6f968132mr9077999a91.1.1732027583528; Tue, 19 Nov 2024
 06:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net> <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
 <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
 <Zzd5YaI99+hieQV+@tissot.1015granger.net> <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
 <ZzeQ1m3xIjrbUMDv@tissot.1015granger.net> <b40e7156-7500-5268-4c3d-c61a6382d1f0@google.com>
 <Zzi1FzrwmNIMIvnH@tissot.1015granger.net> <cdb68fac913bdc16e692f2f2cb833b5dca2d996a.camel@kernel.org>
In-Reply-To: <cdb68fac913bdc16e692f2f2cb833b5dca2d996a.camel@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 19 Nov 2024 23:46:10 +0900
Message-ID: <CAO9qdTGjbtMD9t3PNx95VWF7h_CWo7bWrKSzeqM6op5gxV-Zsg@mail.gmail.com>
Subject: Re: tmpfs hang after v6.12-rc6
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 
	linux-nfs@vger.kernel.org, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sat, 2024-11-16 at 10:07 -0500, Chuck Lever wrote:
> > On Fri, Nov 15, 2024 at 05:31:38PM -0800, Hugh Dickins wrote:
> > > On Fri, 15 Nov 2024, Chuck Lever wrote:
> > > >
> > > > As I said before, I've failed to find any file system getattr method
> > > > that explicitly takes the inode's semaphore around a
> > > > generic_fillattr() call. My understanding is that these methods
> > > > assume that their caller handles appropriate serialization.
> > > > Therefore, taking the inode semaphore at all in shmem_getattr()
> > > > seems to me to be the wrong approach entirely.
> > > >
> > > > The point of reverting immediately is that any fix can't possibly
> > > > get the review and testing it deserves three days before v6.12
> > > > becomes final. Also, it's not clear what the rush to fix the
> > > > KCSAN splat is; according to the Fixes: tag, this issue has been
> > > > present for years without causing overt problems. It doesn't feel
> > > > like this change belongs in an -rc in the first place.
> > > >
> > > > Please revert d949d1d14fa2, then let's discuss a proper fix in a
> > > > separate thread. Thanks!
> > >
> > > Thanks so much for reporting this issue, Chuck: just in time.
> > >
> > > I agree abso-lutely with you: I was just preparing a revert,
> > > when I saw that akpm is already on it: great, thanks Andrew.
> >
> > Thanks to you both for jumping on this!
> >
> >
> > > I was not very keen to see that locking added, just to silence a syzbot
> > > sanitizer splat: added where there has never been any practical problem
> > > (and the result of any stat immediately stale anyway).  I was hoping we
> > > might get a performance regression reported, but a hang serves better!
> > >
> > > If there's a "data_race"-like annotation that can be added to silence
> > > the sanitizer, okay.  But more locking?  I don't think so.
> >
> > IMHO the KCSAN splat suggests there is a missing inode_lock/unlock
> > pair /somewhere/. Just not in shmem_getattr().
> >
> > Earlier in this thread, Jeongjun reported:
> > > ... I found that this data-race mainly occurs when vfs_statx_path
> > > does not acquire the inode_lock ...
> >
> > That sounds to me like a better place to address this; or at least
> > that is a good place to start looking for the problem.
> >
>
> I don't think this data race is anything to worry about:
>
>     ==================================================================
>     BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current
>
>     write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
>      inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
>      inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
>      shmem_mknod+0x117/0x180 mm/shmem.c:3443
>      shmem_create+0x34/0x40 mm/shmem.c:3497
>      lookup_open fs/namei.c:3578 [inline]
>      open_last_lookups fs/namei.c:3647 [inline]
>      path_openat+0xdbc/0x1f00 fs/namei.c:3883
>
>     write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
>      inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
>      inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
>      shmem_mknod+0x117/0x180 mm/shmem.c:3443
>      shmem_create+0x34/0x40 mm/shmem.c:3497
>      lookup_open fs/namei.c:3578 [inline]
>      open_last_lookups fs/namei.c:3647 [inline]
>      path_openat+0xdbc/0x1f00 fs/namei.c:3883
>      do_filp_open+0xf7/0x200 fs/namei.c:3913
>      do_sys_openat2+0xab/0x120 fs/open.c:1416
>      do_sys_open fs/open.c:1431 [inline]
>      __do_sys_openat fs/open.c:1447 [inline]
>      __se_sys_openat fs/open.c:1442 [inline]
>      __x64_sys_openat+0xf3/0x120 fs/open.c:1442
>      x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:258
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>     read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
>      inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
>      inode_get_ctime include/linux/fs.h:1629 [inline]
>      generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
>      shmem_getattr+0x17b/0x200 mm/shmem.c:1157
>      vfs_getattr_nosec fs/stat.c:166 [inline]
>      vfs_getattr+0x19b/0x1e0 fs/stat.c:207
>      vfs_statx_path fs/stat.c:251 [inline]
>      vfs_statx+0x134/0x2f0 fs/stat.c:315
>      vfs_fstatat+0xec/0x110 fs/stat.c:341
>      __do_sys_newfstatat fs/stat.c:505 [inline]
>      __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
>      __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
>      x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>     value changed: 0x2755ae53 -> 0x27ee44d3
>
>     Reported by Kernel Concurrency Sanitizer on:
>     CPU: 0 UID: 0 PID: 3498 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
>     ==================================================================
>
> inode_set_ctime_to_ts() is just setting the ctime fields in the inode
> to the timespec64. inode_get_ctime_nsec() is just fetching the ctime
> nsec field.
>
> We've never tried to synchronize readers and writers when it comes to
> timestamps. It has always been possible to read an inconsistent
> timestamp from the inode. The sec and nsec fields are in different
> words, and there is no synchronization when updating the fields.
>
> Timestamp fetches seem like the right place to use a seqcount loop, but
> I don't think we would want to add any sort of locking to the update
> side of things. Maybe that's doable?

I agree with this opinion to some extent, but I also observe the following
data-race:

==================================================================
BUG: KCSAN: data-race in shmem_getattr / shmem_recalc_inode

read-write to 0xffff88811a219d20 of 8 bytes by task 12342 on cpu 1:
 shmem_recalc_inode+0x36/0x1b0 mm/shmem.c:437
 shmem_alloc_and_add_folio mm/shmem.c:1866 [inline]
 shmem_get_folio_gfp+0x7ce/0xd90 mm/shmem.c:2330
 shmem_get_folio mm/shmem.c:2436 [inline]
 shmem_write_begin+0xa2/0x180 mm/shmem.c:3038
 generic_perform_write+0x1a8/0x4a0 mm/filemap.c:4054
 shmem_file_write_iter+0xc2/0xe0 mm/shmem.c:3213
 __kernel_write_iter+0x24b/0x4e0 fs/read_write.c:616
 dump_emit_page fs/coredump.c:884 [inline]
 dump_user_range+0x3a7/0x550 fs/coredump.c:945
 elf_core_dump+0x1b66/0x1c60 fs/binfmt_elf.c:2121
 do_coredump+0x1736/0x1ce0 fs/coredump.c:758
 get_signal+0xdc0/0x1070 kernel/signal.c:2903
 arch_do_signal_or_restart+0x95/0x4b0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x9a/0x130 kernel/entry/common.c:231
 irqentry_exit+0x12/0x50 kernel/entry/common.c:334
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

read to 0xffff88811a219d20 of 8 bytes by task 10055 on cpu 0:
 shmem_getattr+0x42/0x200 mm/shmem.c:1157
 vfs_getattr_nosec fs/stat.c:166 [inline]
 vfs_getattr+0x19b/0x1e0 fs/stat.c:207
 vfs_statx_path fs/stat.c:251 [inline]
 vfs_statx+0x134/0x2f0 fs/stat.c:315
 vfs_fstatat+0xec/0x110 fs/stat.c:341
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
 __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
 x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:263
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000001932 -> 0x0000000000001934

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 10055 Comm: syz-executor Not tainted 6.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 10/30/2024
==================================================================

This can lead to unexpected changes in execution path, so I'm considering
adding a lock, but I'm not sure how dangerous this actually is, so I'm also
considering commenting out the data-race.

> --
> Jeff Layton <jlayton@kernel.org>


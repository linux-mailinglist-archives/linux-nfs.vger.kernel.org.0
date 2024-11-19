Return-Path: <linux-nfs+bounces-8115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F079D2788
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 15:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BD22837DE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695BA1CDFD8;
	Tue, 19 Nov 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMQq9tkT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5C3F9CC;
	Tue, 19 Nov 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024762; cv=none; b=B+vMP+025F68JSSl9r+5l0m8IfrdaXYCS3idhhN/i0g+yLTCEqngvAKrV9mkta7gv+xGA3Ti5akgRmb5XDY5F0Yu0xjFyW6TYda5O2V5rIRmAHZktGnEaRxp30/eHKVkMKttuatNOKg9zd/bJuAWsn9KkeLks1UZ+WcsF0xRrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024762; c=relaxed/simple;
	bh=maqDpBxyiv1B3K+1vd2w9ltLEydvjMTth1eMwvfshq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h91wUDdC/qO6YPkhlW/nKje81zV7TFpsRSzvAcNMrbNJvmav9t3Ozmlv8W75zLNRpqoi0j9Wh7Ucf64syr1Bje+duSTxrvdSCdJ4eXLsQDzKEea0au0czJELMFhWEKbp2r7nFkE7wxVpvUW1KX0/V5SPYWEe6llP7O2k3RenOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMQq9tkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F17C4CECF;
	Tue, 19 Nov 2024 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732024761;
	bh=maqDpBxyiv1B3K+1vd2w9ltLEydvjMTth1eMwvfshq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dMQq9tkTXIsslXCKZhBgBYtFdjZe1qfY+LH1h937VYShJNP8lEPvOfKLqxCxfFZWX
	 BiuIzcCeodcJtOJgoVSPcoG5ab7C/JAXbIGeJqNrIAmEs6RC+UBqkeDRzmJ2BqYNJC
	 6cHhf2L1ArnBEm2YWrVORKTo4wlYmR7QuDmbI8bEq9Gmr53qPRdNSS1bTzhLdZ5nF9
	 G2ZWoa+7TSkyKsDRq303LIh07cnwmHZW8+RARH5IUBnGveQafn1Zhtb7S4PW3N75nB
	 a7Ej+/5c+okAYQGNvRLvb+ZfjlxWjG1Jqyazok9AiJvUvBzLAxfzl58G5G3xaXNM3H
	 DDvTjHF7DIXSQ==
Message-ID: <cdb68fac913bdc16e692f2f2cb833b5dca2d996a.camel@kernel.org>
Subject: Re: tmpfs hang after v6.12-rc6
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Hugh Dickins <hughd@google.com>
Cc: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org, 
 stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-nfs@vger.kernel.org,  yuzhao@google.com
Date: Tue, 19 Nov 2024 08:59:19 -0500
In-Reply-To: <Zzi1FzrwmNIMIvnH@tissot.1015granger.net>
References: <ZzdxKF39VEmXSSyN@tissot.1015granger.net>
	 <Zzd12OGPDnZTMZ6t@tissot.1015granger.net>
	 <CAO9qdTGLn6QWJg71Ad2xcobiTHE5ovoUxSqvrDDrE_i1+uqUQw@mail.gmail.com>
	 <Zzd5YaI99+hieQV+@tissot.1015granger.net>
	 <CAO9qdTEaYa639ebHX8Qd0_FqOZUZLc_JvYNyxepUthGyDqw_Bw@mail.gmail.com>
	 <ZzeQ1m3xIjrbUMDv@tissot.1015granger.net>
	 <b40e7156-7500-5268-4c3d-c61a6382d1f0@google.com>
	 <Zzi1FzrwmNIMIvnH@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-11-16 at 10:07 -0500, Chuck Lever wrote:
> On Fri, Nov 15, 2024 at 05:31:38PM -0800, Hugh Dickins wrote:
> > On Fri, 15 Nov 2024, Chuck Lever wrote:
> > >=20
> > > As I said before, I've failed to find any file system getattr method
> > > that explicitly takes the inode's semaphore around a
> > > generic_fillattr() call. My understanding is that these methods
> > > assume that their caller handles appropriate serialization.
> > > Therefore, taking the inode semaphore at all in shmem_getattr()
> > > seems to me to be the wrong approach entirely.
> > >=20
> > > The point of reverting immediately is that any fix can't possibly
> > > get the review and testing it deserves three days before v6.12
> > > becomes final. Also, it's not clear what the rush to fix the
> > > KCSAN splat is; according to the Fixes: tag, this issue has been
> > > present for years without causing overt problems. It doesn't feel
> > > like this change belongs in an -rc in the first place.
> > >=20
> > > Please revert d949d1d14fa2, then let's discuss a proper fix in a
> > > separate thread. Thanks!
> >=20
> > Thanks so much for reporting this issue, Chuck: just in time.
> >=20
> > I agree abso-lutely with you: I was just preparing a revert,
> > when I saw that akpm is already on it: great, thanks Andrew.
>=20
> Thanks to you both for jumping on this!
>=20
>=20
> > I was not very keen to see that locking added, just to silence a syzbot
> > sanitizer splat: added where there has never been any practical problem
> > (and the result of any stat immediately stale anyway).  I was hoping we
> > might get a performance regression reported, but a hang serves better!
> >=20
> > If there's a "data_race"-like annotation that can be added to silence
> > the sanitizer, okay.  But more locking?  I don't think so.
>=20
> IMHO the KCSAN splat suggests there is a missing inode_lock/unlock
> pair /somewhere/. Just not in shmem_getattr().
>=20
> Earlier in this thread, Jeongjun reported:
> > ... I found that this data-race mainly occurs when vfs_statx_path
> > does not acquire the inode_lock ...
>=20
> That sounds to me like a better place to address this; or at least
> that is a good place to start looking for the problem.
>=20

I don't think this data race is anything to worry about:

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    BUG: KCSAN: data-race in generic_fillattr / inode_set_ctime_current
   =20
    write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
     inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
     inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
     shmem_mknod+0x117/0x180 mm/shmem.c:3443
     shmem_create+0x34/0x40 mm/shmem.c:3497
     lookup_open fs/namei.c:3578 [inline]
     open_last_lookups fs/namei.c:3647 [inline]
     path_openat+0xdbc/0x1f00 fs/namei.c:3883
   =20
    write to 0xffff888102eb3260 of 4 bytes by task 6565 on cpu 1:
     inode_set_ctime_to_ts include/linux/fs.h:1638 [inline]
     inode_set_ctime_current+0x169/0x1d0 fs/inode.c:2626
     shmem_mknod+0x117/0x180 mm/shmem.c:3443
     shmem_create+0x34/0x40 mm/shmem.c:3497
     lookup_open fs/namei.c:3578 [inline]
     open_last_lookups fs/namei.c:3647 [inline]
     path_openat+0xdbc/0x1f00 fs/namei.c:3883
     do_filp_open+0xf7/0x200 fs/namei.c:3913
     do_sys_openat2+0xab/0x120 fs/open.c:1416
     do_sys_open fs/open.c:1431 [inline]
     __do_sys_openat fs/open.c:1447 [inline]
     __se_sys_openat fs/open.c:1442 [inline]
     __x64_sys_openat+0xf3/0x120 fs/open.c:1442
     x64_sys_call+0x1025/0x2d60 arch/x86/include/generated/asm/syscalls_64.=
h:258
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
   =20
    read to 0xffff888102eb3260 of 4 bytes by task 3498 on cpu 0:
     inode_get_ctime_nsec include/linux/fs.h:1623 [inline]
     inode_get_ctime include/linux/fs.h:1629 [inline]
     generic_fillattr+0x1dd/0x2f0 fs/stat.c:62
     shmem_getattr+0x17b/0x200 mm/shmem.c:1157
     vfs_getattr_nosec fs/stat.c:166 [inline]
     vfs_getattr+0x19b/0x1e0 fs/stat.c:207
     vfs_statx_path fs/stat.c:251 [inline]
     vfs_statx+0x134/0x2f0 fs/stat.c:315
     vfs_fstatat+0xec/0x110 fs/stat.c:341
     __do_sys_newfstatat fs/stat.c:505 [inline]
     __se_sys_newfstatat+0x58/0x260 fs/stat.c:499
     __x64_sys_newfstatat+0x55/0x70 fs/stat.c:499
     x64_sys_call+0x141f/0x2d60 arch/x86/include/generated/asm/syscalls_64.=
h:263
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
   =20
    value changed: 0x2755ae53 -> 0x27ee44d3
   =20
    Reported by Kernel Concurrency Sanitizer on:
    CPU: 0 UID: 0 PID: 3498 Comm: udevd Not tainted 6.11.0-rc6-syzkaller-00=
326-gd1f2d51b711a-dirty #0
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/06/2024
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

inode_set_ctime_to_ts() is just setting the ctime fields in the inode
to the timespec64. inode_get_ctime_nsec() is just fetching the ctime
nsec field.

We've never tried to synchronize readers and writers when it comes to
timestamps. It has always been possible to read an inconsistent
timestamp from the inode. The sec and nsec fields are in different
words, and there is no synchronization when updating the fields.

Timestamp fetches seem like the right place to use a seqcount loop, but
I don't think we would want to add any sort of locking to the update
side of things. Maybe that's doable?
--=20
Jeff Layton <jlayton@kernel.org>


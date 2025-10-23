Return-Path: <linux-nfs+bounces-15572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3722C01846
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C136F3AACD6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D5314A6A;
	Thu, 23 Oct 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMD1e0mn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2931326F
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227150; cv=none; b=SdGBjvfkEYlXsFRan7PlruO1aAFgmjYJo1AL2b8Aqj5jfIhk1cD9GGJx/H78oYtCxyuuKiXgEXSeOgushbG98Bm2eKGgIC7/6VdzLSvr+//sGHa3PV7NPND/rF2qpKIQXEQwMxAjKHzWJYK7ONWTjotkc09d2HsaWypd6hgiluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227150; c=relaxed/simple;
	bh=zthN9/TglBcyvUTnwDV0mVHuhbn/GsUUpZ90rD8RAss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXdss0r3A1E9fgdvEYLA23JfuD1s4MQnpP0QNBFshSkCAyrh4FpE1gZJjjuyZ9TZagwET3h5aVGl9QWmVufxHV5Kdv/FW/VSmrkH8hOj7k/tRhgtbHbApQV+AFx0NNAnGtOSdS+iRSqgQLoEXhn+4h0CDds1ALH2ZSVBeLzxSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMD1e0mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC4AC4CEE7;
	Thu, 23 Oct 2025 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227149;
	bh=zthN9/TglBcyvUTnwDV0mVHuhbn/GsUUpZ90rD8RAss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lMD1e0mn2J2j11LK6uUiy9MIVUURaKqWU8wxYHHW5q8x6ZhFlsoVkvaY5oDO+Qu/7
	 aJKiNgZBIURsm4Bn7fQhWaXbmagDXaENlen1F1vJJU8R/TGiYT/PJ5/UF++HDpgZ/5
	 pB2w/en6qW8Z23cg/yv4fA8ji7SALgFmuPfb844EpjWN/ieqTGJ5EPHFb1+kWlGlwP
	 RD5tJqhxr4VJttNN0jy1sfuX0Afz67+pxdwYdjbdKtaDT4sn3fiQ1mCkrnKwZpM6mQ
	 9TI1eX3L+Gvp1j/hqazeibAwTH+BllHRCsvmBnT9EiOFTRtNUfjCdHZHqfR2O6GbDT
	 er3DbqdwXfpTw==
Message-ID: <2691029ffc12d2f1a1f93425ac62e81f26e67e3c.camel@kernel.org>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Date: Thu, 23 Oct 2025 09:45:48 -0400
In-Reply-To: <CAN-5tyEZ822enzcWidAN5HxtmyZVFrNGtYjdB3JapvhH8fZeoQ@mail.gmail.com>
References: <20251021130506.45065-1-okorniev@redhat.com>
	 <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
	 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
	 <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
	 <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>
	 <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>
	 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>
	 <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
	 <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>
	 <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
	 <CAN-5tyHWWkmgcFCgpZR2Bqm7tAued_JPZ-i0rGaa+FzLtFhMjw@mail.gmail.com>
	 <f1aae34ddba90583b20d56d9b66efe09b8e8fa31.camel@kernel.org>
	 <CAN-5tyEZ822enzcWidAN5HxtmyZVFrNGtYjdB3JapvhH8fZeoQ@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 18:25 -0400, Olga Kornievskaia wrote:
> On Wed, Oct 22, 2025 at 3:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Wed, 2025-10-22 at 13:56 -0400, Olga Kornievskaia wrote:
> > > On Wed, Oct 22, 2025 at 12:06=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > >=20
> > > > On Wed, 2025-10-22 at 11:38 -0400, Olga Kornievskaia wrote:
> > > > > On Tue, Oct 21, 2025 at 1:45=E2=80=AFPM Jeff Layton <jlayton@kern=
el.org> wrote:
> > > > > >=20
> > > > > > On Tue, 2025-10-21 at 13:15 -0400, Jeff Layton wrote:
> > > > > > > On Tue, 2025-10-21 at 13:03 -0400, Jeff Layton wrote:
> > > > > > > > On Tue, 2025-10-21 at 12:17 -0400, Olga Kornievskaia wrote:
> > > > > > > > > On Tue, Oct 21, 2025 at 11:59=E2=80=AFAM Jeff Layton <jla=
yton@kernel.org> wrote:
> > > > > > > > > >=20
> > > > > > > > > > On Tue, 2025-10-21 at 11:23 -0400, Olga Kornievskaia wr=
ote:
> > > > > > > > > > > On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <=
jlayton@kernel.org> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskai=
a wrote:
> > > > > > > > > > > > > When knfsd is a reexport nfs server, it nlm4svc_p=
roc_test() in
> > > > > > > > > > > > > calling nlmsvc_testlock() with a lock conflict lo=
ck_release_private()
> > > > > > > > > > > > > call would end up calling nlmsvc_put_lockowner() =
and then back in
> > > > > > > > > > > > > nlm4svc_proc_test() function there will be anothe=
r call to
> > > > > > > > > > > > > nlmsvc_put_lockowner() for the same owner leading=
 to use-after-free
> > > > > > > > > > > > > violation (below).
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > The problem only arises when the underlying file =
system has been
> > > > > > > > > > > > > re-exported as different paths are taken in vfs_t=
est_lock().
> > > > > > > > > > > > > When it's reexport, filp->f_op->lock is set and w=
hen vfs_test_lock()
> > > > > > > > > > > > > is done fl_lmops pointer is non-null. When it's r=
egular export,
> > > > > > > > > > > > > vfs_test_lock() calls posix_test_lock() which end=
s up calling
> > > > > > > > > > > > > locks_copy_conflock() and it copies NULL into fl_=
lmops and then
> > > > > > > > > > > > > calling into lock_release_private() does not call
> > > > > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > The proposed solution is to intentionally clear f=
l_lmops pointer to
> > > > > > > > > > > > > make sure that if there is a conflict (be it a lo=
cal file system
> > > > > > > > > > > > > or reexport), lock_release_private() would not ca=
ll
> > > > > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > > > > > > > > kernel: BUG: KASAN: slab-use-after-free in nlmsvc=
_put_lockowner+0x30/0x250 [lockd]
> > > > > > > > > > > > > kernel: Read of size 4 at addr ffff0000bf3bca10 b=
y task lockd/6092
> > > > > > > > > > > > > kernel:
> > > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump=
: loaded Not tainted 6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VB=
SA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > > > > kernel:  print_address_description.constprop.0+0x=
90/0x310
> > > > > > > > > > > > > kernel:  print_report+0x108/0x1f8
> > > > > > > > > > > > > kernel:  kasan_report+0xc8/0x120
> > > > > > > > > > > > > kernel:  kasan_check_range+0xe8/0x190
> > > > > > > > > > > > > kernel:  __kasan_check_read+0x20/0x30
> > > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > > kernel:
> > > > > > > > > > > > > kernel: Allocated by task 6092:
> > > > > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > > > > kernel:  kasan_save_alloc_info+0x40/0x58
> > > > > > > > > > > > > kernel:  __kasan_kmalloc+0xd4/0xd8
> > > > > > > > > > > > > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > > > > > > > > > > > > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lo=
ckd]
> > > > > > > > > > > > > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd=
]
> > > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > > kernel:
> > > > > > > > > > > > > kernel: Freed by task 6092:
> > > > > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > > > > kernel:  __kasan_save_free_info+0x4c/0x80
> > > > > > > > > > > > > kernel:  __kasan_slab_free+0x88/0xc0
> > > > > > > > > > > > > kernel:  kfree+0x110/0x480
> > > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > > > > > > > > > > > > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > > > > > > > > > > > > kernel:  locks_release_private+0x190/0x2a8
> > > > > > > > > > > > > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > > kernel:
> > > > > > > > > > > > > kernel: The buggy address belongs to the object a=
t ffff0000bf3bca00
> > > > > > > > > > > > >         which belongs to the cache kmalloc-64 of =
size 64
> > > > > > > > > > > > > kernel: The buggy address is located 16 bytes ins=
ide of
> > > > > > > > > > > > >         freed 64-byte region [ffff0000bf3bca00, f=
fff0000bf3bca40)
> > > > > > > > > > > > > kernel:
> > > > > > > > > > > > > kernel: The buggy address belongs to the physical=
 page:
> > > > > > > > > > > > > kernel: page: refcount:0 mapcount:0 mapping:00000=
00000000000 index:0x0 pfn:0x13f3bc
> > > > > > > > > > > > > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2=
|lastcpupid=3D0xfffff)
> > > > > > > > > > > > > kernel: page_type: f5(slab)
> > > > > > > > > > > > > kernel: raw: 002fffff00000000 ffff0000800028c0 de=
ad000000000122 0000000000000000
> > > > > > > > > > > > > kernel: raw: 0000000000000000 0000000080200020 00=
000000f5000000 0000000000000000
> > > > > > > > > > > > > kernel: page dumped because: kasan: bad access de=
tected
> > > > > > > > > > > > > kernel:
> > > > > > > > > > > > > kernel: Memory state around the buggy address:
> > > > > > > > > > > > > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb f=
b fc fc fc fc fc fc fc fc
> > > > > > > > > > > > > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb f=
b fc fc fc fc fc fc fc fc
> > > > > > > > > > > > > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb f=
b fc fc fc fc fc fc fc fc
> > > > > > > > > > > > > kernel:                          ^
> > > > > > > > > > > > > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb f=
b fc fc fc fc fc fc fc fc
> > > > > > > > > > > > > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc f=
c fc fc fc fc fc fc fc fc
> > > > > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > > > > > > > > > > > kernel: Disabling lock debugging due to kernel ta=
int
> > > > > > > > > > > > > kernel: AGLO: nlmsvc_put_lockowner 00000000028055=
fb count=3D0
> > > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump=
: loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VB=
SA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > > > > kernel:  dump_stack+0x1c/0x30
> > > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > > kernel: ------------[ cut here ]------------
> > > > > > > > > > > > > kernel: refcount_t: underflow; use-after-free.
> > > > > > > > > > > > > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount=
.c:87 refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > > kernel: Modules linked in: rpcrdma rdma_cm iw_cm =
ib_cm ib_core nfsd nfsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc=
16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat f=
at uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc sn=
d_hda_intel videobuf2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_h=
da_codec snd_hda_core mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer=
 snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transpor=
t_common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp=
 nvme nvme_core nvme_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vm=
wgfx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp li=
biscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump=
: loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VB=
SA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TC=
O +DIT -SSBS BTYPE=3D--)
> > > > > > > > > > > > > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > > kernel: sp : ffff80008a627930
> > > > > > > > > > > > > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca=
00 x27: ffff0000ba5c7000
> > > > > > > > > > > > > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f=
48 x24: ffff0000c8f75c24
> > > > > > > > > > > > > kernel: x23: 0000000000000007 x22: ffff80008a6279=
50 x21: 1ffff000114c4f26
> > > > > > > > > > > > > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca=
10 x18: 0000000000000310
> > > > > > > > > > > > > kernel: x17: 0000000000000000 x16: 00000000000000=
00 x15: 0000000000000000
> > > > > > > > > > > > > kernel: x14: 0000000000000000 x13: 00000000000000=
01 x12: ffff60004fd90aa3
> > > > > > > > > > > > > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90a=
a2 x9 : dfff800000000000
> > > > > > > > > > > > > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec855=
13 x6 : 0000000000000001
> > > > > > > > > > > > > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90a=
a3 x3 : ffff800080787bc0
> > > > > > > > > > > > > kernel: x2 : 0000000000000000 x1 : 00000000000000=
00 x0 : ffff0000a75a8000
> > > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > > > > > > > > > > > > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > > kernel: ---[ end trace 0000000000000000 ]---
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat=
.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  fs/lockd/svclock.c | 1 +
> > > > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svcloc=
k.c
> > > > > > > > > > > > > index a31dc9588eb8..1dd0fec186de 100644
> > > > > > > > > > > > > --- a/fs/lockd/svclock.c
> > > > > > > > > > > > > +++ b/fs/lockd/svclock.c
> > > > > > > > > > > > > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rq=
st *rqstp, struct nlm_file *file,
> > > > > > > > > > > > >       conflock->fl.c.flc_type =3D lock->fl.c.flc_=
type;
> > > > > > > > > > > > >       conflock->fl.fl_start =3D lock->fl.fl_start=
;
> > > > > > > > > > > > >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > > > > > > > > > > > > +     conflock->fl.fl_lmops =3D NULL;
> > > > > > > > > > > > >       locks_release_private(&lock->fl);
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >       ret =3D nlm_lck_denied;
> > > > > > > > > > > >=20
> > > > > > > > > > > > The problem sounds real, but I'm not sure I like th=
is solution.
> > > > > > > > > > >=20
> > > > > > > > > > > I have no claim that this solution is the best. I was=
 contemplating on
> > > > > > > > > > > setting this to NULL only in the case when ->f_ops->l=
ock() is NULL
> > > > > > > > > > > thus restricting it to the path that does not call po=
six_test_lock().
> > > > > > > > > > >=20
> > > > > > > > > > > > It seems like this is gaming the refcounting such t=
hat we take a
> > > > > > > > > > > > reference in locks_copy_conflock() but then you zer=
o out fl_lmops
> > > > > > > > > > > > before that reference can be put.
> > > > > > > > > > >=20
> > > > > > > > > > > IF lock_copy_conflock() is called then fl_lmops is al=
ready NULL.
> > > > > > > > > > >=20
> > > > > > > > > > > Let me try to lay out the sequence of steps for both =
cases.
> > > > > > > > > > >=20
> > > > > > > > > > > Reexport
> > > > > > > > > > > 1. when nlmsvc_test_lock() is called file->f_file[mod=
e]->f_ops->lock
> > > > > > > > > > > is set (fl_lmops is set too) prior to calling vfs_tes=
t_lock.
> > > > > > > > > > > 2. Because ->lock is set vfs_test_lock() calls the ->=
lock function
> > > > > > > > > > > (instead of posix_test_lock)
> > > > > > > > > > > 3. After vfs_test_lock() fl_lmops is still set so loc=
k_release_private
> > > > > > > > > > > is called and calls nlmscv_put_lockowner().
> > > > > > > > > > >=20
> > > > > > > > > > > Normal export
> > > > > > > > > > > 1. when nlmsvc_test_lock() is called ->lock is not se=
t (fl_lmops is
> > > > > > > > > > > set) prior to calling vfs_test_lock
> > > > > > > > > > > 2. Because -> is not set posix_test_lock() is called =
which will call
> > > > > > > > > > > local_copy_conflock() which will set fl_lmops to NULL=
.
> > > > > > > > > > > 3. Since fl_lmops is NULL put_lockowner isn't called.
> > > > > > > > > > >=20
> > > > > > > > > > > Reexport is where I'm hazy. I'm assuming that reexpor=
ted server opened
> > > > > > > > > > > a file and the "file" is the NFS file object and that=
's why
> > > > > > > > > > > file->f_file[mode]->f_ops->lock is set? So perhaps if=
 we take the
> > > > > > > > > > > presence of ->lock to mean reexport, we can do as I d=
id (ie., set
> > > > > > > > > > > fl_lmops to null), or maybe we can take an extra refe=
rence knowing
> > > > > > > > > > > that we'd need to put it in lock_release_private() ( =
-- this
> > > > > > > > > > > suggestion ties to your next question). I don't see a=
ny difference to
> > > > > > > > > > > either setting it to NULL or taking an extra referenc=
e for when
> > > > > > > > > > > ->lock() is set . Both are confusing and I would say =
warrant a comment
> > > > > > > > > > > for why we are doing it.
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > To be clear, there is nothing "special" about NFS reexp=
ort here. The
> > > > > > > > > > NFS client just has some limitations as to what it can =
do when it's
> > > > > > > > > > being (re)exported. Exporting other sorts of network or=
 clustered
> > > > > > > > > > filesystems can also be problematic for similar reasons=
.
> > > > > > > > > >=20
> > > > > > > > > > So, we should focus on making this generically work, an=
d not take -
> > > > > > > > > > > lock being set to mean that this is an NFS reexport.
> > > > > > > > >=20
> > > > > > > > > I guess it doesn't matter what kind of re-export but the =
fact that if
> > > > > > > > > ->lock is set we know that posix_test_lock and then
> > > > > > > > > local_copy_conflock won't be called and thus there is a g=
reat chance
> > > > > > > > > that fl_lmops will still be set on return from vfs_test_l=
ock().
> > > > > > > > >=20
> > > > > > > > > > A question: you mentioned this is a reexporting server.=
 Are you
> > > > > > > > > > reexporting an NFSv4 mount as NFSv3? Or is this a v3->v=
3 reexport?
> > > > > > > > >=20
> > > > > > > > > v3->v3 reexport.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Ok, looking now:
> > > > > > > >=20
> > > > > > > > The test_owner in __nlm4svc_proc_test() comes from the args=
, which
> > > > > > > > happens during the decode phase. That gets a valid referenc=
e to an NLM
> > > > > > > > lockowner in nlmsvc_locks_init_private(). Therefore, this c=
all in
> > > > > > > > __nlm4svc_proc_test() seems legit.
> > > > > > > >=20
> > > > > > > >         nlmsvc_put_lockowner(test_owner);
> > > > > > > >=20
> > > > > > > > Now, between those two gets/puts, there is the call to vfs_=
test_lock()
> > > > > > > > in nlmsvc_testlock(). That uses the same file_lock argument=
 structure
> > > > > > > > to represent both the lock and the conflock.
> > > > > > > >=20
> > > > > > > >         error =3D vfs_test_lock(file->f_file[mode], &lock->=
fl);
> > > > > > > >=20
> > > > > > > > ...so the flc_owner field at this point is still set to the=
 (original)
> > > > > > > > nlmclient's owner.
> > > > > > > >=20
> > > > > > > > In this case, that call ends up calling down in nlmclnt_tes=
t(), which
> > > > > > > > ignores the flc_owner field. It also ends up overwriting th=
e other
> > > > > > > > fields in &fl with conflock info.
> > > > > > > >=20
> > > > > > > > I think the bug is actually there. Before nlmclnt_test() ov=
erwrites the
> > > > > > > > fields in "fl", it needs to release the owner reference (an=
d zero out
> > > > > > > > the owner). Would this patch fix the bug?
> > > > > > > >=20
> > > > > > > > ---------------------8------------------------
> > > > > > > >=20
> > > > > > > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > > > > > > index cebcc283b7ce..200309ee1a74 100644
> > > > > > > > --- a/fs/lockd/clntproc.c
> > > > > > > > +++ b/fs/lockd/clntproc.c
> > > > > > > > @@ -438,6 +438,8 @@ nlmclnt_test(struct nlm_rqst *req, stru=
ct file_lock
> > > > > > > > *fl)
> > > > > > > >         if (status < 0)
> > > > > > > >                 goto out;
> > > > > > > >=20
> > > > > > > > +       locks_release_private(&fl);
> > > > > > > > +
> > > > > > > >         switch (req->a_res.status) {
> > > > > > > >                 case nlm_granted:
> > > > > > > >                         fl->c.flc_type =3D F_UNLCK;
> > > > > > >=20
> > > > > > >=20
> > > > > > > Sorry, I take it back. That alone won't fix it because of the=
 pointer-
> > > > > > > saving shenanigans in __nlm4svc_proc_test. We'll need to do t=
his a bit
> > > > > > > more carefully, I think.
> > > > > >=20
> > > > > > How about this patch? The changelog still needs some work, but =
I think
> > > > > > this is the most correct way to handle it:
> > > > > >=20
> > > > > > -------------------------8<----------------------------
> > > > > >=20
> > > > > > [PATCH] nlm: fix handling of conflocks by NLM
> > > > > >=20
> > > > > > The handling of conflocks can result in a refcount overput on t=
he
> > > > > > flc_owner in the case of a reexported NFSv3 fs.
> > > > > >=20
> > > > > > lockd will pass down a file_lock structure in its arguments wit=
h
> > > > > > flc_owner set to an NLM owner and a valid reference. Once that =
gets
> > > > > > down to the reexported NFS client, it will ignore that field an=
d leave
> > > > > > it intact when copying in conflock info.
> > > > > >=20
> > > > > > The NLM server code will then end up releasing the conflock, an=
d then
> > > > > > releasing the one from the arguments, not realizing that the lo=
ck has
> > > > > > already been released.
> > > > > >=20
> > > > > > The owner info in the arguments to vfs_test_lock() is there to =
give
> > > > > > information about the requestor. Once nlmclnt_test() is going t=
o copy in
> > > > > > the conflock info however, it needs to release the old owner.
> > > > > >=20
> > > > > > Have nlmclnt_test() do call locks_release_private() after testi=
ng the
> > > > > > lock to release any info that was in the old file_lock structur=
e.
> > > > > >=20
> > > > > > This creates another problem: __nlm4svc_proc_test() and
> > > > > > __nlmsvc_proc_test() both call nlmsvc_put_lockowner() unconditi=
onally on
> > > > > > the original lockowner that it got from decoding the args. Swit=
ch them
> > > > > > both to just call locks_release_private() on &argp->lock instea=
d, which
> > > > > > should handle the case properly where the info in argp->lock ha=
s already
> > > > > > been released.
> > > > > >=20
> > > > > > With that changed, we can also eliminate the call to
> > > > > > locks_release_private() in nlmsvc_testlock() since the callers =
will now
> > > > > > handle that.
> > > > > >=20
> > > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > >  fs/lockd/clntproc.c | 3 +++
> > > > > >  fs/lockd/svc4proc.c | 4 +---
> > > > > >  fs/lockd/svclock.c  | 1 -
> > > > > >  fs/lockd/svcproc.c  | 5 +----
> > > > > >  4 files changed, 5 insertions(+), 8 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > > > > index cebcc283b7ce..d3dd04137677 100644
> > > > > > --- a/fs/lockd/clntproc.c
> > > > > > +++ b/fs/lockd/clntproc.c
> > > > > > @@ -438,6 +438,9 @@ nlmclnt_test(struct nlm_rqst *req, struct f=
ile_lock *fl)
> > > > > >         if (status < 0)
> > > > > >                 goto out;
> > > > > >=20
> > > > > > +       /* Release any references held by fl before copying in =
conflock info */
> > > > > > +       locks_release_private(fl);
> > > > > > +
> > > > > >         switch (req->a_res.status) {
> > > > > >                 case nlm_granted:
> > > > > >                         fl->c.flc_type =3D F_UNLCK;
> > > > > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > > > > index 109e5caae8c7..cbfec12296a4 100644
> > > > > > --- a/fs/lockd/svc4proc.c
> > > > > > +++ b/fs/lockd/svc4proc.c
> > > > > > @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, s=
truct nlm_res *resp)
> > > > > >         struct nlm_args *argp =3D rqstp->rq_argp;
> > > > > >         struct nlm_host *host;
> > > > > >         struct nlm_file *file;
> > > > > > -       struct nlm_lockowner *test_owner;
> > > > > >         __be32 rc =3D rpc_success;
> > > > > >=20
> > > > > >         dprintk("lockd: TEST4        called\n");
> > > > > > @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp,=
 struct nlm_res *resp)
> > > > > >         if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp=
, &host, &file)))
> > > > > >                 return resp->status =3D=3D nlm_drop_reply ? rpc=
_drop_reply :rpc_success;
> > > > > >=20
> > > > > > -       test_owner =3D argp->lock.fl.c.flc_owner;
> > > > > >         /* Now check for conflicting locks */
> > > > > >         resp->status =3D nlmsvc_testlock(rqstp, file, host, &ar=
gp->lock,
> > > > > >                                        &resp->lock);
> > > > > > @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp,=
 struct nlm_res *resp)
> > > > > >         else
> > > > > >                 dprintk("lockd: TEST4        status %d\n", ntoh=
l(resp->status));
> > > > > >=20
> > > > > > -       nlmsvc_put_lockowner(test_owner);
> > > > > > +       locks_release_private(&argp->lock.fl);
> > > > > >         nlmsvc_release_host(host);
> > > > > >         nlm_release_file(file);
> > > > > >         return rc;
> > > > >=20
> > > > > Aren't these svc4proc changes defeat the purpose of the following=
 commit:
> > > > >=20
> > > > > commit 184cefbe62627730c30282df12bcff9aae4816ea
> > > > > Author: Benjamin Coddington <bcodding@redhat.com>
> > > > > Date:   Mon Jun 13 09:40:06 2022 -0400
> > > > >=20
> > > > >     NLM: Defend against file_lock changes after vfs_test_lock()
> > > > >=20
> > > > >     Instead of trusting that struct file_lock returns completely =
unchanged
> > > > >     after vfs_test_lock() when there's no conflicting lock, stash=
 away our
> > > > >     nlm_lockowner reference so we can properly release it for all=
 cases.
> > > > >=20
> > > > >=20
> > > > >     This defends against another file_lock implementation overwri=
ting fl_owner
> > > > >     when the return type is F_UNLCK.
> > > > >=20
> > > > > Not that they are the cause of the crash but I would imagine it w=
ould
> > > > > cause a problem fixed by the patch....
> > > > >=20
> > > >=20
> > > > Yes, it would. I'm not sure that patch is correct.
> > >=20
> > > But it seems wrong that we are now considering putting a patch that
> > > fixes one issue (ie crash on reexport) but re-introduces another issu=
e
> > > (that the reverted code fixed be it not in a correct manner).
> > >=20
> >=20
> > I'm not sure what you mean by reintroducing another issue? What bug
> > would be reintroduced?
>=20
> I might be reading the changes incorrectly so bear with me. The
> proposal that in nlm4srv_proc_test() we don't save the tets_owner
> pointer prior to calling nlmsvc_testlock() and then do a put on the
> original file (args->lock.fl). now this lock is the one being modified
> by vfs_test_lock() am I not correct?
>=20
> When you asked what bug would be reintroduced. Here's what I got from
> a bugzilla opened with regards to the "NLM: Defend against file_lock
> changes after vfs_test_lock()" patch. I believe it describes the
> problem that would come back.
>=20
> "If underlying filesystem implementation modifies file_lock->fl_owner
> for F_GETLK operations, returned owner may not be even a mapped
> address on the box. This scenario, when dealing with a non-conflictive
> locks may cause oops, panicing the box while accessing unmapped
> address trying to get rid of the owner through :
>=20
> __nlm4svc_proc_test() / __nlm4svc_proc_test() ->
> nlmsvc_release_lockowner() -> nlmsvc_put_lockowner
>=20
> oops stack :
>=20
> [6823679.912979] RIP: 0010:nlmsvc_put_lockowner+0x6/0x80 [lockd]
> ....
> [6823679.923427] Call Trace:
> [6823679.924012]  __nlm4svc_proc_test+0xe8/0x110 [lockd]
> [6823679.924674]  svc_process_common+0x64f/0x700 [sunrpc]
> [6823679.925273]  ? svc_recv+0x3d0/0x820 [sunrpc]
> [6823679.925823]  ? grace_ender+0x20/0x20 [lockd]
> [6823679.926388]  svc_process+0xb7/0xf0 [sunrpc]
> [6823679.926949]  lockd+0xae/0x190 [lockd]
> [6823679.927467]  ? __kthread_parkme+0x4c/0x70
> [6823679.927976]  kthread+0x116/0x130
> [6823679.928467]  ? kthread_flush_work_fn+0x10/0x10
> [6823679.928972]  ret_from_fork+0x1f/0x40
>=20
>=20
> POSIX imposes flock structures to remain intact (but l_type set to
> F_UNLCK) for F_GETLK cases when lock is not held,
> but not necessary file_lock->fl_owner struct. NLM should be more
> defensive on that situation if underlying fs implementation changes
> the owner.
>=20
> Steps to reproduce:
> 1.GPFS cluster, several nodes acting as NFS server
> 2.adv. locking operations over nfs3 shares "
>=20
> > My main concern is that when you clear fl_lmops pointer in the way that
> > you were suggesting, you're making assumptions about the lockowner that
> > eventually ends up in flc_owner.
>=20
> > Calling vfs_test_lock() may populate flc_owner with a valid reference.
> > Maybe it ends up returning an nfsd4 lock in that field. At that point
> > you've just leaked that reference.
>=20
> I'm rather unclear here why a lock that's being tested is supposed to
> be responsible for releasing something on a conflicting lock. I would
> rather think that like an example of GPFS it is not something we
> should be touching but why is a conflicting NFSD lock (saying coming
> from a different namespace) should be any different. On that basis I
> thought my solution is a plausible stepping stone
>=20

I think I'm coming around to your way of thinking. The way I
rationalize it is that the exported fs has to treat the flc_owner as
opaque. Given that, we don't need to mess with the refcounting in the
conflock.

I think Neil's version of this patch makes this a little clearer than
your one-liner, but they're both basically the same approach. Either
way, we'll need some good comments around this as leaving fl_lmops set
to NULL in order to achieve this is quite subtle.
--=20
Jeff Layton <jlayton@kernel.org>


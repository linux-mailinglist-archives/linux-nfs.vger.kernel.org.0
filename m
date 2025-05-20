Return-Path: <linux-nfs+bounces-11841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B79ABE5CF
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 23:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EE31B685C3
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30825334A;
	Tue, 20 May 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ejweHgnP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6DDhRUmZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ejweHgnP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6DDhRUmZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE801F4CB0
	for <linux-nfs@vger.kernel.org>; Tue, 20 May 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775488; cv=none; b=C+oCluxVP2MwSlvb+pVgWwA913jDevmTKYgFR0gxRIYRB8/McOxduqWEF7W5nO8ODSZwlp6phZPy5F+vAaL0guekvtuWh+QWwEzApNKv/mo+LV+LJjY2uOKcHnNZF3sIkO8JwrHXzXwlNqgDRE1a021CRT20DfFzWTiRMyT3xi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775488; c=relaxed/simple;
	bh=ltFjd4q00OGL6COZYkUXomlfqByEtFTl4QXqPIW9jDA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=q+WVcorxh/mFsES3YRDPgjZkGcVzCgRWqFD6S82kYsYvnqkrc4ci0PsHnUSVt2IYMhRk6ec+WVvxBF8FzG2E8SmIXDrh8nHcMncMTv7Rmu0+w6i+qmpkoLf2jlpX/ghmwPwIiAMOSiPisVtSaUzSSJNdlWrl6r01btOZXUi7nnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ejweHgnP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6DDhRUmZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ejweHgnP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6DDhRUmZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33754207A9;
	Tue, 20 May 2025 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747775483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+IBIV3VeFx4PmMBn5Ya6u40mOrVhHvvHsZfQsjldJk=;
	b=ejweHgnPd50oTUgZY0lrKxILW49IhUw0ODdoN08Yqn6bXH7cdBECVWHzX3ZfJPdFFg4oE5
	n2Yo3RGkDv95Al2bkJzgLCPfI63YZ5L7ChodxrFG2edoAmQCbnD8TyV1v1JPuqxERlvdNp
	cYjPVq6a+ScDPYRQ3T2UPPB8nRyLD0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747775483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+IBIV3VeFx4PmMBn5Ya6u40mOrVhHvvHsZfQsjldJk=;
	b=6DDhRUmZZDHgyZUtMT2rj29Mwbu/3bxOdatz1UjENWwja/Dw1NTjia1i8Ox0dGETkW+cTZ
	4etleU2KTS+Uz/Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747775483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+IBIV3VeFx4PmMBn5Ya6u40mOrVhHvvHsZfQsjldJk=;
	b=ejweHgnPd50oTUgZY0lrKxILW49IhUw0ODdoN08Yqn6bXH7cdBECVWHzX3ZfJPdFFg4oE5
	n2Yo3RGkDv95Al2bkJzgLCPfI63YZ5L7ChodxrFG2edoAmQCbnD8TyV1v1JPuqxERlvdNp
	cYjPVq6a+ScDPYRQ3T2UPPB8nRyLD0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747775483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+IBIV3VeFx4PmMBn5Ya6u40mOrVhHvvHsZfQsjldJk=;
	b=6DDhRUmZZDHgyZUtMT2rj29Mwbu/3bxOdatz1UjENWwja/Dw1NTjia1i8Ox0dGETkW+cTZ
	4etleU2KTS+Uz/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F33013888;
	Tue, 20 May 2025 21:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OnvkC/XvLGgcCgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 20 May 2025 21:11:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "syzbot" <syzbot+a15182e1a4094a69cbec@syzkaller.appspotmail.com>,
 Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, okorniev@redhat.com, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, tom@talpey.com, trondmy@kernel.org
Subject:
 Re: [syzbot] [net?] [nfs?] KASAN: slab-out-of-bounds Read in cache_clean
In-reply-to: <517ab3641097d106bfc1c7c86d4364408eac7345.camel@kernel.org>
References: <682c32e0.a00a0220.29bc26.0274.GAE@google.com>,
 <517ab3641097d106bfc1c7c86d4364408eac7345.camel@kernel.org>
Date: Wed, 21 May 2025 07:11:13 +1000
Message-id: <174777547393.62796.12174520124267417436@noble.neil.brown.name>
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=30181bfb60dbb0a9];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[a15182e1a4094a69cbec];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Wed, 21 May 2025, Jeff Layton wrote:
> On Tue, 2025-05-20 at 00:44 -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    088d13246a46 Merge tag 'kbuild-fixes-v6.15' of git://git.=
k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1047ce70580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D30181bfb60dbb=
0a9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da15182e1a4094a6=
9cbec
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> >=20
> > Unfortunately, I don't have any reproducer for this issue yet.
> >=20
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-088d1324.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/273390076ad5/vmlinu=
x-088d1324.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3de2f79595a2/b=
zImage-088d1324.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> > Reported-by: syzbot+a15182e1a4094a69cbec@syzkaller.appspotmail.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-out-of-bounds in hlist_empty include/linux/list.h:972 [i=
nline]
> > BUG: KASAN: slab-out-of-bounds in cache_clean+0x8a0/0x990 net/sunrpc/cach=
e.c:468
> > Read of size 8 at addr ffff88802ae03800 by task kworker/1:2/1335
> >=20
> > CPU: 1 UID: 0 PID: 1335 Comm: kworker/1:2 Not tainted 6.15.0-rc6-syzkalle=
r-00105-g088d13246a46 #0 PREEMPT(full)=20
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> > Workqueue: events_power_efficient do_cache_clean
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:408 [inline]
> >  print_report+0xc3/0x670 mm/kasan/report.c:521
> >  kasan_report+0xe0/0x110 mm/kasan/report.c:634
> >  hlist_empty include/linux/list.h:972 [inline]
> >  cache_clean+0x8a0/0x990 net/sunrpc/cache.c:468
> >  do_cache_clean net/sunrpc/cache.c:519 [inline]
> >  do_cache_clean+0x29/0xa0 net/sunrpc/cache.c:512
> >  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
> >  process_scheduled_works kernel/workqueue.c:3319 [inline]
> >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
> >  kthread+0x3c2/0x780 kernel/kthread.c:464
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >=20
>=20
> This is puzzling:
>=20
> hlist_empty is just checking whether hlist_head->first is a NULL
> pointer, so this probably means we over or underran the hlist array
> somehow. The array is allocated in cache_create_net, and is of a fixed
> size. AFAICT, the accesses in cache_clean are safe and should never
> overrun the allocation (they're bounded by the same value that we use
> to allocate the array).

I agree.
It would be nice if current_index were unsigned so that the
        "current_index < hash_size"
test was more obviously correct, but I cannot see it ever going
negative.

This:
> >=20
> > The buggy address belongs to the object at ffff88802ae03000
> >  which belongs to the cache kmalloc-2k of size 2048
> > The buggy address is located 0 bytes to the right of
> >  allocated 2048-byte region [ffff88802ae03000, ffff88802ae03800)

suggests that current_index was 256 and that hash_size was 256
(resulting in a 2k allocation).  But that is impossible....

current_index is only every accessed under cache_list_lock so it can't
have changed between the test and the access.

The cache is always unregistered before it is freed so that can't result
in any confusion either.

I can easily imagine the CPU issuing a speculative read to that address,
but I cannot is a non-speculative read (is there a better term) doing
this!

NeilBrown


> >=20
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ae00
> > head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > anon flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: f5(slab)
> > raw: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> > raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
> > head: 00fff00000000040 ffff88801b442f00 0000000000000000 dead000000000001
> > head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
> > head: 00fff00000000003 ffffea0000ab8001 00000000ffffffff 00000000ffffffff
> > head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(=
__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pi=
d 837, tgid 837 (kworker/3:2), ts 32884542472, free_ts 32014442038
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
> >  prep_new_page mm/page_alloc.c:1726 [inline]
> >  get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
> >  __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
> >  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
> >  alloc_slab_page mm/slub.c:2450 [inline]
> >  allocate_slab mm/slub.c:2618 [inline]
> >  new_slab+0x244/0x340 mm/slub.c:2672
> >  ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
> >  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
> >  __slab_alloc_node mm/slub.c:4023 [inline]
> >  slab_alloc_node mm/slub.c:4184 [inline]
> >  __do_kmalloc_node mm/slub.c:4326 [inline]
> >  __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4346
> >  kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
> >  __alloc_skb+0x166/0x380 net/core/skbuff.c:668
> >  alloc_skb include/linux/skbuff.h:1340 [inline]
> >  mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1788
> >  add_grhead+0x299/0x340 net/ipv6/mcast.c:1899
> >  add_grec+0x112a/0x1680 net/ipv6/mcast.c:2037
> >  mld_send_cr net/ipv6/mcast.c:2163 [inline]
> >  mld_ifc_work+0x41f/0xca0 net/ipv6/mcast.c:2702
> >  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
> >  process_scheduled_works kernel/workqueue.c:3319 [inline]
> >  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
> > page last free pid 5792 tgid 5792 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1262 [inline]
> >  __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
> >  discard_slab mm/slub.c:2716 [inline]
> >  __put_partials+0x16d/0x1c0 mm/slub.c:3185
> >  qlink_free mm/kasan/quarantine.c:163 [inline]
> >  qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
> >  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
> >  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
> >  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >  slab_post_alloc_hook mm/slub.c:4147 [inline]
> >  slab_alloc_node mm/slub.c:4196 [inline]
> >  __do_kmalloc_node mm/slub.c:4326 [inline]
> >  __kmalloc_noprof+0x1d4/0x510 mm/slub.c:4339
> >  kmalloc_noprof include/linux/slab.h:909 [inline]
> >  tomoyo_realpath_from_path+0xc2/0x6e0 security/tomoyo/realpath.c:251
> >  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
> >  tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
> >  security_inode_getattr+0x116/0x290 security/security.c:2377
> >  vfs_getattr fs/stat.c:256 [inline]
> >  vfs_fstat+0x4b/0xd0 fs/stat.c:278
> >  __do_sys_newfstat+0x91/0x110 fs/stat.c:546
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >=20
> > Memory state around the buggy address:
> >  ffff88802ae03700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffff88802ae03780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > ffff88802ae03800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >                    ^
> >  ffff88802ae03880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff88802ae03900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> >=20
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >=20
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >=20
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >=20
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >=20
> > If you want to undo deduplication, reply with:
> > #syz undup
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20



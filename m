Return-Path: <linux-nfs+bounces-20499-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAVAGbUdyGkShAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20499-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:28:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A524534F930
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00888303BA7F
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42823242CA;
	Sat, 28 Mar 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="2jHfjvyK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF43A6EEA;
	Sat, 28 Mar 2026 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722253; cv=none; b=WQgOcwDEEFo1mtLuv5DcR114x8pmYVxMAAgK3kHdkfcz9HYcaeyReD6aBC/LPnLEpYGykQhfVvugNSXx24j1Lt9AsvceF1Vc2J+hOQ86drladABI38ySBvshxUztBRJwyg0oHNTZZ/DYn3AEiiFjA6sMRS8lHphqZkwcydjrjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722253; c=relaxed/simple;
	bh=Rp5FITiTlFCbGsu+sHbqfWN1svWQcYf8gJFbsz+g/2o=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=gjHnpSYhLth1Cw87nAj0qAhtE73ROLtsif8ngDKCOfzJBAKtWGbZFqpidBt2TZJG/DRV8HwuLKnNstHTinr8J12DpvebbQTWrQa1S7UZublNESbepvulQqL5NevFjVuD4jkUHIxo4TYHzBTZH4Q7PmkNrjmVgWu/GND0WWKROeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=2jHfjvyK; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CnwLiOiEwGodP5DTt0UILplopV/lgZmVDsfGPJfHItk=; b=2jHfjvyKT+by9pRtne1C0sXftl
	B1JxRLn5wUBbUpPMcqJoPIr9tWW0nS+2N8BWa8oBWll9oafhx/7wZIZeJ/1M2sq5WtHRmEadrQU8S
	ysWK4eH9Ql78kPnakUOvXOHZrSAvuxuh0MVUVhp1G756hLSr7h3tzMrw4DW4ZBsgEeNuMapoa8H5o
	bxLJ007k2++KxeDFs4OQpuvU1kvHSGkO+Zyb8e0wYi1CCoPPSVkE9bnmyJTr/V2mmXqpLyv5218zo
	xEV/35PmzhrBrQ1U1QP4NCa40FLWZwdztKjEyiXKVu9v8YAtTOxj74NxlO3KceT5QO2WCB7olrLjy
	KsSmy25g==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YKM-00000001nhL-1HSW;
	Sat, 28 Mar 2026 15:24:06 -0300
Message-ID: <9ba3ab4745fda6aaec36910ad4089e84@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, Christoph
 Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Leon
 Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne
 <marc.dionne@auristor.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov
 <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: Re: [PATCH 03/26] netfs: fix VM_BUG_ON_FOLIO() issue in
 netfs_write_begin() call
In-Reply-To: <20260326104544.509518-4-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-4-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:24:06 -0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20499-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,ibm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,manguebit.org:dkim,manguebit.org:email,manguebit.org:mid]
X-Rspamd-Queue-Id: A524534F930
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The multiple runs of generic/013 test-case is capable
> to reproduce a kernel BUG at mm/filemap.c:1504 with
> probability of 30%.
>
> while true; do
>   sudo ./check generic/013
> done
>
> [ 9849.452376] page: refcount:3 mapcount:0 mapping:00000000e58ff252 index:0x10781 pfn:0x1c322
> [ 9849.452412] memcg:ffff8881a1915800
> [ 9849.452417] aops:ceph_aops ino:1000058db9e dentry name(?):"f9XXXXXX"
> [ 9849.452432] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [ 9849.452441] raw: 0017ffffc0000000 0000000000000000 dead000000000122 ffff88816110d248
> [ 9849.452445] raw: 0000000000010781 0000000000000000 00000003ffffffff ffff8881a1915800
> [ 9849.452447] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
> [ 9849.452474] ------------[ cut here ]------------
> [ 9849.452476] kernel BUG at mm/filemap.c:1504!
> [ 9849.478635] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [ 9849.481772] CPU: 2 UID: 0 PID: 84223 Comm: fsstress Not tainted 7.0.0-rc1+ #18 PREEMPT(full)
> [ 9849.482881] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/1
> 0/2025
> [ 9849.484539] RIP: 0010:folio_unlock+0x85/0xa0
> [ 9849.485076] Code: 89 df 31 f6 e8 1c f3 ff ff 48 8b 5d f8 c9 31 c0 31 d2 31 f6 31 ff c3 cc
> cc cc cc 48 c7 c6 80 6c d9 a7 48 89 df e8 4b b3 10 00 <0f> 0b 48 89 df e8 21 e6 2c 00 eb 9d 0f 1f 40 00 66 66 2e 0f 1f 84
> [ 9849.493818] RSP: 0018:ffff8881bb8076b0 EFLAGS: 00010246
> [ 9849.495740] RAX: 0000000000000000 RBX: ffffea00070c8980 RCX: 0000000000000000
> [ 9849.498678] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 9849.500559] RBP: ffff8881bb8076b8 R08: 0000000000000000 R09: 0000000000000000
> [ 9849.501097] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000010782000
> [ 9849.502108] R13: ffff8881935de738 R14: ffff88816110d010 R15: 0000000000001000
> [ 9849.502516] FS:  00007e36cbe94740(0000) GS:ffff88824a899000(0000) knlGS:0000000000000000
> [ 9849.502996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9849.503810] CR2: 000000c0002b0000 CR3: 000000011bbf6004 CR4: 0000000000772ef0
> [ 9849.504459] PKRU: 55555554
> [ 9849.504626] Call Trace:
> [ 9849.505242]  <TASK>
> [ 9849.505379]  netfs_write_begin+0x7c8/0x10a0
> [ 9849.505877]  ? __kasan_check_read+0x11/0x20
> [ 9849.506384]  ? __pfx_netfs_write_begin+0x10/0x10
> [ 9849.507178]  ceph_write_begin+0x8c/0x1c0
> [ 9849.507934]  generic_perform_write+0x391/0x8f0
> [ 9849.508503]  ? __pfx_generic_perform_write+0x10/0x10
> [ 9849.509062]  ? file_update_time_flags+0x19a/0x4b0
> [ 9849.509581]  ? ceph_get_caps+0x63/0xf0
> [ 9849.510259]  ? ceph_get_caps+0x63/0xf0
> [ 9849.510530]  ceph_write_iter+0xe79/0x1ae0
> [ 9849.511282]  ? __pfx_ceph_write_iter+0x10/0x10
> [ 9849.511839]  ? lock_acquire+0x1ad/0x310
> [ 9849.512334]  ? ksys_write+0xf9/0x230
> [ 9849.512582]  ? lock_is_held_type+0xaa/0x140
> [ 9849.513128]  vfs_write+0x512/0x1110
> [ 9849.513634]  ? __fget_files+0x33/0x350
> [ 9849.513893]  ? __pfx_vfs_write+0x10/0x10
> [ 9849.514143]  ? mutex_lock_nested+0x1b/0x30
> [ 9849.514394]  ksys_write+0xf9/0x230
> [ 9849.514621]  ? __pfx_ksys_write+0x10/0x10
> [ 9849.514887]  ? do_syscall_64+0x25e/0x1520
> [ 9849.515122]  ? __kasan_check_read+0x11/0x20
> [ 9849.515366]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.515655]  __x64_sys_write+0x72/0xd0
> [ 9849.515885]  ? trace_hardirqs_on+0x24/0x1c0
> [ 9849.516130]  x64_sys_call+0x22f/0x2390
> [ 9849.516341]  do_syscall_64+0x12b/0x1520
> [ 9849.516545]  ? do_syscall_64+0x27c/0x1520
> [ 9849.516783]  ? do_syscall_64+0x27c/0x1520
> [ 9849.517003]  ? lock_release+0x318/0x480
> [ 9849.517220]  ? __x64_sys_io_getevents+0x143/0x2d0
> [ 9849.517479]  ? percpu_ref_put_many.constprop.0+0x8f/0x210
> [ 9849.517779]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 9849.518073]  ? do_syscall_64+0x25e/0x1520
> [ 9849.518291]  ? __kasan_check_read+0x11/0x20
> [ 9849.518519]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.518799]  ? do_syscall_64+0x27c/0x1520
> [ 9849.519024]  ? local_clock_noinstr+0xf/0x120
> [ 9849.519262]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 9849.519544]  ? do_syscall_64+0x25e/0x1520
> [ 9849.519781]  ? __kasan_check_read+0x11/0x20
> [ 9849.520008]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.520273]  ? do_syscall_64+0x27c/0x1520
> [ 9849.520491]  ? trace_hardirqs_on_prepare+0x178/0x1c0
> [ 9849.520767]  ? irqentry_exit+0x10c/0x6c0
> [ 9849.520984]  ? trace_hardirqs_off+0x86/0x1b0
> [ 9849.521224]  ? exc_page_fault+0xab/0x130
> [ 9849.521472]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 9849.521766] RIP: 0033:0x7e36cbd14907
> [ 9849.521989] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [ 9849.523057] RSP: 002b:00007ffff2d2a968 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 9849.523484] RAX: ffffffffffffffda RBX: 000000000000e549 RCX: 00007e36cbd14907
> [ 9849.523885] RDX: 000000000000e549 RSI: 00005bd797ec6370 RDI: 0000000000000004
> [ 9849.524277] RBP: 0000000000000004 R08: 0000000000000047 R09: 00005bd797ec6370
> [ 9849.524652] R10: 0000000000000078 R11: 0000000000000246 R12: 0000000000000049
> [ 9849.525062] R13: 0000000010781a37 R14: 00005bd797ec6370 R15: 0000000000000000
> [ 9849.525447]  </TASK>
> [ 9849.525574] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel joydev kvm irqbypass ghash_clmulni_intel aesni_intel input_leds rapl mac_hid psmouse vga16fb serio_raw vgastate floppy i2c_piix4 bochs qemu_fw_cfg i2c_smbus pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> [ 9849.529150] ---[ end trace 0000000000000000 ]---
> [ 9849.529502] RIP: 0010:folio_unlock+0x85/0xa0
> [ 9849.530813] Code: 89 df 31 f6 e8 1c f3 ff ff 48 8b 5d f8 c9 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 48 c7 c6 80 6c d9 a7 48 89 df e8 4b b3 10 00 <0f> 0b 48 89 df e8 21 e6 2c 00 eb 9d 0f 1f 40 00 66 66 2e 0f 1f 84
> [ 9849.534986] RSP: 0018:ffff8881bb8076b0 EFLAGS: 00010246
> [ 9849.536198] RAX: 0000000000000000 RBX: ffffea00070c8980 RCX: 0000000000000000
> [ 9849.537718] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 9849.539321] RBP: ffff8881bb8076b8 R08: 0000000000000000 R09: 0000000000000000
> [ 9849.540862] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000010782000
> [ 9849.542438] R13: ffff8881935de738 R14: ffff88816110d010 R15: 0000000000001000
> [ 9849.543996] FS:  00007e36cbe94740(0000) GS:ffff88824b899000(0000) knlGS:0000000000000000
> [ 9849.545854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9849.547092] CR2: 00007e36cb3ff000 CR3: 000000011bbf6006 CR4: 0000000000772ef0
> [ 9849.548679] PKRU: 55555554
>
> The race sequence:
> 1. Read completes -> netfs_read_collection() runs
> 2. netfs_wake_rreq_flag(rreq, NETFS_RREQ_IN_PROGRESS, ...)
> 3. netfs_wait_for_read() returns -EFAULT to netfs_write_begin()
> 4. The netfs_unlock_abandoned_read_pages() unlocks the folio
> 5. netfs_write_begin() calls folio_unlock(folio) -> VM_BUG_ON_FOLIO()
>
> The key reason of the issue that netfs_unlock_abandoned_read_pages()
> doesn't check the flag NETFS_RREQ_NO_UNLOCK_FOLIO and executes
> folio_unlock() unconditionally. This patch implements in
> netfs_unlock_abandoned_read_pages() logic similar to
> netfs_unlock_read_folio().
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/netfs/read_retry.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>


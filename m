Return-Path: <linux-nfs+bounces-7669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBEE9BCF8C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 15:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93A31F21AFC
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7B1D5AD7;
	Tue,  5 Nov 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVM07IFX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0541D86F1
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817356; cv=none; b=EaKlTg+Q6nMCghCZ1wcsSu69Z0AArbFOoMpQ+vJCxwFODehA+3aqd4r+0v0fJGadsVX36kIla3SDuSdPY06Ib4JqwLgJyFEct1cR1VY/rU1e4Le1HKIMvvSYgCvPcDKScUe8A6E3bgp/l08UH8UdGxWYmpOAOubNPpugbWoQrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817356; c=relaxed/simple;
	bh=HCr9ZRMXhPN3Yml60onPM0HCSXIy3kVF6dX0QytCm+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngjv7ic7ns9WyfJ2PyoZiR//kRe9R/hinvxV7hdtI9xmUCo2n3RGige6446G3ucp+f2Jj9A+kUQC9qo9VN4odlItcrSCes1SqpDFIeYHZlQPxbbOQDSi66gAOkqS8dysnz0WD3foftD7ys6w9kRHUa7V82GobGG6pW7eh3dDYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVM07IFX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730817353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCr9ZRMXhPN3Yml60onPM0HCSXIy3kVF6dX0QytCm+Y=;
	b=AVM07IFXW4LxJKFK7LOolA1lvf3/7YNcx+LHtcN2usKyYiN2VNc2X67KKcUz9pA154g5ys
	/OAsygRnpmJ8YQ2KTj2hxXxHQoHBL5i1ZrVbplAjBo0pf/2sBT1cikLKHtt/GRaz2dEA03
	sE9Ja1k2dwIF9H0ZaofgtEX2L+AjdYQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-uS9hdPJGOvyJJowCNciByg-1; Tue,
 05 Nov 2024 09:35:50 -0500
X-MC-Unique: uS9hdPJGOvyJJowCNciByg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A65761955D57;
	Tue,  5 Nov 2024 14:35:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E6FC300018D;
	Tue,  5 Nov 2024 14:35:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>, Igor Raits <igor@gooddata.com>
Cc: anna.schumaker@oracle.com, chuck.lever@oracle.com,
 linux-nfs@vger.kernel.org
Subject: Re: Soft lockup with fstests on NFSv3 and NFSv4.0
Date: Tue, 05 Nov 2024 09:35:46 -0500
Message-ID: <711C6B90-0BE0-4392-82D5-6DFD859F988C@redhat.com>
In-Reply-To: <727185b6375cbb9138edd46a7bd37186de83670c.camel@hammerspace.com>
References: <9F6400FB-AF3C-4B56-B38F-E964B60B508D@oracle.com>
 <727185b6375cbb9138edd46a7bd37186de83670c.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 4 Nov 2024, at 13:04, Trond Myklebust wrote:

> On Sat, 2024-11-02 at 15:32 +0000, Chuck Lever III wrote:
>> Hi-
>>
>> I've noticed that my nightly fstests runs have been hanging
>> for the past few days for the fs-current and fs-next and
>> linux-6.11.y kernels.
>>
>> I checked in on one of the NFSv3 clients, and the console
>> had this, over and over (same with the NFSv4.0 client):
>>
>>
>> [23860.805728] watchdog: BUG: soft lockup - CPU#2 stuck for 17446s!
>> [751:691784]
>> [23860.806601] Modules linked in: nfsv3 nfs_acl nfs lockd grace
>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill nf_tables nfnetlink
>> siw intel_rapl_msr intel_rapl_common sunrpc ib_core kvm_intel
>> iTCO_wdt intel_pmc_bxt iTCO_vendor_support snd_pcsp snd_pcm kvm
>> snd_timer snd soundcore rapl i2c_i801 virtio_balloon lpc_ich
>> i2c_smbus virtio_net net_failover failover joydev loop fuse zram xfs
>> crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>> polyval_generic ghash_clmulni_intel virtio_console sha512_ssse3
>> virtio_blk serio_raw qemu_fw_cfg
>> [23860.812638] CPU: 2 UID: 0 PID: 691784 Comm: 751 Tainted:
>> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 L=C2=A0=C2=A0=C2=A0=C2=A0 6.12.0-rc5-g8c4f6fa04f3d #1
>> [23860.813529] Tainted: [L]=3DSOFTLOCKUP
>> [23860.813926] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>> BIOS 1.16.3-2.fc40 04/01/2014
>> [23860.814745] RIP: 0010:_raw_spin_lock+0x1b/0x30
>> [23860.815218] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
>> 0f 1e fa 0f 1f 44 00 00 65 ff 05 48 02 ee 61 31 c0 ba 01 00 00 00 f0
>> 0f b1 17 <75> 05 c3 cc cc cc cc 89 c6 e8 77 04 00 00 90 c3 cc cc cc
>> cc 90 90
>> [23860.817076] RSP: 0018:ff55e5e888aef550 EFLAGS: 00000246
>> [23860.817687] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000002
>> [23860.818459] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
>> ff29918f86f43ebc
>> [23860.819147] RBP: ff95ae8744fd8000 R08: 0000000000000000 R09:
>> 0000000000100000
>> [23860.819984] R10: 0000000000000000 R11: 000000000003ed8c R12:
>> ff29918f86f43ebc
>> [23860.820805] R13: ff95ae8744fd8000 R14: 0000000000000001 R15:
>> 0000000000000000
>> [23860.821602] FS:=C2=A0 00007f591e707740(0000) GS:ff299192afb00000(00=
00)
>> knlGS:0000000000000000
>> [23860.822464] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [23860.823030] CR2: 00007f6f6d2f1050 CR3: 0000000111ba0006 CR4:
>> 0000000000773ef0
>> [23860.823708] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [23860.824389] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [23860.825107] PKRU: 55555554
>> [23860.825406] Call Trace:
>> [23860.825721]=C2=A0 <IRQ>
>> [23860.825996]=C2=A0 ? watchdog_timer_fn+0x1e0/0x260
>> [23860.826434]=C2=A0 ? __pfx_watchdog_timer_fn+0x10/0x10
>> [23860.826902]=C2=A0 ? __hrtimer_run_queues+0x113/0x280
>> [23860.827362]=C2=A0 ? ktime_get+0x3e/0xf0
>> [23860.827781]=C2=A0 ? hrtimer_interrupt+0xfa/0x230
>> [23860.828283]=C2=A0 ? __sysvec_apic_timer_interrupt+0x55/0x120
>> [23860.828861]=C2=A0 ? sysvec_apic_timer_interrupt+0x6c/0x90
>> [23860.829356]=C2=A0 </IRQ>
>> [23860.829591]=C2=A0 <TASK>
>> [23860.829827]=C2=A0 ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [23860.830428]=C2=A0 ? _raw_spin_lock+0x1b/0x30
>> [23860.830842]=C2=A0 nfs_folio_find_head_request+0x29/0x90 [nfs]
>> [23860.831398]=C2=A0 nfs_lock_and_join_requests+0x64/0x270 [nfs]
>> [23860.831953]=C2=A0 nfs_page_async_flush+0x1b/0x1f0 [nfs]
>> [23860.832447]=C2=A0 nfs_wb_folio+0x1a4/0x290 [nfs]
>> [23860.832903]=C2=A0 nfs_release_folio+0x62/0xb0 [nfs]
>> [23860.833376]=C2=A0 split_huge_page_to_list_to_order+0x453/0x1140
>> [23860.833930]=C2=A0 split_huge_pages_write+0x601/0xb30
>> [23860.834421]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x210
>> [23860.835000]=C2=A0 ? do_syscall_64+0x8e/0x160
>> [23860.835399]=C2=A0 ? inode_security+0x22/0x60
>> [23860.835810]=C2=A0 full_proxy_write+0x54/0x80
>> [23860.836211]=C2=A0 vfs_write+0xf8/0x450
>> [23860.836560]=C2=A0 ? __x64_sys_fcntl+0x9b/0xe0
>> [23860.837023]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x210
>> [23860.837589]=C2=A0 ksys_write+0x6f/0xf0
>> [23860.837950]=C2=A0 do_syscall_64+0x82/0x160
>> [23860.838396]=C2=A0 ? __x64_sys_fcntl+0x9b/0xe0
>> [23860.838871]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x210
>> [23860.839433]=C2=A0 ? do_syscall_64+0x8e/0x160
>> [23860.839910]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x210
>> [23860.840481]=C2=A0 ? do_syscall_64+0x8e/0x160
>> [23860.840950]=C2=A0 ? get_close_on_exec+0x34/0x40
>> [23860.841363]=C2=A0 ? do_fcntl+0x2d0/0x730
>> [23860.841727]=C2=A0 ? __x64_sys_fcntl+0x9b/0xe0
>> [23860.842168]=C2=A0 ? syscall_exit_to_user_mode+0x10/0x210
>> [23860.842684]=C2=A0 ? do_syscall_64+0x8e/0x160
>> [23860.843084]=C2=A0 ? clear_bhb_loop+0x25/0x80
>> [23860.843490]=C2=A0 ? clear_bhb_loop+0x25/0x80
>> [23860.843897]=C2=A0 ? clear_bhb_loop+0x25/0x80
>> [23860.844271]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [23860.844845] RIP: 0033:0x7f591e812f64
>> [23860.845242] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
>> 84 00 00 00 00 00 f3 0f 1e fa 80 3d 05 74 0d 00 00 74 13 b8 01 00 00
>> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec
>> 20 48 89
>> [23860.847175] RSP: 002b:00007ffc19051998 EFLAGS: 00000202 ORIG_RAX:
>> 0000000000000001
>> [23860.847923] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
>> 00007f591e812f64
>> [23860.848702] RDX: 0000000000000002 RSI: 0000562caf357b00 RDI:
>> 0000000000000001
>> [23860.849402] RBP: 00007ffc190519c0 R08: 0000000000000073 R09:
>> 0000000000000001
>> [23860.850081] R10: 0000000000000000 R11: 0000000000000202 R12:
>> 0000000000000002
>> [23860.850794] R13: 0000562caf357b00 R14: 00007f591e8e35c0 R15:
>> 00007f591e8e0f00
>> [23860.851592]=C2=A0 </TASK>
>>
>
> I suspect it might be commit b571cfcb9dca ("nfs: don't reuse partially
> completed requests in nfs_lock_and_join_requests").
> That patch appears to assume that if one request is complete, then the
> others will complete too before unlocking. I don't think that is a
> valid assumption, since other requests could hit a non-fatal error or a=

> short write that would cause them not to complete.
>
> So can you please try reverting only that patch and seeing if that
> fixes the problem?

Copy Igor Raits here as well, they reported what looks like the same
problem, and might be able to verify a revert:

https://lore.kernel.org/linux-nfs/CA+9S74gER-UFWp7fV8GnsUKMV5T32-UiKDPq4d=
YtW9XzG3tstw@mail.gmail.com

Ben



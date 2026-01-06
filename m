Return-Path: <linux-nfs+bounces-17463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 330CECF6E18
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 07:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 208803018412
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 06:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91530171E;
	Tue,  6 Jan 2026 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXaW1xxZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DD3019A6
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767680481; cv=none; b=AbEJA2yr/x4kJagdcXDCiJXBh97+rNajDU+Hv2up283ts+4rbhjtt2A1ZweAtOgtOn+Ld832q6Uz6tW8nq1bBZZhYhQD/HgiPRAYxWmLMcfg/nUfwRMJy3fXpQJVCLwyJ+hMx1xVVvZa4ZWOZS1mTgCeWOkbnycGslpv225Q77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767680481; c=relaxed/simple;
	bh=PhM7mkMXnWp+1QfT8vBLVQjoxwth3kVTNMTfiTiwEks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY3fcfsdHBH4OISguUWd/eWVU3n8svTB9UTVjqDtiz6Ayv3XEIfZ0pU3LySjaPDz+TlkVuNovnb5H4JyrXSjHZP+zI2g+Ney4RhWYf7/bqgChyg7Gj9qQ9WneAOCG/BnNzbIAMpFe+WEab7e6ng4U9jLK3VQKBlscOELjvacG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZXaW1xxZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3cxTwh04nbrcxzm6aNW2LqQ34vJTkWAdBcJZHkKxesc=; b=ZXaW1xxZVp+KKxpFGHgGX1Hyyr
	AtUMfUx49LPma54LaioGtv2pb83cIto0Z5RlT9Hmt+ftUaKS3ZYGaeRTShi8jHsVOO8WzBIJvtS4C
	fgru7w4SeCw4+iUMx4cNBVMS8ljhIDZsbv4XUmEcyQmA67uZOBaWQPvv2FBvjxJJs0HaqxUw2gRNQ
	E7YYt/OHAVkl4B/trh7mdUzrajuKwsCdmBeNyxiXLRe3YCbTbMlnm6gfwZmaeq+BuWhhuvm8heM1a
	dtlCVAjNh2cZM9HVOGgGcY8ansrHl7YqZfBShzCU4FMN6Ea1z7pnD0E0SkmzRFzycfuRdp0f+g5Fz
	6dYC9sFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd0RR-0000000CSs7-1HT6;
	Tue, 06 Jan 2026 06:21:17 +0000
Date: Mon, 5 Jan 2026 22:21:17 -0800
From: "hch@infradead.ori" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <aVyp3SIddHB5sMhp@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org>
 <aUnq_d93Wo9e-oUD@infradead.org>
 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 31, 2025 at 09:52:35PM +0000, Trond Myklebust wrote:
> Does applying the following on top of Anna's patch fix the Oops?

It does.  But now generic/633 crashes reliably:

generic/633  2s ... [   58.670535] run fstests generic/633 at 2026-01-02 02:00:17
[   58.865568] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv: empty string added
[   58.897522] Oops: general protection fault, probably for non-canonical address 0xcccccccccccccd0c: 0000 [#1] SMP NOPTI
[   58.898234] CPU: 0 UID: 0 PID: 3852 Comm: vfstest Tainted: G                 N  6.19.0-rc2+ #4535 PREEMPT(full) 
[   58.898829] Tainted: [N]=TEST
[   58.899013] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   58.899594] RIP: 0010:nfs_end_delegation_return+0xda/0x390
[   58.899922] Code: 49 89 ce e8 58 be bf ff 48 8b 85 60 ff ff ff 4c 8d 68 80 49 39 c6 74 50 4c 8b 7c 24 08 48 8b 1c 24 4d 8b 65 60 4d 85 e4 74 2e <49> 8b 44 24 40 a8 02 74 25 49 8b 44 24 40 f6 c4 02 75 1b 41 8b 47
[   58.901063] RSP: 0018:ffffc90001947c90 EFLAGS: 00010286
[   58.901419] RAX: ffff88811a3122c0 RBX: ffff888105268970 RCX: ffff888111a9a210
[   58.901827] RDX: ffff8881039320c0 RSI: ffff888105268940 RDI: ffff888111a9a2b0
[   58.902236] RBP: ffff888111a9a2b0 R08: 0000000000000000 R09: 0000000000000000
[   58.902696] R10: ffffc90001947d48 R11: fefefefefefefeff R12: cccccccccccccccc
[   58.903112] R13: ffff88811a312240 R14: ffff888111a9a210 R15: ffff888105268940
[   58.903594] FS:  00007f04f92c6740(0000) GS:ffff8882b353d000(0000) knlGS:0000000000000000
[   58.904125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.904483] CR2: 000055c55fe522d8 CR3: 000000011a3f1004 CR4: 0000000000772ef0
[   58.904927] PKRU: 55555554
[   58.905132] Call Trace:
[   58.905294]  <TASK>
[   58.905434]  ? _raw_spin_unlock+0x13/0x30
[   58.905689]  nfs4_proc_setattr+0xff/0x110
[   58.905947]  nfs_setattr+0x1c8/0x410
[   58.906175]  notify_change+0x373/0x510
[   58.906415]  ? init_object+0x5a/0xc0
[   58.906643]  ? chown_common+0x1ec/0x220
[   58.906885]  chown_common+0x1ec/0x220
[   58.907126]  do_fchownat+0xc3/0xf0
[   58.907358]  __x64_sys_fchownat+0x1a/0x30
[   58.907611]  do_syscall_64+0x50/0xf80
[   58.907848]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   58.908171] RIP: 0033:0x7f04f93c8e4a
[   58.908390] Code: 48 8b 0d b1 6f 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 04 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7e 6f 0e 00 f7 d8 64 89 01 48
[   58.909467] RSP: 002b:00007ffe4cd3ec98 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
[   58.909893] RAX: ffffffffffffffda RBX: 00007ffe4cd3ecb0 RCX: 00007f04f93c8e4a
[   58.910336] RDX: 0000000000002710 RSI: 000055c54836500e RDI: 0000000000000003
[   58.910872] RBP: 000055c55fd522a0 R08: 0000000000000100 R09: 0000000000000001
[   58.911350] R10: 0000000000002710 R11: 0000000000000246 R12: 0000000000000006
[   58.911797] R13: 0000000000002710 R14: 0000000000002710 R15: 000055c55fd52313
[   58.912234]  </TASK>
[   58.912373] Modules linked in: kvm_intel kvm irqbypass
[   58.912717] ---[ end trace 0000000000000000 ]---
[   58.913829] RIP: 0010:nfs_end_delegation_return+0xda/0x390
[   58.914177] Code: 49 89 ce e8 58 be bf ff 48 8b 85 60 ff ff ff 4c 8d 68 80 49 39 c6 74 50 4c 8b 7c 24 08 48 8b 1c 24 4d 8b 65 60 4d 85 e4 74 2e <49> 8b 44 24 40 a8 02 74 25 49 8b 44 24 40 f6 c4 02 75 1b 41 8b 47
[   58.915541] RSP: 0018:ffffc90001947c90 EFLAGS: 00010286
[   58.915871] RAX: ffff88811a3122c0 RBX: ffff888105268970 RCX: ffff888111a9a210
[   58.916317] RDX: ffff8881039320c0 RSI: ffff888105268940 RDI: ffff888111a9a2b0
[   58.916766] RBP: ffff888111a9a2b0 R08: 0000000000000000 R09: 0000000000000000
[   58.917299] R10: ffffc90001947d48 R11: fefefefefefefeff R12: cccccccccccccccc
[   58.917709] R13: ffff88811a312240 R14: ffff888111a9a210 R15: ffff888105268940
[   58.918109] FS:  00007f04f92c6740(0000) GS:ffff8882b353d000(0000) knlGS:0000000000000000
[   58.918560] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.918944] CR2: 00007fbf39569000 CR3: 000000011a3f1004 CR4: 0000000000772ef0
[   58.919622] PKRU: 55555554



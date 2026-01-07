Return-Path: <linux-nfs+bounces-17521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460FCFC0F1
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 06:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D0C43002D17
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 05:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD271A256B;
	Wed,  7 Jan 2026 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kRtq2YhZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38D1F94A
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767763396; cv=none; b=hucxgXDBdn2H5HqJuMiZSqaNBk8SLfBwr1k66QIZEVHWL3Vh2fqZupdHHy+llyPfFyAQbTkzr8u7Q13i23Qygd88qCyJG6lJXYlMAgeb45vVHMUM50enQhYwJ8PRasXXGlNy0VcRhQRnkX5RYNyaew94LAkHVgsg/iUUxEa4Uk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767763396; c=relaxed/simple;
	bh=VyBLTkOhh5AkMS/gSXiV58owvakwYOY939hTfpHhuwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbVcfsKgb3sXjWH8xoko2PT41Fs3mSOUm5Chc93WccQ8MqQPWqlMAJrX7YN7xjyxzvN5Fstsrm3aBFjd4J54+s1NIdUvnOyq0+E+eLIOKXhPzfyrSpSVi3+8Oudnp+qjnjuXlSphAop29wQmcM628dOy6tsTBvaI0qpXyQSpz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kRtq2YhZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F3BhaX5X+5amMTHmj1JVgN5gQNPiYioGK3Bt1bQ7ncs=; b=kRtq2YhZ1dYHTCFKbPYsLx4b92
	vuvuQksff77ULJ/6wRzUzGFHeINRtJItjNCTJ/odiiFiiNcD5RouxXoPs6+OFPAoY/IxuOlK5ZDnL
	UC7kTyrmDrlAxeO5CYOTrfUolMjfKiWesf9inTitDSxpBi9jM/bC3HzTLzQFZRdbeFpTGfrnwUDci
	5mmJQunFQGd5TfI7sls7Q/Uf8T1k8QVI0kOR+3TwNbAByavERW8BxYuvmE5BkowCYNuOKefpj9YL9
	qWbW9XZhzi9nS8JmKc88+9sEfKmWKPzfwoFKXkIiEdQyFALJhjCpbaXp+rkn/eOBJp33INWsjOXLB
	cD/PlTNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdM0b-0000000EAz1-0UFp;
	Wed, 07 Jan 2026 05:23:01 +0000
Date: Tue, 6 Jan 2026 21:23:01 -0800
From: "hch@infradead.ori" <hch@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: "hch@infradead.ori" <hch@infradead.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <aV3ttYmT2vAtPDws@infradead.org>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org>
 <aUnq_d93Wo9e-oUD@infradead.org>
 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
 <aVyp3SIddHB5sMhp@infradead.org>
 <1df4bb7ff3e6fd607c1811d75fcd6dcb860e320e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1df4bb7ff3e6fd607c1811d75fcd6dcb860e320e.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 06, 2026 at 01:32:54PM -0500, Trond Myklebust wrote:
> Sigh... One last patch on top of all the previous ones, but if we hit
> another issue I think we need to consider just disabling directory
> delegations on the client until all the remaining issues can be fixed
> in the next release.

This still crasheѕ generic/633:

generic/633  4s ... [   73.075526] run fstests generic/633 at 2026-01-07 05:21:37
[   73.286318] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv: empty string added
[   73.314625] Oops: general protection fault, probably for non-canonical address 0xcccccccccccccd50: 0000 [#1] SMP NOPTI
[   73.315391] CPU: 1 UID: 0 PID: 100 Comm: kworker/u8:3 Tainted: G                 N  6.19.0-rc4+ #4540 PREEMPT(full) 
[   73.316043] Tainted: [N]=TEST
[   73.316229] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   73.316786] Workqueue: rpciod rpc_async_schedule
[   73.317066] RIP: 0010:nfs_inode_find_state_and_recover+0x9c/0x260
[   73.317430] Code: 01 0f 85 83 00 00 00 49 8b 84 24 80 00 00 00 4c 8d 60 80 48 39 c3 0f 84 68 01 00 00 4d 8b 7c 24 60 4d 85 ff 74 e1 48 8b 7d 00 <49> 39 bf 84 00 00 00 75 af 8b 4d 08 41 39 8f 8c 00 00 00 75 a3 48
[   73.318513] RSP: 0018:ffffc900001bfd00 EFLAGS: 00010286
[   73.318868] RAX: ffff88810cfb98e0 RBX: ffff8881d68d8c50 RCX: 0000000000000000
[   73.319354] RDX: ffff88810330a0c0 RSI: ffff88811a86d914 RDI: b6162427695ded30
[   73.319832] RBP: ffff88811a86d918 R08: ffff88810c685100 R09: ffff88810c685130
[   73.320270] R10: 0000000000000003 R11: fefefefefefefeff R12: ffff88810cfb9860
[   73.320698] R13: ffff8881179b2800 R14: 0000000000000000 R15: cccccccccccccccc
[   73.321135] FS:  0000000000000000(0000) GS:ffff8882b363d000(0000) knlGS:0000000000000000
[   73.321640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.321994] CR2: 0000559277cef238 CR3: 0000000161792002 CR4: 0000000000772ef0
[   73.322422] PKRU: 55555554
[   73.322592] Call Trace:
[   73.322749]  <TASK>
[   73.322889]  nfs4_delegreturn_done+0x1b7/0x380
[   73.323173]  ? __pfx_rpc_exit_task+0x10/0x10
[   73.323475]  rpc_exit_task+0x5c/0x170
[   73.323755]  __rpc_execute+0xb1/0x490
[   73.324000]  rpc_async_schedule+0x2a/0x40
[   73.324257]  process_one_work+0x16c/0x330
[   73.324515]  worker_thread+0x254/0x3a0
[   73.324762]  ? __pfx_worker_thread+0x10/0x10
[   73.325042]  kthread+0x117/0x230
[   73.325303]  ? __pfx_kthread+0x10/0x10
[   73.325557]  ? __pfx_kthread+0x10/0x10
[   73.325812]  ret_from_fork+0x1b6/0x200
[   73.326045]  ? __pfx_kthread+0x10/0x10
[   73.326278]  ret_from_fork_asm+0x1a/0x30
[   73.326535]  </TASK>
[   73.326681] Modules linked in: kvm_intel kvm irqbypass
[   73.327046] ---[ end trace 0000000000000000 ]---


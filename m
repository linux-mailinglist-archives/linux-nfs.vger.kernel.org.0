Return-Path: <linux-nfs+bounces-6044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BF6965909
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 09:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C773F1F267E3
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12E15855F;
	Fri, 30 Aug 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSpHUVcS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001ED158544
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004053; cv=none; b=YwrYxiOgDm1M4IvCWnQNXbQDBdQdtmEuoLnluZsEU3GtyqxzPK/JLeb4Eqk0snqdDSaKCANBWIu+6gU4SgMBdRF3LDSIM+gfrJNBww+x3edq/JVitMd6/06OAhchOmSCfC0L5SSDxHUnE48J4EnxP/MlaSBQLiPaX+MQoibkWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004053; c=relaxed/simple;
	bh=Z5IWmCaGTWNR5JErDN0LUlfl9zkBsCNjOw4HKOxIXug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp3far+8qLEpZ7lrMxFo7Z7cCrYcqCAcVsva7V6AQCxsLa8EYM+ZQgTrui8bhFA6A1HUT8qQlys9XB7s2n1N1GUVRO8LKISqz9xZ6yh/M5Or6HI+xH46/E1Ref4FeMAj575tq5QLkEOGm+xJCldnKI+8gMl8spNXNfz2ZHU0Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSpHUVcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE84C4CEC2;
	Fri, 30 Aug 2024 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725004052;
	bh=Z5IWmCaGTWNR5JErDN0LUlfl9zkBsCNjOw4HKOxIXug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSpHUVcSlVqefGIs+Yr5Kv13NLXKAWqx7CVc/OWcPDu/Y7RQcBEJT7baNTQM6+NiS
	 mEpgN4rb9958KaeyMk+7IOdSnvgAw9ps7d4BvRGeFENBEdI5zsKqawpPjTWFO2SIuB
	 ojyYstRhvolaTs0fsQr62O9iC6CgyYfhAkMIkcRNTBNAsOenzuF+zBintrYiPOZlXh
	 wH87PtYWeFj9FFn/FHH0c+b5PPP/TWn4UoyTO/RepP//NZgwDlylCP1PxKJ3azQAze
	 hsFKoE8v5soGf20FW/OCMlGU4JUrcYwYSMZrXWMZTTIB8KEsYNxZwKSSfMItEbBUZJ
	 P2Z0LmbsVaRbg==
Date: Fri, 30 Aug 2024 03:47:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v14-plus 00/25] Address netns refcount issues for localio
Message-ID: <ZtF5E5H53tkNurR3@kernel.org>
References: <20240830023531.29421-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830023531.29421-1-neilb@suse.de>

On Fri, Aug 30, 2024 at 12:20:13PM +1000, NeilBrown wrote:
> Following are revised versions of 6 patches from the v14 localio series.
> 
> The issue addressed is net namespace refcounting.
> 
> We don't want to keep a long-term counted reference in the client
> because that prevents a server container from completely shutting down.
> 
> So we avoid taking a reference at all and rely on the per-cpu reference
> to the server being sufficient to keep the net-ns active.  This involves
> allowing the net-ns exit code to iterate all active clients and clear
> their ->net pointers (which they need to find the per-cpu-refcount for
> the nfs_serv).
> 
> So:
>  - embed nfs_uuid_t in nfs_client.  This provides a list_head that can
>    be used to find the client.  It does add the actual uuid to nfs_client
>    so it is bigger than needed.  If that is really a problem we can find
>    a fix.
> 
>  - When the nfs server confirms that the uuid is local, it moves the
>    nfs_uuid_t onto a per-net-ns list.
> 
>  - When the net-ns is shutting down - in a "pre_exit" handler, all these
>    nfS_uuid_t have their ->net cleared.  There is an rcu_synchronize()
>    call between pre_exit() handlers and exit() handlers so and caller
>    that sees ->net as not NULL can safely check the ->counter
> 
>  - We now pass the nfs_uuid_t to nfsd_open_local_fh() so it can safely
>    look at ->net in a private rcu_read_lock() section.
> 
> I have compile tested this code but nothing more.
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 14/25] nfs_common: add NFS LOCALIO auxiliary protocol
>  [PATCH 15/25] nfs_common: introduce nfs_localio_ctx struct and
>  [PATCH 16/25] nfsd: add localio support
>  [PATCH 17/25] nfsd: implement server support for NFS_LOCALIO_PROGRAM
>  [PATCH 19/25] nfs: add localio support
>  [PATCH 23/25] nfs: implement client support for NFS_LOCALIO_PROGRAM

Hey Neil,

I attempted to test the kernel with your changes but it crashed with:

[   55.422564] list_add corruption. next is NULL.
[   55.423523] ------------[ cut here ]------------
[   55.424423] kernel BUG at lib/list_debug.c:27!
[   55.425291] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   55.426367] CPU: 29 UID: 0 PID: 5251 Comm: nfsd Kdump: loaded Not tainted 6.11.0-rc4.snitm+ #147
[   55.427991] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-4.module+el8.9.0+19570+14a90618 04/01/2014
[   55.429697] RIP: 0010:__list_add_valid_or_report+0x55/0xa0
[   55.430741] Code: 4c 39 cf 74 4f b8 01 00 00 00 5d c3 cc cc cc cc 48 c7 c7 98 1d a5 82 e8 d9 6d 93 ff 0f 0b 48 c7 c7 c0 1d a5 82 e8 cb 6d 93 ff <0f> 0b 4c 89 c1 48 c7 c7 e8 1d a5 82 e8 ba 6d 93 ff 0f 0b 48 89 d1
[   55.434167] RSP: 0018:ffff8881441a7d50 EFLAGS: 00010296
[   55.435141] RAX: 0000000000000022 RBX: ffff888107b50370 RCX: 0000000000000000
[   55.436455] RDX: ffff888473caf800 RSI: ffff888473ca18c0 RDI: ffff888473ca18c0
[   55.437770] RBP: ffff8881441a7d50 R08: 0000000000000022 R09: ffff8881441a7be8
[   55.439098] R10: ffff8881441a7be0 R11: ffffffff8333f328 R12: ffff888107b50380
[   55.440419] R13: ffff888103b15080 R14: ffff888107bb5d00 R15: 0000000000000000
[   55.441737] FS:  0000000000000000(0000) GS:ffff888473c80000(0000) knlGS:0000000000000000
[   55.443228] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.444297] CR2: 000055958fab3488 CR3: 000000010615e000 CR4: 0000000000350ef0
[   55.445615] Call Trace:
[   55.446090]  <TASK>
[   55.446498]  ? show_regs+0x6d/0x80
[   55.447149]  ? die+0x3c/0xa0
[   55.447698]  ? do_trap+0xcf/0xf0
[   55.448316]  ? do_error_trap+0x75/0xa0
[   55.449026]  ? __list_add_valid_or_report+0x55/0xa0
[   55.449938]  ? exc_invalid_op+0x57/0x80
[   55.450660]  ? __list_add_valid_or_report+0x55/0xa0
[   55.451646]  ? asm_exc_invalid_op+0x1f/0x30
[   55.452438]  ? __list_add_valid_or_report+0x55/0xa0
[   55.453355]  nfs_uuid_is_local+0xba/0x110
[   55.454115]  localio_proc_uuid_is_local+0x64/0x80 [nfsd]
[   55.455145]  nfsd_dispatch+0xc2/0x210 [nfsd]
[   55.455977]  svc_process_common+0x2e6/0x6e0
[   55.456761]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[   55.457697]  svc_process+0x13e/0x1e0
[   55.458377]  svc_recv+0x89e/0xa70
[   55.459012]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[   55.459806]  nfsd+0xa5/0x100 [nfsd]
[   55.460486]  kthread+0xe5/0x120
[   55.461090]  ? __pfx_kthread+0x10/0x10
[   55.461801]  ret_from_fork+0x3d/0x60
[   55.462476]  ? __pfx_kthread+0x10/0x10
[   55.463184]  ret_from_fork_asm+0x1a/0x30
[   55.463923]  </TASK>

I'll triple check my melding of your changes and mine in ~7 hours.. I
may have missed something.

Note this is _not_ with your other incremental patch (that uses
__module_get) -- only because I didn't get to that yet.

Mike


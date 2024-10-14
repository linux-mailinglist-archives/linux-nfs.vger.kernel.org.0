Return-Path: <linux-nfs+bounces-7144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5499CB85
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6985B1C2087F
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E124A3E;
	Mon, 14 Oct 2024 13:24:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA219C551
	for <linux-nfs@vger.kernel.org>; Mon, 14 Oct 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912242; cv=none; b=b522v14Yoak0LXX+gjPcc03RT+iXTZpd/2X9vT7z+4SJdJevYM+vvj04Rjr9OG0t8HAzZzm0iYCyzLSvPzQCtPAvo7Qre3xGwTjh6mxWTdacMSu4ItSGy3guux27HKxVXpxDNzcUEE3/G6kE9i7v81O0t8WZbGm0rvNnFKOsc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912242; c=relaxed/simple;
	bh=NYqq6n6ocMspcgnj7l596bEBClIkYRGt4qP9TxVqMpA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=dRRG1waUbVNgdSHo+dv1io8dRXCbv4bVTQ4dcavO3oKYFBOv8mdWBoZEGwvaJ7jyFoeXCEZHE1zVa2KhUvmnITtCL0mZ+vaO4xv+TBJMp6i5EMRybTaEp2J7xonlowpWZ/AESRCVz8fujov/avLkphyU2aQh3kpYsg/ju7lS3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Zhq-9Gq_1728908564 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 20:22:45 +0800
Date: Mon, 14 Oct 2024 20:22:45 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: nfs client deadloop on 6.6.53
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
In-Reply-To: <2ef7160ab8a62d8afba9654ee43f8ab7e65cd6b5.camel@hammerspace.com>
References: <20241014061048.E3F1.409509F4@e16-tech.com> <2ef7160ab8a62d8afba9654ee43f8ab7e65cd6b5.camel@hammerspace.com>
Message-Id: <20241014202244.D592.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.07 [en]

Hi,

> On Mon, 2024-10-14 at 06:10 +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > On Tue, 2024-10-08 at 21:27 +0800, Wang Yugui wrote:
> > > > Hi,
> > > > 
> > > > nfs client deadloop on 6.6.53.
> > > > 
> > > > [ 9409.381322] sysrq: Show Blocked State
> > > > [ 9409.386146] task:bash??????????? state:D stack:0???? pid:2323?
> > > > ppid:2226?? flags:0x00004002
> > > > [ 9409.395225] Call Trace:
> > > > [ 9409.398376]? <TASK>
> > > > [ 9409.401172]? __schedule+0x232/0x5d0
> > > > [ 9409.405370]? schedule+0x5e/0xd0
> > > > [ 9409.409217]? schedule_timeout+0x8c/0x170
> > > > [ 9409.413837]? ? __pfx_process_timeout+0x10/0x10
> > > > [ 9409.418989]? msleep+0x3b/0x50
> > > > [ 9409.422656]? ff_layout_pg_init_read+0x1c1/0x290
> > > > [nfs_layout_flexfiles]
> > > > [ 9409.429910]? __nfs_pageio_add_request+0x29b/0x480 [nfs]
> > > > [ 9409.435911]? nfs_pageio_add_request+0x221/0x2a0 [nfs]
> > > > [ 9409.441715]? nfs_read_add_folio+0x1a3/0x280 [nfs]
> > > > [ 9409.447175]? nfs_readahead+0x235/0x2d0 [nfs]
> > > > [ 9409.452193]? read_pages+0x56/0x2c0
> > > > [ 9409.456298]? page_cache_ra_unbounded+0x134/0x1a0
> > > > [ 9409.461626]? filemap_get_pages+0xf5/0x3a0
> > > > [ 9409.466355]? ? __nfs_lookup_revalidate+0x53/0x140 [nfs]
> > > > [ 9409.472325]? filemap_read+0xdc/0x350
> > > > [ 9409.476614]? ? find_idlest_group+0x113/0x530
> > > > [ 9409.481614]? nfs_file_read+0x74/0xc0 [nfs]
> > > > [ 9409.486461]? __kernel_read+0xff/0x2b0
> > > > [ 9409.490838]? search_binary_handler+0x70/0x250
> > > > [ 9409.495908]? exec_binprm+0x50/0x1a0
> > > > [ 9409.500102]? bprm_execve.part.0+0x17d/0x230
> > > > [ 9409.504993]? do_execveat_common.isra.0+0x1a2/0x240
> > > > [ 9409.510489]? __x64_sys_execve+0x37/0x50
> > > > [ 9409.515026]? do_syscall_64+0x5a/0x90
> > > > [ 9409.519298]? ? __count_memcg_events+0x4c/0xa0
> > > > [ 9409.524348]? ? mm_account_fault+0x6c/0x100
> > > > [ 9409.529129]? ? handle_mm_fault+0x154/0x280
> > > > [ 9409.533903]? ? do_user_addr_fault+0x35f/0x680
> > > > [ 9409.538935]? ? exc_page_fault+0x69/0x150
> > > > [ 9409.543537]? entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > > > [ 9409.549277] RIP: 0033:0x7f57378d987b
> > > > [ 9409.553572] RSP: 002b:00007ffdb5978708 EFLAGS: 00000246
> > > > ORIG_RAX:
> > > > 000000000000003b
> > > > [ 9409.561847] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> > > > 00007f57378d987b
> > > > [ 9409.569690] RDX: 000055d26e403600 RSI: 000055d26e5cdc50 RDI:
> > > > 000055d26e6ce7f0
> > > > [ 9409.577534] RBP: 000055d26e6ce7f0 R08: 000055d26e5a5b60 R09:
> > > > 0000000000000000
> > > > [ 9409.585375] R10: 0000000000000008 R11: 0000000000000246 R12:
> > > > 00000000ffffffff
> > > > [ 9409.593208] R13: 000055d26e5cdc50 R14: 000055d26e403600 R15:
> > > > 000055d26e6ceb40
> > > > [ 9409.601047]? </TASK>
> > > > [ 9409.603946] task:bash??????????? state:D stack:0???? pid:2550?
> > > > ppid:2462?? flags:0x00004002
> > > > [ 9409.613027] Call Trace:
> > > > [ 9409.616185]? <TASK>
> > > > [ 9409.618983]? __schedule+0x232/0x5d0
> > > > [ 9409.623186]? schedule+0x5e/0xd0
> > > > [ 9409.627033]? io_schedule+0x46/0x70
> > > > [ 9409.631140]? folio_wait_bit_common+0x133/0x390
> > > > [ 9409.636294]? ? folio_wait_bit_common+0x100/0x390
> > > > [ 9409.641624]? ? nfs4_do_open+0xcd/0x210 [nfsv4]
> > > > [ 9409.646854]? ? __pfx_wake_page_function+0x10/0x10
> > > > [ 9409.652268]? filemap_update_page+0x2bc/0x300
> > > > [ 9409.657242]? filemap_get_pages+0x21d/0x3a0
> > > > [ 9409.662042]? ? __nfs_lookup_revalidate+0x53/0x140 [nfs]
> > > > [ 9409.668010]? filemap_read+0xdc/0x350
> > > > [ 9409.672299]? nfs_file_read+0x74/0xc0 [nfs]
> > > > [ 9409.677126]? __kernel_read+0xff/0x2b0
> > > > [ 9409.681476]? search_binary_handler+0x70/0x250
> > > > [ 9409.686526]? exec_binprm+0x50/0x1a0
> > > > [ 9409.690702]? bprm_execve.part.0+0x17d/0x230
> > > > [ 9409.695573]? do_execveat_common.isra.0+0x1a2/0x240
> > > > [ 9409.701047]? __x64_sys_execve+0x37/0x50
> > > > [ 9409.705559]? do_syscall_64+0x5a/0x90
> > > > [ 9409.709805]? ? do_user_addr_fault+0x35f/0x680
> > > > [ 9409.714834]? ? exc_page_fault+0x69/0x150
> > > > [ 9409.719414]? entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > > > [ 9409.725126] RIP: 0033:0x7f3c492d987b
> > > > [ 9409.729362] RSP: 002b:00007ffc6413a458 EFLAGS: 00000246
> > > > ORIG_RAX:
> > > > 000000000000003b
> > > > [ 9409.737609] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> > > > 00007f3c492d987b
> > > > [ 9409.745429] RDX: 000055c6a8f07600 RSI: 000055c6a90e72a0 RDI:
> > > > 000055c6a90f7890
> > > > [ 9409.753256] RBP: 000055c6a90f7890 R08: 000055c6a90f6250 R09:
> > > > 0000000000000000
> > > > [ 9409.761078] R10: 0000000000000008 R11: 0000000000000246 R12:
> > > > 00000000ffffffff
> > > > [ 9409.768904] R13: 000055c6a90e72a0 R14: 000055c6a8f07600 R15:
> > > > 000055c6a90e1ea0
> > > > [ 9409.776732]? </TASK>
> > > > 
> > > > Notice:
> > > > 1, nfs server:? kernel 6.6.54
> > > > pnfs optin in the service side /etc/exports.
> > > > 
> > > 
> > > This is not a client bug.
> > > 
> > > The client has no choice other than to retry here. It is being
> > > given a
> > > layout that it cannot use (probably because it has already
> > > discovered
> > > that it cannot talk to the data server), but it is also being told
> > > by
> > > the same layout that it is not allowed to fall back to doing I/O
> > > through the metadata server.
> > > 
> > > IOW: This bug needs to be fixed on the server, which is handing out
> > > a
> > > layout that is impossible to satisfy.
> > 
> > It seems that pnfs need nfs3/udp.
> > but the nfs3/udp is disabled on this server.
> 
> That is incorrect. There should be no need to enable RPC over UDP.

With the 2 changes in /etc/nfs.conf [nfsd] section, this problem disappeared.
1,  vers3=n     =>    vers3=y
2,  udp=n       =>    udp=y

And both nfs-server and nfs-client version are upgraded to 6.6.56.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/10/14




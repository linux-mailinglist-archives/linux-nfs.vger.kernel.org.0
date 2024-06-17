Return-Path: <linux-nfs+bounces-3881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5C90A359
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 07:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B3228137D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 05:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FB3DDD4;
	Mon, 17 Jun 2024 05:32:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DC17F5;
	Mon, 17 Jun 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602329; cv=none; b=agw/Zt3vLaaItpI93vi8Kj4tfEMsk+4se/xWUItziUHPjSGYq3wUfipaTCFfMaegyU0fxyygLjH0SDPlr7YDd7ZrnpCk48Mvs5CFPwqmSqpMvMQ7JdtbrT7tSIr3yt89gcMskcR/L6rlLaz0abMWqYkHRc7wZpnsLrkOZGWZC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602329; c=relaxed/simple;
	bh=T4U9en+9FcyxPD5xHghxFc6euoBoQoZJ/4mPh9BTMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNpI1SoXcVjRX8m2sFSzX8OBBLa87VV0eDUKTMxRsAU3Mr/PkDg1VRZK1i0TVMcoe/vNRG7FqPcr3rjkdtVeyyR+lXwrk7rfvYbAjqtEm5dXoxZS+WK+krZN445XrZaxezYGIe26pWgbup65fdCUUaqrKwpzFnxCGqotjqitPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DBE6F68B05; Mon, 17 Jun 2024 07:32:01 +0200 (CEST)
Date: Mon, 17 Jun 2024 07:32:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-mm@kvack.org, Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
Message-ID: <20240617053201.GA16852@lst.de>
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de> <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org> <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com> <20240616085436.GA28058@lst.de> <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jun 16, 2024 at 06:23:16PM +0800, Barry Song wrote:
> This is quite unusual. Could you share your setup and backtrace?

Do this in an x86 kvm vm with 1G of memory:

mkfs.xfs -f /dev/vdb

mount /dev/vdb /mnt/nfs1

# this requires the following line in /etc/exports to actually export the
# file system: "/mnt/nfs2	localhost(rw,no_root_squash)"
systemctl restart nfs-kernel-server

mount -t nfs 127.0.0.1:/mnt/nfs1/ /mnt/test/

cd /mnt/test
dd if=/dev/zero of=swapfile bs=1024 count=524288
mkswap swapfile
chmod 0600 swapfile
swapon swapfile

# xfstests-dev is a checked out and built xfstests repo
~/xfstests-dev/src/usemem 1024

The backtrace is at the end of the mail.

> I'd
> like to reproduce the issue, as the mm code only supports mTHP
> swapout on block devices. What is your swap device or swap file?

The above swap fіle on NFS is the only swap in the system

> Additionally, on what kind of filesystem is the executable file built
> from usemem.c located?

Doesn't matter.  I've tried xfs, ext4 and nfs itself.

root@testvm:~# ./xfstests-dev/src/usemem 1024
[   65.065292] ------------[ cut here ]------------
[   65.065528] kernel BUG at fs/nfs/direct.c:144!
[   65.065724] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   65.065988] CPU: 0 PID: 71 Comm: kswapd0 Not tainted 6.10.0-rc3+ #2587
[   65.066270] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   65.066683] RIP: 0010:nfs_swap_rw+0x3f/0x50
[   65.066893] Code: 00 00 74 13 e8 e2 fb ff ff 31 d2 48 85 c0 48 0f 4f c2 c3 cc cc cc cc e8 9f f8 ff ff 31 0
[   65.067698] RSP: 0018:ffffc900001b79c8 EFLAGS: 00010206
[   65.067949] RAX: ffffffff8162afc0 RBX: ffff88800ca24c00 RCX: 0000000000000004
[   65.068274] RDX: ffff88800ca24c30 RSI: ffffc900001b79d0 RDI: ffff88800ca24c00
[   65.068588] RBP: ffff88800dd710e8 R08: 0000000000004000 R09: 0000000000000010
[   65.068911] R10: 0000000000035a40 R11: 000000000000001d R12: ffffc900001b7a78
[   65.069225] R13: ffffc900001b7db0 R14: ffffc900001b7a68 R15: ffffea00003f1c40
[   65.069542] FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
[   65.069904] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.070157] CR2: 00005606ddec4dd0 CR3: 000000000365a003 CR4: 0000000000770ef0
[   65.070472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   65.070784] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   65.071282] PKRU: 55555554
[   65.071407] Call Trace:
[   65.071519]  <TASK>
[   65.071619]  ? die+0x31/0x80
[   65.071754]  ? do_trap+0xd7/0x100
[   65.071915]  ? do_error_trap+0x65/0x90
[   65.072084]  ? nfs_swap_rw+0x3f/0x50
[   65.072247]  ? exc_invalid_op+0x50/0x70
[   65.072420]  ? nfs_swap_rw+0x3f/0x50
[   65.072581]  ? asm_exc_invalid_op+0x1a/0x20
[   65.072770]  ? __pfx_nfs_swap_rw+0x10/0x10
[   65.072966]  ? nfs_swap_rw+0x3f/0x50
[   65.073125]  swap_write_unplug+0x57/0x90
[   65.073307]  shrink_folio_list+0x3a1/0xed0
[   65.073500]  ? __mod_zone_page_state+0x61/0xa0
[   65.073700]  ? isolate_lru_folios+0x2f3/0x400
[   65.073902]  shrink_lruvec+0x587/0xb60
[   65.074071]  ? shrink_slab+0x3ad/0x3c0
[   65.074239]  ? shrink_slab+0x3ad/0x3c0
[   65.074408]  shrink_node+0x2b7/0x7e0
[   65.074569]  balance_pgdat+0x291/0x6f0


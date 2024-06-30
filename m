Return-Path: <linux-nfs+bounces-4415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C767391D2B2
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36BB8B20C75
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B5153BD9;
	Sun, 30 Jun 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAADRqYx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71082576F;
	Sun, 30 Jun 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765319; cv=none; b=dx+6+G5y3559fY1VHosJ6j6bZ06oL/j9vQvIJ9qvyTzzpmDzhrahqQW711ZynZQxYltMAiPu/WEbZsiyLJWsQAn+x4/LdQivGOHdYddnd+3uQe2EiMIeYIET2eM7AvBTttKZ1UzhL3mONFmTgtoJE0Z9xS8yN2qiMkC94juhY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765319; c=relaxed/simple;
	bh=2bf++5UDQOoC0sEB+AovidW641I2CY7+1sDzoVvDMug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxxPEv7ZC4goyjIkBdm5YWb5wYp/F1bygrK9o27zSYppDIYNUFkp1Bz1BCy1x8iiWN4+z+cHHP2NGovQEVQtPYMK946wHmbbHsPnimR5kVMQUZfbHFDssuN6WdF1ey1XUU0Yre/VwMs+BUcAUKW7CBbaZ7PUzN3Us39J3PPKHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAADRqYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA06C2BD10;
	Sun, 30 Jun 2024 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765318;
	bh=2bf++5UDQOoC0sEB+AovidW641I2CY7+1sDzoVvDMug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAADRqYxAcftgoAjtvfat/sEsJHStnPGM3hf+YLiAkMDDfGTsIP6rqXmgSTHssQLB
	 +rfrZJRGQx1c9x9n6UWE2DRrgG6AfW4frWKEFk4gu3KoX0HWmh9O8LTFUWH/L8xWeC
	 +MzMSX4d2jOvTItPHqh2cys6+J8asUKEoFJdhXRTJcZ/krsH2Km+q5w4RYDnuo08Af
	 lCrtKkeJ8BCewRXqxu828Y5y58jHODDK5kPSEan8mj5V5ys2IvFkYzGgXTqLqJPk89
	 7zBaUnh43XmNG0MCmplR1dd3arcVuhIUvZEK5v0i6UiqHObHuhCP/SGmFPi0yfet7V
	 cIuzKTcProPzQ==
Date: Sun, 30 Jun 2024 12:35:17 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-xfs@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>, Brian Foster <bfoster@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoGJRSe98wZFDK36@kernel.org>
References: <Zn7icFF_NxqkoOHR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7icFF_NxqkoOHR@kernel.org>

The need for this fix was exposed while developing a new NFS feature
called "localio" which bypasses the network, if both the client and
server are on the same host, see:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-6.11

Because NFS's nfsiod_workqueue enables WQ_MEM_RECLAIM, writeback will
call into NFS and if localio is enabled the NFS client will call
directly into xfs_file_write_iter, this causes the following
backtrace when running xfstest generic/476 against NFS with localio:

  workqueue: WQ_MEM_RECLAIM writeback:wb_workfn is flushing !WQ_MEM_RECLAIM xfs-sync/vdc:xfs_flush_inodes_worker
  WARNING: CPU: 6 PID: 8525 at kernel/workqueue.c:3706 check_flush_dependency+0x2a4/0x328
  Modules linked in:
  CPU: 6 PID: 8525 Comm: kworker/u71:5 Not tainted 6.10.0-rc3-ktest-00032-g2b0a133403ab #18502
  Hardware name: linux,dummy-virt (DT)
  Workqueue: writeback wb_workfn (flush-0:33)
  pstate: 400010c5 (nZcv daIF -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
  pc : check_flush_dependency+0x2a4/0x328
  lr : check_flush_dependency+0x2a4/0x328
  sp : ffff0000c5f06bb0
  x29: ffff0000c5f06bb0 x28: ffff0000c998a908 x27: 1fffe00019331521
  x26: ffff0000d0620900 x25: ffff0000c5f06ca0 x24: ffff8000828848c0
  x23: 1fffe00018be0d8e x22: ffff0000c1210000 x21: ffff0000c75fde00
  x20: ffff800080bfd258 x19: ffff0000cad63400 x18: ffff0000cd3a4810
  x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080508d98
  x14: 0000000000000000 x13: 204d49414c434552 x12: 1fffe0001b6eeab2
  x11: ffff60001b6eeab2 x10: dfff800000000000 x9 : ffff60001b6eeab3
  x8 : 0000000000000001 x7 : 00009fffe491154e x6 : ffff0000db775593
  x5 : ffff0000db775590 x4 : ffff0000db775590 x3 : 0000000000000000
  x2 : 0000000000000027 x1 : ffff600018be0d62 x0 : dfff800000000000
  Call trace:
   check_flush_dependency+0x2a4/0x328
   __flush_work+0x184/0x5c8
   flush_work+0x18/0x28
   xfs_flush_inodes+0x68/0x88
   xfs_file_buffered_write+0x128/0x6f0
   xfs_file_write_iter+0x358/0x448
   nfs_local_doio+0x854/0x1568
   nfs_initiate_pgio+0x214/0x418
   nfs_generic_pg_pgios+0x304/0x480
   nfs_pageio_doio+0xe8/0x240
   nfs_pageio_complete+0x160/0x480
   nfs_writepages+0x300/0x4f0
   do_writepages+0x12c/0x4a0
   __writeback_single_inode+0xd4/0xa68
   writeback_sb_inodes+0x470/0xcb0
   __writeback_inodes_wb+0xb0/0x1d0
   wb_writeback+0x594/0x808
   wb_workfn+0x5e8/0x9e0
   process_scheduled_works+0x53c/0xd90
   worker_thread+0x370/0x8c8
   kthread+0x258/0x2e8
   ret_from_fork+0x10/0x20

Fix this by enabling WQ_MEM_RECLAIM on XFS's m_sync_workqueue.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/xfs/xfs_super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

[v2: dropped RFC, this fixes xfstests generic/476, resubmitting with more feeling]

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..dbe6af00708b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -574,7 +574,8 @@ xfs_init_mount_workqueues(
 		goto out_destroy_blockgc;
 
 	mp->m_sync_workqueue = alloc_workqueue("xfs-sync/%s",
-			XFS_WQFLAGS(WQ_FREEZABLE), 0, mp->m_super->s_id);
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			0, mp->m_super->s_id);
 	if (!mp->m_sync_workqueue)
 		goto out_destroy_inodegc;
 
-- 
2.44.0



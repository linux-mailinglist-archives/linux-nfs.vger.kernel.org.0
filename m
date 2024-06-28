Return-Path: <linux-nfs+bounces-4381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F091C39F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 18:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437F8B2168F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E091BE876;
	Fri, 28 Jun 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC9aAub2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C67157E91;
	Fri, 28 Jun 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591538; cv=none; b=fAccDhU4eVTicEfOgG9Oxi85R17Jwyp+mFVImQ/4rJxTq6/zty4WzOWbDW+vkwEE8n+A6jGb6CcygwyLaGGCTSACIuWPB5dPiPxnZQGatpIg7kI0xD5zO0YVGyWx+tN7awJO3tEhWX8DUUeJdI+kjVkZCfI3mS2bvWIeAEBdL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591538; c=relaxed/simple;
	bh=vhbHqn0waWFUdaNqCqmKkeJzJtjPhQtwtdAd8Y6Wwe0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mBxgmtuy1yTHoQW+84IhsvUojhXecOaP2ekdytr3SSYzttjfdTjn2gJPJkZoitjkJZmQ61VTxil0UD8kN5DFFFgObMC6A8tRpuUhMiGpjCxogsbif8gYzEWzAyX09A7kGqssdRnOy3LF/cf62Hhw8ZVbONfJfXPsJqVU6FuCLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC9aAub2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EC3C116B1;
	Fri, 28 Jun 2024 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719591538;
	bh=vhbHqn0waWFUdaNqCqmKkeJzJtjPhQtwtdAd8Y6Wwe0=;
	h=Date:From:To:Cc:Subject:From;
	b=FC9aAub2yVhFBPeNJyB2zdaJb0aGk1GmA6cd41+vXKxLnyp+h2uET/1orQ5glehkQ
	 b+Ya5wPBLhHIOke5YW/qyNvT4CYmzWhhjRxSDZCC83CEiAK3bFGm2vtWrNPJMihVge
	 FmVdTlfndZVvZNOFYic+17AEGuYWjY1/BBxnFNzsmylcwtNd/WfiQWfLinFTbASTK3
	 yFus9OwmmLuhVjULnkAAgeQQcTLSowYWeMT4I2U4lkOz2m0vA7prvgEUitouiFtaxQ
	 o66ep4kP60oNCdW7vqvrfEAGjjvAk2jOhzqB+7yxK9813xFWiJF+BInQJ37lhBkvLR
	 S1UVHSLSn/LyA==
Date: Fri, 28 Jun 2024 12:18:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-xfs@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <Zn7icFF_NxqkoOHR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm developing an NFS feature called "localio" that bypasses the
network, if both the client and server are on the same host, see:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-6.11

Because NFS's nfsiod_workqueue enables WQ_MEM_RECLAIM, writeback will
call into NFS and if localio is enabled the NFS client will call
directly into xfs_file_write_iter, this causes the following
backtrace:

00573 workqueue: WQ_MEM_RECLAIM writeback:wb_workfn is flushing !WQ_MEM_RECLAIM xfs-sync/vdc:xfs_flush_inodes_worker
00573 WARNING: CPU: 6 PID: 8525 at kernel/workqueue.c:3706 check_flush_dependency+0x2a4/0x328
00573 Modules linked in:
00573 CPU: 6 PID: 8525 Comm: kworker/u71:5 Not tainted 6.10.0-rc3-ktest-00032-g2b0a133403ab #18502
00573 Hardware name: linux,dummy-virt (DT)
00573 Workqueue: writeback wb_workfn (flush-0:33)
00573 pstate: 400010c5 (nZcv daIF -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
0573 pc : check_flush_dependency+0x2a4/0x328
00573 lr : check_flush_dependency+0x2a4/0x328
00573 sp : ffff0000c5f06bb0
00573 x29: ffff0000c5f06bb0 x28: ffff0000c998a908 x27: 1fffe00019331521
00573 x26: ffff0000d0620900 x25: ffff0000c5f06ca0 x24: ffff8000828848c0
00573 x23: 1fffe00018be0d8e x22: ffff0000c1210000 x21: ffff0000c75fde00
00573 x20: ffff800080bfd258 x19: ffff0000cad63400 x18: ffff0000cd3a4810
00573 x17: 0000000000000000 x16: 0000000000000000 x15: ffff800080508d98
00573 x14: 0000000000000000 x13: 204d49414c434552 x12: 1fffe0001b6eeab2
00573 x11: ffff60001b6eeab2 x10: dfff800000000000 x9 : ffff60001b6eeab3
00573 x8 : 0000000000000001 x7 : 00009fffe491154e x6 : ffff0000db775593
00573 x5 : ffff0000db775590 x4 : ffff0000db775590 x3 : 0000000000000000
00573 x2 : 0000000000000027 x1 : ffff600018be0d62 x0 : dfff800000000000
00573 Call trace:
00573  check_flush_dependency+0x2a4/0x328
00573  __flush_work+0x184/0x5c8
00573  flush_work+0x18/0x28
00573  xfs_flush_inodes+0x68/0x88
00573  xfs_file_buffered_write+0x128/0x6f0
00573  xfs_file_write_iter+0x358/0x448
00573  nfs_local_doio+0x854/0x1568
00573  nfs_initiate_pgio+0x214/0x418
00573  nfs_generic_pg_pgios+0x304/0x480
00573  nfs_pageio_doio+0xe8/0x240
00573  nfs_pageio_complete+0x160/0x480
00573  nfs_writepages+0x300/0x4f0
00573  do_writepages+0x12c/0x4a0
00573  __writeback_single_inode+0xd4/0xa68
00573  writeback_sb_inodes+0x470/0xcb0
00573  __writeback_inodes_wb+0xb0/0x1d0
00573  wb_writeback+0x594/0x808
00573  wb_workfn+0x5e8/0x9e0
00573  process_scheduled_works+0x53c/0xd90
00573  worker_thread+0x370/0x8c8
00573  kthread+0x258/0x2e8
00573  ret_from_fork+0x10/0x20

Fix this by enabling WQ_MEM_RECLAIM on XFS's m_sync_workqueue.

It could be this change is a non-starter due to WQ_MEM_RECLAIM no
longer allowing m_sync_workqueue to be "sync"?  All comments and
suggestions welcome!

Signed-off-by: Mike Snitzer <snitzer@kernel.org>

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
 


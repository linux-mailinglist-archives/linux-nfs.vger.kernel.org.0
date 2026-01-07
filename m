Return-Path: <linux-nfs+bounces-17573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECCCFEE79
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 17:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48A33120D26
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48317352FB3;
	Wed,  7 Jan 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnCp/ObP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615E355047
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802140; cv=none; b=O6mwP3ZyspFGH5aYFtKSEzH+dZdnZRSiURrCzTyFgd4lit+P9n2BVvoCf/UcGYhg/CW36mhc+HjWIkkbB2UJJ79vKZOnSqbWgSCzwQwwVANWy2DfP4Jfk3slbdXj/aJvLJ7Us7E6gy3q+2kAdM9SP5ecNWBSsQP9mwkUa/xQXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802140; c=relaxed/simple;
	bh=svIf+p64STtBcDUpjlXqsIKBM0acR983OWewcEa1RTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcj7YcCkaRuGNzq6qF9+YW2+BYbqlwQIbko2UX1zPFq4lKQc3c8RqnA7PzdqvWPmLMLt0PkL6khdLcbPn29TaoeGcZhzUKKniEylS5BxZbIFjeeR/SB8zAsV33+4UOFunlrnkpxGHL1MLTe67Qb5jbzkUzXeR6rk5gWeDOe4eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnCp/ObP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B6AC4CEF1;
	Wed,  7 Jan 2026 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802140;
	bh=svIf+p64STtBcDUpjlXqsIKBM0acR983OWewcEa1RTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnCp/ObPxUYIQUVpNE9tgO2Ykv7TE4tscNXO8M1YFTNXiUWycbswB/lFzZmjzWcti
	 eoDEO9mLleGok/LjfK1zZSGs8XS+IfsoAAjvxTbZm1PHtHey02jxTRk1djK+c4E1KT
	 wKihyaVxX1cJIxBC47ETaIzRBvGZ0ppxD+pcCI8td1kv31zb5YUOW0QbU1ihgW5cPD
	 drwQAf06VJn4N0djjsXwLLJfBWZVWl1M/ooFJzLKMp+X+qn5XCy/BZEzIOqZ+1TBdx
	 5xK3eeFGenclmRVYwj8z4Lefm3xjNNiKU5udKF5lIUkxrQn7ihanOe6QXufuguXGbe
	 /GIN9/MJRv1Iw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] NFS/localio: various improvements
Date: Wed,  7 Jan 2026 11:08:54 -0500
Message-ID: <20260107160858.6847-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1767459435.git.trond.myklebust@hammerspace.com>
References: 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series has been rebased on Trond's recent patchset:
https://lore.kernel.org/linux-nfs/cover.1767459435.git.trond.myklebust@hammerspace.com/

but the first 2 patches were developed while chasing a particularly
nasty deadlock that was reproducible when putting LOCALIO under heavy
load on systems with smaller amounts of memory (16G).  Ultimately that
deadlock happens to also be fixed by Trond's recent commit here:
https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=cce0be6eb4971456b703aaeafd571650d314bcca

FYI, prior to that nfs_release_folio() deadlock fix, tasks would be
stuck like:

[92]            "khugepaged"
[<0>] wait_on_commit+0x71/0xb0 [nfs]
[<0>] __nfs_commit_inode+0x131/0x180 [nfs]
[<0>] nfs_wb_folio+0xa7/0x1b0 [nfs]
[<0>] nfs_release_folio+0x6b/0x120 [nfs]
[<0>] split_huge_page_to_list_to_order+0x367/0x840
[<0>] migrate_pages_batch+0x208/0x7b0
[<0>] migrate_pages+0x220/0x550
[<0>] compact_zone+0x300/0x6e0
[<0>] compact_zone_order+0xc7/0x110
[<0>] try_to_compact_pages+0xe6/0x2d0
[<0>] __alloc_pages_direct_compact+0x8a/0x210
[<0>] __alloc_pages_slowpath.constprop.0+0x218/0x9c0
[<0>] __alloc_pages_noprof+0x335/0x350
[<0>] __folio_alloc_noprof+0x14/0x30
[<0>] alloc_charge_folio+0xdd/0x1b0
[<0>] collapse_huge_page+0x63/0x700
[<0>] hpage_collapse_scan_pmd+0x627/0x750
[<0>] khugepaged_scan_mm_slot.constprop.0+0x3cf/0x5a0
[<0>] khugepaged+0x105/0x200
[<0>] kthread+0xef/0x230
[<0>] ret_from_fork+0x31/0x50
[<0>] ret_from_fork_asm+0x1a/0x30

and:

[12813]         "nfsd"
[<0>] wait_on_commit+0x71/0xb0 [nfs]
[<0>] __nfs_commit_inode+0x131/0x180 [nfs]
[<0>] nfs_wb_folio+0xa7/0x1b0 [nfs]
[<0>] nfs_release_folio+0x6b/0x120 [nfs]
[<0>] split_huge_page_to_list_to_order+0x367/0x840
[<0>] migrate_pages_batch+0x208/0x7b0
[<0>] migrate_pages+0x220/0x550
[<0>] compact_zone+0x300/0x6e0
[<0>] compact_zone_order+0xc7/0x110
[<0>] try_to_compact_pages+0xe6/0x2d0
[<0>] __alloc_pages_direct_compact+0x8a/0x210
[<0>] __alloc_pages_slowpath.constprop.0+0x218/0x9c0
[<0>] __alloc_pages_noprof+0x335/0x350
[<0>] alloc_pages_mpol_noprof+0x8f/0x1f0
[<0>] folio_alloc_noprof+0x5b/0xb0
[<0>] __filemap_get_folio+0x177/0x330
[<0>] nfs_write_begin+0x81/0x370 [nfs]
[<0>] generic_perform_write+0x91/0x290
[<0>] nfs_file_write+0x1ea/0x2f0 [nfs]
[<0>] vfs_iocb_iter_write+0xc0/0x210
[<0>] nfsd_vfs_write+0x26e/0x760 [nfsd]
[<0>] nfsd_write+0x17c/0x1c0 [nfsd]
[<0>] nfsd3_proc_write+0x10b/0x1a0 [nfsd]
[<0>] nfsd_dispatch+0xea/0x220 [nfsd]
[<0>] svc_process_common+0x4cd/0x6c0 [sunrpc]
[<0>] svc_process+0x145/0x210 [sunrpc]
[<0>] svc_handle_xprt+0x481/0x550 [sunrpc]
[<0>] svc_recv+0x170/0x2c0 [sunrpc]
[<0>] nfsd+0x8f/0xf0 [nfsd]
[<0>] kthread+0xef/0x230
[<0>] ret_from_fork+0x31/0x50
[<0>] ret_from_fork_asm+0x1a/0x30

Anyway, I think this LOCALIO series is worthwhile on its own and ready
for wider review and hopeful inclusion.

Thanks,
Mike

Mike Snitzer (4):
  NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
  NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
  NFS/localio: remove -EAGAIN handling in nfs_local_doio()
  NFS/localio: switch nfs_local_do_read and nfs_local_do_write to return void

 fs/nfs/localio.c | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

-- 
2.44.0



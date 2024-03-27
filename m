Return-Path: <linux-nfs+bounces-2493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE8888E46D
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 15:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECB21C20D56
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBEA1B251F;
	Wed, 27 Mar 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1GJ4eu9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FD1B251B;
	Wed, 27 Mar 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542480; cv=none; b=TShlxkpwtdlj497BoSs9mR8inAa0st3lNg2m2Y+SICybGWr9Pakh4FKWT/+5H2S/DPeIhQmm+Kx/0DSOjfaoT8Gb6Eon3ylBF36P/j8AJW4SO+rvDdVOVFHBErBlQihO97ITWzInItdkzjnNUvWp79k0hJnYbYXQcpzekCbXPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542480; c=relaxed/simple;
	bh=HUcsWSpf/xLT+7CgewDsql3u5zsmcfHjjRl7AnCuMOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcqB0ubxuwwZztBYCSoa1nOszynbjzwGnhO4MzlGK8tpUO/YoOVV0uB7DwMr2SmrANmjSnLbRqWkRmAZZbh7AhJUeaLT2LN9T8rJdPA9p06zA2C2ZXx8fqj43m1yZp8nTnHaI3TW+JslMkSm0ojf+WfSebY3sT/LfB7G6RJkXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1GJ4eu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87918C433F1;
	Wed, 27 Mar 2024 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542480;
	bh=HUcsWSpf/xLT+7CgewDsql3u5zsmcfHjjRl7AnCuMOA=;
	h=From:To:Cc:Subject:Date:From;
	b=R1GJ4eu9qfJiwEF//j4S6QYjps0v3TR+YRrFMUQ73Qjn2fbz8WqXsZlUC4HgWZLVi
	 ZEsT+T1ASKhkJq1fiqzTbsaTiD6+uBae58cOE5ppqhPFqB70acNlqvy+HKCTDkHh+d
	 LZErubwieTUyn7eag9GJGiTnk4FICH+qlhSNlKdmMQ0bBQJo4M1e+VSJg/197w7FoC
	 Xu+LLHbd96ydTehbe8Frnt96Ul52TfCG3nurTBI2oE0K5WnSHkJs8ZD3tj36ZlT4BZ
	 N2GKPiB41L+sfjCGpN3r7zzSyZ6UoYVQ/J93ELeifpOjPsUxoFFEc0BaBza612Q1dl
	 Q0TulcVg+qvXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	josef@toxicpanda.com
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "nfs: fix UAF in direct writes" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:27:58 -0400
Message-ID: <20240327122758.2842369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 17f46b803d4f23c66cacce81db35fef3adb8f2af Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 1 Mar 2024 11:49:57 -0500
Subject: [PATCH] nfs: fix UAF in direct writes

In production we have been hitting the following warning consistently

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 17 PID: 1800359 at lib/refcount.c:28 refcount_warn_saturate+0x9c/0xe0
Workqueue: nfsiod nfs_direct_write_schedule_work [nfs]
RIP: 0010:refcount_warn_saturate+0x9c/0xe0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x9f/0x130
 ? refcount_warn_saturate+0x9c/0xe0
 ? report_bug+0xcc/0x150
 ? handle_bug+0x3d/0x70
 ? exc_invalid_op+0x16/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0x9c/0xe0
 nfs_direct_write_schedule_work+0x237/0x250 [nfs]
 process_one_work+0x12f/0x4a0
 worker_thread+0x14e/0x3b0
 ? ZSTD_getCParams_internal+0x220/0x220
 kthread+0xdc/0x120
 ? __btf_name_valid+0xa0/0xa0
 ret_from_fork+0x1f/0x30

This is because we're completing the nfs_direct_request twice in a row.

The source of this is when we have our commit requests to submit, we
process them and send them off, and then in the completion path for the
commit requests we have

if (nfs_commit_end(cinfo.mds))
	nfs_direct_write_complete(dreq);

However since we're submitting asynchronous requests we sometimes have
one that completes before we submit the next one, so we end up calling
complete on the nfs_direct_request twice.

The only other place we use nfs_generic_commit_list() is in
__nfs_commit_inode, which wraps this call in a

nfs_commit_begin();
nfs_commit_end();

Which is a common pattern for this style of completion handling, one
that is also repeated in the direct code with get_dreq()/put_dreq()
calls around where we process events as well as in the completion paths.

Fix this by using the same pattern for the commit requests.

Before with my 200 node rocksdb stress running this warning would pop
every 10ish minutes.  With my patch the stress test has been running for
several hours without popping.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c        | 11 +++++++++--
 fs/nfs/write.c         |  2 +-
 include/linux/nfs_fs.h |  1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index befcc167e25fe..6b8798d01e3a1 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -672,10 +672,17 @@ static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(mds_list);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
+	nfs_commit_begin(cinfo.mds);
 	nfs_scan_commit(dreq->inode, &mds_list, &cinfo);
 	res = nfs_generic_commit_list(dreq->inode, &mds_list, 0, &cinfo);
-	if (res < 0) /* res == -ENOMEM */
-		nfs_direct_write_reschedule(dreq);
+	if (res < 0) { /* res == -ENOMEM */
+		spin_lock(&dreq->lock);
+		if (dreq->flags == 0)
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+		spin_unlock(&dreq->lock);
+	}
+	if (nfs_commit_end(cinfo.mds))
+		nfs_direct_write_complete(dreq);
 }
 
 static void nfs_direct_write_clear_reqs(struct nfs_direct_req *dreq)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 58adbb7709ba7..15359bbfa56bc 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1646,7 +1646,7 @@ static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 				       !atomic_read(&cinfo->rpcs_out));
 }
 
-static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 {
 	atomic_inc(&cinfo->rpcs_out);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f5ce7b1011461..d59116ac82099 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -611,6 +611,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline bool nfs_have_writebacks(const struct inode *inode)
-- 
2.43.0






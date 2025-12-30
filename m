Return-Path: <linux-nfs+bounces-17350-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF9CE8DE7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 08:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA6A300E7EE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 07:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72355257435;
	Tue, 30 Dec 2025 07:17:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB339FD9;
	Tue, 30 Dec 2025 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767079079; cv=none; b=qZ2FF/KZNySfRpnStBvKKWPKmwQEqSXaWNbgVir0wNcQzh8rttk9DX9CIMg4qeTbzvbgCDomMo34ukuliKVDBtphmlmufebOFwMSoZfAWvTV/1HxRu5yWKSQ+GKZ6xnkBu+uCaIu2xa9QHEBliTnq7D1snoxFK30DvFlMQxAacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767079079; c=relaxed/simple;
	bh=E1Rz9lMhsCZ9uEElurviw+JiOh0iLb9Yiq8G5JNmj5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VIRCnay3Hn9Q+QXG3bEnjAMUsQRWASRUsaITIQtNOJEjeWor5VQ2ZfGp4NAMLQ9T/QBDZJ0zc+b1dOpKesAYVPNtQCkPVDEG+j2c3Nq/kLwy892z3s6pj2Ecn/27srkpEZxFS3fcrVJxabH9TwoMo72u96fdmDnYXx+AG7nLZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dgPXq45WlzYQtxx;
	Tue, 30 Dec 2025 15:16:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E72394056C;
	Tue, 30 Dec 2025 15:17:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.136])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_eYfFNpfl_6Bw--.33850S4;
	Tue, 30 Dec 2025 15:17:45 +0800 (CST)
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	kolga@netapp.com
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	lilingfeng3@huawei.com,
	zhangjian496@huawei.com,
	wangzhaolong@huaweicloud.com
Subject: [PATCH] [RFC] NFSv4.1: slot table draining + memory reclaim can deadlock state manager creation
Date: Tue, 30 Dec 2025 15:17:44 +0800
Message-Id: <20251230071744.9762-1-wangzhaolong@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXd_eYfFNpfl_6Bw--.33850S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JF13KF45AFWxZrWkJF1fZwb_yoWftr4rpF
	WUGr98KrWkJr18Wrn7ZF48Z3WYy397Gr47JFyxG34ay3Z8J3ZxKFy2y3WYvFy5GrW8Jan2
	qF1vyFW0va15AFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRoq2tUUUUU==
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/

Hi all,

I’d like to start an RFC discussion about a hung-task/deadlock that we hit in
production-like testing on NFSv4.1 clients under server outage + memory
pressure. The system becomes stuck even after the server/network is restored.

The scenario is:

- NFSv4.1 client running heavy multi-threaded buffered I/O (fio-style workload)
- server outage (restart/power-off) and/or network blackhole
- client under significant memory pressure / reclaim activity (observed in the
  traces below)

The observed behavior is a deadlock cycle involving:

- v4.1 session slot table “draining” (NFS4_SLOT_TBL_DRAINING)
- state manager thread creation via kthread_run()
- kthreadd entering direct reclaim and getting stuck in NFS commit/writeback paths
- non-privileged RPC tasks sleeping on slot table waitq due to draining

Below is the call-chain I reconstructed from traces (three key participants):

P1: sunrpc worker 1 (error handling triggers session recovery and tries to startstate manager)
rpc_exit_task
  nfs_writeback_done
    nfs4_write_done
      nfs4_sequence_done
        nfs41_sequence_process
          // status error, goto session_recover
          set_bit(NFS4_SLOT_TBL_DRAINING, &session->fc_slot_table.slot_tbl_state)  <1>
          nfs4_schedule_session_recovery
            nfs4_schedule_state_manager
              kthread_run  // - Create a state manager thread to release the draining slots
                kthread_create_on_node
                  __kthread_create_on_node
                    wait_for_completion(&done);   <2> wait for <3>

P2: kthreadd (thread creation triggers reclaim; reclaim hits NFS folios and blocks in commit wait)
kthreadd
 kernel_thread
  kernel_clone
   copy_process
    dup_task_struct
     alloc_thread_stack_node
      __vmalloc_node_range
       __vmalloc_area_node
        vm_area_alloc_pages
         alloc_pages_bulk_array_mempolicy
          __alloc_pages_bulk
           __alloc_pages
            __perform_reclaim
             try_to_free_pages
              do_try_to_free_pages
               shrink_zones
                shrink_node
                 shrink_node_memcgs
                  shrink_lruvec
                   shrink_inactive_list
                    shrink_folio_list
                     filemap_release_folio
                      nfs_release_folio
                       nfs_wb_folio
                        folio PG_private !PG_writeback !PG_dirty
                         nfs_commit_inode(inode, FLUSH_SYNC);
                          __nfs_commit_inode
                           nfs_generic_commit_list
                            nfs_commit_list
                             nfs_initiate_commit
                              rpc_run_task  // Async task
                           wait_on_commit            <3> wait for <4>

P3: sunrpc worker 2 (non-privileged tasks are blocked by draining)
__rpc_execute
  nfs4_setup_sequence
    // if (nfs4_slot_tbl_draining(tbl) && !args->sa_privileged) goto sleep
    rpc_sleep_on(&tbl->slot_tbl_waitq, task, NULL);    <4>  blocked by <1>

This forms a deadlock:

- <1> enables draining; non-privileged requests then block at <4>
- recovery path attempts to create the state manager thread, but
  blocks at <2> waiting for kthreadd
- kthreadd is blocked at <3> waiting for commit progress / completion,
  but commit/RPC progress is impeded because requests are stuck behind draining at <4>
- once in this state, restoring the server/network does not resolve the deadlock

I suspect this deadlock became possible after the following mainline change that
freezes the session table immediately on NFS4ERR_BADSESSION (and similar error paths):

c907e72f58ed ("NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION")

It sets NFS4_SLOT_TBL_DRAINING before the recovery thread runs:

Questions:

1. Has anyone else observed a similar deadlock involving slot table draining + memory
   reclaim? It looks like a similar issue might have been reported before — see
   SUSE Bugzilla #1211527. [1]
2. Is it intended that kthreadd (or other critical kernel threads) may block in
   nfs_commit_inode(FLUSH_SYNC) as part of reclaim?
3. Is there an established way to ensure recovery threads can always be created even
   under severe memory pressure (e.g., reserve resources, GFP flags, or moving state
   manager creation out of contexts that can trigger reclaim)?

I wrote a local patch purely as a discussion starter. I realize this approach is likely
not the right solution upstream; I’m sharing it only to help reason about where the
cycle can be broken. I can post the patch if people think it’s useful for the discussion.

Link: https://access.redhat.com/solutions/7016754 [1]
Fixes: c907e72f58ed ("NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION")
Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
---
 fs/nfs/file.c          |  6 +++---
 fs/nfs/write.c         | 10 +++++-----
 include/linux/nfs_fs.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d020aab40c64..e556a16ce95b 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -487,11 +487,11 @@ static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 	dfprintk(PAGECACHE, "NFS: invalidate_folio(%lu, %zu, %zu)\n",
 		 folio->index, offset, length);
 
 	/* Cancel any unstarted writes on this page */
 	if (offset != 0 || length < folio_size(folio))
-		nfs_wb_folio(inode, folio);
+		nfs_wb_folio(inode, folio, true);
 	else
 		nfs_wb_folio_cancel(inode, folio);
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 	trace_nfs_invalidate_folio(inode, folio_pos(folio) + offset, length);
 }
@@ -509,11 +509,11 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 	/* If the private flag is set, then the folio is not freeable */
 	if (folio_test_private(folio)) {
 		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
 		    current_is_kswapd() || current_is_kcompactd())
 			return false;
-		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
+		if (nfs_wb_folio(folio->mapping->host, folio, false) < 0)
 			return false;
 	}
 	return nfs_fscache_release_folio(folio, gfp);
 }
 
@@ -558,11 +558,11 @@ static int nfs_launder_folio(struct folio *folio)
 
 	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
 		inode->i_ino, folio_pos(folio));
 
 	folio_wait_private_2(folio); /* [DEPRECATED] */
-	ret = nfs_wb_folio(inode, folio);
+	ret = nfs_wb_folio(inode, folio, true);
 	trace_nfs_launder_folio_done(inode, folio_pos(folio),
 			folio_size(folio), ret);
 	return ret;
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 336c510f3750..bc541a192197 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1059,11 +1059,11 @@ static struct nfs_page *nfs_try_to_update_request(struct folio *folio,
 	 * nfs_lock_and_join_requests() cannot preserve
 	 * commit flags, so we have to replay the write.
 	 */
 	nfs_mark_request_dirty(req);
 	nfs_unlock_and_release_request(req);
-	error = nfs_wb_folio(folio->mapping->host, folio);
+	error = nfs_wb_folio(folio->mapping->host, folio, true);
 	trace_nfs_try_to_update_request_done(folio_inode(folio), offset, bytes, error);
 	return (error < 0) ? ERR_PTR(error) : NULL;
 }
 
 /*
@@ -1137,11 +1137,11 @@ int nfs_flush_incompatible(struct file *file, struct folio *folio)
 			do_flush |= l_ctx->lockowner != current->files;
 		}
 		nfs_release_request(req);
 		if (!do_flush)
 			return 0;
-		status = nfs_wb_folio(folio->mapping->host, folio);
+		status = nfs_wb_folio(folio->mapping->host, folio, true);
 	} while (status == 0);
 	return status;
 }
 
 /*
@@ -2030,11 +2030,11 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
  * @folio: pointer to folio
  *
  * Assumes that the folio has been locked by the caller, and will
  * not unlock it.
  */
-int nfs_wb_folio(struct inode *inode, struct folio *folio)
+int nfs_wb_folio(struct inode *inode, struct folio *folio, bool sync)
 {
 	loff_t range_start = folio_pos(folio);
 	size_t len = folio_size(folio);
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
@@ -2055,11 +2055,11 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 			continue;
 		}
 		ret = 0;
 		if (!folio_test_private(folio))
 			break;
-		ret = nfs_commit_inode(inode, FLUSH_SYNC);
+		ret = nfs_commit_inode(inode, sync ? FLUSH_SYNC: 0);
 		if (ret < 0)
 			goto out_error;
 	}
 out_error:
 	trace_nfs_writeback_folio_done(inode, range_start, len, ret);
@@ -2078,11 +2078,11 @@ int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
 	 *        that we can safely release the inode reference while holding
 	 *        the folio lock.
 	 */
 	if (folio_test_private(src)) {
 		if (mode == MIGRATE_SYNC)
-			nfs_wb_folio(src->mapping->host, src);
+			nfs_wb_folio(src->mapping->host, src, true);
 		if (folio_test_private(src))
 			return -EBUSY;
 	}
 
 	if (folio_test_private_2(src)) { /* [DEPRECATED] */
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a6624edb7226..295bc6214750 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -634,11 +634,11 @@ extern int  nfs_update_folio(struct file *file, struct folio *folio,
  * Try to write back everything synchronously (but check the
  * return value!)
  */
 extern int nfs_sync_inode(struct inode *inode);
 extern int nfs_wb_all(struct inode *inode);
-extern int nfs_wb_folio(struct inode *inode, struct folio *folio);
+extern int nfs_wb_folio(struct inode *inode, struct folio *folio, bool sync);
 int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
 extern void nfs_commit_free(struct nfs_commit_data *data);
 void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
-- 
2.34.3



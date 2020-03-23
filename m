Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22BB18F07C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2020 08:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCWHz0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Mar 2020 03:55:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:49212 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbgCWHzZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Mar 2020 03:55:25 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jGHvT-0005vz-Q2; Mon, 23 Mar 2020 10:55:12 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] nfsd: memory corruption in nfsd4_lock()
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Message-ID: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
Date:   Mon, 23 Mar 2020 10:55:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

New struct nfsd4_blocked_lock allocated in find_or_allocate_block()
does not initialised nbl_list and nbl_lru.
If conflock allocation fails rollback can call list_del_init()
access uninitialized fields and corrupt memory.

Fixes: 76d348fadff5 ("nfsd: have nfsd4_lock use blocking locks for v4.1+ lock")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/nfsd/nfs4state.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 369e574c5092..176ef8d24fae 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6524,6 +6524,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
+	conflock = locks_alloc_lock();
+	if (!conflock) {
+		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
+		status = nfserr_jukebox;
+		goto out;
+	}
+
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
 	if (!nbl) {
 		dprintk("NFSD: %s: unable to allocate block!\n", __func__);
@@ -6542,13 +6549,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
 	nfs4_transform_lock_offset(file_lock);
 
-	conflock = locks_alloc_lock();
-	if (!conflock) {
-		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
-		status = nfserr_jukebox;
-		goto out;
-	}
-
 	if (fl_flags & FL_SLEEP) {
 		nbl->nbl_time = jiffies;
 		spin_lock(&nn->blocked_locks_lock);
@@ -6581,17 +6581,15 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfserrno(err);
 		break;
 	}
-out:
-	if (nbl) {
-		/* dequeue it if we queued it before */
-		if (fl_flags & FL_SLEEP) {
-			spin_lock(&nn->blocked_locks_lock);
-			list_del_init(&nbl->nbl_list);
-			list_del_init(&nbl->nbl_lru);
-			spin_unlock(&nn->blocked_locks_lock);
-		}
-		free_blocked_lock(nbl);
+	/* dequeue it if we queued it before */
+	if (fl_flags & FL_SLEEP) {
+		spin_lock(&nn->blocked_locks_lock);
+		list_del_init(&nbl->nbl_list);
+		list_del_init(&nbl->nbl_lru);
+		spin_unlock(&nn->blocked_locks_lock);
 	}
+	free_blocked_lock(nbl);
+out:
 	if (nf)
 		nfsd_file_put(nf);
 	if (lock_stp) {
-- 
2.17.1


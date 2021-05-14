Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9468381147
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhENT6V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhENT6U (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:58:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04D1A613DE;
        Fri, 14 May 2021 19:57:08 +0000 (UTC)
Subject: [PATCH v3 19/24] NFSD: Add an nfsd_cb_lm_notify tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:57:08 -0400
Message-ID: <162102222827.10915.10698485648582592912.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When the server kicks off a CB_LM_NOTIFY callback, record its
arguments so we can better observe asynchronous locking behavior.
For example:

            nfsd-998   [002]  1471.705873: nfsd_cb_notify_lock:  addr=192.168.2.51:0 client 6092a47c:35a43fc1 fh_hash=0x8950b23a

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@redhat.com>
---
 fs/nfsd/nfs4state.c |    4 +++-
 fs/nfsd/trace.h     |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 377ec4a6a771..d4eee8a47ff3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6451,8 +6451,10 @@ nfsd4_lm_notify(struct file_lock *fl)
 	}
 	spin_unlock(&nn->blocked_locks_lock);
 
-	if (queue)
+	if (queue) {
+		trace_nfsd_cb_notify_lock(lo, nbl);
 		nfsd4_run_cb(&nbl->nbl_cb);
+	}
 }
 
 static const struct lock_manager_operations nfsd_posix_mng_ops  = {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index fc80879d6077..921323f88322 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1027,6 +1027,32 @@ TRACE_EVENT(nfsd_cb_done,
 		__entry->status)
 );
 
+TRACE_EVENT(nfsd_cb_notify_lock,
+	TP_PROTO(
+		const struct nfs4_lockowner *lo,
+		const struct nfsd4_blocked_lock *nbl
+	),
+	TP_ARGS(lo, nbl),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, fh_hash)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		const struct nfs4_client *clp = lo->lo_owner.so_client;
+
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__entry->fh_hash = knfsd_fh_hash(&nbl->nbl_fh);
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x fh_hash=0x%08x",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__entry->fh_hash)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH



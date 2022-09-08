Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B805B2916
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Sep 2022 00:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIHWOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIHWOF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 18:14:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641C01098E6
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 15:14:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B7AB822A4
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D0C433D7
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 22:14:01 +0000 (UTC)
Subject: [PATCH v4 4/8] NFSD: Add a mechanism to wait for a DELEGRETURN
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 18:14:00 -0400
Message-ID: <166267524093.1842.15758313847137747406.stgit@manet.1015granger.net>
In-Reply-To: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
References: <166267495153.1842.14474564029477470642.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Subsequent patches will use this mechanism to wake up an operation
that is waiting for a client to return a delegation.

The new tracepoint records whether the wait timed out or was
properly awoken by the expected DELEGRETURN:

            nfsd-1155  [002] 83799.493199: nfsd_delegret_wakeup: xid=0x14b7d6ef fh_hash=0xf6826792 (timed out)

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   30 ++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h      |    7 +++++++
 fs/nfsd/trace.h     |   23 +++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 561f3556b1d2..54bc70427ce3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4717,6 +4717,35 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 	return ret;
 }
 
+static bool nfsd4_deleg_present(const struct inode *inode)
+{
+	struct file_lock_context *ctx = smp_load_acquire(&inode->i_flctx);
+
+	return ctx && !list_empty_careful(&ctx->flc_lease);
+}
+
+/**
+ * nfsd_wait_for_delegreturn - wait for delegations to be returned
+ * @rqstp: the RPC transaction being executed
+ * @inode: in-core inode of the file being waited for
+ *
+ * The timeout prevents deadlock if all nfsd threads happen to be
+ * tied up waiting for returning delegations.
+ *
+ * Return values:
+ *   %true: delegation was returned
+ *   %false: timed out waiting for delegreturn
+ */
+bool nfsd_wait_for_delegreturn(struct svc_rqst *rqstp, struct inode *inode)
+{
+	long __maybe_unused timeo;
+
+	timeo = wait_var_event_timeout(inode, !nfsd4_deleg_present(inode),
+				       NFSD_DELEGRETURN_TIMEOUT);
+	trace_nfsd_delegret_wakeup(rqstp, inode, timeo);
+	return timeo > 0;
+}
+
 static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
@@ -6779,6 +6808,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto put_stateid;
 
+	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
 	destroy_delegation(dp);
 put_stateid:
 	nfs4_put_stid(&dp->dl_stid);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 57a468ed85c3..6ab4ad41ae84 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -164,6 +164,7 @@ char * nfs4_recoverydir(void);
 bool nfsd4_spo_must_allow(struct svc_rqst *rqstp);
 int nfsd4_create_laundry_wq(void);
 void nfsd4_destroy_laundry_wq(void);
+bool nfsd_wait_for_delegreturn(struct svc_rqst *rqstp, struct inode *inode);
 #else
 static inline int nfsd4_init_slabs(void) { return 0; }
 static inline void nfsd4_free_slabs(void) { }
@@ -179,6 +180,11 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 }
 static inline int nfsd4_create_laundry_wq(void) { return 0; };
 static inline void nfsd4_destroy_laundry_wq(void) {};
+static inline bool nfsd_wait_for_delegreturn(struct svc_rqst *rqstp,
+					      struct inode *inode)
+{
+	return false;
+}
 #endif
 
 /*
@@ -343,6 +349,7 @@ void		nfsd_lockd_shutdown(void);
 #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
 #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
 #define	NFS4_CLIENTS_PER_GB		1024
+#define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ec8e08315779..06a96e955bd0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -538,6 +538,29 @@ DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
 #include "filecache.h"
 #include "vfs.h"
 
+TRACE_EVENT(nfsd_delegret_wakeup,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct inode *inode,
+		long timeo
+	),
+	TP_ARGS(rqstp, inode, timeo),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(const void *, inode)
+		__field(long, timeo)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->inode = inode;
+		__entry->timeo = timeo;
+	),
+	TP_printk("xid=0x%08x inode=%p%s",
+		  __entry->xid, __entry->inode,
+		  __entry->timeo == 0 ? " (timed out)" : ""
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_stateid_class,
 	TP_PROTO(stateid_t *stp),
 	TP_ARGS(stp),



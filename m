Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4958C9CB
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbiHHNxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 09:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiHHNxD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 09:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA93B2DF7
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 06:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5745660B3A
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40C6C433C1
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:53:01 +0000 (UTC)
Subject: [PATCH v3 5/7] NFSD: Add a mechanism to wait for a DELEGRETURN
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 08 Aug 2022 09:53:00 -0400
Message-ID: <165996678067.2637.15711746893298706253.stgit@manet.1015granger.net>
In-Reply-To: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
References: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
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

A subsequent patch will use this mechanism to wake up an operation
that is waiting for a client to return a delegation.

The new tracepoint records whether the wait timed out or was
properly awoken by the expected DELEGRETURN.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   31 +++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h      |    1 +
 fs/nfsd/trace.h     |   23 +++++++++++++++++++++++
 fs/nfsd/xdr4.h      |    2 ++
 4 files changed, 57 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0cf5a4bb36df..9d5140d485d4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4689,6 +4689,36 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 	return ret;
 }
 
+static bool nfsd4_deleg_present(struct inode *inode)
+{
+	struct file_lock_context *ctx = smp_load_acquire(&inode->i_flctx);
+
+	return ctx && !list_empty_careful(&ctx->flc_lease);
+}
+
+/**
+ * nfsd4_wait_for_delegreturn - wait for delegations to be returned
+ * @rqstp: the RPC transaction being executed
+ * @fhp: instantiated filehandle of the file being waited for
+ *
+ * The timeout prevents deadlock if all nfsd threads happen to be
+ * tied up waiting for returning delegations.
+ *
+ * Return values:
+ *   %true: delegation was returned
+ *   %false: timed out waiting for delegreturn
+ */
+bool nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp, struct svc_fh *fhp)
+{
+	struct inode *inode = d_inode(fhp->fh_dentry);
+	long __maybe_unused timeo;
+
+	timeo = wait_var_event_timeout(inode, !nfsd4_deleg_present(inode),
+				       NFSD_DELEGRETURN_TIMEOUT);
+	trace_nfsd_delegreturn_wakeup(rqstp, fhp, timeo);
+	return timeo > 0;
+}
+
 static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
@@ -6703,6 +6733,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto put_stateid;
 
+	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
 	destroy_delegation(dp);
 put_stateid:
 	nfs4_put_stid(&dp->dl_stid);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 9a8b09afc173..05abfb6a0271 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -341,6 +341,7 @@ void		nfsd_lockd_shutdown(void);
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
 #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
+#define NFSD_DELEGRETURN_TIMEOUT	(HZ / 34)	/* 30ms */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 6809d92d4cc5..a88f4303fbd9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -538,6 +538,29 @@ DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
 #include "filecache.h"
 #include "vfs.h"
 
+TRACE_EVENT(nfsd_delegreturn_wakeup,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp,
+		long timeo
+	),
+	TP_ARGS(rqstp, fhp, timeo),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+		__field(long, timeo)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->timeo = timeo;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x%s",
+		  __entry->xid, __entry->fh_hash,
+		  __entry->timeo == 0 ? " (timed out)" : ""
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_stateid_class,
 	TP_PROTO(stateid_t *stp),
 	TP_ARGS(stp),
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 7b744011f2d3..7323433746f1 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -788,6 +788,8 @@ extern __be32 nfsd4_destroy_clientid(struct svc_rqst *, struct nfsd4_compound_st
 		union nfsd4_op_u *u);
 __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_state *,
 		union nfsd4_op_u *u);
+extern bool nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp,
+		struct svc_fh *fhp);
 extern __be32 nfsd4_process_open1(struct nfsd4_compound_state *,
 		struct nfsd4_open *open, struct nfsd_net *nn);
 extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,



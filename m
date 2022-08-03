Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2D588EC1
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Aug 2022 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiHCOhq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Aug 2022 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHCOho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Aug 2022 10:37:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59915834
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 07:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BB10B822B4
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 14:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66A8C433C1;
        Wed,  3 Aug 2022 14:37:40 +0000 (UTC)
Subject: [PATCH v2 2/3] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     imammedo@redhat.com
Date:   Wed, 03 Aug 2022 10:37:39 -0400
Message-ID: <165953745991.1658.5781306176717145818.stgit@manet.1015granger.net>
In-Reply-To: <165953688893.1658.15242150042289528147.stgit@manet.1015granger.net>
References: <165953688893.1658.15242150042289528147.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_setattr() can kick off a CB_RECALL (via
notify_change() -> break_lease()) if a delegation is present. Before
returning NFS4ERR_DELAY, give the client holding that delegation a
chance to return it and then retry the nfsd_setattr() again, once.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  |   18 +++++++++++++++---
 fs/nfsd/nfs4state.c |   17 +++++++++++++++++
 fs/nfsd/nfsd.h      |    1 +
 fs/nfsd/trace.h     |   19 +++++++++++++++++++
 fs/nfsd/xdr4.h      |    2 ++
 5 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 42bfe0d769ec..62a267bb2ce5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1142,7 +1142,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_setattr *setattr = &u->setattr;
 	__be32 status = nfs_ok;
-	int err;
+	int err, retries;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
@@ -1173,8 +1173,20 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&setattr->sa_label);
 	if (status)
 		goto out;
-	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
-				0, (time64_t)0);
+
+	retries = 1;
+	do {
+		status = nfsd_setattr(rqstp, &cstate->current_fh,
+				      &setattr->sa_iattr, 0, (time64_t)0);
+		if (status != nfserr_jukebox)
+			break;
+		if (!retries--)
+			break;
+
+		fh_clear_pre_post_attrs(&cstate->current_fh);
+		nfsd4_wait_for_delegreturn(rqstp, &cstate->current_fh);
+	} while (1);
+
 out:
 	fh_drop_write(&cstate->current_fh);
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0cf5a4bb36df..e3ac89d4a859 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4689,6 +4689,23 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 	return ret;
 }
 
+/**
+ * nfsd4_wait_for_delegreturn - wait for delegations to be returned
+ * @rqstp: the RPC transaction being executed
+ * @fhp: filehandle of file being waited for
+ *
+ * A better approach would wait for the DELEGRETURN operation, and
+ * retry just as soon as it was done.
+ *
+ * The timeout prevents deadlock if all nfsd threads happen to be
+ * tied up waiting for returning delegations.
+ */
+void nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp, struct svc_fh *fhp)
+{
+	trace_nfsd_delegreturn_wait(rqstp, fhp);
+	msleep(NFSD_DELEGRETURN_TIMEOUT);
+}
+
 static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 9a8b09afc173..0b800a154828 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -341,6 +341,7 @@ void		nfsd_lockd_shutdown(void);
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
 #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
+#define NFSD_DELEGRETURN_TIMEOUT	(30)	/* milliseconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 8c3d5f88072f..dd2654cac132 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -443,6 +443,25 @@ DEFINE_NFSD_COPY_ERR_EVENT(clone_file_range_err);
 #include "filecache.h"
 #include "vfs.h"
 
+TRACE_EVENT(nfsd_delegreturn_wait,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp
+	),
+	TP_ARGS(rqstp, fhp),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x",
+		  __entry->xid, __entry->fh_hash
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_stateid_class,
 	TP_PROTO(stateid_t *stp),
 	TP_ARGS(stp),
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 7b744011f2d3..5b9213076e95 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -788,6 +788,8 @@ extern __be32 nfsd4_destroy_clientid(struct svc_rqst *, struct nfsd4_compound_st
 		union nfsd4_op_u *u);
 __be32 nfsd4_reclaim_complete(struct svc_rqst *, struct nfsd4_compound_state *,
 		union nfsd4_op_u *u);
+extern void nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp,
+		struct svc_fh *fhp);
 extern __be32 nfsd4_process_open1(struct nfsd4_compound_state *,
 		struct nfsd4_open *open, struct nfsd_net *nn);
 extern __be32 nfsd4_process_open2(struct svc_rqst *rqstp,



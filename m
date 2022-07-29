Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7A58532B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 18:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiG2QHG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jul 2022 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiG2QHF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jul 2022 12:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158988761
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 09:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB9361BF2
        for <linux-nfs@vger.kernel.org>; Fri, 29 Jul 2022 16:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63488C433D6;
        Fri, 29 Jul 2022 16:07:02 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Make nfsd4_setattr() wait before returning
 NFS4ERR_DELAY
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     imammedo@redhat.com
Date:   Fri, 29 Jul 2022 12:07:01 -0400
Message-ID: <165911063667.6303.17490362232454476273.stgit@manet.1015granger.net>
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

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=354
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  |   27 ++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c |    1 +
 fs/nfsd/nfsd.h      |    1 +
 fs/nfsd/trace.h     |   19 +++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

Hi-

Naive approach to the issue of clients attempting to use SETATTR
without first returning a delegation. I'm interested in testing
and suggestions for improving this mechanism.


diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3895eb52d2b1..b4cda7a7e958 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1136,13 +1136,29 @@ nfsd4_secinfo_no_name_release(union nfsd4_op_u *u)
 		exp_put(u->secinfo_no_name.sin_exp);
 }
 
+/*
+ * A better approach would wait for the DELEGRETURN operation, and
+ * retry just as soon as it was done. Unfortunately for NFSv4.0,
+ * we have only the FH, and there isn't a good way to look up a
+ * struct nfs4_delegation given an FH.
+ *
+ * The timeout prevents deadlock if all nfsd threads happen to be
+ * tied up waiting for returning delegations.
+ */
+static void nfsd4_wait_for_delegreturn(struct svc_rqst *rqstp,
+				       struct svc_fh *fhp)
+{
+	trace_nfsd_delegreturn_wait(rqstp, fhp);
+	msleep(NFSD_DELEGRETURN_TIMEOUT);
+}
+
 static __be32
 nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
 {
 	struct nfsd4_setattr *setattr = &u->setattr;
 	__be32 status = nfs_ok;
-	int err;
+	int err, tried;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
@@ -1173,8 +1189,17 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&setattr->sa_label);
 	if (status)
 		goto out;
+
+	tried = 0;
+retry:
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &setattr->sa_iattr,
 				0, (time64_t)0);
+	if (unlikely(status == nfserr_jukebox && !tried)) {
+		nfsd4_wait_for_delegreturn(rqstp, &cstate->current_fh);
+		tried++;
+		goto retry;
+	}
+
 out:
 	fh_drop_write(&cstate->current_fh);
 	return status;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 9a8b09afc173..30838149c7ab 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -341,6 +341,7 @@ void		nfsd_lockd_shutdown(void);
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
 #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
+#define NFSD_DELEGRETURN_TIMEOUT	(50)	/* milliseconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a60ead3b227a..7cc9c6eb4f4e 100644
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



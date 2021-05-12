Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF4437CAD9
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhELQc0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238947AbhELQGv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:06:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D5BC61D00;
        Wed, 12 May 2021 15:35:23 +0000 (UTC)
Subject: [PATCH v2 04/25] NFSD: Add nfsd_clid_verf_mismatch tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:35:22 -0400
Message-ID: <162083372215.3108.12010554310627718001.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record when a client presents a different boot verifier than the
one we know about. Typically this is a sign the client has
rebooted, but sometimes it signals a conflicting client ID, which
the client's administrator will need to address.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   11 ++++++++---
 fs/nfsd/trace.h     |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 84c4021b3826..69405cc9d823 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3191,6 +3191,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_copy;
 		}
 		/* case 5, client reboot */
+		trace_nfsd_clid_verf_mismatch(conf, rqstp, &verf);
 		conf = NULL;
 		goto out_new;
 	}
@@ -3986,9 +3987,13 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (unconf)
 		unhash_client_locked(unconf);
 	/* We need to handle only case 1: probable callback update */
-	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
-		copy_clid(new, conf);
-		gen_confirm(new, nn);
+	if (conf) {
+		if (same_verf(&conf->cl_verifier, &clverifier)) {
+			copy_clid(new, conf);
+			gen_confirm(new, nn);
+		} else
+			trace_nfsd_clid_verf_mismatch(conf, rqstp,
+						      &clverifier);
 	}
 	new->cl_minorversion = 0;
 	gen_callback(new, setclid, rqstp);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 25ed99220c7b..7e2fce504a2d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -562,6 +562,38 @@ TRACE_EVENT(nfsd_clid_cred_mismatch,
 	)
 )
 
+TRACE_EVENT(nfsd_clid_verf_mismatch,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const struct svc_rqst *rqstp,
+		const nfs4_verifier *verf
+	),
+	TP_ARGS(clp, rqstp, verf),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, cl_verifier, NFS4_VERIFIER_SIZE)
+		__array(unsigned char, new_verifier, NFS4_VERIFIER_SIZE)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		memcpy(__entry->cl_verifier, (void *)&clp->cl_verifier,
+		       NFS4_VERIFIER_SIZE);
+		memcpy(__entry->new_verifier, (void *)verf,
+		       NFS4_VERIFIER_SIZE);
+		memcpy(__entry->addr, &rqstp->rq_xprt->xpt_remote,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("client %08x:%08x verf=0x%s, updated=0x%s from addr=%pISpc",
+		__entry->cl_boot, __entry->cl_id,
+		__print_hex_str(__entry->cl_verifier, NFS4_VERIFIER_SIZE),
+		__print_hex_str(__entry->new_verifier, NFS4_VERIFIER_SIZE),
+		__entry->addr
+	)
+);
+
 TRACE_EVENT(nfsd_clid_inuse_err,
 	TP_PROTO(const struct nfs4_client *clp),
 	TP_ARGS(clp),



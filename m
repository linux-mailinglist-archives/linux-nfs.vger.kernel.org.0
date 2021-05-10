Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0C379321
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhEJPyR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhEJPyP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE37E615FF;
        Mon, 10 May 2021 15:53:10 +0000 (UTC)
Subject: [PATCH RFC 15/21] NFSD: Add nfsd_clid_verf_mismatch tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:53:10 -0400
Message-ID: <162066199008.94415.3881243902817026664.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
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
index 4feadb683a2d..56ca79f55da4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3193,6 +3193,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_copy;
 		}
 		/* case 5, client reboot */
+		trace_nfsd_clid_verf_mismatch(conf, rqstp, &verf);
 		conf = NULL;
 		goto out_new;
 	}
@@ -3988,9 +3989,13 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index 80fd6ca6ae46..2c0392f30a86 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -592,6 +592,38 @@ TRACE_EVENT(nfsd_clid_cred_mismatch,
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



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8C381124
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhENT4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232385AbhENT4m (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:56:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9613A61462;
        Fri, 14 May 2021 19:55:30 +0000 (UTC)
Subject: [PATCH v3 03/24] NFSD: Add nfsd_clid_cred_mismatch tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:55:29 -0400
Message-ID: <162102212986.10915.18355855951254162338.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record when a client tries to establish a lease record but uses an
unexpected credential. This is often a sign of a configuration
problem.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   14 ++++++++++----
 fs/nfsd/trace.h     |   28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6abe48dee6ed..84c4021b3826 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3181,6 +3181,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!creds_match) { /* case 3 */
 			if (client_has_state(conf)) {
 				status = nfserr_clid_inuse;
+				trace_nfsd_clid_cred_mismatch(conf, rqstp);
 				goto out;
 			}
 			goto out_new;
@@ -3425,9 +3426,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 			goto out_free_conn;
 		}
 	} else if (unconf) {
+		status = nfserr_clid_inuse;
 		if (!same_creds(&unconf->cl_cred, &rqstp->rq_cred) ||
 		    !rpc_cmp_addr(sa, (struct sockaddr *) &unconf->cl_addr)) {
-			status = nfserr_clid_inuse;
+			trace_nfsd_clid_cred_mismatch(unconf, rqstp);
 			goto out_free_conn;
 		}
 		status = nfserr_wrong_cred;
@@ -3976,7 +3978,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (clp_used_exchangeid(conf))
 			goto out;
 		if (!same_creds(&conf->cl_cred, &rqstp->rq_cred)) {
-			trace_nfsd_clid_inuse_err(conf);
+			trace_nfsd_clid_cred_mismatch(conf, rqstp);
 			goto out;
 		}
 	}
@@ -4034,10 +4036,14 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	 * Nevertheless, RFC 7530 recommends INUSE for this case:
 	 */
 	status = nfserr_clid_inuse;
-	if (unconf && !same_creds(&unconf->cl_cred, &rqstp->rq_cred))
+	if (unconf && !same_creds(&unconf->cl_cred, &rqstp->rq_cred)) {
+		trace_nfsd_clid_cred_mismatch(unconf, rqstp);
 		goto out;
-	if (conf && !same_creds(&conf->cl_cred, &rqstp->rq_cred))
+	}
+	if (conf && !same_creds(&conf->cl_cred, &rqstp->rq_cred)) {
+		trace_nfsd_clid_cred_mismatch(conf, rqstp);
 		goto out;
+	}
 	/* cases below refer to rfc 3530 section 14.2.34: */
 	if (!unconf || !same_verf(&confirm, &unconf->cl_confirm)) {
 		if (conf && same_verf(&confirm, &conf->cl_confirm)) {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 1b50640cdf96..820a542e1013 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -536,6 +536,34 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
 DEFINE_NET_EVENT(grace_start);
 DEFINE_NET_EVENT(grace_complete);
 
+TRACE_EVENT(nfsd_clid_cred_mismatch,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const struct svc_rqst *rqstp
+	),
+	TP_ARGS(clp, rqstp),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(unsigned long, cl_flavor)
+		__field(unsigned long, new_flavor)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__entry->cl_flavor = clp->cl_cred.cr_flavor;
+		__entry->new_flavor = rqstp->rq_cred.cr_flavor;
+		memcpy(__entry->addr, &rqstp->rq_xprt->xpt_remote,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("client %08x:%08x flavor=%s, conflict=%s from addr=%pISpc",
+		__entry->cl_boot, __entry->cl_id,
+		show_nfsd_authflavor(__entry->cl_flavor),
+		show_nfsd_authflavor(__entry->new_flavor), __entry->addr
+	)
+)
+
 TRACE_EVENT(nfsd_clid_inuse_err,
 	TP_PROTO(const struct nfs4_client *clp),
 	TP_ARGS(clp),



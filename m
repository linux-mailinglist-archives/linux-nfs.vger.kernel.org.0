Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0245738113B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhENT5k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233086AbhENT5Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:57:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B37B5615FF;
        Fri, 14 May 2021 19:56:13 +0000 (UTC)
Subject: [PATCH v3 10/24] NFSD: Add tracepoints for SETCLIENTID edge cases
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:56:13 -0400
Message-ID: <162102217298.10915.12247658118076341360.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   19 ++++++++-----------
 fs/nfsd/trace.h     |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2e7bbaa92684..b6da4abd42a0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3976,11 +3976,9 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = create_client(clname, rqstp, &clverifier);
 	if (new == NULL)
 		return nfserr_jukebox;
-	/* Cases below refer to rfc 3530 section 14.2.33: */
 	spin_lock(&nn->client_lock);
 	conf = find_confirmed_client_by_name(&clname, nn);
 	if (conf && client_has_state(conf)) {
-		/* case 0: */
 		status = nfserr_clid_inuse;
 		if (clp_used_exchangeid(conf))
 			goto out;
@@ -3992,7 +3990,6 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	unconf = find_unconfirmed_client_by_name(&clname, nn);
 	if (unconf)
 		unhash_client_locked(unconf);
-	/* We need to handle only case 1: probable callback update */
 	if (conf) {
 		if (same_verf(&conf->cl_verifier, &clverifier)) {
 			copy_clid(new, conf);
@@ -4000,7 +3997,8 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		} else
 			trace_nfsd_clid_verf_mismatch(conf, rqstp,
 						      &clverifier);
-	}
+	} else
+		trace_nfsd_clid_fresh(new);
 	new->cl_minorversion = 0;
 	gen_callback(new, setclid, rqstp);
 	add_to_unconfirmed(new);
@@ -4013,12 +4011,13 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	spin_unlock(&nn->client_lock);
 	if (new)
 		free_client(new);
-	if (unconf)
+	if (unconf) {
+		trace_nfsd_clid_expire_unconf(&unconf->cl_clientid);
 		expire_client(unconf);
+	}
 	return status;
 }
 
-
 __be32
 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 			struct nfsd4_compound_state *cstate,
@@ -4055,21 +4054,19 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 		trace_nfsd_clid_cred_mismatch(conf, rqstp);
 		goto out;
 	}
-	/* cases below refer to rfc 3530 section 14.2.34: */
 	if (!unconf || !same_verf(&confirm, &unconf->cl_confirm)) {
 		if (conf && same_verf(&confirm, &conf->cl_confirm)) {
-			/* case 2: probable retransmit */
 			status = nfs_ok;
-		} else /* case 4: client hasn't noticed we rebooted yet? */
+		} else
 			status = nfserr_stale_clientid;
 		goto out;
 	}
 	status = nfs_ok;
-	if (conf) { /* case 1: callback update */
+	if (conf) {
 		old = unconf;
 		unhash_client_locked(old);
 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
-	} else { /* case 3: normal case; new or rebooted client */
+	} else {
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = nfserr_clid_inuse;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ac96416b4b33..33fba6dbdc4a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -511,6 +511,7 @@ DEFINE_EVENT(nfsd_clientid_class, nfsd_clid_##name, \
 	TP_PROTO(const clientid_t *clid), \
 	TP_ARGS(clid))
 
+DEFINE_CLIENTID_EVENT(expire_unconf);
 DEFINE_CLIENTID_EVENT(reclaim_complete);
 DEFINE_CLIENTID_EVENT(confirmed);
 DEFINE_CLIENTID_EVENT(destroyed);
@@ -600,6 +601,42 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
 	)
 );
 
+DECLARE_EVENT_CLASS(nfsd_clid_class,
+	TP_PROTO(const struct nfs4_client *clp),
+	TP_ARGS(clp),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__field(unsigned long, flavor)
+		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
+		__dynamic_array(char, name, clp->cl_name.len + 1)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		memcpy(__entry->addr, &clp->cl_addr,
+			sizeof(struct sockaddr_in6));
+		__entry->flavor = clp->cl_cred.cr_flavor;
+		memcpy(__entry->verifier, (void *)&clp->cl_verifier,
+		       NFS4_VERIFIER_SIZE);
+		memcpy(__get_str(name), clp->cl_name.data, clp->cl_name.len);
+		__get_str(name)[clp->cl_name.len] = '\0';
+	),
+	TP_printk("addr=%pISpc name='%s' verifier=0x%s flavor=%s client=%08x:%08x",
+		__entry->addr, __get_str(name),
+		__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE),
+		show_nfsd_authflavor(__entry->flavor),
+		__entry->cl_boot, __entry->cl_id)
+);
+
+#define DEFINE_CLID_EVENT(name) \
+DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
+	TP_PROTO(const struct nfs4_client *clp), \
+	TP_ARGS(clp))
+
+DEFINE_CLID_EVENT(fresh);
+
 /*
  * from fs/nfsd/filecache.h
  */



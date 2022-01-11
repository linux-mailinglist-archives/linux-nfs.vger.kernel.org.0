Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54748B649
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 19:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350344AbiAKS7m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 13:59:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56430 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiAKS7g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 13:59:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D022616DB;
        Tue, 11 Jan 2022 18:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDC5C36AE3;
        Tue, 11 Jan 2022 18:59:35 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-trace-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH RFC 2/2] NFSD: Use __sockaddr field to store socket addresses
Date:   Tue, 11 Jan 2022 13:59:34 -0500
Message-Id:  <164192757439.1149.13280600903390427167.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164192738510.1149.7614903005271825552.stgit@klimt.1015granger.net>
References:  <164192738510.1149.7614903005271825552.stgit@klimt.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=8865; h=from:subject:message-id; bh=zvT+dhaVeWaUTx1YCoCvz9OW/eaaPo/WGozW5KXzACs=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh3dOWoERpcVvKO5UkibFzIW4P4DuxipN1By6qbrvS eN7QHG+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYd3TlgAKCRAzarMzb2Z/l94ED/ 45tk1nwLufB724OixeQLhwBn6FvGa2sXXSo8BM9jLmiNieB/vmBjWO/wRLopLdYvgkxAiQOE0LI+SS LLNAy9T1PDSlz8ZRtmm+6VToMB0EMcw7042/zQ9BnZPFeM7sexvb5DAOjAPrNoXifrnDXj1ujNM8Rt 7TInQ76JCWcq2kSQPZYq+tLraVOuVPZg9VK/vScW5DbFZZo7yUOtGZCz14HLyV00HaU+33qxsO/qyX n5grDsjzfBxNt9sLF/ma2+76cUfcPCWKG6cqb+DnFE7Z5241QTFeYioDraiM3u6cIzSICnExSOvE54 SD3x2rM80rRhUgwMqLeu5T7YhTp0e6t5fB4FMnFmPkHMFwOQb5TEC6ltJS42O7Hj0BonqzIkgftJzp Iuh/Drsse6InysnGBI8x4Nq2tNh84d/yijC5i4EqbljcBtK8Xll1NMY+lFObWmqKqAmsZKVeSMAw8n nAiDRYy+f+1HbQWZ7WqGN7GBsbhBQPjcXrmA/FhESRZoCgHukDk/Y7dWdXgGOJvEnF47tQHloLkFFw pJ+e/80vnpRTs3tofTcFb2lkF+51iUJylpSD//fyNXLunKXOs2fvjxh9rF+H42+YSxJYZIpUMqSX5A CAvsAJJCKVOZvNAfaFQ4UG8NggDokFHcttqwmWk20el0RZUkQJa9DsN3+nmA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As an example usage of the new __sockaddr field, convert some NFSD
trace points to use it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   79 +++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index f1e0d3c51bc2..1ade489458fc 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -549,20 +549,21 @@ TRACE_EVENT(nfsd_clid_cred_mismatch,
 		__field(u32, cl_id)
 		__field(unsigned long, cl_flavor)
 		__field(unsigned long, new_flavor)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, rqstp->rq_xprt->xpt_remotelen)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
 		__entry->cl_flavor = clp->cl_cred.cr_flavor;
 		__entry->new_flavor = rqstp->rq_cred.cr_flavor;
-		memcpy(__entry->addr, &rqstp->rq_xprt->xpt_remote,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &rqstp->rq_xprt->xpt_remote,
+				  rqstp->rq_xprt->xpt_remotelen);
 	),
 	TP_printk("client %08x:%08x flavor=%s, conflict=%s from addr=%pISpc",
 		__entry->cl_boot, __entry->cl_id,
 		show_nfsd_authflavor(__entry->cl_flavor),
-		show_nfsd_authflavor(__entry->new_flavor), __entry->addr
+		show_nfsd_authflavor(__entry->new_flavor),
+		__get_sockaddr(addr)
 	)
 )
 
@@ -578,7 +579,7 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
 		__field(u32, cl_id)
 		__array(unsigned char, cl_verifier, NFS4_VERIFIER_SIZE)
 		__array(unsigned char, new_verifier, NFS4_VERIFIER_SIZE)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, rqstp->rq_xprt->xpt_remotelen)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
@@ -587,14 +588,14 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
 		       NFS4_VERIFIER_SIZE);
 		memcpy(__entry->new_verifier, (void *)verf,
 		       NFS4_VERIFIER_SIZE);
-		memcpy(__entry->addr, &rqstp->rq_xprt->xpt_remote,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &rqstp->rq_xprt->xpt_remote,
+				  rqstp->rq_xprt->xpt_remotelen);
 	),
 	TP_printk("client %08x:%08x verf=0x%s, updated=0x%s from addr=%pISpc",
 		__entry->cl_boot, __entry->cl_id,
 		__print_hex_str(__entry->cl_verifier, NFS4_VERIFIER_SIZE),
 		__print_hex_str(__entry->new_verifier, NFS4_VERIFIER_SIZE),
-		__entry->addr
+		__get_sockaddr(addr)
 	)
 );
 
@@ -844,18 +845,17 @@ TRACE_EVENT(nfsd_cb_args,
 		__field(u32, cl_id)
 		__field(u32, prog)
 		__field(u32, ident)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, conn->cb_addrlen)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
 		__entry->prog = conn->cb_prog;
 		__entry->ident = conn->cb_ident;
-		memcpy(__entry->addr, &conn->cb_addr,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &conn->cb_addr, conn->cb_addrlen);
 	),
 	TP_printk("addr=%pISpc client %08x:%08x prog=%u ident=%u",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
 		__entry->prog, __entry->ident)
 );
 
@@ -887,17 +887,17 @@ DECLARE_EVENT_CLASS(nfsd_cb_class,
 		__field(unsigned long, state)
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_fast_assign(
 		__entry->state = clp->cl_cb_state;
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
-		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x state=%s",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
 		show_cb_state(__entry->state))
 );
 
@@ -937,7 +937,7 @@ TRACE_EVENT(nfsd_cb_setup,
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
 		__field(unsigned long, authflavor)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
 		__array(unsigned char, netid, 8)
 	),
 	TP_fast_assign(
@@ -945,11 +945,11 @@ TRACE_EVENT(nfsd_cb_setup,
 		__entry->cl_id = clp->cl_clientid.cl_id;
 		strlcpy(__entry->netid, netid, sizeof(__entry->netid));
 		__entry->authflavor = authflavor;
-		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x proto=%s flavor=%s",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
 		__entry->netid, show_nfsd_authflavor(__entry->authflavor))
 );
 
@@ -963,30 +963,32 @@ TRACE_EVENT(nfsd_cb_setup_err,
 		__field(long, error)
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_fast_assign(
 		__entry->error = error;
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
-		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x error=%ld",
-		__entry->addr, __entry->cl_boot, __entry->cl_id, __entry->error)
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
+		__entry->error)
 );
 
-TRACE_EVENT(nfsd_cb_recall,
+TRACE_EVENT_CONDITION(nfsd_cb_recall,
 	TP_PROTO(
 		const struct nfs4_stid *stid
 	),
 	TP_ARGS(stid),
+	TP_CONDITION(stid->sc_client),
 	TP_STRUCT__entry(
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
 		__field(u32, si_id)
 		__field(u32, si_generation)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, stid->sc_client->cl_cb_conn.cb_addrlen)
 	),
 	TP_fast_assign(
 		const stateid_t *stp = &stid->sc_stateid;
@@ -996,14 +998,11 @@ TRACE_EVENT(nfsd_cb_recall,
 		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
 		__entry->si_id = stp->si_opaque.so_id;
 		__entry->si_generation = stp->si_generation;
-		if (clp)
-			memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-				sizeof(struct sockaddr_in6));
-		else
-			memset(__entry->addr, 0, sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x stateid %08x:%08x",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
 		__entry->si_id, __entry->si_generation)
 );
 
@@ -1017,7 +1016,7 @@ TRACE_EVENT(nfsd_cb_notify_lock,
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
 		__field(u32, fh_hash)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, lo->lo_owner.so_client->cl_cb_conn.cb_addrlen)
 	),
 	TP_fast_assign(
 		const struct nfs4_client *clp = lo->lo_owner.so_client;
@@ -1025,11 +1024,11 @@ TRACE_EVENT(nfsd_cb_notify_lock,
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
 		__entry->fh_hash = knfsd_fh_hash(&nbl->nbl_fh);
-		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x fh_hash=0x%08x",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
 		__entry->fh_hash)
 );
 
@@ -1050,7 +1049,7 @@ TRACE_EVENT(nfsd_cb_offload,
 		__field(u32, fh_hash)
 		__field(int, status)
 		__field(u64, count)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
@@ -1060,11 +1059,11 @@ TRACE_EVENT(nfsd_cb_offload,
 		__entry->fh_hash = knfsd_fh_hash(fh);
 		__entry->status = be32_to_cpu(status);
 		__entry->count = count;
-		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-			sizeof(struct sockaddr_in6));
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x stateid %08x:%08x fh_hash=0x%08x count=%llu status=%d",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
 		__entry->si_id, __entry->si_generation,
 		__entry->fh_hash, __entry->count, __entry->status)
 );


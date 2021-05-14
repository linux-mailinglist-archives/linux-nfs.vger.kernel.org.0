Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8A381146
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhENT6P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhENT6O (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:58:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6E4161353;
        Fri, 14 May 2021 19:57:02 +0000 (UTC)
Subject: [PATCH v3 18/24] NFSD: Enhance the nfsd_cb_setup tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:57:02 -0400
Message-ID: <162102222212.10915.11939476694458119659.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Display the transport protocol and authentication flavor so admins
can see what they might be getting wrong.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    3 ++-
 fs/nfsd/trace.h        |   27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 15ba16c54793..c2a2a58b3581 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -939,7 +939,8 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	}
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
-	trace_nfsd_cb_setup(clp);
+	trace_nfsd_cb_setup(clp, rpc_peeraddr2str(client, RPC_DISPLAY_NETID),
+			    args.authflavor);
 	return 0;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 336dc4c45416..fc80879d6077 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -910,7 +910,6 @@ DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
 	TP_PROTO(const struct nfs4_client *clp),	\
 	TP_ARGS(clp))
 
-DEFINE_NFSD_CB_EVENT(setup);
 DEFINE_NFSD_CB_EVENT(state);
 DEFINE_NFSD_CB_EVENT(lost);
 DEFINE_NFSD_CB_EVENT(shutdown);
@@ -931,6 +930,32 @@ TRACE_DEFINE_ENUM(RPC_AUTH_GSS_KRB5P);
 		{ RPC_AUTH_GSS_KRB5I,		"krb5i" },		\
 		{ RPC_AUTH_GSS_KRB5P,		"krb5p" })
 
+TRACE_EVENT(nfsd_cb_setup,
+	TP_PROTO(const struct nfs4_client *clp,
+		 const char *netid,
+		 rpc_authflavor_t authflavor
+	),
+	TP_ARGS(clp, netid, authflavor),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(unsigned long, authflavor)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__array(unsigned char, netid, 8)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		strlcpy(__entry->netid, netid, sizeof(__entry->netid));
+		__entry->authflavor = authflavor;
+		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("addr=%pISpc client %08x:%08x proto=%s flavor=%s",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__entry->netid, show_nfsd_authflavor(__entry->authflavor))
+);
+
 TRACE_EVENT(nfsd_cb_setup_err,
 	TP_PROTO(
 		const struct nfs4_client *clp,



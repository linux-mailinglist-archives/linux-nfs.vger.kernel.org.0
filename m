Return-Path: <linux-nfs+bounces-4894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D81930F0F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7908C1F21066
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48DA6AB8;
	Mon, 15 Jul 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VZftjmVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X62gdTbO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VZftjmVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X62gdTbO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA3175A6
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029670; cv=none; b=Kfol9R9fQZ62Wq3lTCXt1Ghk3jE06yohLqFJxseeRxPTcS5cK4A27PsjtdUYRjRoIPykCwXsmvBk87SRkpNKV1avpiCvMzvakTRJ5qLYcYJ9yWme9BKZuoMIpzDDZXX5wo7j7G8HE1O4tqiNWPo/uGevrjR4lhCa1H7TJ6oRAPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029670; c=relaxed/simple;
	bh=zGv4lgTOk5B4Vez9M9+1NBEq6MzGbBBrGiUT2VF1sAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVSnToag1/NEzMnA/krcWA3kGBZvZd4A5MLybWwuhLtcmbTPGyeFzQpkzjv6KRgik+HaevgJjwdOXk175Aws5l4ax2WWd1rizzhOJRaMN/PWVPjPzIx8UxwG053U52d/SN6tmtjCIDNqRWfQQfNBAwbCEF7aVdABLXmA2vMOOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VZftjmVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X62gdTbO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VZftjmVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X62gdTbO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E59AC21B95;
	Mon, 15 Jul 2024 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9uwQZxc45oL3RzIBCFXeXBOQabgo6olEaP7HqJa8nE=;
	b=VZftjmVWzogaGbOsR4HZNfeBu1PJwu0+IuqYArVvFvr9tnabJeRrMaQg7vO8W3+SV574xa
	NETVn5Xijro9JueKHu2uTsOpBfk1hUtSZo8CXSAMbM99927joHF3t+Qa+eQOmz5i+dknvm
	UWE3jb3cgYXU3Hlbgrz9rjZvwE1zP7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9uwQZxc45oL3RzIBCFXeXBOQabgo6olEaP7HqJa8nE=;
	b=X62gdTbOFGKa2m9nA37Q3vP7QlpMQohsv5xTvus289W6m0Gwi60n6rUknq3N5RfzLUZi4y
	4ahEZG47uW3vNkBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9uwQZxc45oL3RzIBCFXeXBOQabgo6olEaP7HqJa8nE=;
	b=VZftjmVWzogaGbOsR4HZNfeBu1PJwu0+IuqYArVvFvr9tnabJeRrMaQg7vO8W3+SV574xa
	NETVn5Xijro9JueKHu2uTsOpBfk1hUtSZo8CXSAMbM99927joHF3t+Qa+eQOmz5i+dknvm
	UWE3jb3cgYXU3Hlbgrz9rjZvwE1zP7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9uwQZxc45oL3RzIBCFXeXBOQabgo6olEaP7HqJa8nE=;
	b=X62gdTbOFGKa2m9nA37Q3vP7QlpMQohsv5xTvus289W6m0Gwi60n6rUknq3N5RfzLUZi4y
	4ahEZG47uW3vNkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 811B3137EB;
	Mon, 15 Jul 2024 07:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RWL3DSDUlGbLbQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:47:44 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 02/14] SUNRPC: make various functions static, or not exported.
Date: Mon, 15 Jul 2024 17:14:15 +1000
Message-ID: <20240715074657.18174-3-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Various functions are only used within the sunrpc module, and several
are only use in the one file.  So clean up:

These are marked static, and any EXPORT is removed.
  svc_rcpb_setup()
  svc_rqst_alloc()
  svc_rqst_free()  - also moved before first use
  svc_rpcbind_set_version()
  svc_drop() - also moved to svc.c

These are now not EXPORTed, but are not static.
  svc_authenticate()
  svc_sock_update_bufs()

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h     |  9 -------
 include/linux/sunrpc/svcauth.h |  1 -
 include/linux/sunrpc/svcsock.h |  2 --
 net/sunrpc/sunrpc.h            |  4 +++
 net/sunrpc/svc.c               | 48 ++++++++++++++++++----------------
 net/sunrpc/svc_xprt.c          |  9 -------
 net/sunrpc/svcauth.c           |  1 -
 net/sunrpc/svcsock.c           |  1 -
 8 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index a7d0406b9ef5..e4fa25fafa97 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -401,17 +401,13 @@ struct svc_procedure {
  */
 int sunrpc_set_pool_mode(const char *val);
 int sunrpc_get_pool_mode(char *val, size_t size);
-int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
 struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    int (*threadfn)(void *data));
-struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
-					struct svc_pool *pool, int node);
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
-void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     struct svc_stat *stats,
@@ -446,11 +442,6 @@ int		   svc_generic_rpcbind_set(struct net *net,
 					   u32 version, int family,
 					   unsigned short proto,
 					   unsigned short port);
-int		   svc_rpcbind_set_version(struct net *net,
-					   const struct svc_program *progp,
-					   u32 version, int family,
-					   unsigned short proto,
-					   unsigned short port);
 
 #define	RPC_MAX_ADDRBUFLEN	(63U)
 
diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 61c455f1e1f5..63cf6fb26dcc 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -151,7 +151,6 @@ struct auth_ops {
 
 struct svc_xprt;
 
-extern enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
 extern rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp);
 extern int	svc_authorise(struct svc_rqst *rqstp);
 extern enum svc_auth_status svc_set_client(struct svc_rqst *rqstp);
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 7c78ec6356b9..bf45d9e8492a 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -58,8 +58,6 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
  */
 void		svc_recv(struct svc_rqst *rqstp);
 void		svc_send(struct svc_rqst *rqstp);
-void		svc_drop(struct svc_rqst *);
-void		svc_sock_update_bufs(struct svc_serv *serv);
 int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const int fd, char *name_return, const size_t len,
 			    const struct cred *cred);
diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index d4a362c9e4b3..e3c6e3b63f0b 100644
--- a/net/sunrpc/sunrpc.h
+++ b/net/sunrpc/sunrpc.h
@@ -36,7 +36,11 @@ static inline int sock_is_loopback(struct sock *sk)
 	return loopback;
 }
 
+struct svc_serv;
+struct svc_rqst;
 int rpc_clients_notifier_register(void);
 void rpc_clients_notifier_unregister(void);
 void auth_domain_cleanup(void);
+void svc_sock_update_bufs(struct svc_serv *serv);
+enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
 #endif /* _NET_SUNRPC_SUNRPC_H */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e03f14024e47..072ad115ae3d 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -32,6 +32,7 @@
 #include <trace/events/sunrpc.h>
 
 #include "fail.h"
+#include "sunrpc.h"
 
 #define RPCDBG_FACILITY	RPCDBG_SVCDSP
 
@@ -417,7 +418,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	return &serv->sv_pools[pidx % serv->sv_nrpools];
 }
 
-int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
+static int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
 {
 	int err;
 
@@ -429,7 +430,6 @@ int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
 	svc_unregister(serv, net);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(svc_rpcb_setup);
 
 void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net)
 {
@@ -664,7 +664,20 @@ svc_release_buffer(struct svc_rqst *rqstp)
 			put_page(rqstp->rq_pages[i]);
 }
 
-struct svc_rqst *
+static void
+svc_rqst_free(struct svc_rqst *rqstp)
+{
+	folio_batch_release(&rqstp->rq_fbatch);
+	svc_release_buffer(rqstp);
+	if (rqstp->rq_scratch_page)
+		put_page(rqstp->rq_scratch_page);
+	kfree(rqstp->rq_resp);
+	kfree(rqstp->rq_argp);
+	kfree(rqstp->rq_auth_data);
+	kfree_rcu(rqstp, rq_rcu_head);
+}
+
+static struct svc_rqst *
 svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	struct svc_rqst	*rqstp;
@@ -698,7 +711,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	svc_rqst_free(rqstp);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(svc_rqst_alloc);
 
 static struct svc_rqst *
 svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
@@ -933,24 +945,6 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
 	}
 }
 
-/*
- * Called from a server thread as it's exiting. Caller must hold the "service
- * mutex" for the service.
- */
-void
-svc_rqst_free(struct svc_rqst *rqstp)
-{
-	folio_batch_release(&rqstp->rq_fbatch);
-	svc_release_buffer(rqstp);
-	if (rqstp->rq_scratch_page)
-		put_page(rqstp->rq_scratch_page);
-	kfree(rqstp->rq_resp);
-	kfree(rqstp->rq_argp);
-	kfree(rqstp->rq_auth_data);
-	kfree_rcu(rqstp, rq_rcu_head);
-}
-EXPORT_SYMBOL_GPL(svc_rqst_free);
-
 void
 svc_exit_thread(struct svc_rqst *rqstp)
 {
@@ -1098,6 +1092,7 @@ static int __svc_register(struct net *net, const char *progname,
 	return error;
 }
 
+static
 int svc_rpcbind_set_version(struct net *net,
 			    const struct svc_program *progp,
 			    u32 version, int family,
@@ -1108,7 +1103,6 @@ int svc_rpcbind_set_version(struct net *net,
 				version, family, proto, port);
 
 }
-EXPORT_SYMBOL_GPL(svc_rpcbind_set_version);
 
 int svc_generic_rpcbind_set(struct net *net,
 			    const struct svc_program *progp,
@@ -1526,6 +1520,14 @@ svc_process_common(struct svc_rqst *rqstp)
 	goto sendit;
 }
 
+/*
+ * Drop request
+ */
+static void svc_drop(struct svc_rqst *rqstp)
+{
+	trace_svc_drop(rqstp);
+}
+
 /**
  * svc_process - Execute one RPC transaction
  * @rqstp: RPC transaction context
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d3735ab3e6d1..53ebc719ff5a 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -905,15 +905,6 @@ void svc_recv(struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
-/*
- * Drop request
- */
-void svc_drop(struct svc_rqst *rqstp)
-{
-	trace_svc_drop(rqstp);
-}
-EXPORT_SYMBOL_GPL(svc_drop);
-
 /**
  * svc_send - Return reply to client
  * @rqstp: RPC transaction context
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 1619211f0960..93d9e949e265 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -98,7 +98,6 @@ enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp)
 	rqstp->rq_authop = aops;
 	return aops->accept(rqstp);
 }
-EXPORT_SYMBOL_GPL(svc_authenticate);
 
 /**
  * svc_set_client - Assign an appropriate 'auth_domain' as the client
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6b3f01beb294..825ec5357691 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1378,7 +1378,6 @@ void svc_sock_update_bufs(struct svc_serv *serv)
 		set_bit(XPT_CHNGBUF, &svsk->sk_xprt.xpt_flags);
 	spin_unlock_bh(&serv->sv_lock);
 }
-EXPORT_SYMBOL_GPL(svc_sock_update_bufs);
 
 /*
  * Initialize socket for RPC use and create svc_sock struct
-- 
2.44.0



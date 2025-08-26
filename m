Return-Path: <linux-nfs+bounces-13908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C6B374B3
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 00:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C542072D7
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 22:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449322E406;
	Tue, 26 Aug 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT3NlKtW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AC1514E4
	for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245611; cv=none; b=pkfytwAjzlYlgpa69N7AQrwgSRAJyLLZgWh81COHZEaEN+Wg5+8A6qhSKhx5VvN5pipcdAGIDWO0XloulBGh2bmGhI2R9nPZCLbc6o63ELdp0CTQt2PGvCpYbUmTaMkZMBkFCYeQbsBd9qCTgNxIPoaOJUTZyjgKE01XEXAeoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245611; c=relaxed/simple;
	bh=pDOou0pXWNIvfmO+d93x8FHYCyItr4aiLpT9WvOeiao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJ8jSWd62zNsaSF1g8wPNcQIBo3RwGOH61cT8ePbCUC7BBRovd88/PVIbjd66neWP6+xO/YGPt86Rpf8+3svrJtWtDp5UjRs1mRx2m+/G34CwLNtEZ/cxmCjTxqpvhwfwPc6ArI26Bsp1+KPcsDYC2NMsf4sNwQ5g6JQ4gJUeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OT3NlKtW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756245608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=glAXJP3pVn/herhkOF9QKMZy8z3Y4cccQAGKwNxqeKw=;
	b=OT3NlKtWv4EFXCWxnr0nNeVVOuA6AA4uSMMwR6Bej38c4CAgjy87OUty0doyOc44uzqkoR
	fnrIPSDpBmetsZfZr9GdmR6iIetpV10VLJ1W0yWKjBsM2ga13BT9itu38jA5CMqVu+/Xff
	6VesuEVhOj2x0tl/6qBxn1lbohj1cE0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-XYMqm_LOMgGgFUdC8pHawg-1; Tue,
 26 Aug 2025 18:00:04 -0400
X-MC-Unique: XYMqm_LOMgGgFUdC8pHawg-1
X-Mimecast-MFC-AGG-ID: XYMqm_LOMgGgFUdC8pHawg_1756245603
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8628119560AA;
	Tue, 26 Aug 2025 22:00:03 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.80.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EF7B18004D4;
	Tue, 26 Aug 2025 22:00:01 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [RFC PATCH 1/1] nfsd: rework how a listener is removed
Date: Tue, 26 Aug 2025 18:00:01 -0400
Message-Id: <20250826220001.8235-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch tries to address the following failure:
nfsdctl threads 0
nfsdctl listener +rdma::20049
nfsdctl listener +tcp::2049
nfsdctl listener -tcp::2049
nfsdctl: Error: Cannot assign requested address

The reason for the failure is due to the fact that socket cleanup only
happens in __svc_rdma_free() which is a deferred work triggers when an
rdma transport is destroyed. To remove a listener nfsdctl is forced to
first remove all transports via svc_xprt_destroy_all() and then re-add
the ones that are left. Due to the fact that there isn't a way to
delete a particular entry from server's lwq sp_xprts that stores
transports. Going back to the deferred work done in __svc_rdma_free(),
the work might not get to run before nfsd_nl_listener_set_doit() creates
the new transports. As a result, it finds that something is still
listening of the rdma port and rdma_bind_addr() fails.

Instead of using svc_xprt_destroy_all() to manipulate the sp_xprt,
instead introduce a function that just dequeues all transports. Then,
we add non-removed transports back to the list.

Still not allowing to remove a listener while the server is active.

We need to make several passes over the list of existing/new list
entries. On the first pass we determined if any of the entries need
to be removed. If so, we then check if the server has no active
threads. Then we dequeue all the transports and then go over the
list and recreate both permsocks list and sp_xprts lists. Then,
for the deleted transports, the transport is closed.

--- Comments:
(1) There is still a restriction on removing an active listener as
I dont know how to handle if the transport to be remove is currently
serving a request (it won't be on the sp_xprt list I believe?).
In general, I'm unsure if there are other things I'm not considering.
(2) I'm questioning if in svc_xprt_dequeue_all() it is correct. I
used svc_cleanup_up_xprts() as the example.

Fixes: d093c90892607 ("nfsd: fix management of listener transports")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfsctl.c                | 123 +++++++++++++++++++-------------
 include/linux/sunrpc/svc_xprt.h |   1 +
 include/linux/sunrpc/svcsock.h  |   1 -
 net/sunrpc/svc_xprt.c           |  12 ++++
 4 files changed, 88 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index dd3267b4c203..38aaaef4734e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1902,44 +1902,17 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-/**
- * nfsd_nl_listener_set_doit - set the nfs running sockets
- * @skb: reply buffer
- * @info: netlink metadata and command arguments
- *
- * Return 0 on success or a negative errno.
- */
-int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
+static void _nfsd_walk_listeners(struct genl_info *info, struct svc_serv *serv,
+				 struct list_head *permsocks, int modify_xprt)
 {
 	struct net *net = genl_info_net(info);
-	struct svc_xprt *xprt, *tmp;
 	const struct nlattr *attr;
-	struct svc_serv *serv;
-	LIST_HEAD(permsocks);
-	struct nfsd_net *nn;
-	bool delete = false;
-	int err, rem;
-
-	mutex_lock(&nfsd_mutex);
-
-	err = nfsd_create_serv(net);
-	if (err) {
-		mutex_unlock(&nfsd_mutex);
-		return err;
-	}
-
-	nn = net_generic(net, nfsd_net_id);
-	serv = nn->nfsd_serv;
-
-	spin_lock_bh(&serv->sv_lock);
+	struct svc_xprt *xprt, *tmp;
+	int rem;
 
-	/* Move all of the old listener sockets to a temp list */
-	list_splice_init(&serv->sv_permsocks, &permsocks);
+	if (modify_xprt)
+		svc_xprt_dequeue_all(serv);
 
-	/*
-	 * Walk the list of server_socks from userland and move any that match
-	 * back to sv_permsocks
-	 */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
 		const char *xcl_name;
@@ -1962,7 +1935,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
 		/* Put back any matching sockets */
-		list_for_each_entry_safe(xprt, tmp, &permsocks, xpt_list) {
+		list_for_each_entry_safe(xprt, tmp, permsocks, xpt_list) {
 			/* This shouldn't be possible */
 			if (WARN_ON_ONCE(xprt->xpt_net != net)) {
 				list_move(&xprt->xpt_list, &serv->sv_permsocks);
@@ -1971,35 +1944,89 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 			/* If everything matches, put it back */
 			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
-			    rpc_cmp_addr_port(sa, (struct sockaddr *)&xprt->xpt_local)) {
+			    rpc_cmp_addr_port(sa,
+				    (struct sockaddr *)&xprt->xpt_local)) {
 				list_move(&xprt->xpt_list, &serv->sv_permsocks);
+				if (modify_xprt)
+					svc_xprt_enqueue(xprt);
 				break;
 			}
 		}
 	}
+}
+
+/**
+ * nfsd_nl_listener_set_doit - set the nfs running sockets
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct svc_xprt *xprt;
+	const struct nlattr *attr;
+	struct svc_serv *serv;
+	LIST_HEAD(permsocks);
+	struct nfsd_net *nn;
+	bool delete = false;
+	int err, rem;
+
+	mutex_lock(&nfsd_mutex);
+
+	err = nfsd_create_serv(net);
+	if (err) {
+		mutex_unlock(&nfsd_mutex);
+		return err;
+	}
+
+	nn = net_generic(net, nfsd_net_id);
+	serv = nn->nfsd_serv;
+
+	spin_lock_bh(&serv->sv_lock);
+
+	/* Move all of the old listener sockets to a temp list */
+	list_splice_init(&serv->sv_permsocks, &permsocks);
 
 	/*
-	 * If there are listener transports remaining on the permsocks list,
-	 * it means we were asked to remove a listener.
+	 * Walk the list of server_socks from userland and move any that match
+	 * back to sv_permsocks. Determine if anything needs to be removed so
+	 * don't manipulate sp_xprts list.
 	 */
-	if (!list_empty(&permsocks)) {
-		list_splice_init(&permsocks, &serv->sv_permsocks);
-		delete = true;
-	}
-	spin_unlock_bh(&serv->sv_lock);
+	_nfsd_walk_listeners(info, serv, &permsocks, false);
 
-	/* Do not remove listeners while there are active threads. */
-	if (serv->sv_nrthreads) {
+	/* For now, no removing old sockets while server is running */
+	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
+		list_splice_init(&permsocks, &serv->sv_permsocks);
+		spin_unlock_bh(&serv->sv_lock);
 		err = -EBUSY;
 		goto out_unlock_mtx;
 	}
 
 	/*
-	 * Since we can't delete an arbitrary llist entry, destroy the
-	 * remaining listeners and recreate the list.
+	 * If there are listener transports remaining on the permsocks list,
+	 * it means we were asked to remove a listener. Walk the list again,
+	 * but this time also manage the sp_xprts but first removing all of
+	 * them and only adding back the ones not being deleted. Then close
+	 * the ones left on the list.
 	 */
-	if (delete)
-		svc_xprt_destroy_all(serv, net, false);
+	if (!list_empty(&permsocks)) {
+		list_splice_init(&permsocks, &serv->sv_permsocks);
+		list_splice_init(&serv->sv_permsocks, &permsocks);
+		_nfsd_walk_listeners(info, serv, &permsocks, true);
+		while (!list_empty(&permsocks)) {
+			xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
+			clear_bit(XPT_BUSY, &xprt->xpt_flags);
+			set_bit(XPT_CLOSE, &xprt->xpt_flags);
+			spin_unlock_bh(&serv->sv_lock);
+			svc_xprt_close(xprt);
+			spin_lock_bh(&serv->sv_lock);
+		}
+		spin_unlock_bh(&serv->sv_lock);
+		goto out_unlock_mtx;
+	}
+	spin_unlock_bh(&serv->sv_lock);
 
 	/* walk list of addrs again, open any that still don't exist */
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index da2a2531e110..7038fd8ef20a 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -186,6 +186,7 @@ int	svc_xprt_names(struct svc_serv *serv, char *buf, const int buflen);
 void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *xprt);
 void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
 void	svc_xprt_deferred_close(struct svc_xprt *xprt);
+void	svc_xprt_dequeue_all(struct svc_serv *serv);
 
 static inline void svc_xprt_get(struct svc_xprt *xprt)
 {
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 963bbe251e52..4c1be01afdb7 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -65,7 +65,6 @@ int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const struct cred *cred);
 void		svc_init_xprt_sock(void);
 void		svc_cleanup_xprt_sock(void);
-
 /*
  * svc_makesock socket characteristics
  */
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 6973184ff667..2aa46b9468d4 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -890,6 +890,18 @@ void svc_recv(struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
+void svc_xprt_dequeue_all(struct svc_serv *serv)
+{
+	int i;
+
+	for (i = 0; i < serv->sv_nrpools; i++) {
+		struct svc_pool *pool = &serv->sv_pools[i];
+
+		lwq_dequeue_all(&pool->sp_xprts);
+	}
+}
+EXPORT_SYMBOL_GPL(svc_xprt_dequeue_all);
+
 /**
  * svc_send - Return reply to client
  * @rqstp: RPC transaction context
-- 
2.47.1



Return-Path: <linux-nfs+bounces-13801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C00B2DF7B
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE62686FBB
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F6321447;
	Wed, 20 Aug 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMqlQkx0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9BB321433
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700053; cv=none; b=sU3uMNB6Mx6xZz0SV6qJLbV6IxwtatFBfo+zGxAtBH77z3cp8rpDT11d3MEx1a4Wx2fx01Ijrbk5w3Lti6FrEgHJPnpgab+fspbJecJr64iH41PXWvg2lK/eOnHakg07mb3AXbnRGRkKx7HiFI3xt4/+AQQQ9DhQOQmqkx1IutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700053; c=relaxed/simple;
	bh=bNtD+cdVKaaX2mWWRDoiDi55mMME8xCgrM6UcxO3mRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsaAmR7y4AiMHAaa/m7iekz62Q84VnTcmrmVapXgmxQVgOCSNhnC1mtu7Z5kwhtfmyLxJoCDxKU7XHos/RgNiNMo8FNIi9DZPpK7/kIBGQ3zA4l7jmCjz1U0ytOadl/ZwGHQdb5XOQXfCudntBJJ3mX5fDVMn8sWbOou0ylxk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMqlQkx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F98C4CEE7;
	Wed, 20 Aug 2025 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755700053;
	bh=bNtD+cdVKaaX2mWWRDoiDi55mMME8xCgrM6UcxO3mRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMqlQkx0+xeis02YP2m79/gk0xBYcYVxtp1zWJ5XFh6rqsC4533d0UftfHYXVND9Z
	 ZhFsKnacQsz30fzXiwLwOOF8T8MM+R4yZ7nf/QgxZyD5Mj5d7zRyx5qUB79pCaslHv
	 SMfh0GjVX1d7z+PDazOeaeOM3LK9Bg4O2ChPkTXcVdEuhuGbc/vDPQJ3Xt0DAwV4Z6
	 cb2vgmOutGVzv9eO5IC1+8gwWAPhVT7QKIhMayAjCDLnAfsdrNo7C6JbsIlYz4wC7y
	 bxNG8M/RO32+MkuSDPlCD2QVGuIvV6cy2NYiQG6P/b1O44v1/nuvhPRg8qKqr1tmIa
	 oy7ieVd7YYd+A==
From: Chuck Lever <cel@kernel.org>
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/2] SUNRPC: Move the svc_rpcb_cleanup() call sites
Date: Wed, 20 Aug 2025 10:27:28 -0400
Message-ID: <20250820142729.89704-3-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250820142729.89704-1-cel@kernel.org>
References: <20250820142729.89704-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: because svc_rpcb_cleanup() and svc_xprt_destroy_all()
are always invoked in pairs, we can deduplicate code by moving
the svc_rpcb_cleanup() call sites into svc_xprt_destroy_all().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c                  | 6 ++----
 fs/nfs/callback.c               | 2 +-
 fs/nfsd/nfsctl.c                | 2 +-
 fs/nfsd/nfssvc.c                | 7 ++-----
 include/linux/sunrpc/svc_xprt.h | 3 ++-
 net/sunrpc/svc.c                | 1 -
 net/sunrpc/svc_xprt.c           | 7 ++++++-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index e80262a51884..d68afa196535 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -216,8 +216,7 @@ static int make_socks(struct svc_serv *serv, struct net *net,
 	if (warned++ == 0)
 		printk(KERN_WARNING
 			"lockd_up: makesock failed, error=%d\n", err);
-	svc_xprt_destroy_all(serv, net);
-	svc_rpcb_cleanup(serv, net);
+	svc_xprt_destroy_all(serv, net, true);
 	return err;
 }
 
@@ -255,8 +254,7 @@ static void lockd_down_net(struct svc_serv *serv, struct net *net)
 			nlm_shutdown_hosts_net(net);
 			cancel_delayed_work_sync(&ln->grace_period_end);
 			locks_end_grace(&ln->lockd_manager);
-			svc_xprt_destroy_all(serv, net);
-			svc_rpcb_cleanup(serv, net);
+			svc_xprt_destroy_all(serv, net, true);
 		}
 	} else {
 		pr_err("%s: no users! net=%x\n",
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 511f80878809..c8b837006bb2 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -136,7 +136,7 @@ static void nfs_callback_down_net(u32 minorversion, struct svc_serv *serv, struc
 		return;
 
 	dprintk("NFS: destroy per-net callback data; net=%x\n", net->ns.inum);
-	svc_xprt_destroy_all(serv, net);
+	svc_xprt_destroy_all(serv, net, false);
 }
 
 static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index bc6b776fc657..63d52edcad72 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1993,7 +1993,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 * remaining listeners and recreate the list.
 	 */
 	if (delete)
-		svc_xprt_destroy_all(serv, net);
+		svc_xprt_destroy_all(serv, net, false);
 
 	/* walk list of addrs again, open any that still don't exist */
 	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 82b0111ac469..7057ddd7a0a8 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -535,16 +535,13 @@ void nfsd_destroy_serv(struct net *net)
 #endif
 	}
 
-	svc_xprt_destroy_all(serv, net);
-
 	/*
 	 * write_ports can create the server without actually starting
-	 * any threads--if we get shut down before any threads are
+	 * any threads.  If we get shut down before any threads are
 	 * started, then nfsd_destroy_serv will be run before any of this
 	 * other initialization has been done except the rpcb information.
 	 */
-	svc_rpcb_cleanup(serv, net);
-
+	svc_xprt_destroy_all(serv, net, true);
 	nfsd_shutdown_net(net);
 	svc_destroy(&serv);
 }
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 369a89aea186..fde60d4e2cd5 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -165,7 +165,8 @@ int	svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 			struct net *net, const int family,
 			const unsigned short port, int flags,
 			const struct cred *cred);
-void	svc_xprt_destroy_all(struct svc_serv *serv, struct net *net);
+void	svc_xprt_destroy_all(struct svc_serv *serv, struct net *net,
+			     bool unregister);
 void	svc_xprt_received(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b1fab3a69544..9c7245d811eb 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -436,7 +436,6 @@ void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net)
 	svc_unregister(serv, net);
 	rpcb_put_local(net);
 }
-EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
 
 static int svc_uses_rpcbind(struct svc_serv *serv)
 {
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8b1837228799..049ab53088e9 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1102,6 +1102,7 @@ static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
  * svc_xprt_destroy_all - Destroy transports associated with @serv
  * @serv: RPC service to be shut down
  * @net: target network namespace
+ * @unregister: true if it is OK to unregister the destroyed xprts
  *
  * Server threads may still be running (especially in the case where the
  * service is still running in other network namespaces).
@@ -1114,7 +1115,8 @@ static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
  * threads, we may need to wait a little while and then check again to
  * see if they're done.
  */
-void svc_xprt_destroy_all(struct svc_serv *serv, struct net *net)
+void svc_xprt_destroy_all(struct svc_serv *serv, struct net *net,
+			  bool unregister)
 {
 	int delay = 0;
 
@@ -1124,6 +1126,9 @@ void svc_xprt_destroy_all(struct svc_serv *serv, struct net *net)
 		svc_clean_up_xprts(serv, net);
 		msleep(delay++);
 	}
+
+	if (unregister)
+		svc_rpcb_cleanup(serv, net);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_destroy_all);
 
-- 
2.50.0



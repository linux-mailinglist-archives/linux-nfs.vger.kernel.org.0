Return-Path: <linux-nfs+bounces-11880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB80AC2996
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530FE7B0ADC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D2298CD2;
	Fri, 23 May 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Udz168OE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5629995C;
	Fri, 23 May 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024636; cv=none; b=Df9SAM1NfujxslJ8UJi4Oteh/xemHTRC/Z5fkBwAdzYewyU1TYR16w8Hi279jotMhGiRLhGNHJAitrM0Nlo2c93s/jQPTEoyedJYScjoogi9MNbXNDCnIlOrFZtrKTlte+lfEuLYILgLB/GXlnrR2endzx8y/RA70gNhg4c8Ot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024636; c=relaxed/simple;
	bh=F0t3l4IZxkAYsOWJyzNF1rvRtwScyZYkRxoieYr7CqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcuphW7zyF1xevskKs4Uow1S+A8Xb3vPyS3+ZCI0erFzeEDShzMS7p6up2o/hwNCpMFelIfkeqZ29U0JV7R5yEqFC9Bc0qXuj/libxXQ6//smiwbzzYmA+vbNgbphlxRLHgZdbGxJtoI61dSUjx/LanUWub9zrnTk9hxVqxmhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Udz168OE; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024635; x=1779560635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NqDy5UPNcvwSJ+ktcHnTmTft8+/hWNC40l+bLvuZvUo=;
  b=Udz168OEB3t7kU/GxJzr4DfBM6N5mTLTt5O8mAA5D0JwGEnOwkhubw7l
   ySInigKJ4EnD3GZN6SPID4iGUwIJUuRu3Bxb+oT/KbQPwRuNusRmfqhcR
   pj34G7FtpVNR5zOuMd3Vxxkiy300VGmR0INoeCdxZ362fn1DPuYqKG6uR
   SF01H3QaCIZoEPS63VQn8ad/DrQr3XyFTQ9hBjJ13AgBXL5HiF+1CtP+X
   r1wzAjthmwBvdwNo/gt+oT6HJZsmYxC1EaT59LHiAhw07DYxl3ag/wY1K
   7IXr8BXPKDU9CcDAQFurt4az1pT+eCrdVLrrkrXFnK1zIe43ZDaYTpxsk
   g==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="523766238"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:23:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:27507]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.185:2525] with esmtp (Farcaster)
 id 49269a6c-743c-4409-b3a4-5e9f901e244e; Fri, 23 May 2025 18:23:53 +0000 (UTC)
X-Farcaster-Flow-ID: 49269a6c-743c-4409-b3a4-5e9f901e244e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:53 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	"Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	<netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>
Subject: [PATCH v2 net-next 5/7] socket: Remove kernel socket conversion except for net/rds/.
Date: Fri, 23 May 2025 11:21:11 -0700
Message-ID: <20250523182128.59346-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523182128.59346-1-kuniyu@amazon.com>
References: <20250523182128.59346-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
count the netns of kernel sockets."), TCP kernel socket has caused
many UAF.

We have converted such sockets to hold netns refcnt, and we have
the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.

  __sock_create_kern(..., &sock);
  sk_net_refcnt_upgrade(sock->sk);

Let's drop the conversion and use sock_create_kern() instead.

The changes for cifs, mptcp, nvme, and smc are straightforward.

For sunrpc, we call sk_net_refcnt_upgrade() for IPPROTO_TCP only
so we use sock_create_kern() for TCP and use __sock_create_kern()
for others.

For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
sockets.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>  # net/mptcp
Acked-by: Chuck Lever <chuck.lever@oracle.com>
---
v2: Drop unnecessary change for sunrpc and updated changelog for sunrpc
---
 drivers/nvme/host/tcp.c |  7 +++----
 fs/smb/client/connect.c | 12 ++----------
 net/mptcp/subflow.c     |  7 +------
 net/smc/af_smc.c        | 18 ++----------------
 net/sunrpc/svcsock.c    |  6 ++++--
 net/sunrpc/xprtsock.c   |  8 ++++----
 6 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3d3bdc5e280f..fabb1cc02564 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1756,9 +1756,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = __sock_create_kern(current->nsproxy->net_ns,
-				 ctrl->addr.ss_family, SOCK_STREAM,
-				 IPPROTO_TCP, &queue->sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       ctrl->addr.ss_family, SOCK_STREAM,
+			       IPPROTO_TCP, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1771,7 +1771,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		goto err_destroy_mutex;
 	}
 
-	sk_net_refcnt_upgrade(queue->sock->sk);
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index afac23a5a3ec..c7b4f5a7cca1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3348,22 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		socket = server->ssocket;
 	} else {
 		struct net *net = cifs_net_ns(server);
-		struct sock *sk;
 
-		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
-					IPPROTO_TCP, &server->ssocket);
+		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
+				      IPPROTO_TCP, &server->ssocket);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
 		}
 
-		sk = server->ssocket->sk;
-		__netns_tracker_free(net, &sk->ns_tracker, false);
-		net_passive_dec(net);
-		sk->sk_net_refcnt = 1;
-		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
-
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
 		socket = server->ssocket;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 602e689e991f..00e5cecb7683 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1757,7 +1757,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 
@@ -1770,11 +1770,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 * Update ns_tracker to current stack trace and refcounted tracker.
-	 */
-	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d998ffed1712..6140a9e386d0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3328,22 +3328,8 @@ static const struct proto_ops smc_sock_ops = {
 
 int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 {
-	struct smc_sock *smc = smc_sk(sk);
-	int rc;
-
-	rc = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
-				&smc->clcsock);
-	if (rc)
-		return rc;
-
-	/* smc_clcsock_release() does not wait smc->clcsock->sk's
-	 * destruction;  its sk_state might not be TCP_CLOSE after
-	 * smc->sk is close()d, and TCP timers can be fired later,
-	 * which need net ref.
-	 */
-	sk = smc->clcsock->sk;
-	sk_net_refcnt_upgrade(sk);
-	return 0;
+	return sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
+				&smc_sk(sk)->clcsock);
 }
 
 static int __smc_create(struct net *net, struct socket *sock, int protocol,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index adacfd03153a..10d83a03ccfa 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1516,7 +1516,10 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = __sock_create_kern(net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		error = sock_create_kern(net, family, type, protocol, &sock);
+	else
+		error = __sock_create_kern(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
@@ -1541,7 +1544,6 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	newlen = error;
 
 	if (protocol == IPPROTO_TCP) {
-		sk_net_refcnt_upgrade(sock->sk);
 		if ((error = kernel_listen(sock, 64)) < 0)
 			goto bummer;
 	}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 6fb921ce6cf2..f9576bd8f9c5 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1924,7 +1924,10 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	struct socket *sock;
 	int err;
 
-	err = __sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	if (protocol == IPPROTO_TCP)
+		err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	else
+		err = __sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
@@ -1941,9 +1944,6 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP)
-		sk_net_refcnt_upgrade(sock->sk);
-
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
 		return ERR_CAST(filp);
-- 
2.49.0



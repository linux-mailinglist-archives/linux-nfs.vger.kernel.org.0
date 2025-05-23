Return-Path: <linux-nfs+bounces-11881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57689AC2998
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68603A218A4
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B68299A97;
	Fri, 23 May 2025 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fRL7+9HH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB272298CAA;
	Fri, 23 May 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024663; cv=none; b=eYrBL6siYgdrRkeEm5s3pP2bFYmaCMMgcBklNiX99I5sKx8dR4AEJ89u1EeVoN6O4k8Y/Wi4TdVfX3//mhYYOHPagZ5CDQBlVXj2RDVlSis90HJq4VmZAT1IP62z2N2yVVnmK7QQn7MHdSCJlFpXxwE+g0Oubb69dF2T13WxywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024663; c=relaxed/simple;
	bh=yS0LHTUHjZeufGohZ/G1LkLYzmVuC8hQGvqm+fnY0h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPZGzcw8DtItuGcweEPmlLZ9zQXOERDJZiCVWo8B1QdI+jcZ7fNorBlfaHJFp7K2WOSwQ3Y/Pc4Jq/FjwIQwvnNA3JK5RuZFUBXjt0ot0BTbsM9JsnapaGYlDKxXaDcVGOSn+O3tW9/p/4bgC2vv6irqCwRDDQThLuFvzjSgF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fRL7+9HH; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024662; x=1779560662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mr+HGfc/NDHwPhm1cPT7tfkvFkLNtbK2fi3H5uBrWE=;
  b=fRL7+9HHm7TiqI9GR2iy5HhwBVIlbPiCzfPD9TIi964lhc2MuLMoUO/j
   KIUTxzdam2L6FFUOMLsGwrXcTi1743YvB//GobNT0CCnrsjfBWZn5iG2l
   PV9+8CCAgEY9n14VoUHaQyVXlC0exIRP827MPcenPsjldBXmbWW061ozE
   btilEHjaXrc+TAJQayzvC9PuK0EKASf3Gfb+RNceXYY8qNlT6UzOtdS+l
   nfPkb8nWJfMj+kv6kjttMuUM6+YAOcj7C+abhZn0TrefFopGVHAejnYul
   llcWPRMT70Pc9kmZ2fARind5rjxre54IsJ6KeOQUB7W3F5x7uJhwD3cFb
   w==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="53385123"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:24:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:31257]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.213:2525] with esmtp (Farcaster)
 id e2a6872f-6eeb-4ec2-af08-c555d6bd2020; Fri, 23 May 2025 18:24:19 +0000 (UTC)
X-Farcaster-Flow-ID: e2a6872f-6eeb-4ec2-af08-c555d6bd2020
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:24:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:24:15 +0000
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
Subject: [PATCH v2 net-next 6/7] socket: Replace most sock_create() calls with sock_create_kern().
Date: Fri, 23 May 2025 11:21:12 -0700
Message-ID: <20250523182128.59346-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Except for only one user, sctp_do_peeloff(), all sockets created
by drivers and fs are not tied to userspace processes nor exposed
via file descriptors.

Let's use sock_create_kern() for such in-kernel use cases as CIFS
client and NFS.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/infiniband/hw/erdma/erdma_cm.c    | 6 ++++--
 drivers/infiniband/sw/siw/siw_cm.c        | 6 ++++--
 drivers/isdn/mISDN/l1oip_core.c           | 3 ++-
 drivers/nvme/target/tcp.c                 | 5 +++--
 drivers/target/iscsi/iscsi_target_login.c | 7 ++++---
 drivers/xen/pvcalls-back.c                | 6 ++++--
 fs/ocfs2/cluster/tcp.c                    | 8 +++++---
 fs/smb/server/transport_tcp.c             | 7 ++++---
 8 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index e0acc185e719..cec758cec7fd 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -1026,7 +1026,8 @@ int erdma_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		return -ENOENT;
 	erdma_qp_get(qp);
 
-	ret = sock_create(AF_INET, SOCK_STREAM, IPPROTO_TCP, &s);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       AF_INET, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (ret < 0)
 		goto error_put_qp;
 
@@ -1305,7 +1306,8 @@ int erdma_create_listen(struct iw_cm_id *id, int backlog)
 	if (addr_family != AF_INET)
 		return -EAFNOSUPPORT;
 
-	ret = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 708b13993fdf..bea948640aba 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1391,7 +1391,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_dbg_qp(qp, "pd_len %d, laddr %pISp, raddr %pISp\n", pd_len, laddr,
 		   raddr);
 
-	rv = sock_create(v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
+	rv = sock_create_kern(current->nsproxy->net_ns,
+			      v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0)
 		goto error;
 
@@ -1767,7 +1768,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	if (addr_family != AF_INET && addr_family != AF_INET6)
 		return -EAFNOSUPPORT;
 
-	rv = sock_create(addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
+	rv = sock_create_kern(current->nsproxy->net_ns,
+			      addr_family, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0)
 		return rv;
 
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index a5ad88a960d0..1451ec859a32 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -659,7 +659,8 @@ l1oip_socket_thread(void *data)
 	allow_signal(SIGTERM);
 
 	/* create socket */
-	if (sock_create(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &socket)) {
+	if (sock_create_kern(current->nsproxy->net_ns,
+			     PF_INET, SOCK_DGRAM, IPPROTO_UDP, &socket)) {
 		printk(KERN_ERR "%s: Failed to create socket.\n", __func__);
 		ret = -EIO;
 		goto fail;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 12a5cb8641ca..4e499df746f4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2078,8 +2078,9 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
-	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       port->addr.ss_family, SOCK_STREAM,
+			       IPPROTO_TCP, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index c2ac9a99ebbb..c085a3aaca6e 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -796,10 +796,11 @@ int iscsit_setup_np(
 		return -EINVAL;
 	}
 
-	ret = sock_create(sockaddr->ss_family, np->np_sock_type,
-			np->np_ip_proto, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       sockaddr->ss_family, np->np_sock_type,
+			       np->np_ip_proto, &sock);
 	if (ret < 0) {
-		pr_err("sock_create() failed.\n");
+		pr_err("sock_create_kern() failed.\n");
 		return ret;
 	}
 	np->np_socket = sock;
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index fd7ed65e0197..c404678e1924 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -406,7 +406,8 @@ static int pvcalls_back_connect(struct xenbus_device *dev,
 	    sa->sa_family != AF_INET)
 		goto out;
 
-	ret = sock_create(AF_INET, SOCK_STREAM, 0, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       AF_INET, SOCK_STREAM, 0, &sock);
 	if (ret < 0)
 		goto out;
 	ret = inet_stream_connect(sock, sa, req->u.connect.len, 0);
@@ -646,7 +647,8 @@ static int pvcalls_back_bind(struct xenbus_device *dev,
 		goto out;
 	}
 
-	ret = sock_create(AF_INET, SOCK_STREAM, 0, &map->sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       AF_INET, SOCK_STREAM, 0, &map->sock);
 	if (ret < 0)
 		goto out;
 
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index fce9beb214f0..491916662561 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1558,7 +1558,7 @@ static void o2net_start_connect(struct work_struct *work)
 	unsigned int nofs_flag;
 
 	/*
-	 * sock_create allocates the sock with GFP_KERNEL. We must
+	 * sock_create_kern() allocates the sock with GFP_KERNEL. We must
 	 * prevent the filesystem from being reentered by memory reclaim.
 	 */
 	nofs_flag = memalloc_nofs_save();
@@ -1600,7 +1600,8 @@ static void o2net_start_connect(struct work_struct *work)
 		goto out;
 	}
 
-	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		mlog(0, "can't create socket: %d\n", ret);
 		goto out;
@@ -1984,7 +1985,8 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 		.sin_port = port,
 	};
 
-	ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			       PF_INET, SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		printk(KERN_ERR "o2net: Error %d while creating socket\n", ret);
 		goto out;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index abedf510899a..e1e9cbe5742f 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -427,18 +427,19 @@ static void tcp_destroy_socket(struct socket *ksmbd_socket)
  */
 static int create_socket(struct interface *iface)
 {
+	struct net *net = current->nsproxy->net_ns;
 	int ret;
 	struct sockaddr_in6 sin6;
 	struct sockaddr_in sin;
 	struct socket *ksmbd_socket;
 	bool ipv4 = false;
 
-	ret = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
+	ret = sock_create_kern(net, PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
 	if (ret) {
 		if (ret != -EAFNOSUPPORT)
 			pr_err("Can't create socket for ipv6, fallback to ipv4: %d\n", ret);
-		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
-				  &ksmbd_socket);
+		ret = sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
+				       &ksmbd_socket);
 		if (ret) {
 			pr_err("Can't create socket for ipv4: %d\n", ret);
 			goto out_clear;
-- 
2.49.0



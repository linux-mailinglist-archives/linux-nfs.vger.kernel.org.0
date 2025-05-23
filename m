Return-Path: <linux-nfs+bounces-11877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19300AC2989
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9CB17BEFC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D69296FCE;
	Fri, 23 May 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="npJNqaG/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937122A1E1;
	Fri, 23 May 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024563; cv=none; b=s28oYpvuy0Mo5MorJAeTzBANhoRfFkVmpczafQyz5i7yZYf6rySbSrNKZdpewO3amIuxtqijH+VzQW1mrfMUwEN+QryUAhWZ8wNse0+U73wKbOtxZNRsuzBXlPJUDfL8pSxBofqGRge9HQnQxPCDUPaSPHbt0YVgKm4+joVfG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024563; c=relaxed/simple;
	bh=vdgti3s5WToSGcgbDfO7ZRNQikbmpXyA8bEIy1eouTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4zUlsHtBZJYjcFuwJdFz/T/lDWrxr9OONXbhDIBJmdLG51HVnYWkfdNqwZ6jYPiNfizZcKZ2pU+5BLZKwfNIKPsIrpfJfRWmsIZtNpFoPBZfVhr3meNR5xX8OE93zmEP3xjvGDNoCIOoHsRgXEoq/9qhwIsQwXdbV0Kr3wCiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=npJNqaG/; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024561; x=1779560561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=klaKlBfbHk1HR8VslYc/ePbaG0TAU0D1gywW5hHVMuw=;
  b=npJNqaG/H14UnteEAWx6EAlB7aOepJAjkJO/E9U9nVHf2Mbl+cpuGdZ+
   21suuhDWmXEHp8SQnCVFRrC0LEJF9RYCa1XO2pSiKvdFF+NcJVmJUCI+U
   1aq9wUGdTly3QEiYG84RpR2Wyr9A4hy17gZsT7xnoOW7JTYTVP4LRftS2
   AQPMZKa0M67IFi0oLPdr+AvS9glsPpfrg5KuqwqpWQa3FLcC1pWDI5nNa
   cKFwYuw/Ia0beYfJqg8fLwH58vAQw0HYlRzNEzoR2UZcjQ6hGdElSJpw9
   oPM3XJv8iuosVVUNnE1KEasVRgbSJb6jPCZOYUE+5P8W5ipGcWiPdjQIX
   w==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="827934697"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:22:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:64658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.53:2525] with esmtp (Farcaster)
 id 5f918d04-2ff3-4b76-b268-cad0d6acd104; Fri, 23 May 2025 18:22:35 +0000 (UTC)
X-Farcaster-Flow-ID: 5f918d04-2ff3-4b76-b268-cad0d6acd104
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:22:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:22:30 +0000
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
Subject: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to __sock_create_kern().
Date: Fri, 23 May 2025 11:21:08 -0700
Message-ID: <20250523182128.59346-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_create_kern() is a catchy name and often chosen by non-networking
developers to create kernel sockets.  But due to its poor documentation,
it has caused a bunch of netns use-after-free:

  * commit ef7134c7fc48 ("smb: client: Fix use-after-free of network
     namespace.")
  * commit b013b817f32f ("nvme-tcp: fix use-after-free of netns by
     kernel TCP socket.")
  .. and more in NFS, SMC, MPTCP, RDS

Some non-networking maintainers mentioned that the socket API should
be more robust to prevent this type of issues. [0]

The current sock_create_kern() doesn't hold a reference to the netns,
which allows the netns to be removed while the socket is still around.
This is useful when the socket is used as the backend for a networking
device.

But, this is rather a special case, where netdev folks should use a
dedicated API, and we should provide sock_create_kern() as the standard
API for general in-kernel use cases.

In fact, we did so before commit 26abe14379f8 ("net: Modify sk_alloc
to not reference count the netns of kernel sockets."),

  sock_create_kern(&init_net, ..., &sock)
  sk_change_net(sock->sk, net);

but that implicit API change ended up causing a lot of problems.

Let's rename sock_create_kern() to __sock_create_kern() as a special
API and add a fat documentation.

The next patch will add sock_create_kern() that holds netns refcnt.

Link: https://lore.kernel.org/lkml/20250409084446.GA2771@lst.de/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>  # net/mptcp
Acked-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/block/drbd/drbd_receiver.c            | 12 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c            |  2 +-
 drivers/nvme/host/tcp.c                       |  6 +--
 drivers/soc/qcom/qmi_interface.c              |  4 +-
 fs/afs/rxrpc.c                                |  2 +-
 fs/dlm/lowcomms.c                             |  8 ++--
 fs/smb/client/connect.c                       |  4 +-
 include/linux/net.h                           |  3 +-
 net/9p/trans_fd.c                             |  8 ++--
 net/bluetooth/rfcomm/core.c                   |  3 +-
 net/ceph/messenger.c                          |  6 +--
 net/handshake/handshake-test.c                |  2 +-
 net/ipv4/af_inet.c                            |  2 +-
 net/ipv4/udp_tunnel_core.c                    |  2 +-
 net/ipv6/ip6_udp_tunnel.c                     |  2 +-
 net/l2tp/l2tp_core.c                          |  8 ++--
 net/mctp/test/route-test.c                    |  6 +--
 net/mptcp/pm_kernel.c                         |  4 +-
 net/mptcp/subflow.c                           |  4 +-
 net/netfilter/ipvs/ip_vs_sync.c               |  8 ++--
 net/qrtr/ns.c                                 |  6 +--
 net/rds/tcp_connect.c                         |  8 ++--
 net/rds/tcp_listen.c                          |  4 +-
 net/rxrpc/rxperf.c                            |  4 +-
 net/sctp/socket.c                             |  2 +-
 net/smc/af_smc.c                              |  4 +-
 net/smc/smc_inet.c                            |  2 +-
 net/socket.c                                  | 37 +++++++++++++------
 net/sunrpc/clnt.c                             |  4 +-
 net/sunrpc/svcsock.c                          |  2 +-
 net/sunrpc/xprtsock.c                         |  6 +--
 net/tipc/topsrv.c                             |  4 +-
 net/wireless/nl80211.c                        |  4 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +-
 34 files changed, 102 insertions(+), 85 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e5a2e5f7887b..3e4619fad8c8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -618,9 +618,9 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	peer_addr_len = min_t(int, connection->peer_addr_len, sizeof(src_in6));
 	memcpy(&peer_in6, &connection->peer_addr, peer_addr_len);
 
-	what = "sock_create_kern";
-	err = sock_create_kern(&init_net, ((struct sockaddr *)&src_in6)->sa_family,
-			       SOCK_STREAM, IPPROTO_TCP, &sock);
+	what = "__sock_create_kern";
+	err = __sock_create_kern(&init_net, ((struct sockaddr *)&src_in6)->sa_family,
+				 SOCK_STREAM, IPPROTO_TCP, &sock);
 	if (err < 0) {
 		sock = NULL;
 		goto out;
@@ -713,9 +713,9 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 	my_addr_len = min_t(int, connection->my_addr_len, sizeof(struct sockaddr_in6));
 	memcpy(&my_addr, &connection->my_addr, my_addr_len);
 
-	what = "sock_create_kern";
-	err = sock_create_kern(&init_net, ((struct sockaddr *)&my_addr)->sa_family,
-			       SOCK_STREAM, IPPROTO_TCP, &s_listen);
+	what = "__sock_create_kern";
+	err = __sock_create_kern(&init_net, ((struct sockaddr *)&my_addr)->sa_family,
+				 SOCK_STREAM, IPPROTO_TCP, &s_listen);
 	if (err) {
 		s_listen = NULL;
 		goto out;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 7975fb0e2782..b4df63fdabad 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -241,7 +241,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	/* if we don't finish qp create make sure queue is valid */
 	skb_queue_head_init(&qp->req_pkts);
 
-	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
+	err = __sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
 		return err;
 	qp->sk->sk->sk_user_data = (void *)(uintptr_t)qp->elem.index;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8ae6cc2280ca..3d3bdc5e280f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1756,9 +1756,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create_kern(current->nsproxy->net_ns,
-			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+	ret = __sock_create_kern(current->nsproxy->net_ns,
+				 ctrl->addr.ss_family, SOCK_STREAM,
+				 IPPROTO_TCP, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index bc6d6379d8b1..c8339985b2fe 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -588,8 +588,8 @@ static struct socket *qmi_sock_create(struct qmi_handle *qmi,
 	struct socket *sock;
 	int ret;
 
-	ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
-			       PF_QIPCRTR, &sock);
+	ret = __sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
+				 PF_QIPCRTR, &sock);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index c1cadf8fb346..9b54cba9b751 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -53,7 +53,7 @@ int afs_open_socket(struct afs_net *net)
 
 	_enter("");
 
-	ret = sock_create_kern(net->net, AF_RXRPC, SOCK_DGRAM, PF_INET6, &socket);
+	ret = __sock_create_kern(net->net, AF_RXRPC, SOCK_DGRAM, PF_INET6, &socket);
 	if (ret < 0)
 		goto error_1;
 
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 70abd4da17a6..9086c3807a94 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1580,8 +1580,8 @@ static int dlm_connect(struct connection *con)
 	}
 
 	/* Create a socket to communicate with */
-	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
-				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
+	result = __sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
+				    SOCK_STREAM, dlm_proto_ops->proto, &sock);
 	if (result < 0)
 		return result;
 
@@ -1761,8 +1761,8 @@ static int dlm_listen_for_all(void)
 	if (result < 0)
 		return result;
 
-	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
-				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
+	result = __sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
+				    SOCK_STREAM, dlm_proto_ops->proto, &sock);
 	if (result < 0) {
 		log_print("Can't create comms socket: %d", result);
 		return result;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c251a23a6447..37a2ba38f10e 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3350,8 +3350,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		struct net *net = cifs_net_ns(server);
 		struct sock *sk;
 
-		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
-				      IPPROTO_TCP, &server->ssocket);
+		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
+					IPPROTO_TCP, &server->ssocket);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
diff --git a/include/linux/net.h b/include/linux/net.h
index 26aaaa841f48..12180e00f882 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -252,7 +252,8 @@ int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
 bool sock_is_registered(int family);
 int sock_create(int family, int type, int proto, struct socket **res);
-int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
+int __sock_create_kern(struct net *net, int family, int type, int proto,
+		       struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 842977f309b3..728d60904a20 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1007,8 +1007,8 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 	client->trans_opts.tcp.port = opts.port;
 	client->trans_opts.tcp.privport = opts.privport;
 
-	err = sock_create_kern(current->nsproxy->net_ns, stor.ss_family,
-			       SOCK_STREAM, IPPROTO_TCP, &csocket);
+	err = __sock_create_kern(current->nsproxy->net_ns, stor.ss_family,
+				 SOCK_STREAM, IPPROTO_TCP, &csocket);
 	if (err) {
 		pr_err("%s (%d): problem creating socket\n",
 		       __func__, task_pid_nr(current));
@@ -1058,8 +1058,8 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 	sun_server.sun_family = PF_UNIX;
 	strcpy(sun_server.sun_path, addr);
-	err = sock_create_kern(current->nsproxy->net_ns, PF_UNIX,
-			       SOCK_STREAM, 0, &csocket);
+	err = __sock_create_kern(current->nsproxy->net_ns, PF_UNIX,
+				 SOCK_STREAM, 0, &csocket);
 	if (err < 0) {
 		pr_err("%s (%d): problem creating socket\n",
 		       __func__, task_pid_nr(current));
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 20ea7dba0a9a..7ee7203aae22 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -200,7 +200,8 @@ static int rfcomm_l2sock_create(struct socket **sock)
 
 	BT_DBG("");
 
-	err = sock_create_kern(&init_net, PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP, sock);
+	err = __sock_create_kern(&init_net, PF_BLUETOOTH, SOCK_SEQPACKET,
+				 BTPROTO_L2CAP, sock);
 	if (!err) {
 		struct sock *sk = (*sock)->sk;
 		sk->sk_data_ready   = rfcomm_l2data_ready;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d1b5705dc0c6..84da1ca9ce82 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -442,10 +442,10 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	     ceph_pr_addr(&con->peer_addr));
 	BUG_ON(con->sock);
 
-	/* sock_create_kern() allocates with GFP_KERNEL */
+	/* __sock_create_kern() allocates with GFP_KERNEL */
 	noio_flag = memalloc_noio_save();
-	ret = sock_create_kern(read_pnet(&con->msgr->net), ss.ss_family,
-			       SOCK_STREAM, IPPROTO_TCP, &sock);
+	ret = __sock_create_kern(read_pnet(&con->msgr->net), ss.ss_family,
+				 SOCK_STREAM, IPPROTO_TCP, &sock);
 	memalloc_noio_restore(noio_flag);
 	if (ret)
 		return ret;
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 4f300504f3e5..d78fc3a8520d 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -145,7 +145,7 @@ static void handshake_req_alloc_case(struct kunit *test)
 
 static int handshake_sock_create(struct socket **sock)
 {
-	return sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, sock);
+	return __sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP, sock);
 }
 
 static void handshake_req_submit_test1(struct kunit *test)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..9b666648d621 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1631,7 +1631,7 @@ int inet_ctl_sock_create(struct sock **sk, unsigned short family,
 			 struct net *net)
 {
 	struct socket *sock;
-	int rc = sock_create_kern(net, family, type, protocol, &sock);
+	int rc = __sock_create_kern(net, family, type, protocol, &sock);
 
 	if (rc == 0) {
 		*sk = sock->sk;
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 2326548997d3..6fd3f1df882b 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -15,7 +15,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 	struct socket *sock = NULL;
 	struct sockaddr_in udp_addr;
 
-	err = sock_create_kern(net, AF_INET, SOCK_DGRAM, 0, &sock);
+	err = __sock_create_kern(net, AF_INET, SOCK_DGRAM, 0, &sock);
 	if (err < 0)
 		goto error;
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..34ba859d82b9 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -21,7 +21,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 	int err;
 	struct socket *sock = NULL;
 
-	err = sock_create_kern(net, AF_INET6, SOCK_DGRAM, 0, &sock);
+	err = __sock_create_kern(net, AF_INET6, SOCK_DGRAM, 0, &sock);
 	if (err < 0)
 		goto error;
 
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 369a2f2e459c..0f347775a8b4 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1494,8 +1494,8 @@ static int l2tp_tunnel_sock_create(struct net *net,
 		if (cfg->local_ip6 && cfg->peer_ip6) {
 			struct sockaddr_l2tpip6 ip6_addr = {0};
 
-			err = sock_create_kern(net, AF_INET6, SOCK_DGRAM,
-					       IPPROTO_L2TP, &sock);
+			err = __sock_create_kern(net, AF_INET6, SOCK_DGRAM,
+						 IPPROTO_L2TP, &sock);
 			if (err < 0)
 				goto out;
 
@@ -1522,8 +1522,8 @@ static int l2tp_tunnel_sock_create(struct net *net,
 		{
 			struct sockaddr_l2tpip ip_addr = {0};
 
-			err = sock_create_kern(net, AF_INET, SOCK_DGRAM,
-					       IPPROTO_L2TP, &sock);
+			err = __sock_create_kern(net, AF_INET, SOCK_DGRAM,
+						 IPPROTO_L2TP, &sock);
 			if (err < 0)
 				goto out;
 
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 06c1897b685a..faa6f682f078 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -310,7 +310,7 @@ static void __mctp_route_test_init(struct kunit *test,
 	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
-	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	rc = __sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	addr.smctp_family = AF_MCTP;
@@ -568,7 +568,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
-	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	rc = __sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	msk = container_of(sock->sk, struct mctp_sock, sk);
@@ -1186,7 +1186,7 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	rt = mctp_test_create_route(&init_net, dev->mdev, dst, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
-	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
+	rc = __sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
 	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d39e7c178460..a7467497de0f 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -637,8 +637,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	int backlog = 1024;
 	int err;
 
-	err = sock_create_kern(sock_net(sk), entry->addr.family,
-			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
+	err = __sock_create_kern(sock_net(sk), entry->addr.family,
+				 SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
 	if (err)
 		return err;
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15613d691bfe..602e689e991f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1757,7 +1757,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
+	err = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 
@@ -1948,7 +1948,7 @@ static int subflow_ulp_init(struct sock *sk)
 	int err = 0;
 
 	/* disallow attaching ULP to a socket unless it has been
-	 * created with sock_create_kern()
+	 * created with __sock_create_kern()
 	 */
 	if (!sk->sk_kern_sock) {
 		err = -EOPNOTSUPP;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3402675bf521..6c55471846cb 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1470,8 +1470,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	int result, salen;
 
 	/* First create a socket */
-	result = sock_create_kern(ipvs->net, ipvs->mcfg.mcast_af, SOCK_DGRAM,
-				  IPPROTO_UDP, &sock);
+	result = __sock_create_kern(ipvs->net, ipvs->mcfg.mcast_af, SOCK_DGRAM,
+				    IPPROTO_UDP, &sock);
 	if (result < 0) {
 		pr_err("Error during creation of socket; terminating\n");
 		goto error;
@@ -1527,8 +1527,8 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 	int result, salen;
 
 	/* First create a socket */
-	result = sock_create_kern(ipvs->net, ipvs->bcfg.mcast_af, SOCK_DGRAM,
-				  IPPROTO_UDP, &sock);
+	result = __sock_create_kern(ipvs->net, ipvs->bcfg.mcast_af, SOCK_DGRAM,
+				    IPPROTO_UDP, &sock);
 	if (result < 0) {
 		pr_err("Error during creation of socket; terminating\n");
 		goto error;
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3de9350cbf30..3496357b8650 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -692,8 +692,8 @@ int qrtr_ns_init(void)
 	INIT_LIST_HEAD(&qrtr_ns.lookups);
 	INIT_WORK(&qrtr_ns.work, qrtr_ns_worker);
 
-	ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
-			       PF_QIPCRTR, &qrtr_ns.sock);
+	ret = __sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
+				 PF_QIPCRTR, &qrtr_ns.sock);
 	if (ret < 0)
 		return ret;
 
@@ -735,7 +735,7 @@ int qrtr_ns_init(void)
 	 *  qrtr module is inserted successfully.
 	 *
 	 * However, the reference count is increased twice in
-	 * sock_create_kern(): one is to increase the reference count of owner
+	 * __sock_create_kern(): one is to increase the reference count of owner
 	 * of qrtr socket's proto_ops struct; another is to increment the
 	 * reference count of owner of qrtr proto struct. Therefore, we must
 	 * decrement the module reference count twice to ensure that it keeps
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index a0046e99d6df..717e76e16a23 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -112,12 +112,12 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		return 0;
 	}
 	if (ipv6_addr_v4mapped(&conn->c_laddr)) {
-		ret = sock_create_kern(rds_conn_net(conn), PF_INET,
-				       SOCK_STREAM, IPPROTO_TCP, &sock);
+		ret = __sock_create_kern(rds_conn_net(conn), PF_INET,
+					 SOCK_STREAM, IPPROTO_TCP, &sock);
 		isv6 = false;
 	} else {
-		ret = sock_create_kern(rds_conn_net(conn), PF_INET6,
-				       SOCK_STREAM, IPPROTO_TCP, &sock);
+		ret = __sock_create_kern(rds_conn_net(conn), PF_INET6,
+					 SOCK_STREAM, IPPROTO_TCP, &sock);
 		isv6 = true;
 	}
 
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d89bd8d0c354..9569b85fc596 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -278,8 +278,8 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 	int addr_len;
 	int ret;
 
-	ret = sock_create_kern(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
-			       IPPROTO_TCP, &sock);
+	ret = __sock_create_kern(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
+				 IPPROTO_TCP, &sock);
 	if (ret < 0) {
 		rdsdebug("could not create %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 0377301156b0..40af834a7ff7 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -188,8 +188,8 @@ static int rxperf_open_socket(void)
 	struct socket *socket;
 	int ret;
 
-	ret = sock_create_kern(&init_net, AF_RXRPC, SOCK_DGRAM, PF_INET6,
-			       &socket);
+	ret = __sock_create_kern(&init_net, AF_RXRPC, SOCK_DGRAM, PF_INET6,
+				 &socket);
 	if (ret < 0)
 		goto error_1;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 90b75d4ec329..3249e0680235 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1329,7 +1329,7 @@ static int __sctp_setsockopt_connectx(struct sock *sk, struct sockaddr *kaddrs,
 		return err;
 
 	/* in-kernel sockets don't generally have a file allocated to them
-	 * if all they do is call sock_create_kern().
+	 * if all they do is call __sock_create_kern().
 	 */
 	if (sk->sk_socket->file)
 		flags = sk->sk_socket->file->f_flags;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3760131f1484..d998ffed1712 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3331,8 +3331,8 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 	struct smc_sock *smc = smc_sk(sk);
 	int rc;
 
-	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
-			      &smc->clcsock);
+	rc = __sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
+				&smc->clcsock);
 	if (rc)
 		return rc;
 
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a944e7dcb8b9..5dba8c0aa9fc 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -111,7 +111,7 @@ static struct inet_protosw smc_inet6_protosw = {
 static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
 {
 	/* No need pass it through to clcsock, mss can always be set by
-	 * sock_create_kern or smc_setsockopt.
+	 * __sock_create_kern or smc_setsockopt.
 	 */
 	return 0;
 }
diff --git a/net/socket.c b/net/socket.c
index 241d9767ae69..7c4474c966c0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1600,22 +1600,37 @@ int sock_create(int family, int type, int protocol, struct socket **res)
 EXPORT_SYMBOL(sock_create);
 
 /**
- *	sock_create_kern - creates a socket (kernel space)
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * __sock_create_kern - creates a socket for kernel space
  *
- *	A wrapper around __sock_create().
- *	Returns 0 or an error. This function internally uses GFP_KERNEL.
+ * @net: net namespace
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res.
+ *
+ * The socket is for kernel space and should not be exposed to
+ * userspace via a file descriptor nor BPF hooks except for LSM
+ * (see inet_create(), inet_release(), etc).
+ *
+ * The socket bypasses some LSMs that take care of @kern in
+ * security_socket_create() and security_socket_post_create().
+ *
+ * The socket **DOES NOT** hold a reference count of @net to allow
+ * it to be removed; the caller MUST ensure that the socket is always
+ * freed before @net.
+ *
+ * @net MUST be alive as of calling __sock_create_kern().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
  */
-
-int sock_create_kern(struct net *net, int family, int type, int protocol, struct socket **res)
+int __sock_create_kern(struct net *net, int family, int type, int protocol, struct socket **res)
 {
 	return __sock_create(net, family, type, protocol, res, 1);
 }
-EXPORT_SYMBOL(sock_create_kern);
+EXPORT_SYMBOL(__sock_create_kern);
 
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index f9f340171530..e567776a53ab 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1455,8 +1455,8 @@ static int rpc_sockname(struct net *net, struct sockaddr *sap, size_t salen,
 	struct socket *sock;
 	int err;
 
-	err = sock_create_kern(net, sap->sa_family,
-			       SOCK_DGRAM, IPPROTO_UDP, &sock);
+	err = __sock_create_kern(net, sap->sa_family,
+				 SOCK_DGRAM, IPPROTO_UDP, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create UDP socket (%d)\n", err);
 		goto out;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e2c69ab17ac5..adacfd03153a 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1516,7 +1516,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = sock_create_kern(net, family, type, protocol, &sock);
+	error = __sock_create_kern(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 5ffe88145193..6fb921ce6cf2 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1924,7 +1924,7 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	struct socket *sock;
 	int err;
 
-	err = sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
+	err = __sock_create_kern(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
@@ -1999,8 +1999,8 @@ static int xs_local_setup_socket(struct sock_xprt *transport)
 	struct socket *sock;
 	int status;
 
-	status = sock_create_kern(xprt->xprt_net, AF_LOCAL,
-				  SOCK_STREAM, 0, &sock);
+	status = __sock_create_kern(xprt->xprt_net, AF_LOCAL,
+				    SOCK_STREAM, 0, &sock);
 	if (status < 0) {
 		dprintk("RPC:       can't create AF_LOCAL "
 			"transport socket (%d).\n", -status);
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 8ee0c07d00e9..f970659a04f1 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -515,7 +515,7 @@ static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 	struct sock *sk;
 	int rc;
 
-	rc = sock_create_kern(srv->net, AF_TIPC, SOCK_SEQPACKET, 0, &lsock);
+	rc = __sock_create_kern(srv->net, AF_TIPC, SOCK_SEQPACKET, 0, &lsock);
 	if (rc < 0)
 		return rc;
 
@@ -553,7 +553,7 @@ static int tipc_topsrv_create_listener(struct tipc_topsrv *srv)
 	 * after TIPC module is inserted successfully.
 	 *
 	 * However, the reference count is ever increased twice in
-	 * sock_create_kern(): one is to increase the reference count of owner
+	 * __sock_create_kern(): one is to increase the reference count of owner
 	 * of TIPC socket's proto_ops struct; another is to increment the
 	 * reference count of owner of TIPC proto struct. Therefore, we must
 	 * decrement the module reference count twice to ensure that it keeps
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 98a7298e427d..22607a34be71 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13750,8 +13750,8 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
 	port = nla_get_u16_default(tb[NL80211_WOWLAN_TCP_SRC_PORT], 0);
 #ifdef CONFIG_INET
 	/* allocate a socket and port for it and use it */
-	err = sock_create_kern(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
-			       IPPROTO_TCP, &cfg->sock);
+	err = __sock_create_kern(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
+				 IPPROTO_TCP, &cfg->sock);
 	if (err) {
 		kfree(cfg);
 		return err;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 3220f1d28697..a2351a92069d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -804,8 +804,8 @@ __bpf_kfunc int bpf_kfunc_init_sock(struct init_sock_args *args)
 		goto out;
 	}
 
-	err = sock_create_kern(current->nsproxy->net_ns, args->af, args->type,
-			       proto, &sock);
+	err = __sock_create_kern(current->nsproxy->net_ns, args->af, args->type,
+				 proto, &sock);
 
 	if (!err)
 		/* Set timeout for call to kernel_connect() to prevent it from hanging,
-- 
2.49.0



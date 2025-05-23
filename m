Return-Path: <linux-nfs+bounces-11878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A1AC298E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A78F544190
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF13299956;
	Fri, 23 May 2025 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XAtF7zbJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE3298CAA;
	Fri, 23 May 2025 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024590; cv=none; b=emEkAX1bKNdEoVtP5kZNwcivD7UXOesKxrpRr/N9JedaQ3BLQYuUHytsCuofoQ6V/AisHs6p8WO4QzGLhFOT7ST/TE8Vg90+chkIW8mKk9Cd/XCMo1mvH9eYPuHXoaSJGvQGQKpu9xnJyp70VUfUVGt39On6+xnN/urv5oUCTTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024590; c=relaxed/simple;
	bh=IVvsGgdag82cjmXQvWKN347LsX2vMIVusNuKZpsVtUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBmK4Mr5YjYXNBp5uqh9ZEQFV+z3tRwThzh3RkeAjq3XlWH6GaJKSyvjCBfNsVPdqESNMiBYFDYmwbs4meS3z5Aag2hSxLcz12iYFrqV++ow1gBgeXbZPBL+eCFU2FdoyM00mPZY/y+7xz7JIsog22MYMy+VQYkq5AveCSAzYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XAtF7zbJ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024589; x=1779560589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVv00rElFcQlgyf5ZIGQk3aMx2dIRPcRXeEVzmqzmBU=;
  b=XAtF7zbJ1xLkwWkInozOTH7+R32+2mw8yrrZQ/KV/fHcJk7Ri3Jd6zi+
   tXVJ0av9jonrW25PD+gfuRfgtxbWNgNOKmHbP8wKo6yHvjOmCu6b8r2FI
   LaoNA1OV44ISq+kuqdLArSQWak0IQRzG/hne5zJeEfx4um7iD4/5UvqBx
   X5Gu36S7F6nU7PCgSsJ7xxub55D4ZlESP8YB+eo58eP3+lhCtxTASYzow
   9c6sQshFuLz3jP8zZoLtdu6ATe/0K+kOVMTJL8YoEM59G8Sb/qcDIxBCA
   X5MgvW7DnsJPwYGiSZ0u1VKbczykNIFgAOqCo3SCly9jlXnzDydyqGv/8
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="523766039"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:23:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:18801]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.213:2525] with esmtp (Farcaster)
 id 363f85c8-889b-4702-93ed-d1b434c006f5; Fri, 23 May 2025 18:23:01 +0000 (UTC)
X-Farcaster-Flow-ID: 363f85c8-889b-4702-93ed-d1b434c006f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:22:56 +0000
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
Subject: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Date: Fri, 23 May 2025 11:21:09 -0700
Message-ID: <20250523182128.59346-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's restore sock_create_kern() that holds a netns reference.

Now, it's the same as the version before commit 26abe14379f8 ("net:
Modify sk_alloc to not reference count the netns of kernel sockets.").

Back then, after creating a socket in init_net, we used sk_change_net()
to drop the netns ref and switch to another netns, but now we can
simply use __sock_create_kern() instead.

  $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~

DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
from __net_init functions, since doing so would leak the netns as
__net_exit functions cannot run until the socket is removed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2: s/ret/err/ in sock_create_kern() for clarity
---
 include/linux/net.h |  2 ++
 net/socket.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index 12180e00f882..b60e3afab344 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -254,6 +254,8 @@ bool sock_is_registered(int family);
 int sock_create(int family, int type, int proto, struct socket **res);
 int __sock_create_kern(struct net *net, int family, int type, int proto,
 		       struct socket **res);
+int sock_create_kern(struct net *net, int family, int type, int proto,
+		     struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
diff --git a/net/socket.c b/net/socket.c
index 7c4474c966c0..9ad352183fae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1632,6 +1632,48 @@ int __sock_create_kern(struct net *net, int family, int type, int protocol, stru
 }
 EXPORT_SYMBOL(__sock_create_kern);
 
+/**
+ * sock_create_kern - creates a socket for kernel space
+ *
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
+ * The socket holds a reference count of @net so that the caller
+ * does not need to care about @net's lifetime.
+ *
+ * This MUST NOT be called from the __net_init path and @net MUST
+ * be alive as of calling sock_create_kern().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
+ */
+int sock_create_kern(struct net *net, int family, int type, int protocol,
+		     struct socket **res)
+{
+	int err;
+
+	DEBUG_NET_WARN_ON_ONCE(!net_initialized(net));
+
+	err = __sock_create(net, family, type, protocol, res, 1);
+	if (!err)
+		sk_net_refcnt_upgrade((*res)->sk);
+
+	return err;
+}
+EXPORT_SYMBOL(sock_create_kern);
+
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
 	struct socket *sock;
-- 
2.49.0



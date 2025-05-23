Return-Path: <linux-nfs+bounces-11882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F4AC299B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 20:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8201C02781
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC83299A8D;
	Fri, 23 May 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ok1iFqS9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F64729993E;
	Fri, 23 May 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024690; cv=none; b=XaG4PwDRio0qa+Ow+KbqIEWXL8buIpocWH3sg0ibSY5/pBkQkLMpJc8SMeFZ6mallOCFwDTpctLaYL2BQRU0ul4ycHb2gx4zgQ6JD+DaOCW3qyFNYt7/VDO0IJgVN3zkRy/SboCUwPAsMFq9aYRWabC0n1msWA9BAlm7rsk5XMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024690; c=relaxed/simple;
	bh=aFdYqC5yR7IS7C1K0ft6ANTYCQeklh9fnLjP9xYz9w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtVBrJtwaSPJf98wRs9tyz+fnO2Elh+jO1U6zT3DTKeuzk67oLdp1uMCM2RBiLfx1MwHkzoGfVQcxXapZ5egr6cgrVCLv/ukGDhTJ61ZwlXhEMfbEQWJBLD6k2n2EmkTKaIngHxYOaA+T4r1AlUZpbGwvS3Y4zpC/uKpTa2vQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ok1iFqS9; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024688; x=1779560688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dFwPDfIzlH6tGV/bxIu9QKq8iVcQQ5JJd5NsWTivNLU=;
  b=ok1iFqS9b5+Cd6wL+QFFGXwkTtmKn3cOQrrXwR71ackg9rVlZvF6E4Lg
   dr995swBmuUYeJ8PrE6fhIuBfdBn4LdO6zQ1Fg5c3QhkSaAWauJqVqScf
   tFLn/PiBoqNtKo5z24bMbHqGpJsJRuaPpohdY0tnUmEjDfF4krI+th3O3
   UYmLCnlgMk/gO7TMCo18e0Y6GJfkwn08M8aoLHlFIgrUD9dyORuK/CAz6
   hr/fQYxUdFVUu16rIQEOFPhrzfzW6lVe8SAhKc4AsyaumzhS7vw4NftjJ
   FfkzucArBWQ+vtUfCyHEV7um2PMTctoF+0Zl0C4y4qvw0K7FloMt7pbaG
   g==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="96733226"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:24:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:5360]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.185:2525] with esmtp (Farcaster)
 id 0c05805c-7ef1-4828-9116-14573788f047; Fri, 23 May 2025 18:24:45 +0000 (UTC)
X-Farcaster-Flow-ID: 0c05805c-7ef1-4828-9116-14573788f047
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:24:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:24:41 +0000
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
Subject: [PATCH v2 net-next 7/7] socket: Clean up kdoc for sock_create() and sock_create_lite().
Date: Fri, 23 May 2025 11:21:13 -0700
Message-ID: <20250523182128.59346-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

__sock_create() is now static and the same doc exists on sock_create()
and sock_create_kern().

Also, __sock_create() says "On failure @res is set to %NULL.", but
this is always false.

In addition, the old style kdoc is a bit corrupted and we can't see the
DESCRIPTION section:

  $ scripts/kernel-doc -man net/socket.c | scripts/split-man.pl /tmp/man
  $ man /tmp/man/sock_create.9

Let's clean them up.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/socket.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 9ad352183fae..e4e9f5cc5d70 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1315,18 +1315,20 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 }
 
 /**
- *	sock_create_lite - creates a socket
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create_lite - creates a socket
  *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	The new socket initialization is not complete, see kernel_accept().
- *	Returns 0 or an error. On failure @res is set to %NULL.
- *	This function internally uses GFP_KERNEL.
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
+ *
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The new socket initialization is not complete, see kernel_accept().
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error. On failure @res is set to %NULL.
  */
-
 int sock_create_lite(int family, int type, int protocol, struct socket **res)
 {
 	int err;
@@ -1452,21 +1454,6 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
 }
 EXPORT_SYMBOL(sock_wake_async);
 
-/**
- *	__sock_create - creates a socket
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
- *	@kern: boolean for kernel space sockets
- *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
- *	be set to true if the socket resides in kernel space.
- *	This function internally uses GFP_KERNEL.
- */
-
 static int __sock_create(struct net *net, int family, int type, int protocol,
 			 struct socket **res, int kern)
 {
@@ -1583,16 +1570,21 @@ static int __sock_create(struct net *net, int family, int type, int protocol,
 }
 
 /**
- *	sock_create - creates a socket
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
+ * sock_create - creates a socket for userspace
+ *
+ * @family: protocol family (AF_INET, ...)
+ * @type: communication type (SOCK_STREAM, ...)
+ * @protocol: protocol (0, ...)
+ * @res: new socket
  *
- *	A wrapper around __sock_create().
- *	Returns 0 or an error. This function internally uses GFP_KERNEL.
+ * Creates a new socket and assigns it to @res, passing through LSM.
+ *
+ * The socket is for userspace and should be exposed via a file
+ * descriptor and BPF hooks (see inet_create(), inet_release(), etc).
+ *
+ * Context: Process context. This function internally uses GFP_KERNEL.
+ * Return: 0 or an error.
  */
-
 int sock_create(int family, int type, int protocol, struct socket **res)
 {
 	return __sock_create(current->nsproxy->net_ns, family, type, protocol, res, 0);
-- 
2.49.0



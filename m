Return-Path: <linux-nfs+bounces-3897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1A90AEFE
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4211C232DB
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F31993A1;
	Mon, 17 Jun 2024 13:17:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFB1991D9;
	Mon, 17 Jun 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630263; cv=none; b=UQDi2Bi7K2pRkW7WN1Z/mQjVUD1gei5gF8aXSs2NhHkhsXBTfsG8eV/7VKV7rg5MQi3kfT1GRKLRFi/3T83pYhtKsOhtvO4aIwXp33G6WpFnr6ysyqrUI6xFEEA3Y1DMMnuDsbKkEtxoT9Jynj4NxxFaUvnRqvfA2iw4IuzOuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630263; c=relaxed/simple;
	bh=UKrQB7BAzMucLmu6rSZnSX21jFfck85fX5kiW2DsiHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo34XVZ6BeJAk5mhJNKOm8SXcm41fS4sPEeAlNrdkZSeNaUkAN/8EZQVds2wwqJZvE3D1QSKolEQwT14NNWA58LWqjIuHdeiZpWPozKkIvtkMkuc41al51hRtg2pBsw4esn1hYRpVfZr1ZlhVr8HcGSOVwLN5QzBBF8Q2fPhMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4W2r480Hksz1xsdG;
	Mon, 17 Jun 2024 21:16:08 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 940551A016C;
	Mon, 17 Jun 2024 21:17:33 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 21:17:33 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, David
 Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-afs@lists.infradead.org>, <linux-nfs@vger.kernel.org>
Subject: [PATCH net-next v8 05/13] mm: page_frag: avoid caller accessing 'page_frag_cache' directly
Date: Mon, 17 Jun 2024 21:14:04 +0800
Message-ID: <20240617131413.25189-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240617131413.25189-1-linyunsheng@huawei.com>
References: <20240617131413.25189-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Use appropriate frag_page API instead of caller accessing
'page_frag_cache' directly.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/vhost/net.c             |  2 +-
 include/linux/page_frag_cache.h | 10 ++++++++++
 mm/page_frag_test.c             |  2 +-
 net/core/skbuff.c               |  6 +++---
 net/rxrpc/conn_object.c         |  4 +---
 net/rxrpc/local_object.c        |  4 +---
 net/sunrpc/svcsock.c            |  6 ++----
 7 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 6691fac01e0d..b2737dc0dc50 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1325,7 +1325,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 			vqs[VHOST_NET_VQ_RX]);
 
 	f->private_data = n;
-	n->pf_cache.va = NULL;
+	page_frag_cache_init(&n->pf_cache);
 
 	return 0;
 }
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index c6fde197a6eb..6ac3a25089d1 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -23,6 +23,16 @@ struct page_frag_cache {
 	bool pfmemalloc;
 };
 
+static inline void page_frag_cache_init(struct page_frag_cache *nc)
+{
+	nc->va = NULL;
+}
+
+static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
+{
+	return !!nc->pfmemalloc;
+}
+
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c
index c3cfce87fbbf..8b259e422fae 100644
--- a/mm/page_frag_test.c
+++ b/mm/page_frag_test.c
@@ -341,7 +341,7 @@ static int __init page_frag_test_init(void)
 	u64 duration;
 	int ret;
 
-	test_frag.va = NULL;
+	page_frag_cache_init(&test_frag);
 	atomic_set(&nthreads, 2);
 	init_completion(&wait);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6842fa6a71a5..ac5fe61c0ff2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -741,12 +741,12 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	if (in_hardirq() || irqs_disabled()) {
 		nc = this_cpu_ptr(&netdev_alloc_cache);
 		data = page_frag_alloc_va(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
 	} else {
 		local_bh_disable();
 		nc = this_cpu_ptr(&napi_alloc_cache.page);
 		data = page_frag_alloc_va(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
 		local_bh_enable();
 	}
 
@@ -834,7 +834,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 		len = SKB_HEAD_ALIGN(len);
 
 		data = page_frag_alloc_va(&nc->page, len, gfp_mask);
-		pfmemalloc = nc->page.pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(&nc->page);
 	}
 
 	if (unlikely(!data))
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 1539d315afe7..694c4df7a1a3 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -337,9 +337,7 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	 */
 	rxrpc_purge_queue(&conn->rx_queue);
 
-	if (conn->tx_data_alloc.va)
-		__page_frag_cache_drain(virt_to_page(conn->tx_data_alloc.va),
-					conn->tx_data_alloc.pagecnt_bias);
+	page_frag_cache_drain(&conn->tx_data_alloc);
 	call_rcu(&conn->rcu, rxrpc_rcu_free_connection);
 }
 
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 504453c688d7..a8cffe47cf01 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -452,9 +452,7 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 #endif
 	rxrpc_purge_queue(&local->rx_queue);
 	rxrpc_purge_client_connections(local);
-	if (local->tx_alloc.va)
-		__page_frag_cache_drain(virt_to_page(local->tx_alloc.va),
-					local->tx_alloc.pagecnt_bias);
+	page_frag_cache_drain(&local->tx_alloc);
 }
 
 /*
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 42d20412c1c3..4b1e87187614 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1609,7 +1609,6 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
-	struct page_frag_cache *pfc = &svsk->sk_frag_cache;
 	struct socket *sock = svsk->sk_sock;
 
 	trace_svcsock_free(svsk, sock);
@@ -1619,8 +1618,7 @@ static void svc_sock_free(struct svc_xprt *xprt)
 		sockfd_put(sock);
 	else
 		sock_release(sock);
-	if (pfc->va)
-		__page_frag_cache_drain(virt_to_head_page(pfc->va),
-					pfc->pagecnt_bias);
+
+	page_frag_cache_drain(&svsk->sk_frag_cache);
 	kfree(svsk);
 }
-- 
2.33.0



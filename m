Return-Path: <linux-nfs+bounces-7137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEBB99C805
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30A928766C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8B21AD9F8;
	Mon, 14 Oct 2024 11:00:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DA11AC444;
	Mon, 14 Oct 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903640; cv=none; b=geKiha/3QJ8ySj5Jiy88dP7vWBsfEgo6Dai7PRuiOV+i3tL2oilYIbHISWtfrBbbM6EWqOlOVEZqBthXdpQRoeGrrjDvu23M0U6deHLOI3K22FmolGsDUuA6WrVxyNVRzGj5sH4zF9ucxTX3OWz/Mjy2qF83+9zUqHcwRELB8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903640; c=relaxed/simple;
	bh=x3r7cGik4a+cV7xnBT9Zyr3ejj7E/w6UkjWUpLXgsOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgq3+rDfY8uGMGCLiJlXMVFbTTI4Vu3kco31ZdcuU99HQ9nxpTR2Iw9Z38nnr9G1/uTiiyXn2iw2xwd/xzrrzdd3cMW5ljC+YgOejVHtH3V4/gLJ0+x1p2Sw4gURTa/S5Bp5BW0aPK0kwGOtiK+o/kteQUXDkpq6TmQxRQXZFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 306CE1691;
	Mon, 14 Oct 2024 04:01:08 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF153F51B;
	Mon, 14 Oct 2024 04:00:35 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna Schumaker <anna@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Paolo Abeni <pabeni@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v1 23/57] net: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:30 +0100
Message-ID: <20241014105912.3207374-23-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Define NLMSG_GOODSIZE using min() instead of ifdeffery. This will now
evaluate to a compile-time constant for compile-time page size, but
evaluate at run-time when using boot-time page size.

Rework NAPI small page frag infrastructure so that for boot-time page
size it is compiled in if 4K page size is in the possible range, but
defer deciding to use it to run time when the page size is known. No
change for compile-time page size case.

Resize cache_defer_hash[] array for PAGE_SIZE_MAX.

Convert a complex BUILD_BUG_ON() to runtime BUG_ON().

Wrap global variables that are initialized with PAGE_SIZE derived values
using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/linux/netlink.h    | 6 +-----
 net/core/hotdata.c         | 4 ++--
 net/core/skbuff.c          | 4 ++--
 net/core/sysctl_net_core.c | 2 +-
 net/sunrpc/cache.c         | 3 ++-
 net/unix/af_unix.c         | 2 +-
 6 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index b332c2048c755..ffa1e94111f89 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -267,11 +267,7 @@ netlink_skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
  *	use enormous buffer sizes on recvmsg() calls just to avoid
  *	MSG_TRUNC when PAGE_SIZE is very large.
  */
-#if PAGE_SIZE < 8192UL
-#define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(PAGE_SIZE)
-#else
-#define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(8192UL)
-#endif
+#define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(min(PAGE_SIZE, 8192UL))
 
 #define NLMSG_DEFAULT_SIZE (NLMSG_GOODSIZE - NLMSG_HDRLEN)
 
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index d0aaaaa556f22..e1f30e87ba6e9 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -5,7 +5,7 @@
 #include <net/hotdata.h>
 #include <net/proto_memory.h>
 
-struct net_hotdata net_hotdata __cacheline_aligned = {
+__DEFINE_GLOBAL_PAGE_SIZE_VAR(struct net_hotdata, net_hotdata, __cacheline_aligned, {
 	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
 	.ptype_all = LIST_HEAD_INIT(net_hotdata.ptype_all),
 	.gro_normal_batch = 8,
@@ -21,5 +21,5 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
 	.sysctl_skb_defer_max = 64,
 	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE
-};
+});
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d16..b6c8eee0cc74b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -219,9 +219,9 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
 #define NAPI_SKB_CACHE_BULK	16
 #define NAPI_SKB_CACHE_HALF	(NAPI_SKB_CACHE_SIZE / 2)
 
-#if PAGE_SIZE == SZ_4K
+#if PAGE_SIZE_MIN <= SZ_4K && SZ_4K <= PAGE_SIZE_MAX
 
-#define NAPI_HAS_SMALL_PAGE_FRAG	1
+#define NAPI_HAS_SMALL_PAGE_FRAG	(PAGE_SIZE == SZ_4K)
 #define NAPI_SMALL_PAGE_PFMEMALLOC(nc)	((nc).pfmemalloc)
 
 /* specialized page frag allocator using a single order 0 page
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 86a2476678c48..a7a2eb7581bd1 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -33,7 +33,7 @@ static int int_3600 = 3600;
 static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
 static int max_skb_frags = MAX_SKB_FRAGS;
-static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
+static DEFINE_GLOBAL_PAGE_SIZE_VAR(int, min_mem_pcpu_rsv, SK_MEMORY_PCPU_RESERVE);
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 95ff747061046..4e682c0cd7586 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -573,13 +573,14 @@ EXPORT_SYMBOL_GPL(cache_purge);
  */
 
 #define	DFR_HASHSIZE	(PAGE_SIZE/sizeof(struct list_head))
+#define	DFR_HASHSIZE_MAX (PAGE_SIZE_MAX/sizeof(struct list_head))
 #define	DFR_HASH(item)	((((long)item)>>4 ^ (((long)item)>>13)) % DFR_HASHSIZE)
 
 #define	DFR_MAX	300	/* ??? */
 
 static DEFINE_SPINLOCK(cache_defer_lock);
 static LIST_HEAD(cache_defer_list);
-static struct hlist_head cache_defer_hash[DFR_HASHSIZE];
+static struct hlist_head cache_defer_hash[DFR_HASHSIZE_MAX];
 static int cache_defer_cnt;
 
 static void __unhash_deferred_req(struct cache_deferred_req *dreq)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0be0dcb07f7b6..1cf9f583358af 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2024,7 +2024,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 				 MAX_SKB_FRAGS * PAGE_SIZE);
 		data_len = PAGE_ALIGN(data_len);
 
-		BUILD_BUG_ON(SKB_MAX_ALLOC < PAGE_SIZE);
+		BUG_ON(SKB_MAX_ALLOC < PAGE_SIZE);
 	}
 
 	skb = sock_alloc_send_pskb(sk, len - data_len, data_len,
-- 
2.43.0



Return-Path: <linux-nfs+bounces-20380-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEllBfb9w2lXvQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20380-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:23:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6620C327D87
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72973302B3A4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7263F211A;
	Wed, 25 Mar 2026 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i108c/H1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29A3F2105;
	Wed, 25 Mar 2026 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449661; cv=none; b=Cl4aqjJcqzypqvZlt0mU0ayZe4AQ63+0TR4ACByBM9omWunCmKwEE+QPvr5cO1kLJd25hPjeoaKW/bTXAto7KfCQT0o5IQUaFNvJmLVZemxTF44uAPvtNx3jMH1Ch0a+L2fSMJj+61VwiaZcthISwJ7fJ9HgLvOHPL58FkfwGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449661; c=relaxed/simple;
	bh=xHH5cRLi+97NSkxpPLYe0sdarAUIo3BqhkjHWnScunA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBM95Jjqt5Y48g+E1jICD8hi4NhEXYwNYDAYf9xGZZqCWkKkpp5n1xOXVypK9iBzbqROUsrmJiQo4Rn6ivbuCGB1Zgw+htYG/Ln1AMTKePekZMmdzeJDswPr7fw/pLOYFNgLKWJuyJOmHjWwKedA6HTfUUA+vHS7g/ghQBaUZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i108c/H1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF04C116C6;
	Wed, 25 Mar 2026 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449660;
	bh=xHH5cRLi+97NSkxpPLYe0sdarAUIo3BqhkjHWnScunA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i108c/H1M4MaRbEu49YXKv1HRfRgVU4wCc07vJCFY8z5VjeMDCAC14MaGRTU00h4x
	 qbINSn05GS0ZO3U+H/duc9j87311bp7QIgfJ6C70I/Zs1PeUjmUGjONnAGuZDqK1MH
	 jhGmI1UcjLr8pDRtWuSe2bHAN3XGOXRrVucw9eO+RutxdDGJoNh4Fq8KjTnFqphFlg
	 ph2eabcr5BVYlVgUP9eG/fXLyraLv+ba6LirRxPBdTtZLH/ERBMlWB4cLCrsgwhvvY
	 Nc41qCcEIKvhb6TMSPja9z3cY+jREDSOE1fTXCH+KgJ1Ls9l286wdFTDhcf7F++Zca
	 ZmiX5CphQYdOQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:27 -0400
Subject: [PATCH v2 06/13] sunrpc: add helpers to count and snapshot pending
 cache requests
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-6-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
In-Reply-To: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3858; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xHH5cRLi+97NSkxpPLYe0sdarAUIo3BqhkjHWnScunA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/PuvlI5IZsC/pehjII95piczodTsmbgnpypX
 5V8xjha2J+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7gAKCRAADmhBGVaC
 FdZ7D/4p7zHkcMjKDNqf2i9yG+NocFs5MbxnhVjtFRG1wmhNyeUgivdSPztvbKXpMtbZgmCnYVv
 jiNFfi5/EmoYGcxClUL+D5r9pqjj8J8d/fwExmA9/U43CbHBiDhBY0WDmmAM5lkIJWJg0OxsCt/
 50syNb9nF+ggRy/UPrrG9oqSiyWQFThFT9w4GtP9bSLEL+Rpz8F8HDVhF5C4AHfqyuvEW4xBaeZ
 ABwzkCXsjwSNZlPTOjlWz6kZ/Dckn5aVW3fbxS/s8TFipxpdavGhWI9VGQIkwboCS1Z1UxCLVj0
 Lk0n4JfkZ+hge/hXg3UTqQnEaYLFFM0VpMwdGGx1bMhTMteNA0mB5j2xypEl+bKxOon3Qxke3Qd
 mgG6a3fWBUJLdgzaUVuUhtCWdEByQyM+yLwvhgrPYZ6N+qHxMu8IMDnlOZ0thR4xHhYNm7S/iol
 I8c60v2AkK/nKBG2AdxNwSOApGcDZH8/5KvIpHS6+i4EN40av43nxm5EuJJLRJGu4eMWIb7bTho
 9G5ino74hYWj6WacyM80/Ga97BvP6bDghROhvWAJnBcmoYl6qlIhEQRAKEqBEwhKSjK2TC0JICv
 jvVBFb7z4DSFZif3tLPVJj62BqbPqZA42QWcBbi+No8u3zigWeCAWMBuiCxvpEM86nZ+57hT8q3
 NuA2gNzHvjv+g9w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20380-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6620C327D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add sunrpc_cache_requests_count() and sunrpc_cache_requests_snapshot()
to allow callers to count and snapshot the pending upcall request list
without exposing struct cache_request outside of cache.c.

Both functions skip entries that no longer have CACHE_PENDING set.

The snapshot function takes a cache_get() reference on each item so the
caller can safely use them after the queue_lock is released.

These will be used by the nfsd generic netlink dumpit handler for
svc_export upcall requests.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/cache.h |  6 +++++
 net/sunrpc/cache.c           | 61 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index c358151c23950ab48e83991c6138bb7d0e049ace..f88dc6bb17c7078781b3cf7e0371f369eddcb563 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -251,6 +251,12 @@ extern int sunrpc_cache_register_pipefs(struct dentry *parent, const char *,
 extern void sunrpc_cache_unregister_pipefs(struct cache_detail *);
 extern void sunrpc_cache_unhash(struct cache_detail *, struct cache_head *);
 
+int sunrpc_cache_requests_count(struct cache_detail *cd);
+int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
+				   struct cache_head **items,
+				   u64 *seqnos, int max,
+				   u64 min_seqno);
+
 /* Must store cache_detail in seq_file->private if using next three functions */
 extern void *cache_seq_start_rcu(struct seq_file *file, loff_t *pos);
 extern void *cache_seq_next_rcu(struct seq_file *file, void *p, loff_t *pos);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index a182a179a1bfdb883ceda417a5809d967659be5d..1282c61030d35efd924072e2739109cfae3472e2 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1899,3 +1899,64 @@ void sunrpc_cache_unhash(struct cache_detail *cd, struct cache_head *h)
 		spin_unlock(&cd->hash_lock);
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_unhash);
+
+/**
+ * sunrpc_cache_requests_count - count pending upcall requests
+ * @cd: cache_detail to query
+ *
+ * Returns the number of requests on the cache's request list that
+ * still have CACHE_PENDING set.
+ */
+int sunrpc_cache_requests_count(struct cache_detail *cd)
+{
+	struct cache_request *crq;
+	int cnt = 0;
+
+	spin_lock(&cd->queue_lock);
+	list_for_each_entry(crq, &cd->requests, list) {
+		if (test_bit(CACHE_PENDING, &crq->item->flags))
+			cnt++;
+	}
+	spin_unlock(&cd->queue_lock);
+	return cnt;
+}
+EXPORT_SYMBOL_GPL(sunrpc_cache_requests_count);
+
+/**
+ * sunrpc_cache_requests_snapshot - snapshot pending upcall requests
+ * @cd: cache_detail to query
+ * @items: array to fill with cache_head pointers (caller-allocated)
+ * @seqnos: array to fill with sequence numbers (caller-allocated)
+ * @max: size of the arrays
+ * @min_seqno: only include entries with seqno > min_seqno (0 for all)
+ *
+ * Only entries with CACHE_PENDING set are included. Takes a reference
+ * on each cache_head via cache_get(). Caller must call cache_put()
+ * on each returned item when done.
+ *
+ * Returns the number of entries filled.
+ */
+int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
+				   struct cache_head **items,
+				   u64 *seqnos, int max,
+				   u64 min_seqno)
+{
+	struct cache_request *crq;
+	int i = 0;
+
+	spin_lock(&cd->queue_lock);
+	list_for_each_entry(crq, &cd->requests, list) {
+		if (i >= max)
+			break;
+		if (!test_bit(CACHE_PENDING, &crq->item->flags))
+			continue;
+		if (crq->seqno <= min_seqno)
+			continue;
+		items[i] = cache_get(crq->item);
+		seqnos[i] = crq->seqno;
+		i++;
+	}
+	spin_unlock(&cd->queue_lock);
+	return i;
+}
+EXPORT_SYMBOL_GPL(sunrpc_cache_requests_snapshot);

-- 
2.53.0



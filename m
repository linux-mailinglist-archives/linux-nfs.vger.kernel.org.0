Return-Path: <linux-nfs+bounces-20190-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDffNOgfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20190-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:21:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3129C2DF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D4F30BF5FD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B53A1D14;
	Mon, 16 Mar 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Gxm2XC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11A3A1CFE;
	Mon, 16 Mar 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674118; cv=none; b=C3RB5H39wRscUQ/Rz4zW/nyfchfyCzLxfALRB8T9PAEihjrMkjmOH8IqAL2dgW14jDkUQSmiD0n6K0KptV7jZEyP/94GBncbR9TWbthxZz/QMxS50sH98MC22ilWMOFCsRPdM/9pVhLPAjUjNoYeeAUosS7whkKclSXcVXw4aLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674118; c=relaxed/simple;
	bh=X0uUzaqlrvWI3pq3RSR2Kt1DBj/aWQDwAozoQb51la8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGBjS3Wh+lapxU2pfqsOKQ8vYTvYYY8JtT/xPQS1dXk/T9cZA0aoJqfde259OE+05QleTffjS1nSiiC42weepQ7E/7ClegqbuB6OXI7mNVqnPbuEbVmQSmEjicxr4PDnSBZZgEUkRD1hmmlqMI3FaOUpQJ/AQcdAO1pFr9cns0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Gxm2XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393E3C19425;
	Mon, 16 Mar 2026 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674118;
	bh=X0uUzaqlrvWI3pq3RSR2Kt1DBj/aWQDwAozoQb51la8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K5Gxm2XCC+frGkQreeJNP0RDEHgVY/TP2V7A7FTYrdOWk6NARJ8UITQD2y5WgIBcH
	 PqeQSvGE2tZM0IepjyW7DKH+jAubfPD2GTM+ppaO2PKIFOv4uzOQGannvp2LCKQkvQ
	 /Em4rcBL1Y3zRF8jCPSkzYzJj1J+rPjeUiHVj/c1POtVf/Ut9fI92uBgUqWcYJ0xvy
	 DYwOOmTgyEeRDVrjmCqX9JRyKDGAm0TWs679DCUsEdezr3eAgEyXY9Cxpa+EFoeBi3
	 +MRZbXupSee6KWuL2QE8hc+JbAVeIap4LsPT/slHPlsSSHJGZxL72asUwB/o8/Eipa
	 pF0N3uRl8cZLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:40 -0400
Subject: [PATCH 06/14] sunrpc: add helpers to count and snapshot pending
 cache requests
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-6-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3688; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X0uUzaqlrvWI3pq3RSR2Kt1DBj/aWQDwAozoQb51la8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB58Z1BDol0s8jn1EM0GW5gC1McET0++OR+vQ
 jqRLgGizWWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgefAAKCRAADmhBGVaC
 FRiSD/9+ivJxJwlW+Nh54iimrPD+ZoYpdccLcPCs5eUi9HnCzaaAiqi62DNeqbaFR3lxB3/9ZUg
 5fQH0dtB36nS/wFnYYdK7PLAfgEVRFKhOG+Rc2oasThDeiP53iMlE9WYtPqIpVmHbaYwVOC/wjn
 QPlKb5lM40gHKAaM4XrVXYD8mZ+VOubofqBmppf7oTez2pEmIq38jPVhqgr9CjwL50oSPPcEGAh
 bnk4RKGvCy32xsJM8GDmvC5+j0tgFYE4L3BM4Ui43W4kgA+2z80jBe9g3cJlTUbKtaaom7WcoSc
 S4MSwQMIPNdN6GDFZIqNVQ2D9Cf+fqClDERUF1GuRtmgnR5VUcQZXLOHQLlWd2RsPd0jhWwD+Xc
 OG4PAWm3GME5y5waXFR4MubY19fkkDWJrqzQqZcGQwJrIHRXMaUpvm7DsjwtsV17rCs0/WktdbE
 6DZnY7gDnopWSP7pPz2qpWzrPmbkAjnxc1rXTa30SSrn287H23AoZ7+fz3IG+XzU91DsgLdpBBD
 r29TsJlstZNIjL1ly0HsWmzrd7g9My0vhETDXI8gVB9+vYU4sPApVTbtczxuXGtEXme7Uyjxib6
 zNRUyI2lNarvWosL/fzeYDdzyoEqsicrShS8ROi/yye8c3UIVRvtYvrgWFm4fyAr8zuuCvXa5hA
 u9lqC2d7cHfA4ew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20190-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CE3129C2DF
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
 include/linux/sunrpc/cache.h |  5 ++++
 net/sunrpc/cache.c           | 57 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index c358151c23950ab48e83991c6138bb7d0e049ace..343f0fb675d761e019989e47e03645484e0aa30f 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -251,6 +251,11 @@ extern int sunrpc_cache_register_pipefs(struct dentry *parent, const char *,
 extern void sunrpc_cache_unregister_pipefs(struct cache_detail *);
 extern void sunrpc_cache_unhash(struct cache_detail *, struct cache_head *);
 
+int sunrpc_cache_requests_count(struct cache_detail *cd);
+int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
+				   struct cache_head **items,
+				   u64 *seqnos, int max);
+
 /* Must store cache_detail in seq_file->private if using next three functions */
 extern void *cache_seq_start_rcu(struct seq_file *file, loff_t *pos);
 extern void *cache_seq_next_rcu(struct seq_file *file, void *p, loff_t *pos);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 819f12add8f26562fdc6aaa200f55dec0180bfbc..2a78560edee5ca07be0fce90f87ce43a19df245f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1906,3 +1906,60 @@ void sunrpc_cache_unhash(struct cache_detail *cd, struct cache_head *h)
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
+ *
+ * Only entries with CACHE_PENDING set are included. Takes a reference
+ * on each cache_head via cache_get(). Caller must call cache_put()
+ * on each returned item when done.
+ *
+ * Returns the number of entries filled.
+ */
+int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
+				   struct cache_head **items,
+				   u64 *seqnos, int max)
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



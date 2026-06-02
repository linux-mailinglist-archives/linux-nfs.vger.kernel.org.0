Return-Path: <linux-nfs+bounces-22213-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WNB7O28GH2pFdgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22213-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:36:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF71C6303D3
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:35:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aAlssH8L;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22213-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22213-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F43E3031A05
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFDB37189B;
	Tue,  2 Jun 2026 16:23:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F336EA80;
	Tue,  2 Jun 2026 16:23:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417420; cv=none; b=gqPzLacRYwB03FSs6ZVva61Q5N2GMTNIqaQhoQ5J3yKawn1GozKo4b0V8TpTuC1W2Qg9KJnSZ+bbq9AXy7Hzvw0nq+ZNXas5b36g40FqxJPd+0Q5a6wt2XJG8X/a6Ww8nYb3mLTy5DuH+1g+uaiNA9bRp3mYXcj0gUpdQFXFdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417420; c=relaxed/simple;
	bh=4p1CVpcJ+A7EaLxF7Um3E6hVGg91UNafTKWuimRUO5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srQ2BKdu1VjVMp15WipSeGgOQuSOTyG77NzT4DczH/gXojJGynJi9luXG/XWj95g7jtmA0Dai7xZYF9Xez7BfAnP/WUZ2yTkc/Tu+ShD7sV1dbzuPK4xKuhakKiqHyoStA67PmU0vVHSXQgQFvsFcam0Meu3klMjreaNopM0wxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAlssH8L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A931F0089A;
	Tue,  2 Jun 2026 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417419;
	bh=gnQV3veSdBsU4Xt2Zlss8tJxAFnNE9xWCwOd+DHr7Rw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aAlssH8LwQ6xX5Z7xnLY7egyOHVw1flxv6DyXKmokpWdRCQ2goYuNExdSSzzTfQOQ
	 9AD+xIDeEpXY3oEEKjJFz/tSTiNnZqZMxELS+7Cfdnvihgt7AzHeifGx8BaVutIXFg
	 /WCYKfVplLwN2VvNxzrZJEZgJXTLrrJBo+BEomxHSex7ePzdDMhgZkTZXBI484z270
	 q3IJeaL0X+UGn7VZz2vkdHLuZqJ+zHfSNGcOe6LiZvLh0AsiRHu7WjKGpvqrL7sdHo
	 yS9SgBd+VhuzOugmHrZN8bninYowqPFqiku2p71KePY5CdZaRcGZaH9y3vyu2x0cjX
	 pu76TXVN5+3ag==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jun 2026 12:23:19 -0400
Subject: [PATCH v2 7/9] nfsd: fix fcache_disposal UAF by inlining dispose
 state into nfsd_net
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nfsd-testing-v2-7-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
In-Reply-To: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6986; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4p1CVpcJ+A7EaLxF7Um3E6hVGg91UNafTKWuimRUO5E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN9gB2TyepAZU4ISMLzdxfx/D8MAUA7rAd7v
 huJFjZ9Ih+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DfQAKCRAADmhBGVaC
 FR5GD/9y6r8qo76cG3i3OOWAy33nfqUJgau2+KBc7unQEGIgvCvBFtiBpbNYG8j+7vChgPskjEB
 cAzhu98QyE9vWRX6zqNzzKaVlPoDphplPoq6t4MDvk4XYdnFyySiB5RDqnyk7lEyOi64dfNe4G/
 9f78Bt5pBLU5OzI9IZbRJn79CYht3COanPSAN26j/XPMDkoCc9erZ8LdbLVdsUnCo2vDPy9mSKr
 S87vxTlYDSzlelnqZfnok7Kz+0S1n3JZNkN/8BqBpw0RefrFlQtBOloieZ3/fySsvc45F2LnTC8
 wqqQ0dd2U+cco79KmfoA/sEZSk+LLUqRc9oD6GgdaT59HYnNB68Koa7SvPU3+j3E7FCkxtttSCg
 f+mdyr6Q+/I1WOlP1O/d/hIl39ekQNw/YLM0PAHeMsYxLOxVgdbfdpwuYYerIdluU+T2DFZOKvw
 NXoIA+f3RYEEbKn+KBY7y6Mmx/cmBI0fSaLFYqV9Z/D4YfKUymnR08D4sbWAkFqg9HbsAnrZZXi
 24lpHeq0LQDxAjDIB6Nm2E7/4cRNdlquGYVDxyLGD2E1aMOkzp2q9P5iwZ49fo4QSxgaARjq6rw
 4cKYYKdTt7e3yRyDizuBM9JWl2O/0likmxp2I0uBUO8yZYy1S6E/s3/AXskq+0jMwWE5El++q8E
 073yfecz/WRZFdg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22213-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF71C6303D3

nfsd_file_dispose_list_delayed() defers fput() to nfsd service threads
via a per-net freeme queue, preventing the shrinker and GC worker from
bearing the cost of closing files (see ffb402596147).  However, the
queue lives in a separately-allocated struct nfsd_fcache_disposal that
is freed by nfsd_free_fcache_disposal_net() during per-net teardown.
The global shrinker, laundrette, and fsnotify callbacks can still be
inside nfsd_file_dispose_list_delayed() dereferencing that pointer,
causing a use-after-free.

Inline the spinlock and freeme list directly into struct nfsd_net (as
fcache_dispose_lock and fcache_dispose_list), eliminating the separately
allocated struct nfsd_fcache_disposal entirely.  These fields now have
the same lifetime as the net namespace itself, so there is no dangling
pointer to chase.

nfsd_file_cache_start_net() now just initializes the inline fields and
cannot fail due to allocation.  nfsd_file_cache_shutdown_net() drains
the inline list directly instead of freeing a separate struct.  The
alloc/free helpers are removed.

Fixes: 1463b38e7cf3 ("NFSD: simplify per-net file cache management")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 90 +++++++++++++----------------------------------------
 fs/nfsd/netns.h     |  3 +-
 2 files changed, 24 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d5b917e40d62..03f01a0beced 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -62,11 +62,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
 
-struct nfsd_fcache_disposal {
-	spinlock_t lock;
-	struct list_head freeme;
-};
-
 static struct kmem_cache		*nfsd_file_slab;
 static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
@@ -425,31 +420,26 @@ nfsd_file_dispose_list(struct list_head *dispose)
 }
 
 /**
- * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme list
+ * nfsd_file_dispose_list_delayed - queue dead files for disposal by nfsd threads
  * @dispose: list of nfsd_files to be disposed
  *
- * Transfers each file to the "freeme" list for its nfsd_net, to eventually
- * be disposed of by the per-net garbage collector.
+ * Transfers each file to the per-net freeme list in its nfsd_net and wakes
+ * an nfsd thread to do the actual close.  This keeps the cost of fput()
+ * in the nfsd threads rather than in the shrinker or GC worker.
  */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
-	while(!list_empty(dispose)) {
+	while (!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
-		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 		struct svc_serv *serv;
 
-		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_gc, &l->freeme);
-		spin_unlock(&l->lock);
+		spin_lock(&nn->fcache_dispose_lock);
+		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
+		spin_unlock(&nn->fcache_dispose_lock);
 
-		/*
-		 * The filecache laundrette is shut down after the
-		 * nn->nfsd_serv pointer is cleared, but before the
-		 * svc_serv is freed.
-		 */
 		serv = nn->nfsd_serv;
 		if (serv)
 			svc_wake_up(serv);
@@ -467,25 +457,15 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
  */
 void nfsd_file_net_dispose(struct nfsd_net *nn)
 {
-	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-	if (!list_empty(&l->freeme)) {
+	if (!list_empty(&nn->fcache_dispose_list)) {
 		LIST_HEAD(dispose);
 		int i;
 
-		spin_lock(&l->lock);
-		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
-			list_move(l->freeme.next, &dispose);
-		spin_unlock(&l->lock);
-		if (!list_empty(&l->freeme)) {
-			/*
-			 * Wake up another thread to share the work
-			 * *before* doing any actual disposing.
-			 *
-			 * The filecache laundrette is shut down after
-			 * the nn->nfsd_serv pointer is cleared, but
-			 * before the svc_serv is freed.
-			 */
+		spin_lock(&nn->fcache_dispose_lock);
+		for (i = 0; i < 8 && !list_empty(&nn->fcache_dispose_list); i++)
+			list_move(nn->fcache_dispose_list.next, &dispose);
+		spin_unlock(&nn->fcache_dispose_lock);
+		if (!list_empty(&nn->fcache_dispose_list)) {
 			struct svc_serv *serv = nn->nfsd_serv;
 
 			if (serv)
@@ -701,11 +681,11 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 }
 
 /**
- * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
+ * nfsd_file_close_inode - attempt a deferred close of a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
  * Close out any open nfsd_files that can be reaped for @inode. The
- * actual freeing is deferred to the dispose_list_delayed infrastructure.
+ * actual freeing is deferred to the nfsd service threads.
  *
  * This is used by the fsnotify callbacks and setlease notifier.
  */
@@ -990,42 +970,14 @@ __nfsd_file_cache_purge(struct net *net)
 	nfsd_file_dispose_list(&dispose);
 }
 
-static struct nfsd_fcache_disposal *
-nfsd_alloc_fcache_disposal(void)
-{
-	struct nfsd_fcache_disposal *l;
-
-	l = kmalloc_obj(*l);
-	if (!l)
-		return NULL;
-	spin_lock_init(&l->lock);
-	INIT_LIST_HEAD(&l->freeme);
-	return l;
-}
-
-static void
-nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
-{
-	nfsd_file_dispose_list(&l->freeme);
-	kfree(l);
-}
-
-static void
-nfsd_free_fcache_disposal_net(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
-
-	nfsd_free_fcache_disposal(l);
-}
-
 int
 nfsd_file_cache_start_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nn->fcache_disposal = nfsd_alloc_fcache_disposal();
-	return nn->fcache_disposal ? 0 : -ENOMEM;
+	spin_lock_init(&nn->fcache_dispose_lock);
+	INIT_LIST_HEAD(&nn->fcache_dispose_list);
+	return 0;
 }
 
 /**
@@ -1044,8 +996,10 @@ nfsd_file_cache_purge(struct net *net)
 void
 nfsd_file_cache_shutdown_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
 	nfsd_file_cache_purge(net);
-	nfsd_free_fcache_disposal_net(net);
+	nfsd_file_dispose_list(&nn->fcache_dispose_list);
 }
 
 void
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index f6b8b340bf8e..5c33c96da28e 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -216,7 +216,8 @@ struct nfsd_net {
 	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 
-	struct nfsd_fcache_disposal *fcache_disposal;
+	spinlock_t		fcache_dispose_lock;
+	struct list_head	fcache_dispose_list;
 
 	siphash_key_t		siphash_key;
 

-- 
2.54.0



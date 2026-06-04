Return-Path: <linux-nfs+bounces-22275-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zo5AFoePIWqlIwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22275-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:45:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CED1B641013
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:45:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bskg85vR;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22275-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22275-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09FD3111DA7
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8126C3B0;
	Thu,  4 Jun 2026 14:31:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F131E856;
	Thu,  4 Jun 2026 14:31:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583485; cv=none; b=jKwNWOdQysFe1Yg+R0lcehrU3EMoCVaZ7GR7WYfjFHOFioh7oTZwcxFkEG99yOARPYcaMHthZ59b2h2AX8asWMzQHs7/sZj5S6AY/8h24kOa4gZD/DaFaUAtjb7EAt3wBsvQBwMbgxtQhsOyhLRYecqef+E/kTJpfJRq3HZW05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583485; c=relaxed/simple;
	bh=/mXagmWTUoOltPFI4uE//U4o0+w85Zov/066RjOrcmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FS6OupSM1oVMTjlPDNTpJvQzKWrA2nUs/svoiWzaGCwVS8mEw8XoVlJrbVTpsjrXPvHEZm2Sx5Bcfwl5Rv6Kuwp/UsUhFLkGQAyOf36ZHinpBD3AVrvtr+EvzPzG4MWQmg/AFenBbMeqgaYTPMgdKfd/zrTKUJHjSnPhhw+Zulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bskg85vR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372631F00898;
	Thu,  4 Jun 2026 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583483;
	bh=A4IxB9Y6ViEMI3L5tYUxC+z23F5dOllD17AOy+HopPQ=;
	h=From:Date:Subject:To:Cc;
	b=bskg85vRT43ZtK4Ofggq4SYVOaDmKVlf+3KR3Vq1VF+8yMc7nDBtpVNQQijfrMp24
	 pk7nYESUjtPqT5UsiQiRCc8CV5G6Pcw9nFElWNCJWK905x+xKC/z34bs/skNLc+rjZ
	 dkgHV57V3Id0YS2lFwQ3daloRxsGZOycfQJqEGxDyAVabeDCHN12HexI8IgyX9jj2u
	 MlB+AJRvhCbF+GcQTBWdJ9eSjviy5/jWFO8aVSerCZe7xtMvE0TUh2DLnhuG92IyVn
	 RHKC4D7QPqGlLxxOXUH6bUtVq9V7Isx9UkZa66z6MYxyOjkjS96e585W/VDSx24MQ3
	 CWc5J/V5GFXoA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 04 Jun 2026 10:31:09 -0400
Subject: [PATCH v4] nfsd: close shrinker/GC/fsnotify vs per-net shutdown
 race in filecache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-nfsd-testing-v4-1-3aeb1479c5bb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMSw6CMBSF4a2Qjq3pW3DkPowDcnsLjaaYljQaw
 t4tjBDj8Jzk+yeSMHpM5FxNJGL2yQ+hDHWoCPRt6JB6WzYRTBhmGKfBJUtHTKMPHUWpWWM1Mqm
 RFPKM6PxrzV1vZfc+jUN8r/XMl/dPKHPKqGXOcNTSWFdf7hgDPo5D7MhSymKrxU6LolFhawRKs
 Bp+tNxqtdOScgoN6BpAaTjxLz3P8wcvODZGJQEAAA==
X-Change-ID: 20260601-nfsd-testing-e3509d5e035e
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6380; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/mXagmWTUoOltPFI4uE//U4o0+w85Zov/066RjOrcmQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqIYw1XFUysFylH+9Cd07rKGcZnR3riPYaY4K+7
 /j4Y9GzYcyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaiGMNQAKCRAADmhBGVaC
 FTomEADNNvCShVZhaGr4rX6feyP3UdsSyZz6nwY/DkqJ9tokL3cFY0kYpWjz2qWJZK4j6lvPnzS
 ipieCFpVA3sIoDuqnIMMNmBzZYWlhjse9uGlWz3XM9N2wiaQKt9g93XPKkMto+Qd+2N194G7oUB
 chUg0mutujxwJKFaW+32uQ26W/IzNvDKbTa6mmaf9cDZVSjjO/e/yMKpg9fkjoN9cC0YL8iN0LI
 ee0h/NLHYpGM2muWDcpJzcnjtMy/3C5fXxxUP7ZmsNtUGpJ7CpBGT94EbDemVXrICliuzmFHIZP
 FKG5Glsdg+KE9q9slfbqUJeT0ROGVo5ciQQ3kH6a1x1hfT8Clkg/U6m6xPnhVp5wNf6UhK+DqcB
 7NMPrwEjJBuhS+UCoCDbGouEOvem45xtSlVgrWH7yloDn02lNTYbvOwD1tgrkzdJEmOh7sfX6y4
 tDsYBSRkb34huqJwghiKCwOEmy5EH4hVYJsC7lXIyjzypvF6qsfYx0R7K6EqH9OcM8w1kKEsGrJ
 6tF51hzswqFaVi7lKdiUYMlHMU3OzHY+jgY6k/GdsYB1F9AFdc4mlt9G18BmpYrSni6Jkgq5GA2
 2VxpSgCyqBZE82psvm8A6ADE1ZtfcyLeXdWgSPn5EUQ02fAcl3AGsUSDlB0+8ijHGXeCv4qBjon
 2whZau2G46U3x5A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22275-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CED1B641013

The shrinker, GC worker, and fsnotify/lease callbacks can unhash an
nfsd_file from the rhashtable and then call
nfsd_file_dispose_list_delayed() to move it to the per-net dispose list.
If nfsd_file_cache_shutdown_net() runs concurrently, its rhashtable walk
misses the already-unhashed file, and its drain of the per-net dispose
list can run before the file has been queued.  The file then sits on
the per-net list with no thread to drain it, leaking both the file and
its associated state.

The GC worker and shrinker already hold nfsd_gc_lock while walking the
LRU, but in the original code they release it before calling
nfsd_file_dispose_list_delayed().  The fsnotify/lease path
(nfsd_file_close_inode) has no synchronisation at all.

Fix this by:

  1. Widening nfsd_gc_lock in both nfsd_file_gc() and nfsd_file_lru_scan()
     to cover the nfsd_file_dispose_list_delayed() call.

  2. Wrapping nfsd_file_close_inode() in nfsd_gc_lock so that all three
     callers of nfsd_file_dispose_list_delayed() hold the lock.

  3. Adding a spin_lock/unlock(nfsd_gc_lock) barrier in
     nfsd_file_cache_shutdown_net() after the purge, so that any
     in-progress disposal has fully completed before the per-net list
     is drained.

All operations inside the lock are non-sleeping (rhashtable lookups,
atomic bit/refcount ops, list moves, svc_wake_up), so the spinlock is
appropriate.

Fixes: 43fd953fa7e2 ("nfsd: simplify the delayed disposal list code")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
This is the remaining patch from the 9 patch series I posted earlier
this week. I'm only sending v4 to fix up a minor contextual diff vs. a
patch in Chuck's nfsd-testing branch. This one should merge cleanly.
---
Changes in v4:
- Fix minor contextual conflict in a comment
- Link to v3: https://lore.kernel.org/r/20260604-nfsd-testing-v3-1-c9c58cc45c71@kernel.org

Changes in v3:
- Drop already-merged patches from series
- Protect against race vs. pernet teardown by using nfsd_gc_lock instead
  of taking net references
- Link to v2: https://lore.kernel.org/r/20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org

Changes in v2:
- rework filecache patch to only take net ref at disposal time
- fix ordering of operations in nfsd4_release_compoundargs()
- add Al's patch to simplify nfsd_cross_mnt() cleanup
- Link to v1: https://lore.kernel.org/r/20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org
---
 fs/nfsd/filecache.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fccef285f47b..0f7d8c85aff3 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -55,6 +55,14 @@
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
 #define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
+/* If the shrinker runs between calls to list_lru_walk_node() in
+ * nfsd_file_gc(), the "remaining" count will be wrong.  This could
+ * result in premature freeing of some files.  This may not matter much
+ * but is easy to fix with this spinlock which temporarily disables
+ * the shrinker.
+ */
+static DEFINE_SPINLOCK(nfsd_gc_lock);
+
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_allocations);
@@ -426,10 +434,16 @@ nfsd_file_dispose_list(struct list_head *dispose)
  * Transfers each file to the dispose list in its nfsd_net and wakes an nfsd
  * thread to do the actual close.  This keeps the cost of fput() in the nfsd
  * threads rather than in the shrinker or GC worker.
+ *
+ * All callers must hold nfsd_gc_lock, so that nfsd_file_cache_shutdown_net()
+ * can synchronise against them before draining the per-net dispose list.
+ * This guarantees nf_net is still live when we call net_generic().
  */
 static void
 nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
+	lockdep_assert_held(&nfsd_gc_lock);
+
 	while (!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_gc);
@@ -560,13 +574,6 @@ nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
 	return nfsd_file_lru_cb(item, lru, arg);
 }
 
-/* If the shrinker runs between calls to list_lru_walk_node() in
- * nfsd_file_gc(), the "remaining" count will be wrong.  This could
- * result in premature freeing of some files.  This may not matter much
- * but is easy to fix with this spinlock which temporarily disables
- * the shrinker.
- */
-static DEFINE_SPINLOCK(nfsd_gc_lock);
 static void
 nfsd_file_gc(void)
 {
@@ -589,9 +596,9 @@ nfsd_file_gc(void)
 				remaining = 0;
 		}
 	}
+	nfsd_file_dispose_list_delayed(&dispose);
 	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 static void
@@ -619,9 +626,9 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
+	nfsd_file_dispose_list_delayed(&dispose);
 	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
-	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
 }
 
@@ -707,8 +714,10 @@ nfsd_file_close_inode(struct inode *inode)
 {
 	LIST_HEAD(dispose);
 
+	spin_lock(&nfsd_gc_lock);
 	nfsd_file_queue_for_close(inode, &dispose);
 	nfsd_file_dispose_list_delayed(&dispose);
+	spin_unlock(&nfsd_gc_lock);
 }
 
 /**
@@ -1012,6 +1021,14 @@ nfsd_file_cache_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfsd_file_cache_purge(net);
+	/*
+	 * Ensure any in-progress shrinker, GC, or fsnotify/lease callback
+	 * (all of which hold nfsd_gc_lock while calling
+	 * nfsd_file_dispose_list_delayed()) has fully completed before
+	 * draining the per-net dispose list.
+	 */
+	spin_lock(&nfsd_gc_lock);
+	spin_unlock(&nfsd_gc_lock);
 	nfsd_file_dispose_list(&nn->fcache_dispose_list);
 }
 

---
base-commit: fb997598bc8c885e9d17b19b809009bd34f39779
change-id: 20260601-nfsd-testing-e3509d5e035e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



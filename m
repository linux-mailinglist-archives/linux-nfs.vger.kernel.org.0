Return-Path: <linux-nfs+bounces-9924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D2A2BA95
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 06:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70613A7747
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 05:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5163D;
	Fri,  7 Feb 2025 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cqVqqPrE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yocfy0o6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E/V9emz4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amaDs3YJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8B14F9C4
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738905479; cv=none; b=sp2FaHjvDczxWI4fZy0w7shdTGzC/T4XAP0xUdkPZ3EeVmUGc7/9IDjXwEUVCRX/JVo8sf3BF9BTCrBMsuQOp9E8TsBuUSjJOG0qkOJIQ196IimcRksh0zioGSFb0VXGTUo9qEzTkrkkwctQP5R/lS/lpWmg/WaSW0gbw7sik/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738905479; c=relaxed/simple;
	bh=gG7CdlQKviFJzEOM5RuuOe2cC5NxRie4hTd9xCT0XOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1NE2OuqcK1i22v05x/Mvg3KvUB6Nv04OHF0i+oL2uFTiasdQ10G4IwS8hQ612JvTCgWxvPkzRC326JuU0MtxkZPM5xD8Kt/vAtq14YJV/LMG4Wn0Q4IPoc0GP9vrVlvTbBP207S5bG0DXRVxRrygUzqZIKXv2voJkKqZjexD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cqVqqPrE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yocfy0o6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E/V9emz4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=amaDs3YJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB02921133;
	Fri,  7 Feb 2025 05:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6wzLGMXv76tyWMql3E+wb6WTpmcsY+i+ln/Az0yDQk=;
	b=cqVqqPrEEgwnZLTvmVIL2XNTStxEFQlcJiUvJ7/dQnqrEy7kMv/SopedFBPyerp9q6s12K
	Q73vSF0+wtszAoaCMOF/OH5Mveg/tOUpFA5/vy+CQwzKHB1qZeeYxkhYy9gmGFrwtjltqm
	AzfsO6ho2pWPwoNL80J7tcRWEEAv5PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6wzLGMXv76tyWMql3E+wb6WTpmcsY+i+ln/Az0yDQk=;
	b=Yocfy0o6sE4fKgzdG9J/SBvug5yB/rLPM5HWIPJ2/jOUr/pJpP1NNa6dYF5W2plmYCNPQp
	Zoj8qgZ1VB0CnzAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="E/V9emz4";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=amaDs3YJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6wzLGMXv76tyWMql3E+wb6WTpmcsY+i+ln/Az0yDQk=;
	b=E/V9emz4cG7CBb0jtePV/1fh2ZiqHrxPCdqzQZHUxc6Ys1tZYipJCXKEsZ+DsTwoEavHNm
	dJsin7cwBDya/5VGG6m9XJ14NU/hMcjB1LZM6S3MHrewYfUd5qVmNoOnSHdn6a1uDUg7mK
	JlHOlb1jxxn6FR0TyzqvNsIPBN1qB/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6wzLGMXv76tyWMql3E+wb6WTpmcsY+i+ln/Az0yDQk=;
	b=amaDs3YJlTImEx9wJreBqtzGHc+OFfbrIgJcNgdpM+8O/VliKzoH9CD3iGx1X2dC7myRSN
	CNx4daA+jA5M8PCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ED2813694;
	Fri,  7 Feb 2025 05:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M8HtDIGXpWcpFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 05:17:53 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6/6] nfsd: filecache: drop the list_lru lock during lock gc scans
Date: Fri,  7 Feb 2025 16:15:16 +1100
Message-ID: <20250207051701.3467505-7-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207051701.3467505-1-neilb@suse.de>
References: <20250207051701.3467505-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB02921133
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Under a high NFSv3 load with lots of different files being accessed,
the LRU list of garbage-collectable files can become quite long.

Asking list_lru_scan_node() to scan the whole list can result in a long
period during which a spinlock is held, blocking the addition of new LRU
items.

So ask list_lru_scan_node() to scan only a few entries at a time, and
repeat until the scan is complete.

If the shrinker runs between two consecutive calls of
list_lru_scan_node() it could invalidate the "remaining" counter which
could lead to premature freeing.  So add a spinlock to avoid that.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 27 ++++++++++++++++++++++++---
 fs/nfsd/filecache.h |  6 ++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d1ce0bc86ff7..54df5e23f119 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -533,6 +533,13 @@ nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
 	return nfsd_file_lru_cb(item, lru, arg);
 }
 
+/* If the shrinker runs between calls to list_lru_walk_node() in
+ * nfsd_file_gc(), the "remaining" count will be wrong.  This could
+ * result in premature freeing of some files.  This may not matter much
+ * but is easy to fix with this spinlock which temporarily disables
+ * the shrinker.
+ */
+static DEFINE_SPINLOCK(nfsd_gc_lock);
 static void
 nfsd_file_gc(void)
 {
@@ -540,11 +547,21 @@ nfsd_file_gc(void)
 	unsigned long ret = 0;
 	int nid;
 
+	spin_lock(&nfsd_gc_lock);
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
-		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
-		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
-					  &dispose, &nr);
+		unsigned long remaining = list_lru_count_node(&nfsd_file_lru, nid);
+
+		while (remaining > 0) {
+			unsigned long nr = min(remaining, NFSD_FILE_GC_BATCH);
+			remaining -= nr;
+			ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
+						  &dispose, &nr);
+			if (nr)
+				/* walk aborted early */
+				remaining = 0;
+		}
 	}
+	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
 }
@@ -569,8 +586,12 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	LIST_HEAD(dispose);
 	unsigned long ret;
 
+	if (!spin_trylock(&nfsd_gc_lock))
+		return SHRINK_STOP;
+
 	ret = list_lru_shrink_walk(&nfsd_file_lru, sc,
 				   nfsd_file_lru_cb, &dispose);
+	spin_unlock(&nfsd_gc_lock);
 	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
 	nfsd_file_dispose_list_delayed(&dispose);
 	return ret;
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index de5b8aa7fcb0..5865f9c72712 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -3,6 +3,12 @@
 
 #include <linux/fsnotify_backend.h>
 
+/*
+ * Limit the time that the list_lru_one lock is held during
+ * an LRU scan.
+ */
+#define NFSD_FILE_GC_BATCH     (16UL)
+
 /*
  * This is the fsnotify_mark container that nfsd attaches to the files that it
  * is holding open. Note that we have a separate refcount here aside from the
-- 
2.47.1



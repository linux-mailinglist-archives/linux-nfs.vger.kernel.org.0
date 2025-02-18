Return-Path: <linux-nfs+bounces-10173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE67A3A188
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7072D3AEAEF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56C26D5DF;
	Tue, 18 Feb 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwumJEW8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73EA26B968
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893185; cv=none; b=X4mDuRjfEm2K408C1ivtWdVManrz5K54RIHsqIIxdhBSNWXZe1AIr5vz2dspadWSbFoTr19Hh28VDAyRBZGwqDfSvmMC2x4G8QmWnkN9eP/I0GxiKuH09m8zOq82guA4VQ93q827XcXSx96H1GYpH9lP3cYZxXCAqko3yg0PgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893185; c=relaxed/simple;
	bh=qHiS4IzCVpGM4RTkqp/s/x5lqhU+jKs59ky5QPy9kQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASkafyCorwWF5qmcvHgjpn/g+r2Dg5yX3WJhw6ZaQBLSh92E0q7amjfdMMOExv7N9ZmA/LY7pX4ekotcnfJ+NZ8wYe1MkJtmHAqFCS9UVFQQh4hb5fkFHDKWBKxgGybv0hZ5qeqBciR7zYBLuG3wQ5ERh7ILyq6tt6soGWjkr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwumJEW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEDAC4CEE7;
	Tue, 18 Feb 2025 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893185;
	bh=qHiS4IzCVpGM4RTkqp/s/x5lqhU+jKs59ky5QPy9kQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwumJEW8BDuN1OrP807OTm9+HPg+6tz4hJcl2oiUakhDutf3ccHa8WCKkja6Ww4Vk
	 kZYgIQDyLAPTVrDWltqinEhUAgdPUM0jZTgcS0kwarnrZsYj+cbgQwsHQx/CQY6s6G
	 aQ5A8f7UdCZcnby6FxaBdfFalia9RYd+HsVau9rAMwlhAlXGzVah+GXvIlGtqOLEyl
	 cXBhDpRCRIGzmpaYMt5g/Qq9eNz5Senv97Nr2VuTu55VGrHQsCfWYzDUcTGakD8FT2
	 yiT9Xa7aGpACT0arTY+fkvclC+c4WSTtAgouNUAi77S/7QRYei1CC71x3H/q0RjQTp
	 aIfTEoFNL456Q==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 5/7] nfsd: filecache: introduce NFSD_FILE_RECENT
Date: Tue, 18 Feb 2025 10:39:35 -0500
Message-ID: <20250218153937.6125-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250218153937.6125-1-cel@kernel.org>
References: <20250218153937.6125-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

The filecache lru is walked in 2 circumstances for 2 different reasons.

1/ When called from the shrinker we want to discard the first few
   entries on the list, ignoring any with NFSD_FILE_REFERENCED set
   because they should really be at the end of the LRU as they have been
   referenced recently.  So those ones are ROTATED.

2/ When called from the nfsd_file_gc() timer function we want to discard
   anything that hasn't been used since before the previous call, and
   mark everything else as unused at this point in time.

Using the same flag for both of these can result in some unexpected
outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then
nfsd_file_gc() will think the file hasn't been used in a while, while
really it has.

I think it is easier to reason about the behaviour if we instead have
two flags.

 NFSD_FILE_REFERENCED means "this should be at the end of the LRU, please
     put it there when convenient"
 NFSD_FILE_RECENT means "this has been used recently - since the last
     run of nfsd_file_gc()

When either caller finds an NFSD_FILE_REFERENCED entry, that entry
should be moved to the end of the LRU and the flag cleared.  This can
safely happen at any time.  The actual order on the lru might not be
strictly least-recently-used, but that is normal for linux lrus.

The shrinker callback can ignore the "recent" flag.  If it ends up
freeing something that is "recent" that simply means that memory
pressure is sufficient to limit the acceptable cache age to less than
the nfsd_file_gc frequency.

The gc callback should primarily focus on NFSD_FILE_RECENT.  It should
free everything that doesn't have this flag set, and should clear the
flag on everything else.  When it clears the flag it is convenient to
clear the "REFERENCED" flag and move to the end of the LRU too.

With this, calls from the shrinker do not prematurely age files.  It
will focus only on freeing those that are least recently used.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 22 ++++++++++++++++++++--
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/trace.h     |  3 +++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 747929c8c0d5..0d621833a9f2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -319,10 +319,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-
 static bool nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
 	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
 		trace_nfsd_file_lru_add(nf);
 		return true;
@@ -534,6 +534,24 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	return LRU_REMOVED;
 }
 
+static enum lru_status
+nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
+		 void *arg)
+{
+	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
+
+	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
+		/*
+		 * "REFERENCED" really means "should be at the end of the
+		 * LRU. As we are putting it there we can clear the flag.
+		 */
+		clear_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
+		trace_nfsd_file_gc_aged(nf);
+		return LRU_ROTATE;
+	}
+	return nfsd_file_lru_cb(item, lru, arg);
+}
+
 static void
 nfsd_file_gc(void)
 {
@@ -544,7 +562,7 @@ nfsd_file_gc(void)
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
 		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
 
-		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
+		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_gc_cb,
 					  &dispose, &nr);
 	}
 	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index d5db6b34ba30..de5b8aa7fcb0 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -38,6 +38,7 @@ struct nfsd_file {
 #define NFSD_FILE_PENDING	(1)
 #define NFSD_FILE_REFERENCED	(2)
 #define NFSD_FILE_GC		(3)
+#define NFSD_FILE_RECENT	(4)
 	unsigned long		nf_flags;
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 49bbd26ffcdb..d93573504fa4 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1050,6 +1050,7 @@ DEFINE_CLID_EVENT(confirmed_r);
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
+		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
 		{ 1 << NFSD_FILE_GC,		"GC" })
 
 DECLARE_EVENT_CLASS(nfsd_file_class,
@@ -1328,6 +1329,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
+DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
 
 DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
@@ -1357,6 +1359,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
 	TP_ARGS(removed, remaining))
 
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
+DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
 
 TRACE_EVENT(nfsd_file_close,
-- 
2.47.0



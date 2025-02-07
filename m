Return-Path: <linux-nfs+bounces-9922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E458AA2BA92
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 06:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FAB1640A7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 05:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90663D;
	Fri,  7 Feb 2025 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jHvCXHrA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3SnG58GO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jHvCXHrA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3SnG58GO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0C14F9C4
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738905463; cv=none; b=FWGjy4Guallh0z4A8gVbB/8I2gdHyHjAHa9+7Ojz2jcZ/LEt+BauppDBRtPstSWOw7RPYgsfkVoqUyVsXxmAdD5VxJ22vP+KfJ/0x+IiG7Qfz19N3IVFIRgarTW3MXfQi+r9cNKgGlu3MBK3jFzh+QonNN9aVAMrIs8qLeF9i0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738905463; c=relaxed/simple;
	bh=nSZz6Pj/s3cItEYEKl6cBiUdDVPYLP9oqzN5JfVeY4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvhQVRPYIciWvnkAdlrnTOD/D4toBVALNL2uzY+TNG3IITISWNSyH515yi+rZFTFhY0K6BPwELsnM5/ioQ6dCF3iilv8IQaCVt+HyVHKTqVaijoiKV9nVJy8byD/b7dh/SOuGSoYfLfnyGI9p0+b7uYPo8RWLbuOHhMBILAV0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jHvCXHrA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3SnG58GO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jHvCXHrA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3SnG58GO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0685B1F38D;
	Fri,  7 Feb 2025 05:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDMUVU9C7kxdtq5b8fVLw7+0ebUWoLiL7My3XjJVuLE=;
	b=jHvCXHrAgppUGuoPio/Z+v2YsmDCvHp3WrSC0S4tXno+G2vxJVuJsJCDjnX69GV5P+wCym
	eqfzYnEdpsuV2g7dPTu8EhIZvrcjCYISXjfDcv3rfGsUpUDdby+38OTRZv6lSQo0zo0lGP
	ZBq1zjG69oMF7MNSbBK8N/eJLd0VHoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDMUVU9C7kxdtq5b8fVLw7+0ebUWoLiL7My3XjJVuLE=;
	b=3SnG58GOtxf4VKlaMr93jWizOVPNKwRM6/goC+WAXt6VSweZvPd08y6hZ4Y9yjQM6FZYB+
	HaqcUL44tSDYwHCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDMUVU9C7kxdtq5b8fVLw7+0ebUWoLiL7My3XjJVuLE=;
	b=jHvCXHrAgppUGuoPio/Z+v2YsmDCvHp3WrSC0S4tXno+G2vxJVuJsJCDjnX69GV5P+wCym
	eqfzYnEdpsuV2g7dPTu8EhIZvrcjCYISXjfDcv3rfGsUpUDdby+38OTRZv6lSQo0zo0lGP
	ZBq1zjG69oMF7MNSbBK8N/eJLd0VHoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDMUVU9C7kxdtq5b8fVLw7+0ebUWoLiL7My3XjJVuLE=;
	b=3SnG58GOtxf4VKlaMr93jWizOVPNKwRM6/goC+WAXt6VSweZvPd08y6hZ4Y9yjQM6FZYB+
	HaqcUL44tSDYwHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 839FA13694;
	Fri,  7 Feb 2025 05:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1YkcDnGXpWcUFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 05:17:37 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
Date: Fri,  7 Feb 2025 16:15:14 +1100
Message-ID: <20250207051701.3467505-5-neilb@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The filecache lru is walked in 2 circumstances for 2 different reasons.

1/ When called from the shrinker we want to discard the first few
   entries on the list, ignoring any with NFSD_FILE_REFERENCED set
   because they should really be at the end of the LRU as they have been
   referenced recently.  So those ones are ROTATED.

2/ When called from the nfsd_file_gc() timer function we want to discard
   anything that hasn't been used since before the previous call, and
   mark everything else as unused at this point in time.

Using the same flag for both of these can result in some unexpected
outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then the
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

The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
free everything that doesn't have this flag set, and should clear the
flag on everything else.  When it clears the flag it is convenient to
clear the "REFERENCED" flag and move to the end of the LRU too.

With this, calls from the shrinker do not prematurely age files.  It
will focus only on freeing those that are least recently used.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 21 +++++++++++++++++++--
 fs/nfsd/filecache.h |  1 +
 fs/nfsd/trace.h     |  3 +++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 04588c03bdfe..9faf469354a5 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
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
@@ -528,6 +528,23 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 	return LRU_REMOVED;
 }
 
+static enum lru_status
+nfsd_file_gc_cb(struct list_head *item, struct list_lru_one *lru,
+		 void *arg)
+{
+	struct nfsd_file *nf = list_entry(item, struct nfsd_file, nf_lru);
+
+	if (test_and_clear_bit(NFSD_FILE_RECENT, &nf->nf_flags)) {
+		/* "REFERENCED" really means "should be at the end of the LRU.
+		 * As we are putting it there we can clear the flag
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
@@ -537,7 +554,7 @@ nfsd_file_gc(void)
 
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
index ad2c0c432d08..9af723eeb2b0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1039,6 +1039,7 @@ DEFINE_CLID_EVENT(confirmed_r);
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
 		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED" },		\
+		{ 1 << NFSD_FILE_RECENT,	"RECENT" },		\
 		{ 1 << NFSD_FILE_GC,		"GC" })
 
 DECLARE_EVENT_CLASS(nfsd_file_class,
@@ -1317,6 +1318,7 @@ DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
+DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_aged);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_disposed);
 
 DECLARE_EVENT_CLASS(nfsd_file_lruwalk_class,
@@ -1346,6 +1348,7 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
 	TP_ARGS(removed, remaining))
 
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
+DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_recent);
 DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
 
 TRACE_EVENT(nfsd_file_close,
-- 
2.47.1



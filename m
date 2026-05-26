Return-Path: <linux-nfs+bounces-21950-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id um+oIHaGFWpyWQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21950-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:39:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDDC5D500D
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC48A304B8A9
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D23E5590;
	Tue, 26 May 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2ZHD5Bt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BC3E1727
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795470; cv=none; b=qyxkMJBfc98/Zy9IlVxmAH2QkGJ9oagEZRsIzmTou8bOKvyUdYSKpGGKExEiY2bYzeGiW6AAY0SfgNMJuT57OqFPClYnvLaFZxEdfMHoHNvMZJevTHSUN2bglxWCgX6m4GetdubWDzvD7k4TI+xZ67CouKKVI3z60DN0a7S7hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795470; c=relaxed/simple;
	bh=YkONpgjarkoyetvAWGsRSwGxKORs8lGBbP3iuK2k+jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2FW7NNjB0/9pVxy80JJWNBA1ryp32oba9I7aPRWMCx1BlLEwUC6A0wFOSws8CQtXuy56SXPLLklAvFgkrFOQxjo76wS7aiHp8NyJlNNnbxPz7a6HqFZkOvjM1hudfhU2wNuKSTAZzUMMUFDEUWmNx5x5dPoAuVCo2qd501/PZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2ZHD5Bt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8fbe18b1dso16702456e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795460; x=1780400260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YrtHMEYPI1tjDQiF/FNeUbCwB0JCeO1sQzq3zX3f00=;
        b=N2ZHD5Bt5an0mStRTPeVWIQaVmz6beWBYuD4n8NsNunqLk2ddmXIjc8Oa6pDhulG1O
         Isa0TtFuLFxfEtZzJWR9Uv7IhyIjdz9kGgpKRsuoISwQ9oXc/9k4zzQW/X56LdvUmejx
         obzfuHs82WGgJMksWEqG2tiD1L2g/ZoioAOa7IbLkoZ60K48GZOGpGOyvZGd5GRi2/4S
         NENjEAzmm+N9LIYuQHnkmYqi8X/RWD1xGCuuT+i4ZlY/HZWqRJklAZo+KDZ3hoWn2tMc
         sMEI18PB9pqV2TRBnnNtH84vEX/5ph7ycMGpNUPrgHRUcragwU/dU0VzV0DeIzMDLYs5
         y7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795460; x=1780400260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4YrtHMEYPI1tjDQiF/FNeUbCwB0JCeO1sQzq3zX3f00=;
        b=XCkHr4bGLI1ra4IqLuhCvl3PnKgYITEwqR79L/vNX99l96JkuL0beYU8fJwm6SgXcH
         wWPlE9Gig1mty5nhQ9VMt2gX3ZuPROPfex0jXOhi38XKrbuYKuwCB+w4KTNjUIvjwN3r
         gM/SM+vk4DTHcuV0vPz38RH6h6hN/yeXLzT6QM65sZJt31D4W81PisA+e6eFpBpMnoT8
         YKTB8ihQmaOgWTC8eBgzj3rA31E5IP6QM28bWliZX4DtCJVSJ+s/ccAKRm6HAp1uoeU8
         pMmNjCyaVlbIxPDxWasS7obRcT835aJGN7wBfL4SQdYa6FMX/skn4lX/8GWcS9GpASc4
         U2MQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dTTAnm9a12/nASQJTj4NJFkhgVQXzYebl7zr9cqnYM7VoocjJKkxgKZ8ZHB65eRSnmut/6t1Pb7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTdi+mh4JzOPnMj4sOPR6CiMHPXky2CFu29p1pNGufPk3fNPw4
	xFlSQSHvpqL9HSdnyfl2vIYbYA9oSp1XLanMiutztE9tVpGyeeYyrVP1
X-Gm-Gg: Acq92OGS07GOyqoyf0N6s9QfDT9Ccm9jTpvYS06s39rzsCciRtVpAjkBb4xAie751p4
	Ri/bQH3er0bYc9fFC5oUeqyZ4z4gJyzwUkRVzB0JBUrC6J/0DyGG79JmLtd1h0NnpBXpsXioSkY
	HKyiJ2JOFVlXReOqBCqWvHO37QlFlbLDI1hn4lyynSxI3gTZ00118UWIjRZUsXzB42d7G+k6gg8
	9dBSyzI6jQeismZmaraE4l0HfsyaSWOk1uURvfpJoyrOO0XH3wGmiOvnDxPjvHJ4uN8EuKq+TUM
	NRb+wGJpgodpGOopSKjP5RLmgcQjIfoPVDhZMqLRgC3PMPt/NRP/z1PbmyQH6kKiJmVDxSpG1z4
	38G7Y0OgseI2k1QC76dAq44E/1MRnlcaErnRpnEnOAkuX3ZlC+F5lSdfNMTlGjZse4kyV3NuJvl
	AP2eq8g9Nkhcsi/6k3Zz4MRAI5LLc6qVE2Nrf4tsVkge6TdEtoIpVCMnIN1L8HOrlGYJaO
X-Received: by 2002:a19:f010:0:b0:5a8:8f72:de76 with SMTP id 2adb3069b0e04-5aa3233bde4mr4472023e87.19.1779795459278;
        Tue, 26 May 2026 04:37:39 -0700 (PDT)
Received: from [127.0.1.1] (h-62-63-197-109.NA.cust.bahnhof.se. [62.63.197.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa46330d9asm376332e87.59.2026.05.26.04.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:37:38 -0700 (PDT)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Tue, 26 May 2026 13:37:03 +0200
Subject: [PATCH RFC 2/3] mm: new migrate_mode flag for async using
 non-temporal stores
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rfc-nt-demote-v1-2-eb9c9422daef@zptcorp.com>
References: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
In-Reply-To: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
 Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, 
 Raghavendra K T <rkodsara@amd.com>, 
 "Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, 
 Wei Xu <weixugc@google.com>, Xuezheng Chu <xuezhengchu@huawei.com>, 
 Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, 
 Alirad Malek <alirad.malek@zptcorp.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21950-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,linux-foundation.org,oracle.com,google.com,suse.com,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,goodmis.org,efficios.com,cmpxchg.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,stgolabs.net,gmail.com,kernel.org,amd.com,huawei.com,zptcorp.com,palyvos.net,arm.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yiannisnikolakop@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EFDDC5D500D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alirad Malek <alirad.malek@zptcorp.com>

In preparation for the following patch, add a new migrate_mode which is
still async but will use non-temporal stores. Add a helper function
that checks for both async modes and replace all plain checks of
MIGRATE_ASYNC.

Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
---
 fs/nfs/write.c                 |  2 +-
 include/linux/migrate_mode.h   |  9 +++++++++
 include/trace/events/migrate.h |  1 +
 mm/compaction.c                | 18 +++++++++---------
 mm/migrate.c                   | 12 ++++++------
 5 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1ed4b3590b1a..beae4441e080 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2119,7 +2119,7 @@ int nfs_migrate_folio(struct address_space *mapping, struct folio *dst,
 	}
 
 	if (folio_test_private_2(src)) { /* [DEPRECATED] */
-		if (mode == MIGRATE_ASYNC)
+		if (migrate_mode_is_async(mode))
 			return -EBUSY;
 		folio_wait_private_2(src);
 	}
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index 265c4328b36a..f7186e705b48 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -3,6 +3,8 @@
 #define MIGRATE_MODE_H_INCLUDED
 /*
  * MIGRATE_ASYNC means never block
+ * MIGRATE_ASYNC_NON_TEMPORAL_STORES means never block and use non-temporal
+ * stores if supported by the architecture
  * MIGRATE_SYNC_LIGHT in the current implementation means to allow blocking
  *	on most operations but not ->writepage as the potential stall time
  *	is too significant
@@ -10,10 +12,17 @@
  */
 enum migrate_mode {
 	MIGRATE_ASYNC,
+	MIGRATE_ASYNC_NON_TEMPORAL_STORES,
 	MIGRATE_SYNC_LIGHT,
 	MIGRATE_SYNC,
 };
 
+static inline bool migrate_mode_is_async(enum migrate_mode mode)
+{
+	return mode == MIGRATE_ASYNC ||
+		mode == MIGRATE_ASYNC_NON_TEMPORAL_STORES;
+}
+
 enum migrate_reason {
 	MR_COMPACTION,
 	MR_MEMORY_FAILURE,
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index cd01dd7b3640..e493207a3f46 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -9,6 +9,7 @@
 
 #define MIGRATE_MODE						\
 	EM( MIGRATE_ASYNC,	"MIGRATE_ASYNC")		\
+	EM(MIGRATE_ASYNC_NON_TEMPORAL_STORES,		"MIGRATE_ASYNC_NON_TEMPORAL_STORES")	\
 	EM( MIGRATE_SYNC_LIGHT,	"MIGRATE_SYNC_LIGHT")		\
 	EMe(MIGRATE_SYNC,	"MIGRATE_SYNC")
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..cd26781b7376 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -444,7 +444,7 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 	/* Update where async and sync compaction should restart */
 	if (pfn > zone->compact_cached_migrate_pfn[0])
 		zone->compact_cached_migrate_pfn[0] = pfn;
-	if (cc->mode != MIGRATE_ASYNC &&
+	if (!migrate_mode_is_async(cc->mode) &&
 	    pfn > zone->compact_cached_migrate_pfn[1])
 		zone->compact_cached_migrate_pfn[1] = pfn;
 }
@@ -507,7 +507,7 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	__acquires(lock)
 {
 	/* Track if the lock is contended in async mode */
-	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
+	if (migrate_mode_is_async(cc->mode) && !cc->contended) {
 		if (spin_trylock_irqsave(lock, *flags))
 			return true;
 
@@ -864,7 +864,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			return -EAGAIN;
 
 		/* async migration should just abort */
-		if (cc->mode == MIGRATE_ASYNC)
+		if (migrate_mode_is_async(cc->mode))
 			return -EAGAIN;
 
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED);
@@ -875,7 +875,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	cond_resched();
 
-	if (cc->direct_compaction && (cc->mode == MIGRATE_ASYNC)) {
+	if (cc->direct_compaction && migrate_mode_is_async(cc->mode)) {
 		skip_on_failure = true;
 		next_skip_pfn = block_end_pfn(low_pfn, cc->order);
 	}
@@ -1364,7 +1364,7 @@ static bool suitable_migration_source(struct compact_control *cc,
 	if (pageblock_skip_persistent(page))
 		return false;
 
-	if ((cc->mode != MIGRATE_ASYNC) || !cc->direct_compaction)
+	if (!migrate_mode_is_async(cc->mode) || !cc->direct_compaction)
 		return true;
 
 	block_mt = get_pageblock_migratetype(page);
@@ -1465,7 +1465,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 		return;
 
 	/* Minimise scanning during async compaction */
-	if (cc->direct_compaction && cc->mode == MIGRATE_ASYNC)
+	if (cc->direct_compaction && migrate_mode_is_async(cc->mode))
 		return;
 
 	/* Pageblock boundaries */
@@ -1705,7 +1705,7 @@ static void isolate_freepages(struct compact_control *cc)
 	block_end_pfn = min(block_start_pfn + pageblock_nr_pages,
 						zone_end_pfn(zone));
 	low_pfn = pageblock_end_pfn(cc->migrate_pfn);
-	stride = cc->mode == MIGRATE_ASYNC ? COMPACT_CLUSTER_MAX : 1;
+	stride = migrate_mode_is_async(cc->mode) ? COMPACT_CLUSTER_MAX : 1;
 
 	/*
 	 * Isolate free pages until enough are available to migrate the
@@ -2514,7 +2514,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	unsigned long start_pfn = cc->zone->zone_start_pfn;
 	unsigned long end_pfn = zone_end_pfn(cc->zone);
 	unsigned long last_migrated_pfn;
-	const bool sync = cc->mode != MIGRATE_ASYNC;
+	const bool sync = !migrate_mode_is_async(cc->mode);
 	bool update_cached;
 	unsigned int nr_succeeded = 0, nr_migratepages;
 	int order;
@@ -2537,7 +2537,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		ret = compaction_suit_allocation_order(cc->zone, cc->order,
 						       cc->highest_zoneidx,
 						       cc->alloc_flags,
-						       cc->mode == MIGRATE_ASYNC,
+						       migrate_mode_is_async(cc->mode),
 						       !cc->direct_compaction);
 		if (ret != COMPACT_CONTINUE)
 			return ret;
diff --git a/mm/migrate.c b/mm/migrate.c
index 2c3d489ecf51..ff6cf50e7b0b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -907,7 +907,7 @@ static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 
 	do {
 		if (!trylock_buffer(bh)) {
-			if (mode == MIGRATE_ASYNC)
+			if (migrate_mode_is_async(mode))
 				goto unlock;
 			if (mode == MIGRATE_SYNC_LIGHT && !buffer_uptodate(bh))
 				goto unlock;
@@ -1220,7 +1220,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	dst->private = NULL;
 
 	if (!folio_trylock(src)) {
-		if (mode == MIGRATE_ASYNC)
+		if (migrate_mode_is_async(mode))
 			goto out;
 
 		/*
@@ -1325,7 +1325,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
+		try_to_migrate(src, migrate_mode_is_async(mode) ? TTU_BATCH_FLUSH : 0);
 		old_page_state |= PAGE_WAS_MAPPED;
 	}
 
@@ -1565,7 +1565,7 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 {
 	int rc;
 
-	if (mode == MIGRATE_ASYNC) {
+	if (migrate_mode_is_async(mode)) {
 		if (!folio_trylock(folio))
 			return -EAGAIN;
 	} else {
@@ -1799,7 +1799,7 @@ static int migrate_pages_batch(struct list_head *from,
 	LIST_HEAD(dst_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 
-	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
+	VM_WARN_ON_ONCE(!migrate_mode_is_async(mode) &&
 			!list_empty(from) && !list_is_singular(from));
 
 	for (pass = 0; pass < nr_pass && retry; pass++) {
@@ -2107,7 +2107,7 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 		list_cut_before(&folios, from, &folio2->lru);
 	else
 		list_splice_init(from, &folios);
-	if (mode == MIGRATE_ASYNC)
+	if (migrate_mode_is_async(mode))
 		rc = migrate_pages_batch(&folios, get_new_folio, put_new_folio,
 				private, mode, reason, &ret_folios,
 				&split_folios, &stats,

-- 
2.43.0



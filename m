Return-Path: <linux-nfs+bounces-21951-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CRjHvaHFWpXWQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21951-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:45:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1B5D5177
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD473037F6E
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E823E5A04;
	Tue, 26 May 2026 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPrQWuk7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2113E5A18
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795476; cv=none; b=egi8xNlkICFMhkcO/565u80FiUrXJVd5mV2hUCrk8DZ2EiV0/LHXUGmzb0qpb66k/71UWmrEqcoj8WdniYcHwRsCIeHkdxmEWc0mx9ngUxHtr4wc0F+iLTlwACVOvqYhFwel7ozwn0DiJtBzSZOaUseg6ALhHJsNLhFDqr1eIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795476; c=relaxed/simple;
	bh=SwXzV8tK9BQ8QjgrG6CC7I98NvDSuaRSrOJYRNh4rFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0lNWqVPR1Dgyt6n57KSbyk6Mdom/aTdAEJrArRYPR94AmPVgS/8cC1xllfSelIibO0+W/hXrAgFkLkhjuTPpE5V3cGa0X9qy3qIxYHUTnUfTiXeX4UuidysmpuYciqwPEUSoqaVWi6wC9jVTTON8naNiFTCgH1eyQ0ZNdgCOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPrQWuk7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a858881ad2so13069994e87.3
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795462; x=1780400262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLeHkQsXAybNTL4Q4w5mxgSBDAtaR04/XoGzkQTY4uA=;
        b=cPrQWuk7sFJUVnkI4J/4xCExY/hk6221tlhx/fRQOGzXvYnbD8jjnmtRYkFbnZ/roK
         waeGXT5OZRhbCqSw5xnlFc0eASPxHOX7h50ogsv+uFqNtnKvGUUExbfF1La+W7rLN8ww
         Ldf1hFmkvdbphZQXxbd+1PFRGn37BZFi7x0doEwCnb+cJTP3EYWo/XgCk0/516EVhi36
         al3XS5e55xVWGBm4EdvarjPTK7n49WFmqJpg6ExdgNoeeQlySQkrNgXcQ/7MiCLZRjvb
         2TuEtQLcFmq6Tu9cGnsBBS55uskggQ3xq6pnvuIofrvHhlQTTN0BXOt++oBwCvRTzEQ5
         xxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795462; x=1780400262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLeHkQsXAybNTL4Q4w5mxgSBDAtaR04/XoGzkQTY4uA=;
        b=a7p0rd1Ug6VtsssE7yOYggM4HW5pnVeNQlTi5SMXl/5m5pI5ll6wEKQXoE6PQO4hKO
         ZZ4zdqsh7Sg7O7q9qYyZ7a+zl1nxcgNzg8huj7cPHuuKbXjfW6HrcsS/4niiVRkk37AG
         h2tc+VCIAbnoSUJzzOhTHfyiAP9z2H1HAlLE2McqbajP4jl84eG+gWk5LBNVaPL+cybw
         jjKE/gF2NmmzFNVvxs07LtmJ0NlGuY8Uf2EXQHTKSTcNR24U7HmTpGD1zf1rBCII7FLE
         //5UGoD5TJrFBDL91KeEDWYYSjZnVDaxL3k1l0QDEQOepvV65k+jE66kUP9BwzOyYp72
         apog==
X-Forwarded-Encrypted: i=1; AFNElJ8dQzAldLl4xXHno5NnfsnuFxS/Hk5BsL/TPcfbTyQbcyhz34C7xmJ31c2jQDA2kzv3IP97K3YVSFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7Vm5bh3nGJuwjrbzeUwbssWh7oXzdQIXtZ8sqndGSHUo0CmN
	gJzWBkJJ68JgV1Ia5kwtJDvVSs5YNvrjTSjeNg0XYtYka28v/M3pEmd3
X-Gm-Gg: Acq92OG2BOlMehAtdi0jqvyFUZiuIjH/qTU4xpsjmZcg7ZIurLfhKgiF4m8gAz+XWPR
	KJ3hfxXNFaIHnvZnF5tPXr9F8WkvVzQPMpQeETu2SU3GTjHY7wJYjKd9TLJKjLeOdUNqGAICivS
	hAIe6e4gvaBgNq8LCEPyw+nhlCCYNKG2LKkk83EVJWRWkUPjGtRs1n1TBPTuuc8FWh2H3Cg0E2V
	9gzn9L6NYgJVJ73QLh25uYZxMYKchTzRWhzGTEmc4MZsj2HSSpCqrhqRpouLhH69mjzLQih2CBV
	PrVz63wglGrhZL4f1vqxMzrrrvHYdCqfeCC5SaDPqsT9yMKSugVbYP+oxIevRBKS3Qj2lddDhGR
	EmM4tI8JXKFc6PWwoyY14udPlMCav4sXhcucvKoA/wuiUY1OudH5Gr3BAeawtwFgssY3grmWWz0
	Ik4lLX+ReuuUc3cJLF/ddSZkb1TDRWUw7razCjW3pIsrMXNKMj+d6cLktA+zQK4LYT0rk6
X-Received: by 2002:a05:6512:3b21:b0:5a4:1a2:1d39 with SMTP id 2adb3069b0e04-5aa323143camr4952108e87.6.1779795461414;
        Tue, 26 May 2026 04:37:41 -0700 (PDT)
Received: from [127.0.1.1] (h-62-63-197-109.NA.cust.bahnhof.se. [62.63.197.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa46330d9asm376332e87.59.2026.05.26.04.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:37:41 -0700 (PDT)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Tue, 26 May 2026 13:37:04 +0200
Subject: [PATCH RFC 3/3] mm: use non-temporal stores for demotion
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rfc-nt-demote-v1-3-eb9c9422daef@zptcorp.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21951-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D6D1B5D5177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alirad Malek <alirad.malek@zptcorp.com>

Memory demoted to a lower tier is assumed to be cold and most likely out of
the CPU's last level cache. Additionally, in certain demotion targets (e.g.
CXL devices with compressed memory) the bandwidth can be negatively
impacted by the eviction patterns of the last level cache when standard
memcpy is used. When the feature is enabled, use the
MIGRATE_ASYNC_NON_TEMPORAL_STORES flag in demotions to trigger the folio
copy path using non-temporal stores.

Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
---
 mm/Kconfig   | 8 ++++++++
 mm/migrate.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687..4b7a75b57f6e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -645,6 +645,14 @@ config MIGRATION
 	  pages as migration can relocate pages to satisfy a huge page
 	  allocation instead of reclaiming.
 
+config DEMOTION_WITH_NON_TEMPORAL_STORES
+	bool "Use non-temporal stores for demotion"
+	default n
+	depends on MIGRATION
+	help
+	  Enable non-temporal stores when migrating pages due to demotion.
+	  If disabled, demotion uses regular migration copy paths.
+
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
 
diff --git a/mm/migrate.c b/mm/migrate.c
index ff6cf50e7b0b..368d40dc8772 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -862,7 +862,10 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	rc = folio_mc_copy(dst, src);
+	if (mode == MIGRATE_ASYNC_NON_TEMPORAL_STORES)
+		rc = folio_mc_copy_nt(dst, src);
+	else
+		rc = folio_mc_copy(dst, src);
 	if (unlikely(rc))
 		return rc;
 
@@ -2081,6 +2084,10 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 	LIST_HEAD(split_folios);
 	struct migrate_pages_stats stats;
 
+	if (IS_ENABLED(CONFIG_DEMOTION_WITH_NON_TEMPORAL_STORES) &&
+		reason == MR_DEMOTION && mode == MIGRATE_ASYNC)
+		mode = MIGRATE_ASYNC_NON_TEMPORAL_STORES;
+
 	trace_mm_migrate_pages_start(mode, reason);
 
 	memset(&stats, 0, sizeof(stats));

-- 
2.43.0



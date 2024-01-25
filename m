Return-Path: <linux-nfs+bounces-1417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856583CCE6
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9A81F22E70
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B4C135A7C;
	Thu, 25 Jan 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UwqG0ciW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC7136643
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212426; cv=none; b=hfaChSavjmjafwqulrNw+rFM+kmPw2FFRH2T+rH5irPbZEtPgBQklEAXP35+AqUIYd6W0aCUkNHTY3dpf/SUTLX/nfgHnkL3b43XiiCiovJPhcrote5zDECFvzLqT2bn27oiMOvymACFwJQz9kR8Jb/4RvzoFyAaReM2zwD1nhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212426; c=relaxed/simple;
	bh=HYw7RJrKrn30ygP9WEHGLl9B1l9lIWNNnnl8a6T35kE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaZHp4J7g6je/OgElM/6L6+PWXUFgHA7cxTNA71q6aVZP38Gswg74dwNtROHWFm22TeityfuVvH/spqL0SYA+p21KsWgvIpSql759vL6+5L2M4nt+Bt5IyzbLtlt+X5l6x4+O7qmz3BwJBk5q834DeHtZuuPq3n2XVq0Y/WfLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UwqG0ciW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-602a0a45dd6so20432357b3.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212423; x=1706817223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhcT4LxscUNgYkzme87+B08aKhu2LGoP/3IfHmoLGzc=;
        b=UwqG0ciW8/AqiNzH7UMG/BO+wBzoDFiyeAGhg1NwJ7IzCLf9ujjc3t6Qp2SMFhRHkJ
         cPX6vGuHQkzLEZ1fPI102/qROO4fcQNBdRxv7W+RWiej32EYUEencPPM6RWqiAPInVJf
         JBTlPpy0BAjA+H03lXbMm0e8onh0/cNs8OKnGsMSYfMHdUD5H+NIbZOkkZa6Qw59/ouV
         7napX/Lbvcsp+3x02L2oKOsaYpeo6/FXpLMChZVJ0+8s35nnjLrjpqVnyeJPxtPqpWnB
         +MOSzn2ygBc6aPJAp4Fd7Zu06hR5O7PtL26Ekx0Pk3TztGG7H2Zx1zbKqZBTED6R9soD
         qM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212423; x=1706817223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhcT4LxscUNgYkzme87+B08aKhu2LGoP/3IfHmoLGzc=;
        b=ATG0jCOaRjQ/2obfCNiZCYFF7hy/+f4AbzceAH9tQ/mAcftdgkMhcWxBkj8q9QQtKx
         DrwfqFTTP4zyxyDJMr5HoNm8QQA6WRIcnTjk5HKg/cJvmF1nmIgmToeElshkzkJXbE5w
         7Bvl6B1fazhnnCxybEMFnPiAPfkcQCoLFUTi4ryWa2WN1kMFAfU66+hakU9nS0dRDA4Q
         EEi0WwHpyE4rCyoAVX5EbCU78W5Ut3aKb7oNti0VDb3EgzgSaLtHmniTRje4COZK74NQ
         ZKLOME9o/lbOzmgTpxCRyUmELAGWB7VEJHJu93giaVAr2ZScRSdcJ83X9fJDAWPdb2Yf
         Gblw==
X-Gm-Message-State: AOJu0YzrQ1sxsPSBstSJlCKkJof9qzk5HkamSDJlucEJU9Zd3gaL4cYQ
	PbgFg43r2nuQmNk2EemXoamGjcSRBlOvH3gQlRQR3y+zqhL/077aT0HVUBrGwp0iEGnsWdaBIEd
	7
X-Google-Smtp-Source: AGHT+IEcVV5FZWaZpudtF4nG/BHtMqm2Ng/XQIsRu6owITdjzD+GgBIiEqJE13QrGZJ21iHtS7ZnEg==
X-Received: by 2002:a81:ae21:0:b0:5ff:9903:8347 with SMTP id m33-20020a81ae21000000b005ff99038347mr327933ywh.64.1706212423291;
        Thu, 25 Jan 2024 11:53:43 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d134-20020a0ddb8c000000b005ffd1bf706fsm866119ywe.96.2024.01.25.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 07/13] nfsd: rename NFSD_NET_* to NFSD_STATS_*
Date: Thu, 25 Jan 2024 14:53:17 -0500
Message-ID: <3d99f0ca12126464c3cf6afa6d8cdff84bd3c5ea.1706212208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're going to merge the stats all into per network namespace in
subsequent patches, rename these nn counters to be consistent with the
rest of the stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/netns.h    | 4 ++--
 fs/nfsd/nfscache.c | 4 ++--
 fs/nfsd/stats.h    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 74b4360779a1..e3605cb5f044 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -26,9 +26,9 @@ struct nfsd4_client_tracking_ops;
 
 enum {
 	/* cache misses due only to checksum comparison failures */
-	NFSD_NET_PAYLOAD_MISSES,
+	NFSD_STATS_PAYLOAD_MISSES,
 	/* amount of memory (in bytes) currently consumed by the DRC */
-	NFSD_NET_DRC_MEM_USAGE,
+	NFSD_STATS_DRC_MEM_USAGE,
 	NFSD_NET_COUNTERS_NUM
 };
 
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 5c1a4a0aa605..3d4a9d181c43 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -687,7 +687,7 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&nn->num_drc_entries));
 	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
 	seq_printf(m, "mem usage:             %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_DRC_MEM_USAGE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_DRC_MEM_USAGE]));
 	seq_printf(m, "cache hits:            %lld\n",
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
 	seq_printf(m, "cache misses:          %lld\n",
@@ -695,7 +695,7 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "not cached:            %lld\n",
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]));
 	seq_printf(m, "payload misses:        %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_PAYLOAD_MISSES]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]));
 	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
 	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 14f50c660b61..7ed4325ac691 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -81,17 +81,17 @@ static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 amount)
 
 static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]);
 }
 
 static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_sub(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 #ifdef CONFIG_NFSD_V4
-- 
2.43.0



Return-Path: <linux-nfs+bounces-1478-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BC83DDB3
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9D21F23820
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9B1CFAD;
	Fri, 26 Jan 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LdsqhbBR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800EA1CFAB
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283647; cv=none; b=HG96Qt8NJcrho0zTKMcTI7Yd+EJL+jx5EG46/sjJU2bh8oxa1e9xajY19uEWLCsamIlFnrTZG99N90DwQad9nJvjr2/KldPoa0C9Ih3UFqUQ84r4TSbMNan92SeZGiYEKarQBU50tU/GYKrvlY1VkU4iM5wjXZuZ9l5aSWNqSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283647; c=relaxed/simple;
	bh=HYw7RJrKrn30ygP9WEHGLl9B1l9lIWNNnnl8a6T35kE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enLxWVPI/D5AVLimB5igYw4/qb6Zm7YeHnVWlIfFaerFU//FkhsQyoNK34OlHFG+qblKIWxkSZ57Vhx/SZdTHGlilcc3iIejjHIlfMrAl7siz98QaV/wGC92colGDko5h3uh2/uFXzKADIyIiFLtAtQohIfF27qb/oamAZsFu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LdsqhbBR; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6000bbdbeceso5227827b3.2
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283645; x=1706888445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhcT4LxscUNgYkzme87+B08aKhu2LGoP/3IfHmoLGzc=;
        b=LdsqhbBRNn1oom0KX5v/C/cdj83xBAkZT2z+d6vbiEq/03/twH95UyX/VrGlxDpejq
         ut1eln4qLrTDTeUOjE2l4Xzv+FirihGtoNcB2nsXjU8BNjT00lxVtFlqFxDnT7Zi0I0Y
         Foe5KDMylDOGNjmm8mqj5uFXCSedNSWMq3z8fICvAy/kcQOgahCqWVS2PySYmN3Knw27
         iXllUSYSeVlr3niiNIsvmTvVoTfCMlR8naFsg661N69mSZJw2ypCoiCauLcoP52h4r1z
         iejgGflSGEOu/d1fxLnAtSJAwMNTiXrjyFbnYMfw4cugC766m+0GsuzqwYp5ipGUl7+A
         1GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283645; x=1706888445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhcT4LxscUNgYkzme87+B08aKhu2LGoP/3IfHmoLGzc=;
        b=AMiCLzaVpVhZJ+u5TELDyumNeSq6NPf1qM7U0zbYZzigGJv4izumt+8B0LaoB4feJY
         59hBRcnIxvPK8EAybnJ45j2FsX7oIreoHUB72ryP0d8SW9hgavCQ3PQmQqrKXtBAmvm6
         LuNTHyD8P2QHKwFn+gWz3hSR2DneJ5ns0HDcnkFG5V2geACLc692jkPBpG0oAuScPxvn
         8oVTTEMddZnUcZ8uRX5pFgLYYI1BcGVCEj1qGBHsPimd+W7rwVTkp7lMLO4SKIxD/eXY
         Wk1Hpvrpx45qKxaqhK0YwbcyLMDMcBOwUUmAHn9haAgtZuZMij7Kny46ahEWEAHl8Lgo
         DEyw==
X-Gm-Message-State: AOJu0Yztfgqx2VzW3r3A8JR+diJdrsARIxaqMKNWQNLdukJpYDcsB4+s
	JsqF68LyIbMWNETghXnPdn0KT4wB5gs91gCC/rGqDLY4lcSJq4hQyAVtD24iS4dnL8za3QF2wHA
	f
X-Google-Smtp-Source: AGHT+IEOHWIu2u87Dod7bFY23DJfaz6Mw/6CqrJObtIP3GjL/qigOUdIX7UmUKCDDRaZrcvvvU9sMg==
X-Received: by 2002:a81:af21:0:b0:5ff:73d8:216f with SMTP id n33-20020a81af21000000b005ff73d8216fmr1421887ywh.17.1706283645541;
        Fri, 26 Jan 2024 07:40:45 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t16-20020a818310000000b005ff9b0ab578sm451630ywf.117.2024.01.26.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 06/10] nfsd: rename NFSD_NET_* to NFSD_STATS_*
Date: Fri, 26 Jan 2024 10:39:45 -0500
Message-ID: <abaeacbbdf2dc86eb5e6fd119304b3fa1a265c04.1706283433.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706283433.git.josef@toxicpanda.com>
References: <cover.1706283433.git.josef@toxicpanda.com>
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



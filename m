Return-Path: <linux-nfs+bounces-1479-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4383DDB6
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE180285CEC
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C91D548;
	Fri, 26 Jan 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J/C5iniv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3D1D540
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283651; cv=none; b=bQ7qJVSa0Gb05hUnV0TQ7oRSu2ebV+25LsvXuNqTLnUkr70GNNapf9lPRY8rXEbEaWWPUUQk89OxA1eo4O364qdND7hSvlSsmsXBiQQcv7eyMFkz940Hzh07rWWI2JFLTrl0jYUj7j7U8aG6UD1qRemhT/Jj3AZ/0subHWuTFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283651; c=relaxed/simple;
	bh=oIVFoPMvY5SGkisb2sELX+f9WkOpaBpUfRMWGj42rI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmYsv3J1Z3uu4meNaV5WfEndLtwxsJYhoEJe6Y+9/z6oLMy+341fajyClc/TQ+lZPLrUFURR7Cts0a7uTHYRL5jDYFR43BoYGa2SLHuoYl3pCngZDnRzOJN1PvgQFrckk15EyHmcJUpyAMvwdzOpoNiOiHLP/NfI6QZfx7hTPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J/C5iniv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5ffb07bed9bso4322727b3.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283648; x=1706888448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lbwexu1bLugmUgDGM5YUyVtPA9AXcJlbApt7mNBJh0E=;
        b=J/C5inivo00YFjUosIbTiAG7VZqwls3PYHdZWsRWmr0AMfUJBd4tHWdMZuKwA9cH0g
         geNFQQMsK+OUSpStVw2znx3Wr3lPM13KDNt4E6HT7FfT4GaSSKPo/9JP4b9kSxbc9POK
         6ikTNvLKYIrYfbDEPRe9Mtbngez+W3lVivBH7D0/psN+vwutCwEOHt0TZ67zM8uPm3oL
         UYZBC7cIFyEX62yR6WxtCkgJX7xaJYrTkfgIs29wtV2FLCmDse+Q30r8UNlIKVfiTIjT
         o7yNQ0+gmFh6iGEoGnEnkhBL5Q4JTSJBOUipTvF6M9lXpNuqySBiCQRfiqBT0ZUWf83l
         GyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283648; x=1706888448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbwexu1bLugmUgDGM5YUyVtPA9AXcJlbApt7mNBJh0E=;
        b=Wtv8MQB8sw0vpAGPEmfivaCCFXt8qRFdcoRhsnscKL3/oT5O/agQNUMHF5mV9vp+3s
         uiCIUBkRQAIklWd5+VXaTHZHAhloOwD4WjCWXa5EGhagsZ7hp9YJaudy/0HEkn6M6bUn
         3vorDJnXhEi5YD8ZTLfbHGVFL0AJfKVnPyv3aggkQCUuOzEsz27pHBOijTT1X/C06c94
         6j6WzjTUBR7AALdw56tlv7o6zQIjl6cXa8MtlUbleB87dlQB2+mlsp6oSelK1aAnLDAo
         R6Dc1YQTsYqznvIf5yVL5iF72GXzwDyx8OzFIg2TaKIl42YLvPuYOv8WQZzwC3S+y2mK
         CgBQ==
X-Gm-Message-State: AOJu0YwmF2dIxsh0DAFWKiPP/XSxW9BAldNi++gcOs01tlDl3gOHVhlK
	OcGV5yGBc3GZxYM4I8gk/z1L/eQXvoi7olbgmKQq1et3Uws9hWvmigBCwPgEc1dbxHY5EpF8Cg8
	f
X-Google-Smtp-Source: AGHT+IGDu4xwCKMiV1ANSst2cbnHwe+SwEryEXv5okihV508/hDo0dizDeSRT4pLao24X0xsOR3f2w==
X-Received: by 2002:a81:a888:0:b0:5ff:8484:9ceb with SMTP id f130-20020a81a888000000b005ff84849cebmr1190820ywh.0.1706283648540;
        Fri, 26 Jan 2024 07:40:48 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05690c34c300b005a7d46770f2sm445741ywb.83.2024.01.26.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:46 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 07/10] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Date: Fri, 26 Jan 2024 10:39:46 -0500
Message-ID: <61a1e6f96fe04204c5c9475f140d2d75b3251a77.1706283433.git.josef@toxicpanda.com>
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

We are running nfsd servers inside of containers with their own network
namespace, and we want to monitor these services using the stats found
in /proc.  However these are not exposed in the proc inside of the
container, so we have to bind mount the host /proc into our containers
to get at this information.

Separate out the stat counters init and the proc registration, and move
the proc registration into the pernet operations entry and exit points
so that these stats can be exposed inside of network namespaces.

This is an intermediate step, this just exposes the global counters in
the network namespace.  Subsequent patches will move these counters into
the per-network namespace container.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/nfsctl.c |  8 +++++---
 fs/nfsd/stats.c  | 21 ++++++---------------
 fs/nfsd/stats.h  |  6 ++++--
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f206ca32e7f5..b57480b50e35 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1679,6 +1679,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
+	nfsd_proc_stat_init(net);
 
 	return 0;
 
@@ -1699,6 +1700,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_proc_stat_shutdown(net);
 	nfsd_net_reply_cache_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
@@ -1722,7 +1724,7 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	retval = nfsd_stat_init();	/* Statistics */
+	retval = nfsd_stat_counters_init();	/* Statistics */
 	if (retval)
 		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
@@ -1762,7 +1764,7 @@ static int __init init_nfsd(void)
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
 out_free_stat:
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
@@ -1780,7 +1782,7 @@ static void __exit exit_nfsd(void)
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 12d79f5d4eb1..394a65a33942 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -108,31 +108,22 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
 		percpu_counter_destroy(&counters[i]);
 }
 
-static int nfsd_stat_counters_init(void)
+int nfsd_stat_counters_init(void)
 {
 	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-static void nfsd_stat_counters_destroy(void)
+void nfsd_stat_counters_destroy(void)
 {
 	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-int nfsd_stat_init(void)
+void nfsd_proc_stat_init(struct net *net)
 {
-	int err;
-
-	err = nfsd_stat_counters_init();
-	if (err)
-		return err;
-
-	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
-
-	return 0;
+	svc_proc_register(net, &nfsd_svcstats, &nfsd_proc_ops);
 }
 
-void nfsd_stat_shutdown(void)
+void nfsd_proc_stat_shutdown(struct net *net)
 {
-	nfsd_stat_counters_destroy();
-	svc_proc_unregister(&init_net, "nfsd");
+	svc_proc_unregister(net, "nfsd");
 }
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 7ed4325ac691..38811aa7d13e 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -40,8 +40,10 @@ extern struct svc_stat		nfsd_svcstats;
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-int nfsd_stat_init(void);
-void nfsd_stat_shutdown(void);
+int nfsd_stat_counters_init(void);
+void nfsd_stat_counters_destroy(void);
+void nfsd_proc_stat_init(struct net *net);
+void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(void)
 {
-- 
2.43.0



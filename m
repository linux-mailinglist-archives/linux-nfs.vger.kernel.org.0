Return-Path: <linux-nfs+bounces-1418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17283CCE8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABA6B23831
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0211350D7;
	Thu, 25 Jan 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UbIpu84M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD7136651
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212426; cv=none; b=Lg/qIq2RZ2QG8Q0z/Ignod7zzDj0STh/NdT6mC5Q3mOmDXN9Hxo2V68iQM2xFukdn5/ahU7Ty7aiMddPlTMs4NQ2IGnI8kLoUtVsxSPaDxHKAjJcMBZtBGnBoMSQ5BuBcVdWNrdzZyrlYs8bVEedjNaYSCUOlJ1MBRt7qJDLKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212426; c=relaxed/simple;
	bh=oIVFoPMvY5SGkisb2sELX+f9WkOpaBpUfRMWGj42rI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNhbIwoY3lH0TZ6C82YaO4qi1CIcaQIKTQSLcVfQmIEdcwl1sW+PpXFRNRw+RyQXuR8fA2jn5ALHBIlvbbABbmXnP/n28kblj+Wgd3M+C6s1gK+Vu0uQtWfcgFchnIrjaA7FJGvt/mM2SEqvu76F3UnMFHAmUTKaYRYOMKEAW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UbIpu84M; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-600094c5703so45162837b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212424; x=1706817224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lbwexu1bLugmUgDGM5YUyVtPA9AXcJlbApt7mNBJh0E=;
        b=UbIpu84MVIo7ZpJBVs5zRJS4kD5evjCaPSajZ6z19y7zXjFkNqi9IEV0QkdonM889S
         kiplLMrwm//busfOgdmWVpk6ADExDG48x3Hsqn7bFgyM63wyrZKEvqLekrW+IVCjX0wv
         nUZP51oM4k+VN84JVWYzt0y8D3/Fhj5tB/WSi9F8A7kyDxv2kl3m1VGe9UNgn4t6e8cE
         kGc87xMJv2FgSvMt4w/50J3SKk4roHFahi85XvauLZ1TMFC5e14pW5wATWsCko9o0dB9
         do4XbnuU7tTC2wEE6cVwdXvsjCnq6ATjb5epa1UzDuWeJggxuj+iVVgNcxBKFLq2BGVI
         bAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212424; x=1706817224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbwexu1bLugmUgDGM5YUyVtPA9AXcJlbApt7mNBJh0E=;
        b=lOVna9AFYtQ8YMWDPjlSnzZBSqoeXfsKeOH31+DCJnNk3QbXSruvO1JeeoWs0GyoJD
         xRCISN7preSAe7qVmudxoSHB+wQb7UdYUAOdMuMWd7I9njGl1Cgnd8klkOBRRJZP78kQ
         XCJXurZc04jXlfxtRg06ln1aCPNLH4Fup0O4LqpH/s1k2DVzO/JbA3oLrSaA9M7lwbvI
         bO1xwvoz6vUlBKcrcZuHGdrZYp92vUNXa9t4WFX/4gPfDNobsZsIVIjlJTbslrsVQzY2
         l5fh1EtXyjjg59O4prz6YXXnj6TV2CRPkTNj5yQpsj5kyDQ5DGDbQFQAafH5oP0QN0Do
         uQTw==
X-Gm-Message-State: AOJu0Yw6YskdOrOhJnKnvS5rbfywAng3+xfkueDmAQtiyvSb6PxEUgPi
	sxmMDoi1D/zs7hyk5P7myO6zfW1+PuxH1+TzAW53aw9qXiH8oFuav4bpD+xObYilIGNUrj8Mu4X
	Q
X-Google-Smtp-Source: AGHT+IHiIaa4wPOAMB1jg4O7nLL39bDUaJUlY10BVxK/XODKB4QFmv7Mm6WTwbYk+jhhZL9GK2KNYw==
X-Received: by 2002:a81:b654:0:b0:5ff:a9ae:4a81 with SMTP id h20-20020a81b654000000b005ffa9ae4a81mr304584ywk.77.1706212424204;
        Thu, 25 Jan 2024 11:53:44 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i13-20020a81d50d000000b0060022aff36dsm844514ywj.107.2024.01.25.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 08/13] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Date: Thu, 25 Jan 2024 14:53:18 -0500
Message-ID: <eb4f7d4574c9490c7c14fdd1fe0a5587d6753887.1706212208.git.josef@toxicpanda.com>
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



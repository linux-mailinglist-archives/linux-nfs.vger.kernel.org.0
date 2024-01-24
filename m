Return-Path: <linux-nfs+bounces-1313-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361783B258
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741331C223A6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C714132C1D;
	Wed, 24 Jan 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dKaj1mAS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE0132C28
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125037; cv=none; b=Kf5dXoXetJ9N83l7NPWrfBtGGYLrkSGbGn90OyKk+//iUl7Wx7/aT6OqTGqu096o5LUTsDt20DjyQQ3D+5FnmLdGr9Dc1IXZ8FckpXxEGc+OgoN02uLMpvy8OnUOFLsa/gntUxc7p4g6JjxPiM/uVq/OoNSBtt4XuI+Ql+k0bds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125037; c=relaxed/simple;
	bh=BN1JUtCYuPq7DKP5yA5dzEv5EYF+OVn2J92x5csDo5Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGb4bGRWqld2gmZgaysTeJJ/v4IH/MkWkbPG4drL+U199lYAK12+f68ViAMyNw2VbMmccuoVq6RGp94Tx6lNWVe+IUpswUELvcE3wrXsb6TnQ3zLyW83V/DmPUFrCj8gBdWB1rPPcVRGuIKJvSjeG1tLaJBSQ/paQSYwLuMLK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dKaj1mAS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff821b9acfso53694397b3.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 11:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706125034; x=1706729834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Spk/VYIUeHuyOHnuim/eYj/+nFLYxESdE8HVTIA9l9o=;
        b=dKaj1mASaMKMffSkRxGbC9o7K3hxc50EeWPtQhfe210NWLaHDhQkpjHZqxCL8EcTNm
         fpAmDgwZA+YOL0ssYayRBS5cPfqRL269V0MsnC4Yy5REYEPFDVyxmnaFNA10L8WQgORT
         /2Fus620bRT3gbOPkN2UTc6le6f80ZsnI8yUeuxEzCgsPASkGqSuRZini004rcqcOAuD
         GFKwfMrzIMsdtrLAvktKTwdw1ycirR3pWU7eLMl79VDGufYzwmI6vwfX4uOiVTRGHURt
         dG/z6hvaW+EEaP19aeBLypLFQQqFAbeWepjFdJvk2AQBdIv//iv3HThjQpBr5ja2wKaD
         bHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125034; x=1706729834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spk/VYIUeHuyOHnuim/eYj/+nFLYxESdE8HVTIA9l9o=;
        b=NLjdUfVcLUH/OY8jiXEwWTIgbDcYvs+RIh3t8a5ipSmXUNPWEFCwnAn3G16rNo1vGP
         qLIbORH4y9ixKMEBo0B4q7UO6DX8PO/yDsNfEuq5+Ri1vJkipSpnt/UCMnpMvkJdiTZT
         56vm9iob4bqgmspF3TI4pFGmJ3Xdsl4uoXtjx1OIalDe/ik8/FWPxPvbkfgdrHuojaoy
         JexFuG5CtetyzEqQahxMFI3x/tgrs1OoD1HgjvWqt/w9pZ6Zyx66lgLyOFDbzgk/lB+o
         Y/2yn/Nw7HQ0iIPKIJPjNQICbnuZktXQVVUvlGxMy4EIy48XL5o+7Y/L/3Zz4X+LqIPc
         /z1A==
X-Gm-Message-State: AOJu0Yw7z3KsJnEXKHgrJZM5yBa7SzoPIxWiO/miPTzswShfh915xsvg
	qwyUe4j79JyPcf6rfQRCk1EqKVP4H/KkiNl3wNYQzMF2+VgIY2uDch4uLFpTR08tUxhG+TDIgMJ
	9
X-Google-Smtp-Source: AGHT+IE9PRgv2g9d/SjYsNAmx6VHXDVeR0jvO0ET5wfmSCXmPBw8qGvEqurmkl+FTd4eqi8yJHTaBg==
X-Received: by 2002:a81:7c8a:0:b0:600:ec7f:5442 with SMTP id x132-20020a817c8a000000b00600ec7f5442mr1329587ywc.70.1706125034240;
        Wed, 24 Jan 2024 11:37:14 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t18-20020a818312000000b005ffa3fa57f9sm144065ywf.51.2024.01.24.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:37:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Date: Wed, 24 Jan 2024 14:37:00 -0500
Message-ID: <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706124811.git.josef@toxicpanda.com>
References: <cover.1706124811.git.josef@toxicpanda.com>
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
index 14f50c660b61..5cd6517b52a9 100644
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



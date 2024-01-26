Return-Path: <linux-nfs+bounces-1481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE2A83DDB9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E6B22650
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6291CFBC;
	Fri, 26 Jan 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HPnCP5NH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80111CFBF
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283660; cv=none; b=ouYMg+q3aQJOvm2Fy56DxJpAyjghkLi/GV0RpUbg67EGT6yDKS86bFW43HkEEpZV5D1LJN/kZu9PaR9J6N6a/R5WbkWDZhS0DA3hme1CYmE2061XpkyxA4zC8FVjYbpkJceNojS3q8kYLUEdMmN9LLODiPtwkuw2/+Nksf3mnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283660; c=relaxed/simple;
	bh=35jsdxf8lwzU36VgGl//nJgt1RwsHszFXySzzFXvlUk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlPb82bMorV6fqYE6hooNDLMlDA7JjoeydKatpnVaWptE1PwbZX3eztw8H1lIijYDfKIcGSMdIYvdVMwivQbIMhAYyOByE5qwmC3Rd51gQ1XV/Gd0csu7PXEM0mHK90LMUgaoqcdo8VvdFC/MzVrVqQC8i30nAcVYGK+vG/+jbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HPnCP5NH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-602d222c078so4488247b3.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283658; x=1706888458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9HH43wDjRvJ0WXW6QamUAjH4CWIkZZgYv2Lp+qh0h0=;
        b=HPnCP5NHtzHPRCR1bNiGq0IsU3o1PQOr2QstE8G9/37j8YkMLzujk1pe7jRqQvR/LO
         QjY8sArTYhzffL5Z/ocvtD9DGYutJqXKF1hSGh0sZz5g6+1ayd5+fMS0O6PLdEo5vIF1
         QPSx0dtxoS7SFIUy7vevIxPEs8Cu5UdFk+tcd3FUKdUbBWdyP0UZ4iR8k2XRg4KMOuOc
         ecSEZNLxMk2L5vn/2joEGWw7GRVjaKwUn+GEpK/TkpwXIzQL9qAEvI+AvqqtlRU9zRz+
         MSRJ4s1CJLljlDlv8VsS6UKRqbb0V1jCOmN4rJCXuy02zvHj2I1kGrO6KeM4F7ynyAOF
         Zvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283658; x=1706888458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9HH43wDjRvJ0WXW6QamUAjH4CWIkZZgYv2Lp+qh0h0=;
        b=FqWYavGxHf1Wyd+TN0YMF5eEsltjFrHJft2f5L7/mCiemyMJ46+SpfoEU1+L2qvwOY
         0WIsgOyx1577iKVX4pfZ41UBBk3YFGSTnHGU06Nqqc5rr4kVN7rsUFC/y6VOn12roWI0
         lVoZax1jJkZmOmvj39Zvxj+R7i1kERMxQ50jpG5biP6sdFiV8pfI/VHkTxPB6ZIE2f5N
         NWM4RyLh+5K7i9kyCenUz5YC2hVFf/WtVHdPN4oiftqWJxdifs/dUPBSwdSYi/6Kymoo
         +qD+ROycWj28ItLzHV8FZWYrrHJnPiz4r9TSb82kBiPixyUFOi3xOLEKD7zkurctw+Hv
         WkWQ==
X-Gm-Message-State: AOJu0YxijiaEzfxi/0F91W7fOPo4b98amcdaXOrDMcaMUwVsCfgoLNF/
	UA0uW1f6UR7Xnswv2WjHLl5qrnS8jROMzlTPPBPmMzC2dZePcnsYo9prZqXJEeU=
X-Google-Smtp-Source: AGHT+IEQNYP3HwnFO0fiptekPvQ75rJkFQLmTzRzslE6AvL0SYO3kee72dCCzOJoRfAwdwz3cPsAGA==
X-Received: by 2002:a81:4053:0:b0:5ff:7c9a:8385 with SMTP id m19-20020a814053000000b005ff7c9a8385mr1416923ywn.67.1706283657721;
        Fri, 26 Jan 2024 07:40:57 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05690c010300b005ff952f0073sm453512ywb.11.2024.01.26.07.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 10/10] nfsd: make svc_stat per-network namespace instead of global
Date: Fri, 26 Jan 2024 10:39:49 -0500
Message-ID: <256921ebcb66d444fba600fbf478dc8d556e22ea.1706283433.git.josef@toxicpanda.com>
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

The final bit of stats that is global is the rpc svc_stat.  Move this
into the nfsd_net struct and use that everywhere instead of the global
struct.  Remove the unused global struct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/netns.h  |  4 ++++
 fs/nfsd/nfsctl.c |  2 ++
 fs/nfsd/nfssvc.c |  2 +-
 fs/nfsd/stats.c  | 10 ++++------
 fs/nfsd/stats.h  |  2 --
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0cef4bb407a9..afc16ee4da74 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -14,6 +14,7 @@
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
+#include <linux/sunrpc/stats.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -179,6 +180,9 @@ struct nfsd_net {
 	/* Per-netns stats counters */
 	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
 
+	/* sunrpc svc stats */
+	struct svc_stat          nfsd_svcstats;
+
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ea3c8114245c..5a5547bd6ecf 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1674,6 +1674,8 @@ static __net_init int nfsd_net_init(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
+	nn->nfsd_svcstats.program = &nfsd_program;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fdb591896430..c0d17b92b249 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -661,7 +661,7 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 3a7f791c3052..be52fb1e928e 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -27,10 +27,6 @@
 
 #include "nfsd.h"
 
-struct svc_stat		nfsd_svcstats = {
-	.program	= &nfsd_program,
-};
-
 static int nfsd_show(struct seq_file *seq, void *v)
 {
 	struct net *net = pde_data(file_inode(seq->file));
@@ -56,7 +52,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 	seq_puts(seq, "\nra 0 0 0 0 0 0 0 0 0 0 0 0\n");
 
 	/* show my rpc info */
-	svc_seq_show(seq, &nfsd_svcstats);
+	svc_seq_show(seq, &nn->nfsd_svcstats);
 
 #ifdef CONFIG_NFSD_V4
 	/* Show count for individual nfsv4 operations */
@@ -121,7 +117,9 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 
 void nfsd_proc_stat_init(struct net *net)
 {
-	svc_proc_register(net, &nfsd_svcstats, &nfsd_proc_ops);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 5675d283a537..d2753e975dfd 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,8 +10,6 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-extern struct svc_stat		nfsd_svcstats;
-
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-- 
2.43.0



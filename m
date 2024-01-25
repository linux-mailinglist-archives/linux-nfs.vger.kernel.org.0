Return-Path: <linux-nfs+bounces-1421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300983CCE9
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D644B290BF8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF21350EE;
	Thu, 25 Jan 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BOqS5MM+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0C13666B
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212430; cv=none; b=UaoTrn3OoOvtOLrMomsrlSteEicHN/pbYA7Rl72UYiA5mVSWfO4ZT/4gM5jmD0a+/+FJE74zLtS4m6tJyad147Y7MhL4I/voMIbuhgntT0Bn3zUReAriq3bgfdbT5Gn6ygt8XImJG2oAf/mQzKXa8TCfkKFPr8V/aOqkid5iJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212430; c=relaxed/simple;
	bh=IX7p0SsOy1Dkkd3HatPleJ0FZisFP0H+hR0nLdYx1Xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iesg4eQ0IB71mDpSnm746d82IfzDUVtygQTFG74zIF5W+YL35o+WWPsDAHywxbZ26g1e/EYOefPMjv0uoZVrTeZwTdXD1MeZIQLrs97OcKzXRSQ7f00HPXTctDHmopZ3m7fuDuxkI/4nN2XXw8oQi+vt4GNY8fBvGfw5P+yD9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BOqS5MM+; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60032f9e510so29141307b3.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212427; x=1706817227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU+BKQwdeLARoJuGNZq8IqNPghLfsVNLxT7WEA+90mQ=;
        b=BOqS5MM+iFcO47fbqOWmqsWg3iQ2KBc7VAJOCOzsFGJZjkkPJywGmC/xI24gmuMAhz
         JB2FLc/uiv8lOx5ZRaQPu0k+8g0AUNhIyvyctkF5034fRLmu0U3aPKF5z/Vg4RIXLwLn
         rzsPu5L8GuZTUuTTo++wcV7PNiLZ6cr7pD6otZ9+nzdpWbZPHKpYyJi6MctH59WkzMdE
         hG0xw7VNbfjsP9lzdBpExkjfkuHtLq/h5uAf578gzFQjbYjGVmGrOQC0qmcozPsr+BmF
         HIgRgFewPvFW9uSpWsgTruvB4e4BS6jJLdBcn4q4Wps4eaqomST4csdFzU1fZ/VdTUKr
         5D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212427; x=1706817227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU+BKQwdeLARoJuGNZq8IqNPghLfsVNLxT7WEA+90mQ=;
        b=eUyo4hrBGmm2E2uhpMVz4brq3GVWfme7O9sf814MaPlwZ6uyUUF1mvAW48l+KwDAbc
         unqKOWiwjlBPXxtH7L7P8nSZ3PSU1/kh+Q80bs7A9CyVNF7S+x+swuiFP3Ayx5j/agcX
         v267AHm0+mig/VGhv4n0vFH7ixF8dNe7XTSHoybWxh4Op5AHSKiI4uVH9qFIm+JpATdS
         KHBPSzyu2UBR5QRiiHg5QyBc1nwGED4j6zotbfOD+jYMV5O7Kl+C1837rlJvhaohYLEM
         ONFVGwhNncSwp/hWr+SLiDlLQvNKbz7UHQ2OykbDIcaYJVgn7SjL8l8oPyjqYO0zjspU
         f8hg==
X-Gm-Message-State: AOJu0Yw12dHgHXHpvXj3Hd4qSiRRCHF+Ep4Ljq1x81htZYHBwYxR94Hb
	pyZH24NYLia0LkwnHzdJdl6EyujcV5U2hLqCF3IM/tAFmOuSCHq+bY9s0Mm42fFZTrhfQL7um9Y
	A
X-Google-Smtp-Source: AGHT+IHTZk9ncjBjmgQDDt9JWcrRaHkAWug8eOm2f8Yi8Z8JzyAWLdQTSmCk0SSAtb3hBJLZ3xMGIw==
X-Received: by 2002:a81:b510:0:b0:5ff:9236:10df with SMTP id t16-20020a81b510000000b005ff923610dfmr365144ywh.84.1706212427205;
        Thu, 25 Jan 2024 11:53:47 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cm30-20020a05690c0c9e00b005ff928d6effsm860856ywb.33.2024.01.25.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:46 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 11/13] nfsd: make svc_stat per-network namespace instead of global
Date: Thu, 25 Jan 2024 14:53:21 -0500
Message-ID: <e737f795e845b71af01c867d933ac05d9759daef.1706212208.git.josef@toxicpanda.com>
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
index 8d3f4cb7cab4..8fa23898669d 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -14,6 +14,7 @@
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
+#include <linux/sunrpc/stats.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -182,6 +183,9 @@ struct nfsd_net {
 	/* number of available threads */
 	atomic_t                 th_cnt;
 
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
index 0961b95dcef6..ee39d4702811 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -660,7 +660,7 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 360e6dbf4e5c..06f52dcda528 100644
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
@@ -122,7 +118,9 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 
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



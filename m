Return-Path: <linux-nfs+bounces-1482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD6D83DDB8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5712854A9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BCA1CFB9;
	Fri, 26 Jan 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i5cTa61D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA91D524
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283662; cv=none; b=etnbAQco57w/BlKjK3Nyjhoa1wc6Kex4CK0SccQhgPs4Uo7hR+F9WubfrVC3t8UtDua6us9UJ7Kpx3hF7giBsRSyOyCmI3imp4Zm7uQ3NHrZaliWcrDZKeuQA9ETit0cK+g6pBPePSTMspMMSIWrzsRE3B1kNAjDLXn5qNRtFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283662; c=relaxed/simple;
	bh=XVUiwQC+0YilvbaR+oiwWjwFj6Pyk15nYvK4RhtdrCU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAxoKcdY5FtPzT+kufTJwnKPIBTIS/Y1t3JWKJcQQM+Hk79FCXqGvmbCLwCICP92ErKDYZxaCW0eHKCPLv2R8V7afbblVlufsc2SpcrIkzTdDAJvi+NGW4DsnSXms2gGUogmmI9bqaAXKS0fbCOTMmyLnlGSeiJbPBKIoPr0lD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i5cTa61D; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6029e069e08so11122957b3.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283659; x=1706888459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma8D8+vSeMOLIk2YLj9dZoxswjw1aUIA8yxKLapIACg=;
        b=i5cTa61DXYAed7BgMmdFRB1DXwj/rG7qSRUpnsZKw8uCdzcTM2EbkPzGupEnYcNBTK
         Sm7VO7eVYXzrVsULkoJBFj9h75C2B3CGNo2Np9gVA0k89IT6gDBakVs8+xTqeSI1mNG2
         ZVjF79yasGcAXpQxLZ1a0AmvFfygVc/TUQg6qy2VA1c8FUrRaHJQvEDxCPIIIV2J85Cz
         QDsVpyNddp0KbDVECkyE23Ky+j3YdIq/UMQZvlcFwF7haagT71prFSH/FxbpEbttrATO
         VUDsw9+yVgHqOwvOBvlzPshn6pRrY9H3JzLKGmtGAJWbivTJMggZTtVwJaKpt7cOQAGD
         bjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283659; x=1706888459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma8D8+vSeMOLIk2YLj9dZoxswjw1aUIA8yxKLapIACg=;
        b=Cp3/pDyc4qpO33a9PEhjhX0yukmo+9KJBHP/GmSnbCNh+uWkzQepAjz6TRNVcrxfO7
         lzEMAq5itPnwAjMPL1fbagSTewSINkbtXEkG0qpuyna63obK5qRJpOUct0s/esI6WJND
         jztJa0KFEqcZvEetWi7pYg5OBOC40TlXB9AZ8g9JpQ/IcrxDgmsQFA9gegqMxN6t/z14
         Uj6q8ciMJtoXDzVhXw8GLlvF9v+jIZFZfOBVlHGUttGzIepYLKeR/OR+1BJLoZkLDDgZ
         83CTuKgk/hVUbmU7N0+nA4OZt8NnxNC5F2Ng/Q/3fLOV9PjhrTb5TTy3vAB+H3TARTXy
         rUVA==
X-Gm-Message-State: AOJu0YxPYOGz3U9c0cFlZ1owVtbZ2zONRARUGITsv1gH4nzX36742U9D
	nFqt5QTRI8Y2ChQHXGhR4ggdeuFq0IgpBFPRgpuT7o5EW2mOR+xIHMksTMl0rIs=
X-Google-Smtp-Source: AGHT+IHbG4jjEAhM9YPHNuTXTmG7pBvkCuYhVy0aQ8q481jiRSn2kxIZ7asgvNJaZ1LNdmVMAbStGA==
X-Received: by 2002:a0d:ca8f:0:b0:5ff:afe5:2515 with SMTP id m137-20020a0dca8f000000b005ffafe52515mr1388025ywd.82.1706283654680;
        Fri, 26 Jan 2024 07:40:54 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g81-20020a0ddd54000000b005ff7cda85c5sm451946ywe.69.2024.01.26.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/10] nfsd: remove nfsd_stats, make th_cnt a global counter
Date: Fri, 26 Jan 2024 10:39:48 -0500
Message-ID: <ee68eca2933b2ad10fb61d40484e74003d427a3b.1706283433.git.josef@toxicpanda.com>
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

This is the last global stat, take it out of the nfsd_stats struct and
make it a global part of nfsd, report it the same as always.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/nfsd.h   | 1 +
 fs/nfsd/nfssvc.c | 5 +++--
 fs/nfsd/stats.c  | 3 +--
 fs/nfsd/stats.h  | 6 ------
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 304e9728b929..be2ea3d6d2a2 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -86,6 +86,7 @@ extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
 extern unsigned long		nfsd_drc_max_mem;
 extern unsigned long		nfsd_drc_mem_used;
+extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d98a6abad990..fdb591896430 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
+atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -924,7 +925,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	atomic_inc(&nfsdstats.th_cnt);
+	atomic_inc(&nfsd_th_cnt);
 
 	set_freezable();
 
@@ -940,7 +941,7 @@ nfsd(void *vrqstp)
 		nfsd_file_net_dispose(nn);
 	}
 
-	atomic_dec(&nfsdstats.th_cnt);
+	atomic_dec(&nfsd_th_cnt);
 
 out:
 	/* Release the thread */
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 44e275324b06..3a7f791c3052 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -27,7 +27,6 @@
 
 #include "nfsd.h"
 
-struct nfsd_stats	nfsdstats;
 struct svc_stat		nfsd_svcstats = {
 	.program	= &nfsd_program,
 };
@@ -47,7 +46,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
-	seq_printf(seq, "th %u 0", atomic_read(&nfsdstats.th_cnt));
+	seq_printf(seq, "th %u 0", atomic_read(&nfsd_th_cnt));
 
 	/* deprecated thread usage histogram stats */
 	for (i = 0; i < 10; i++)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index c24be4ddbe7d..5675d283a537 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,12 +10,6 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-struct nfsd_stats {
-	atomic_t	th_cnt;		/* number of available threads */
-};
-
-extern struct nfsd_stats	nfsdstats;
-
 extern struct svc_stat		nfsd_svcstats;
 
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
-- 
2.43.0



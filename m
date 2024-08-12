Return-Path: <linux-nfs+bounces-5337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2643D94F9BB
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A701C2234B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0019198A05;
	Mon, 12 Aug 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6eOyVq5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88233197A92;
	Mon, 12 Aug 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502285; cv=none; b=K++vpPj8t2DP3D3D3cxzmmfNiXHcrRRvLpScJVzTH9w2b5VqEKbwCM+gS+fCWQjwci73LE2Bmh0JyUNICZrNZV9X+2Fkqr9AtuCDm6nNl2kIs3uRiQaDacC1tXYxnlnnSUx6BERSyWJYVWBOnizfwXbrvlFMo68moqtPk79X7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502285; c=relaxed/simple;
	bh=CH2kfhljhSFuHCmJfSkzEL7l+TDD0yWCf2eyQV0qNAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT3JF4FM2bxk4rkC0E8cB0cStwtKPmDOYJNcLf/hgm0CxTYwl1zFliqr5eg/DVA5oIM811/uY36+hsoUJRVX9pdugluzPggLM1k98w7jL9PWTtHM0JlLDLOVtLptQO6rNTFFRYbXuh2irVPzLm/IwT2ELWPWgfhdrBbafqZgnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6eOyVq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E53BC4AF0E;
	Mon, 12 Aug 2024 22:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502285;
	bh=CH2kfhljhSFuHCmJfSkzEL7l+TDD0yWCf2eyQV0qNAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6eOyVq5SsI9NZzX8NlBsF9T2KeRwPEqCoedKE1x1jLxeCeNYI+pBQfctot6IvgYE
	 a00VbO+8Ooh8XogJIIRHgMqrklgYujHLyEUKWrFOCFLPK5cu/IeV/N7RU1jyV3Z09P
	 9fuXzV24qz/XjOdsUXuj/nGr2uAFNywQs+E7TFvqd+hFBkkZzGktBCE+tNXe5ggC7P
	 QXobs9Fd/di4aoR6zieWKUl83B14J8cdfqAN0whZ/QMMnIoUqS47RsdtgkCdSjilwj
	 IhGZT0bf2Zet8DXovUKJ8Stlyncn+hmiE1YLfurhUtXX995lTUIYDarU3s2q48hv2V
	 OdhKP+bqW1KEg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 11/12] nfsd: remove nfsd_stats, make th_cnt a global counter
Date: Mon, 12 Aug 2024 18:36:03 -0400
Message-ID: <20240812223604.32592-12-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
References: <20240812223604.32592-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit e41ee44cc6a473b1f414031782c3b4283d7f3e5f ]

This is the last global stat, take it out of the nfsd_stats struct and
make it a global part of nfsd, report it the same as always.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h   | 1 +
 fs/nfsd/nfssvc.c | 5 +++--
 fs/nfsd/stats.c  | 3 +--
 fs/nfsd/stats.h  | 6 ------
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index fe846a360ae1..d05bd2b811f3 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -69,6 +69,7 @@ extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
 extern unsigned long		nfsd_drc_max_mem;
 extern unsigned long		nfsd_drc_mem_used;
+extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index acb1c1242005..e9689db75f63 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
+atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -945,7 +946,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	atomic_inc(&nfsdstats.th_cnt);
+	atomic_inc(&nfsd_th_cnt);
 
 	set_freezable();
 
@@ -959,7 +960,7 @@ nfsd(void *vrqstp)
 		svc_recv(rqstp);
 	}
 
-	atomic_dec(&nfsdstats.th_cnt);
+	atomic_dec(&nfsd_th_cnt);
 
 out:
 	/* Release the thread */
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index db95c4f34b0e..276bbcd59cdb 100644
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
2.45.1



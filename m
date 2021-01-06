Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382522EBAE1
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jan 2021 08:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbhAFHxi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jan 2021 02:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbhAFHxg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jan 2021 02:53:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01797C061358
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 23:52:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 3so1784017wmg.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 23:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K5dk8yI9EiYDA51rzx47W+4F698q0DNYBCqjWhs9FxU=;
        b=PppxN7whZ9c9BqQYezorLicffdzE1rvd7weZdsfKFqqWfa9HcfHV7OapoRWAiTw8S3
         y2X1pFDyfpZFrbJnKGmMuxPDpbwTd+7m+tuSViFbxpU1PagU/sDgrcJakFjpme5ifE4v
         QHCxCnSaU3WOD7Ymq0rwgj1boVQa+92P8NGeW4yINfAfRLsMDzUP2yxC94OGQFDLOibu
         OypUJJlkrDFmOXNzah9gulAALCe52Nb1QfDotAv2gFK5PQtTnQR4P48rF9gxfCOpEIoH
         bLzFI0eg2lwMVWIBce95RHdxYiFIxWeTcS9ErK5S1p7KgaouErb5zyVAsHpWWM2ZlIlk
         pPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K5dk8yI9EiYDA51rzx47W+4F698q0DNYBCqjWhs9FxU=;
        b=WoAV9uZR9HG3BvDGqK1doFOXWg6NdTc4+6ISpBRWHE9ozmWqEfNq46LUO/eGc9JGtC
         K743LaaUahU5DR+akTWDpTRF8N4Fy9fkAS0CPFv1V2igwMgG+t1i/nIPDzNK6w75QhYN
         6Pqg1o8L6ssuB7DUkmWBPEG+BHzoj36iAY3o6nMPpPw6z+fH+ZPUJnId7B4F7dKqAo7t
         e7hZ1TIjaLx1Ulc6iS4sErnzrS4Y7vfP0Bz6yCyb7RVq9iL1atixiOtvBc9L8x9m/rrj
         cgq3l/1KF7tEMGH5fh6oot/XuQHn4wKQaQlHyUoVMi/dl6qi67ZKmsavXXn8phWP6x6E
         KBQA==
X-Gm-Message-State: AOAM531bbv/sRlbrp34f7yDLt83SfsT2XP/W3KJN0H5BvHU/t3orDXKk
        KLbSnhxJx9WEquRegUhDPbo=
X-Google-Smtp-Source: ABdhPJxR8qCsU2F4yhX84fELZrUdNBBCapWFWq7zlFdqUYRRStaANqkcaNOgXWov94x6FCuVvJtcgA==
X-Received: by 2002:a05:600c:410d:: with SMTP id j13mr2515988wmi.95.1609919574706;
        Tue, 05 Jan 2021 23:52:54 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id h16sm1865536wmb.41.2021.01.05.23.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 23:52:53 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] nfsd: report per-export stats
Date:   Wed,  6 Jan 2021 09:52:36 +0200
Message-Id: <20210106075236.4184-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106075236.4184-1-amir73il@gmail.com>
References: <20210106075236.4184-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Collect some nfsd stats per export in addition to the global stats.

A new nfsdfs export_stats file is created.  It uses the same ops as the
exports file to iterate the export entries and we use the file's name to
determine the reported info per export.  For example:

 $ cat /proc/fs/nfsd/export_stats
 # Version 1.1
 # Path Client Start-time
 #	Stats
 /test	localhost	92
	fh_stale: 0
	io_read: 9
	io_write: 1

Every export entry reports the start time when stats collection
started, so stats collecting scripts can know if stats where reset
between samples.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/export.c | 68 ++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/export.h | 15 +++++++++++
 fs/nfsd/nfsctl.c |  3 +++
 fs/nfsd/nfsd.h   |  2 +-
 fs/nfsd/nfsfh.c  |  4 +--
 fs/nfsd/stats.h  | 12 ++++++---
 fs/nfsd/vfs.c    |  4 +--
 7 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 81e7bb12aca6..7c863f2c21e0 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -331,12 +331,29 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
 	fsloc->locations = NULL;
 }
 
+static int export_stats_init(struct export_stats *stats)
+{
+	stats->start_time = ktime_get_seconds();
+	return nfsd_percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM);
+}
+
+static void export_stats_reset(struct export_stats *stats)
+{
+	nfsd_percpu_counters_reset(stats->counter, EXP_STATS_COUNTERS_NUM);
+}
+
+static void export_stats_destroy(struct export_stats *stats)
+{
+	nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
+}
+
 static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
+	export_stats_destroy(&exp->ex_stats);
 	kfree(exp->ex_uuid);
 	kfree_rcu(exp, ex_rcu);
 }
@@ -692,22 +709,47 @@ static void exp_flags(struct seq_file *m, int flag, int fsid,
 		kuid_t anonu, kgid_t anong, struct nfsd4_fs_locations *fslocs);
 static void show_secinfo(struct seq_file *m, struct svc_export *exp);
 
+static int is_export_stats_file(struct seq_file *m)
+{
+	/*
+	 * The export_stats file uses the same ops as the exports file.
+	 * We use the file's name to determine the reported info per export.
+	 * There is no rename in nsfdfs, so d_name.name is stable.
+	 */
+	return !strcmp(m->file->f_path.dentry->d_name.name, "export_stats");
+}
+
 static int svc_export_show(struct seq_file *m,
 			   struct cache_detail *cd,
 			   struct cache_head *h)
 {
-	struct svc_export *exp ;
+	struct svc_export *exp;
+	bool export_stats = is_export_stats_file(m);
 
-	if (h ==NULL) {
-		seq_puts(m, "#path domain(flags)\n");
+	if (h == NULL) {
+		if (export_stats)
+			seq_puts(m, "#path domain start-time\n#\tstats\n");
+		else
+			seq_puts(m, "#path domain(flags)\n");
 		return 0;
 	}
 	exp = container_of(h, struct svc_export, h);
 	seq_path(m, &exp->ex_path, " \t\n\\");
 	seq_putc(m, '\t');
 	seq_escape(m, exp->ex_client->name, " \t\n\\");
+	if (export_stats) {
+		seq_printf(m, "\t%lld\n", exp->ex_stats.start_time);
+		seq_printf(m, "\tfh_stale: %lld\n",
+			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_FH_STALE]));
+		seq_printf(m, "\tio_read: %lld\n",
+			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_READ]));
+		seq_printf(m, "\tio_write: %lld\n",
+			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_WRITE]));
+		seq_putc(m, '\n');
+		return 0;
+	}
 	seq_putc(m, '(');
-	if (test_bit(CACHE_VALID, &h->flags) && 
+	if (test_bit(CACHE_VALID, &h->flags) &&
 	    !test_bit(CACHE_NEGATIVE, &h->flags)) {
 		exp_flags(m, exp->ex_flags, exp->ex_fsid,
 			  exp->ex_anon_uid, exp->ex_anon_gid, &exp->ex_fslocs);
@@ -748,6 +790,7 @@ static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
 	new->ex_layout_types = 0;
 	new->ex_uuid = NULL;
 	new->cd = item->cd;
+	export_stats_reset(&new->ex_stats);
 }
 
 static void export_update(struct cache_head *cnew, struct cache_head *citem)
@@ -780,10 +823,15 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
 static struct cache_head *svc_export_alloc(void)
 {
 	struct svc_export *i = kmalloc(sizeof(*i), GFP_KERNEL);
-	if (i)
-		return &i->h;
-	else
+	if (!i)
+		return NULL;
+
+	if (export_stats_init(&i->ex_stats)) {
+		kfree(i);
 		return NULL;
+	}
+
+	return &i->h;
 }
 
 static const struct cache_detail svc_export_cache_template = {
@@ -1245,10 +1293,14 @@ static int e_show(struct seq_file *m, void *p)
 	struct cache_head *cp = p;
 	struct svc_export *exp = container_of(cp, struct svc_export, h);
 	struct cache_detail *cd = m->private;
+	bool export_stats = is_export_stats_file(m);
 
 	if (p == SEQ_START_TOKEN) {
 		seq_puts(m, "# Version 1.1\n");
-		seq_puts(m, "# Path Client(Flags) # IPs\n");
+		if (export_stats)
+			seq_puts(m, "# Path Client Start-time\n#\tStats\n");
+		else
+			seq_puts(m, "# Path Client(Flags) # IPs\n");
 		return 0;
 	}
 
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index e7daa1f246f0..ee0e3aba4a6e 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -6,6 +6,7 @@
 #define NFSD_EXPORT_H
 
 #include <linux/sunrpc/cache.h>
+#include <linux/percpu_counter.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -46,6 +47,19 @@ struct exp_flavor_info {
 	u32	flags;
 };
 
+/* Per-export stats */
+enum {
+	EXP_STATS_FH_STALE,
+	EXP_STATS_IO_READ,
+	EXP_STATS_IO_WRITE,
+	EXP_STATS_COUNTERS_NUM
+};
+
+struct export_stats {
+	time64_t		start_time;
+	struct percpu_counter	counter[EXP_STATS_COUNTERS_NUM];
+};
+
 struct svc_export {
 	struct cache_head	h;
 	struct auth_domain *	ex_client;
@@ -62,6 +76,7 @@ struct svc_export {
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
 	struct rcu_head		ex_rcu;
+	struct export_stats	ex_stats;
 };
 
 /* an "export key" (expkey) maps a filehandlefragement to an
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 258605ee49b8..4f6e514192bd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -32,6 +32,7 @@
 enum {
 	NFSD_Root = 1,
 	NFSD_List,
+	NFSD_Export_Stats,
 	NFSD_Export_features,
 	NFSD_Fh,
 	NFSD_FO_UnlockIP,
@@ -1348,6 +1349,8 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	static const struct tree_descr nfsd_files[] = {
 		[NFSD_List] = {"exports", &exports_nfsd_operations, S_IRUGO},
+		/* Per-export io stats use same ops as exports file */
+		[NFSD_Export_Stats] = {"export_stats", &exports_nfsd_operations, S_IRUGO},
 		[NFSD_Export_features] = {"export_features",
 					&export_features_operations, S_IRUGO},
 		[NFSD_FO_UnlockIP] = {"unlock_ip",
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index d63cf8196fed..8bdc37aa2c2e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -24,8 +24,8 @@
 #include <uapi/linux/nfsd/debug.h>
 
 #include "netns.h"
-#include "stats.h"
 #include "export.h"
+#include "stats.h"
 
 #undef ifdebug
 #ifdef CONFIG_SUNRPC_DEBUG
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 9e31b2b5c6d2..4744a276058d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -349,7 +349,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 __be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
-	struct svc_export *exp;
+	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
 	__be32		error;
 
@@ -422,7 +422,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	}
 out:
 	if (error == nfserr_stale)
-		nfsd_stats_fh_stale_inc();
+		nfsd_stats_fh_stale_inc(exp);
 	return error;
 }
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 87c3150c200f..51ecda852e23 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -59,19 +59,25 @@ static inline void nfsd_stats_rc_nocache_inc(void)
 	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
 }
 
-static inline void nfsd_stats_fh_stale_inc(void)
+static inline void nfsd_stats_fh_stale_inc(struct svc_export *exp)
 {
 	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
+	if (exp)
+		percpu_counter_inc(&exp->ex_stats.counter[EXP_STATS_FH_STALE]);
 }
 
-static inline void nfsd_stats_io_read_add(s64 amount)
+static inline void nfsd_stats_io_read_add(struct svc_export *exp, s64 amount)
 {
 	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
+	if (exp)
+		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_READ], amount);
 }
 
-static inline void nfsd_stats_io_write_add(s64 amount)
+static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 amount)
 {
 	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
+	if (exp)
+		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_WRITE], amount);
 }
 
 static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d560c1bb2ec2..d316e11923c5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -889,7 +889,7 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
-		nfsd_stats_io_read_add(host_err);
+		nfsd_stats_io_read_add(fhp->fh_export, host_err);
 		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
@@ -1040,7 +1040,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		goto out_nfserr;
 	}
 	*cnt = host_err;
-	nfsd_stats_io_write_add(*cnt);
+	nfsd_stats_io_write_add(exp, *cnt);
 	fsnotify_modify(file);
 
 	if (stable && use_wgather) {
-- 
2.17.1


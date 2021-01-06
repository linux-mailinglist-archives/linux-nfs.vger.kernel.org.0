Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB32EBADE
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jan 2021 08:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbhAFHxe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jan 2021 02:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbhAFHxd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jan 2021 02:53:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97298C06134D
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 23:52:52 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c133so1649034wme.4
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 23:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cQKvk64LOd97opM3wH8HCf9LS0nGx3hkLOgXPc66S9A=;
        b=DGsGgCuPUZyQ26QfW1Mo/xxGtQy2V6reQYbgsbHwwBJlPJzXrGLlFtofvjV29P2xGD
         0Gfc2FKaVwoCZZ9Iq+XpKJnwEh+8PF+H7L1KYR71cWw85qPkvtIfytQjY3DGy8+mFqNx
         EkbVeJRJNnzBzgGz7ypG7OzEeS7laWIuePNoyQCVSQ9ZGohDwPMahfKkmL+PipYk7+UI
         NsBBYXs+uB4JpDfuKnvUOaHilDli158SXV6XuLtiyZ51vr4xtYRBPMKLFCJpLk+i0+og
         sefqpl42V6/6o7oFcRIof5J8GOXu0TPM1ENsyvPRa4E702p1tSJ2CkIxl+dp5gUuKWV+
         Gbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cQKvk64LOd97opM3wH8HCf9LS0nGx3hkLOgXPc66S9A=;
        b=S7ZgzK5ZImEMZZKSpMfTKvypb1o02udGpY7s1UFcXgn3BLVKjC/0oDn44hSF/j7Rad
         Y2fRz7IhPHIH/tikr/WGFiqgvSxadcetTP6OeE6NWBybhrTZ/rtsQ5aJgqzPOiF/qWnt
         pR1xRSp/LTSYm2u9m+P93GQfCKqjU0bju+8yuBsbfgvABzDh6EPaWWoKK1LGdvs3iaLX
         rdyXl6C3S7LqPTjCVtTgQvLoSoC/7ul0m1xFS9BF3sOBli1q+o+cv4SqkJW6UW52T4tX
         Gt17F/FVuuHNobaWQYDQBEY5h5gNKN+1LFD8i3dE/QFZf4xb/fG40cZRX8Jie/lCH25A
         DLog==
X-Gm-Message-State: AOAM533qPTK5Lsc6wDIMGvAOz7qTevb6vJjeJaWgSdc4D9F71SPV8vwe
        g7VTTmLIgvbXkgiDHC5g1xE=
X-Google-Smtp-Source: ABdhPJwpq7nVPmzc8rGCI9o+j8bFQMkC1khfGYFJuSgRzodgscxFUQuAYKxcKl3sApS02rudVhsQxA==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr2493601wmi.23.1609919571406;
        Tue, 05 Jan 2021 23:52:51 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id h16sm1865536wmb.41.2021.01.05.23.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 23:52:50 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] nfsd: remove unused stats counters
Date:   Wed,  6 Jan 2021 09:52:34 +0200
Message-Id: <20210106075236.4184-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106075236.4184-1-amir73il@gmail.com>
References: <20210106075236.4184-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 501cb1849f86 ("nfsd: rip out the raparms cache") removed the
code that updates read-ahead cache stats counters,
commit 8bbfa9f3889b ("knfsd: remove the nfsd thread busy histogram")
removed code that updates the thread busy stats counters back in 2009
and code that updated filehandle cache stats was removed back in 2002.

Remove the unused stats counters from nfsd_stats struct and print
hardcoded zeros in /proc/net/rpc/nfsd.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/stats.c | 41 ++++++++++++++++-------------------------
 fs/nfsd/stats.h | 10 ----------
 2 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index b1bc582b0493..e928e224205a 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -7,16 +7,14 @@
  * Format:
  *	rc <hits> <misses> <nocache>
  *			Statistsics for the reply cache
- *	fh <stale> <total-lookups> <anonlookups> <dir-not-in-dcache> <nondir-not-in-dcache>
+ *	fh <stale> <deprecated filehandle cache stats>
  *			statistics for filehandle lookup
  *	io <bytes-read> <bytes-written>
  *			statistics for IO throughput
- *	th <threads> <fullcnt> <10%-20%> <20%-30%> ... <90%-100%> <100%> 
- *			time (seconds) when nfsd thread usage above thresholds
- *			and number of times that all threads were in use
- *	ra cache-size  <10%  <20%  <30% ... <100% not-found
- *			number of times that read-ahead entry was found that deep in
- *			the cache.
+ *	th <threads> <deprecated thread usage histogram stats>
+ *			number of threads
+ *	ra <deprecated ra-cache stats>
+ *
  *	plus generic RPC stats (see net/sunrpc/stats.c)
  *
  * Copyright (C) 1995, 1996, 1997 Olaf Kirch <okir@monad.swb.de>
@@ -38,31 +36,24 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 {
 	int i;
 
-	seq_printf(seq, "rc %u %u %u\nfh %u %u %u %u %u\nio %u %u\n",
+	seq_printf(seq, "rc %u %u %u\nfh %u 0 0 0 0\nio %u %u\n",
 		      nfsdstats.rchits,
 		      nfsdstats.rcmisses,
 		      nfsdstats.rcnocache,
 		      nfsdstats.fh_stale,
-		      nfsdstats.fh_lookup,
-		      nfsdstats.fh_anon,
-		      nfsdstats.fh_nocache_dir,
-		      nfsdstats.fh_nocache_nondir,
 		      nfsdstats.io_read,
 		      nfsdstats.io_write);
+
 	/* thread usage: */
-	seq_printf(seq, "th %u %u", nfsdstats.th_cnt, nfsdstats.th_fullcnt);
-	for (i=0; i<10; i++) {
-		unsigned int jifs = nfsdstats.th_usage[i];
-		unsigned int sec = jifs / HZ, msec = (jifs % HZ)*1000/HZ;
-		seq_printf(seq, " %u.%03u", sec, msec);
-	}
-
-	/* newline and ra-cache */
-	seq_printf(seq, "\nra %u", nfsdstats.ra_size);
-	for (i=0; i<11; i++)
-		seq_printf(seq, " %u", nfsdstats.ra_depth[i]);
-	seq_putc(seq, '\n');
-	
+	seq_printf(seq, "th %u 0", nfsdstats.th_cnt);
+
+	/* deprecated thread usage histogram stats */
+	for (i = 0; i < 10; i++)
+		seq_puts(seq, " 0.000");
+
+	/* deprecated ra-cache stats */
+	seq_puts(seq, "\nra 0 0 0 0 0 0 0 0 0 0 0 0\n");
+
 	/* show my rpc info */
 	svc_seq_show(seq, &nfsd_svcstats);
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index b23fdac69820..5e3cdf21556a 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -15,19 +15,9 @@ struct nfsd_stats {
 	unsigned int	rcmisses;	/* repcache hits */
 	unsigned int	rcnocache;	/* uncached reqs */
 	unsigned int	fh_stale;	/* FH stale error */
-	unsigned int	fh_lookup;	/* dentry cached */
-	unsigned int	fh_anon;	/* anon file dentry returned */
-	unsigned int	fh_nocache_dir;	/* filehandle not found in dcache */
-	unsigned int	fh_nocache_nondir;	/* filehandle not found in dcache */
 	unsigned int	io_read;	/* bytes returned to read requests */
 	unsigned int	io_write;	/* bytes passed in write requests */
 	unsigned int	th_cnt;		/* number of available threads */
-	unsigned int	th_usage[10];	/* number of ticks during which n perdeciles
-					 * of available threads were in use */
-	unsigned int	th_fullcnt;	/* number of times last free thread was used */
-	unsigned int	ra_size;	/* size of ra cache */
-	unsigned int	ra_depth[11];	/* number of times ra entry was found that deep
-					 * in the cache (10percentiles). [10] = not found */
 #ifdef CONFIG_NFSD_V4
 	unsigned int	nfs4_opcount[LAST_NFS4_OP + 1];	/* count of individual nfsv4 operations */
 #endif
-- 
2.17.1


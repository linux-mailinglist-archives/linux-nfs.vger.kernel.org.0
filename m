Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0765E0C4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 00:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjADXNA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 18:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjADXMK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 18:12:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFA44436B
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 15:11:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 888B0B818F2
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 23:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA041C433D2;
        Wed,  4 Jan 2023 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672873916;
        bh=1Nd40obCfa6CipkEA3WbpxkqatgCTVsuC/Esldjk7JU=;
        h=From:To:Cc:Subject:Date:From;
        b=klmVJHDN+ZZYczHkplPV+h4Qo8y0Ncb1iEMyx45x8qWKEJ1TZnhruTXxpETNXOeNb
         ApYiPA7I3VCz35VNbzuB3SIGLUa6vpbRAh2B6CBjVdD7t97JbVXC0SWlRYQm+t2TeI
         CaLVPHx+QAXZYYHAsbnpbzxIUAzdwbKo7MezzwKqf0qAgSqeEWV3omoW0BMfGEaz31
         QjXDHjyb4Rzp3Q5TF8fiBaO/UvGBL+nh9RQRKCZZUYp2A4IRbxVFmluoRGbBQiP+lF
         hXFoNBQLnaviHYZIjVkvcJFjHwu86rwuPfXTp5oLzpwDzyWVgb4b0z27MPkmyITco+
         KGQBXOjGK0lqg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Stanislav Saner <ssaner@redhat.com>
Subject: [PATCH] nfsd: fix handling of cached open files in nfsd4_open codepath
Date:   Wed,  4 Jan 2023 18:11:54 -0500
Message-Id: <20230104231154.286083-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
regular NFSv4 file") added the ability to cache an open fd over a
compound. There are a couple of problems with the way this currently
works:

It's racy, as a newly-created nfsd_file can end up with its PENDING bit
cleared while the nf is hashed, and the nf_file pointer is still zeroed
out. Other tasks can find it in this state and they expect to see a
valid nf_file, and can oops if nf_file is NULL.

Also, there is no guarantee that we'll end up creating a new nfsd_file
if one is already in the hash. If an extant entry is in the hash with a
valid nf_file, nfs4_get_vfs_file will clobber its nf_file pointer with
the value of op_file and the old nf_file will leak.

Fix both issues by changing nfsd_file_acquire to take an optional file
pointer. If one is present when this is called, we'll take a new
reference to it instead of trying to open the file. If the nfsd_file
already has a valid nf_file, we'll just ignore the optional file and
pass the nfsd_file back as-is.

Also rework the tracepoints a bit to allow for a cached open variant,
and don't try to avoid counting acquisitions in the case where we
already have a cached open file.

Cc: Trond Myklebust <trondmy@hammerspace.com>
Reported-by: Stanislav Saner <ssaner@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 49 ++++++++++++++----------------------------
 fs/nfsd/filecache.h |  5 ++---
 fs/nfsd/nfs4proc.c  |  2 +-
 fs/nfsd/nfs4state.c | 20 ++++++-----------
 fs/nfsd/trace.h     | 52 ++++++++++++---------------------------------
 5 files changed, 38 insertions(+), 90 deletions(-)

Only lightly tested with pynfs so far, but this should fix the oops
that was reported.

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f55798cc0947..f0ca9501edb2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1075,8 +1075,8 @@ nfsd_file_is_cached(struct inode *inode)
 
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		     unsigned int may_flags, struct nfsd_file **pnf,
-		     bool open, bool want_gc)
+		     unsigned int may_flags, struct file *file,
+		     struct nfsd_file **pnf, bool want_gc)
 {
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_FULL,
@@ -1151,25 +1151,27 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 out:
 	if (status == nfs_ok) {
-		if (open)
-			this_cpu_inc(nfsd_file_acquisitions);
+		this_cpu_inc(nfsd_file_acquisitions);
 		*pnf = nf;
 	}
 	put_cred(key.cred);
-	if (open)
-		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
+	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
 	return status;
 
 open_file:
 	trace_nfsd_file_alloc(nf);
 	nf->nf_mark = nfsd_file_mark_find_or_create(nf, key.inode);
 	if (nf->nf_mark) {
-		if (open) {
+		if (file) {
+			get_file(file);
+			nf->nf_file = file;
+			status = nfs_ok;
+			trace_nfsd_file_open_cached(nf, status);
+		} else {
 			status = nfsd_open_verified(rqstp, fhp, may_flags,
 						    &nf->nf_file);
 			trace_nfsd_file_open(nf, status);
-		} else
-			status = nfs_ok;
+		}
 	} else
 		status = nfserr_jukebox;
 	/*
@@ -1210,7 +1212,7 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, true);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
 }
 
 /**
@@ -1218,6 +1220,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @rqstp: the RPC transaction being executed
  * @fhp: the NFS filehandle of the file to be opened
  * @may_flags: NFSD_MAY_ settings for the file
+ * @file: cached, already-open file (may be NULL)
  * @pnf: OUT: new or found "struct nfsd_file" object
  *
  * The nfsd_file_object returned by this API is reference-counted
@@ -1229,30 +1232,10 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  unsigned int may_flags, struct nfsd_file **pnf)
-{
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, false);
-}
-
-/**
- * nfsd_file_create - Get a struct nfsd_file, do not open
- * @rqstp: the RPC transaction being executed
- * @fhp: the NFS filehandle of the file just created
- * @may_flags: NFSD_MAY_ settings for the file
- * @pnf: OUT: new or found "struct nfsd_file" object
- *
- * The nfsd_file_object returned by this API is reference-counted
- * but not garbage-collected. The object is released immediately
- * one RCU grace period after the final nfsd_file_put().
- *
- * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
- * network byte order is returned.
- */
-__be32
-nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		 unsigned int may_flags, struct nfsd_file **pnf)
+		  unsigned int may_flags, struct file *file,
+		  struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, false);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index b7efb2c3ddb1..ef0083cd4ea9 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -59,8 +59,7 @@ bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
 __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  unsigned int may_flags, struct nfsd_file **nfp);
-__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  unsigned int may_flags, struct nfsd_file **nfp);
+		  unsigned int may_flags, struct file *file,
+		  struct nfsd_file **nfp);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bd880d55f565..6b09cdd4b067 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -735,7 +735,7 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 
 	status = nfsd_file_acquire(rqstp, &cstate->current_fh, NFSD_MAY_WRITE |
-				   NFSD_MAY_NOT_BREAK_LEASE, &nf);
+				   NFSD_MAY_NOT_BREAK_LEASE, NULL, &nf);
 	if (status != nfs_ok)
 		return status;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f7b9e12245dd..3df3ae84bd07 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5262,18 +5262,10 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	if (!fp->fi_fds[oflag]) {
 		spin_unlock(&fp->fi_lock);
 
-		if (!open->op_filp) {
-			status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
-			if (status != nfs_ok)
-				goto out_put_access;
-		} else {
-			status = nfsd_file_create(rqstp, cur_fh, access, &nf);
-			if (status != nfs_ok)
-				goto out_put_access;
-			nf->nf_file = open->op_filp;
-			open->op_filp = NULL;
-			trace_nfsd_file_create(rqstp, access, nf);
-		}
+		status = nfsd_file_acquire(rqstp, cur_fh, access,
+					   open->op_filp, &nf);
+		if (status != nfs_ok)
+			goto out_put_access;
 
 		spin_lock(&fp->fi_lock);
 		if (!fp->fi_fds[oflag]) {
@@ -6476,7 +6468,7 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 			goto out;
 		}
 	} else {
-		status = nfsd_file_acquire(rqstp, fhp, acc, &nf);
+		status = nfsd_file_acquire(rqstp, fhp, acc, NULL, &nf);
 		if (status)
 			return status;
 	}
@@ -7648,7 +7640,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 	struct inode *inode;
 	__be32 err;
 
-	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
+	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, NULL, &nf);
 	if (err)
 		return err;
 	inode = fhp->fh_dentry->d_inode;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c852ae8eaf37..7c6cbc37c8c9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -981,43 +981,6 @@ TRACE_EVENT(nfsd_file_acquire,
 	)
 );
 
-TRACE_EVENT(nfsd_file_create,
-	TP_PROTO(
-		const struct svc_rqst *rqstp,
-		unsigned int may_flags,
-		const struct nfsd_file *nf
-	),
-
-	TP_ARGS(rqstp, may_flags, nf),
-
-	TP_STRUCT__entry(
-		__field(const void *, nf_inode)
-		__field(const void *, nf_file)
-		__field(unsigned long, may_flags)
-		__field(unsigned long, nf_flags)
-		__field(unsigned long, nf_may)
-		__field(unsigned int, nf_ref)
-		__field(u32, xid)
-	),
-
-	TP_fast_assign(
-		__entry->nf_inode = nf->nf_inode;
-		__entry->nf_file = nf->nf_file;
-		__entry->may_flags = may_flags;
-		__entry->nf_flags = nf->nf_flags;
-		__entry->nf_may = nf->nf_may;
-		__entry->nf_ref = refcount_read(&nf->nf_ref);
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
-	),
-
-	TP_printk("xid=0x%x inode=%p may_flags=%s ref=%u nf_flags=%s nf_may=%s nf_file=%p",
-		__entry->xid, __entry->nf_inode,
-		show_nfsd_may_flags(__entry->may_flags),
-		__entry->nf_ref, show_nf_flags(__entry->nf_flags),
-		show_nfsd_may_flags(__entry->nf_may), __entry->nf_file
-	)
-);
-
 TRACE_EVENT(nfsd_file_insert_err,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
@@ -1079,8 +1042,8 @@ TRACE_EVENT(nfsd_file_cons_err,
 	)
 );
 
-TRACE_EVENT(nfsd_file_open,
-	TP_PROTO(struct nfsd_file *nf, __be32 status),
+DECLARE_EVENT_CLASS(nfsd_file_open_class,
+	TP_PROTO(const struct nfsd_file *nf, __be32 status),
 	TP_ARGS(nf, status),
 	TP_STRUCT__entry(
 		__field(void *, nf_inode)	/* cannot be dereferenced */
@@ -1104,6 +1067,17 @@ TRACE_EVENT(nfsd_file_open,
 		__entry->nf_file)
 )
 
+#define DEFINE_NFSD_FILE_OPEN_EVENT(name)					\
+DEFINE_EVENT(nfsd_file_open_class, name,					\
+	TP_PROTO(							\
+		const struct nfsd_file *nf,				\
+		__be32 status						\
+	),								\
+	TP_ARGS(nf, status))
+
+DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open);
+DEFINE_NFSD_FILE_OPEN_EVENT(nfsd_file_open_cached);
+
 TRACE_EVENT(nfsd_file_is_cached,
 	TP_PROTO(
 		const struct inode *inode,
-- 
2.39.0


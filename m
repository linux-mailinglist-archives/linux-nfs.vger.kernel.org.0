Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EB96033A5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 21:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJRT6p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJRT6n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 15:58:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11D08E989
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 12:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F75EB82102
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 19:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D86FC433C1;
        Tue, 18 Oct 2022 19:58:39 +0000 (UTC)
Subject: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Tue, 18 Oct 2022 15:58:38 -0400
Message-ID: <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>
In-Reply-To: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSv4 operations manage the lifetime of nfsd_file items they use by
means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
garbage collected.

Introduce a mechanism to enable garbage collection for nfsd_file
items used only by NFSv2/3 callers.

Note that the change in nfsd_file_put() ensures that both CLOSE and
DELEGRETURN will actually close out and free an nfsd_file on last
reference of a non-garbage-collected file.

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=394
Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/filecache.h |    3 +++
 fs/nfsd/nfs3proc.c  |    4 ++-
 fs/nfsd/trace.h     |    3 ++-
 fs/nfsd/vfs.c       |    4 ++-
 5 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index b7aa523c2010..87fce5c95726 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
 	struct net			*net;
 	const struct cred		*cred;
 	unsigned char			need;
+	unsigned char			gc:1;
 	enum nfsd_file_lookup_type	type;
 };
 
@@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 			return 1;
 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
 			return 1;
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+			return 1;
 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
 			return 1;
 		break;
@@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
 		nf->nf_flags = 0;
 		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
 		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
+		if (key->gc)
+			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
 		nf->nf_inode = key->inode;
 		/* nf_ref is pre-incremented for hash table */
 		refcount_set(&nf->nf_ref, 2);
@@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
 	}
 }
 
+static void
+nfsd_file_unhash_and_put(struct nfsd_file *nf)
+{
+	if (nfsd_file_unhash(nf))
+		nfsd_file_put_noref(nf);
+}
+
 void
 nfsd_file_put(struct nfsd_file *nf)
 {
 	might_sleep();
 
-	nfsd_file_lru_add(nf);
+	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) == 1)
+		nfsd_file_lru_add(nf);
+	else if (refcount_read(&nf->nf_ref) == 2)
+		nfsd_file_unhash_and_put(nf);
+
 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0) {
 		nfsd_file_flush(nf);
 		nfsd_file_put_noref(nf);
-	} else if (nf->nf_file) {
+	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) == 1) {
 		nfsd_file_put_noref(nf);
 		nfsd_file_schedule_laundrette();
 	} else
@@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
 
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
+		     unsigned int may_flags, struct nfsd_file **pnf,
+		     bool open, int want_gc)
 {
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_FULL,
 		.need	= may_flags & NFSD_FILE_MAY_MASK,
 		.net	= SVC_NET(rqstp),
+		.gc	= want_gc,
 	};
 	bool open_retry = true;
 	struct nfsd_file *nf;
@@ -1117,14 +1135,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * then unhash.
 	 */
 	if (status != nfs_ok || key.inode->i_nlink == 0)
-		if (nfsd_file_unhash(nf))
-			nfsd_file_put_noref(nf);
+		nfsd_file_unhash_and_put(nf);
 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
 	smp_mb__after_atomic();
 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
 	goto out;
 }
 
+/**
+ * nfsd_file_acquire_gc - Get a struct nfsd_file with an open file
+ * @rqstp: the RPC transaction being executed
+ * @fhp: the NFS filehandle of the file to be opened
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * The nfsd_file object returned by this API is reference-counted
+ * and garbage-collected. The object is retained for a few
+ * seconds after the final nfsd_file_put() in case the caller
+ * wants to re-use it.
+ *
+ * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
+ * network byte order is returned.
+ */
+__be32
+nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 1);
+}
+
 /**
  * nfsd_file_acquire - Get a struct nfsd_file with an open file
  * @rqstp: the RPC transaction being executed
@@ -1132,6 +1171,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @may_flags: NFSD_MAY_ settings for the file
  * @pnf: OUT: new or found "struct nfsd_file" object
  *
+ * The nfsd_file_object returned by this API is reference-counted
+ * but not garbage-collected. The object is unhashed after the
+ * final nfsd_file_put().
+ *
  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
  * network byte order is returned.
  */
@@ -1139,7 +1182,7 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 0);
 }
 
 /**
@@ -1149,6 +1192,10 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @may_flags: NFSD_MAY_ settings for the file
  * @pnf: OUT: new or found "struct nfsd_file" object
  *
+ * The nfsd_file_object returned by this API is reference-counted
+ * but not garbage-collected. The object is released immediately
+ * one RCU grace period after the final nfsd_file_put().
+ *
  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
  * network byte order is returned.
  */
@@ -1156,7 +1203,7 @@ __be32
 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		 unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, 0);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index f81c198f4ed6..0f6546bcd3e0 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -38,6 +38,7 @@ struct nfsd_file {
 #define NFSD_FILE_HASHED	(0)
 #define NFSD_FILE_PENDING	(1)
 #define NFSD_FILE_REFERENCED	(2)
+#define NFSD_FILE_GC		(3)
 	unsigned long		nf_flags;
 	struct inode		*nf_inode;	/* don't deref */
 	refcount_t		nf_ref;
@@ -55,6 +56,8 @@ void nfsd_file_put(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 bool nfsd_file_is_cached(struct inode *inode);
+__be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct nfsd_file **nfp);
 __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
 __be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index d12823371857..6a5ad6c91d8e 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -779,8 +779,8 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 				(unsigned long long) argp->offset);
 
 	fh_copy(&resp->fh, &argp->fh);
-	resp->status = nfsd_file_acquire(rqstp, &resp->fh, NFSD_MAY_WRITE |
-					 NFSD_MAY_NOT_BREAK_LEASE, &nf);
+	resp->status = nfsd_file_acquire_gc(rqstp, &resp->fh, NFSD_MAY_WRITE |
+					    NFSD_MAY_NOT_BREAK_LEASE, &nf);
 	if (resp->status)
 		goto out;
 	resp->status = nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 9ebd67d461f9..4921144880d3 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -742,7 +742,8 @@ DEFINE_CLID_EVENT(confirmed_r);
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
-		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
+		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
+		{ 1 << NFSD_FILE_GC,		"GC"})
 
 DECLARE_EVENT_CLASS(nfsd_file_class,
 	TP_PROTO(struct nfsd_file *nf),
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 44f210ba17cc..89d682a56fc4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1060,7 +1060,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 err;
 
 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
-	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
+	err = nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
 
@@ -1092,7 +1092,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 
 	trace_nfsd_write_start(rqstp, fhp, offset, *cnt);
 
-	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_WRITE, &nf);
+	err = nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_WRITE, &nf);
 	if (err)
 		goto out;
 



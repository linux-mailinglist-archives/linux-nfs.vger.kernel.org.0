Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C55F56CF
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJEO4B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJEO4A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 10:56:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494D10DE
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 07:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 306E8B81BEF
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD174C433D6
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 14:55:56 +0000 (UTC)
Subject: [PATCH RFC 3/9] NFSD: Pass the target nfsd_file to nfsd_commit()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 05 Oct 2022 10:55:55 -0400
Message-ID: <166498175594.1527.16969786367945672963.stgit@manet.1015granger.net>
In-Reply-To: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
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

In a moment I'm going to introduce separate nfsd_file types, one of
which is garbage-collected; the other, not. The garbage-collected
variety is to be used by NFSv2 and v3, and the non-garbage-collected
variety is to be used by NFSv4.

nfsd_commit() is invoked by both NFSv3 and NFSv4 consumers. We want
nfsd_commit() to find and use the correct variety of cached
nfsd_file object for the NFS version that is in use.

This is a refactoring change. No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   10 +++++++++-
 fs/nfsd/nfs4proc.c |   11 ++++++++++-
 fs/nfsd/vfs.c      |   15 ++++-----------
 fs/nfsd/vfs.h      |    3 ++-
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index a41cca619338..d12823371857 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -13,6 +13,7 @@
 #include "cache.h"
 #include "xdr3.h"
 #include "vfs.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -770,6 +771,7 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 {
 	struct nfsd3_commitargs *argp = rqstp->rq_argp;
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
+	struct nfsd_file *nf;
 
 	dprintk("nfsd: COMMIT(3)   %s %u@%Lu\n",
 				SVCFH_fmt(&argp->fh),
@@ -777,8 +779,14 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 				(unsigned long long) argp->offset);
 
 	fh_copy(&resp->fh, &argp->fh);
-	resp->status = nfsd_commit(rqstp, &resp->fh, argp->offset,
+	resp->status = nfsd_file_acquire(rqstp, &resp->fh, NFSD_MAY_WRITE |
+					 NFSD_MAY_NOT_BREAK_LEASE, &nf);
+	if (resp->status)
+		goto out;
+	resp->status = nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
 				   argp->count, resp->verf);
+	nfsd_file_put(nf);
+out:
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a72ab97f77ef..d0d976f847ca 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -739,10 +739,19 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	struct nfsd4_commit *commit = &u->commit;
+	struct nfsd_file *nf;
+	__be32 status;
 
-	return nfsd_commit(rqstp, &cstate->current_fh, commit->co_offset,
+	status = nfsd_file_acquire(rqstp, &cstate->current_fh, NFSD_MAY_WRITE |
+				   NFSD_MAY_NOT_BREAK_LEASE, &nf);
+	if (status != nfs_ok)
+		return status;
+
+	status = nfsd_commit(rqstp, &cstate->current_fh, nf, commit->co_offset,
 			     commit->co_count,
 			     (__be32 *)commit->co_verf.data);
+	nfsd_file_put(nf);
+	return status;
 }
 
 static __be32
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fc17b0ac8729..44f210ba17cc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1108,6 +1108,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
  * nfsd_commit - Commit pending writes to stable storage
  * @rqstp: RPC request being processed
  * @fhp: NFS filehandle
+ * @nf: target file
  * @offset: raw offset from beginning of file
  * @count: raw count of bytes to sync
  * @verf: filled in with the server's current write verifier
@@ -1124,19 +1125,13 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
  *   An nfsstat value in network byte order.
  */
 __be32
-nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
-	    u32 count, __be32 *verf)
+nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
+	    u64 offset, u32 count, __be32 *verf)
 {
+	__be32			err = nfs_ok;
 	u64			maxbytes;
 	loff_t			start, end;
 	struct nfsd_net		*nn;
-	struct nfsd_file	*nf;
-	__be32			err;
-
-	err = nfsd_file_acquire(rqstp, fhp,
-			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
-	if (err)
-		goto out;
 
 	/*
 	 * Convert the client-provided (offset, count) range to a
@@ -1177,8 +1172,6 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
 	} else
 		nfsd_copy_write_verifier(verf, nn);
 
-	nfsd_file_put(nf);
-out:
 	return err;
 }
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index c95cd414b4bb..04dfd80570f0 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -88,7 +88,8 @@ __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
 __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct svc_fh *resfhp, struct nfsd_attrs *iap);
 __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
-				u64 offset, u32 count, __be32 *verf);
+				struct nfsd_file *nf, u64 offset, u32 count,
+				__be32 *verf);
 #ifdef CONFIG_NFSD_V4
 __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			    char *name, void **bufp, int *lenp);



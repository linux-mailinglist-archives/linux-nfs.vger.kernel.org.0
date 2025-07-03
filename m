Return-Path: <linux-nfs+bounces-12880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B9AF81A5
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 21:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E53ABE57
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0EE2FF46C;
	Thu,  3 Jul 2025 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW5dY16Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3422F2FF466;
	Thu,  3 Jul 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572410; cv=none; b=Npc5L0CnXhfjgYuluyKXahzgpKkh0Mf/qi4ZfHRjR7fXk3sk+uYxgO2ciy5LQ6Ee1MwHDTNpTojTAEEJajd42uVbaLC2CTI0/yDMUXLI66trAmLeWiDJQJfncUShTFGd6xS2IaOu7Gwv4ddKq7iWjfeYGariV1Pa01NWCLyaBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572410; c=relaxed/simple;
	bh=smL/eB8fAl03uaDWHjZi76er77bcyUSMpdWXPH0CtxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVRJUhC1DmB+DvheGdulsp9jKIGIV4s4vYfei1EJtJCQMfgNI63n0P+MyWXNfNhG/hbVDQAQ0lCMWRqbh1Q582FawKS5EO0dbxl/c6fPGddSz2i+4WtvoGUQAdXn26q+0Dr78VpUasJKnQHxtbfueNKa+OEm2sf5inE+thEAvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW5dY16Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB50C4CEF5;
	Thu,  3 Jul 2025 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751572409;
	bh=smL/eB8fAl03uaDWHjZi76er77bcyUSMpdWXPH0CtxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oW5dY16ZprqAWGMN5f4RhSWHPr0Pm/FrhCt1R9qZf1H10cdtB5GwEci7RuafiloTq
	 sDwbtp/ZGQb23UeqW2aFXva+WEQp22aXBwOmbp5oH1cXtQWg2Hrb1J1kq5Pb+RU4eH
	 Xc3XW1FAyRY8bxPan0jfEybx8BfGXQyNFdciwFYcbjCyiHrOt9dfNnFnC0SnDZObQg
	 6hzQxEFHlOikGoNsDygIUb40EhicGuA2fJXWvwH53r80YyNo+chn3HoRO/1e2l1HSr
	 awft1oMjh8rwAzLu1gdVOW0MvwQEFs22+fQ8cOrIf7VDdCnPfD1D0sktF5/nQi8GEg
	 j6bGuM+IFkofw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 03 Jul 2025 15:53:13 -0400
Subject: [PATCH RFC 2/2] nfsd: call generic_fadvise after v3 READ, stable
 WRITE or COMMIT
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-nfsd-testing-v1-2-cece54f36556@kernel.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
In-Reply-To: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11642; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=smL/eB8fAl03uaDWHjZi76er77bcyUSMpdWXPH0CtxU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoZt+23+RZ30jZf5uBOB+WifyhnAMa2xdwrM1vS
 F+bAbqSftCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaGbftgAKCRAADmhBGVaC
 FY8bD/wM0gDyHQiTX8+OscbLSCXaz0A34f4RAijl8rMJNwSU2sHKzHUqthSRgZaEhCOl5DOVr4u
 /SjEvBlvsHrwYxWE5TfD83Z/l4yw9+19OM9w2uWhIwDgRTG+jep/8aeGxDPYmF13TRfaHtBhuJQ
 M9fERyUWCp4OR5O5/m6I+g2zlrHG5hWm3Af9OvhWmz2z8U+i1k7rKwA05LY2RxJAOzkcea2cpPo
 ll3j9rfLcLyQez8IZ9ln4n5jvb+W7NWOQuiIy8DvbyZOwP+/cH2phGnfyFiZQ7LPlxf33tXObxW
 +0fEJhubxx3WT5/qH5uknH9zOhx6njjWWWHKrecZa2cU8q3KiYwD4P6ZlLfnKR24sRBme8EEsG/
 A3LVxjQcAUwuNCRPLr+gI7wQgULXq6E1FXmW1lt6N5y8Vqqd75tiXwyzU4ovjz0C0TuhoXSKMDE
 +54ksqliS2BMn1mcr7Tp8GY2XKihC/fUbJFmePK2WINieMYDQpXTNvYbEG/SAaynS41jOTRhO36
 ZvBuRQFCZmd1CrpfW2XJ8pUqIYujnHqiJcBxqDhqvDxoXOMGHar/wiDTMmCe9uMiiAeF3pNBj3p
 7X2dfYuge+hHhotOrxz74V5MVN11eE2xPuxFCzK8nVERCteIOBr7ZRm/CUKI37NN7vFHQIA8dCH
 dgiCjUP0VngohBA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Recent testing has shown that keeping pagecache pages around for too
long can be detrimental to performance with nfsd. Clients only rarely
revisit the same data, so the pages tend to just hang around.

This patch changes the pc_release callbacks for NFSv3 READ, WRITE and
COMMIT to call generic_fadvise(..., POSIX_FADV_DONTNEED) on the accessed
range.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/debugfs.c  |  2 ++
 fs/nfsd/nfs3proc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/nfsd.h     |  1 +
 fs/nfsd/nfsproc.c  |  4 ++--
 fs/nfsd/vfs.c      | 21 ++++++++++++++-----
 fs/nfsd/vfs.h      |  5 +++--
 fs/nfsd/xdr3.h     |  3 +++
 7 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc90bd5c2d9d5e15c8e0682c0d610c..b007718dd959bc081166ec84e06f577a8fc2b46b 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -44,4 +44,6 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
+	debugfs_create_bool("enable-fadvise-dontneed", 0644,
+			    nfsd_top_dir, &nfsd_enable_fadvise_dontneed);
 }
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7a5e8dd111b0d56c061f1e91abff7..11261cf67ea817ec566626f08b733e09c9e121de 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -9,6 +9,7 @@
 #include <linux/ext2_fs.h>
 #include <linux/magic.h>
 #include <linux/namei.h>
+#include <linux/fadvise.h>
 
 #include "cache.h"
 #include "xdr3.h"
@@ -206,11 +207,25 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
-				 &resp->count, &resp->eof);
+				 &resp->count, &resp->eof, &resp->nf);
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
+static void
+nfsd3_release_read(struct svc_rqst *rqstp)
+{
+	struct nfsd3_readargs *argp = rqstp->rq_argp;
+	struct nfsd3_readres *resp = rqstp->rq_resp;
+
+	if (nfsd_enable_fadvise_dontneed && resp->status == nfs_ok)
+		generic_fadvise(nfsd_file_file(resp->nf), argp->offset, resp->count,
+				POSIX_FADV_DONTNEED);
+	if (resp->nf)
+		nfsd_file_put(resp->nf);
+	fh_put(&resp->fh);
+}
+
 /*
  * Write data to a file
  */
@@ -236,12 +251,26 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 	resp->committed = argp->stable;
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
 				  &argp->payload, &cnt,
-				  resp->committed, resp->verf);
+				  resp->committed, resp->verf, &resp->nf);
 	resp->count = cnt;
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
+static void
+nfsd3_release_write(struct svc_rqst *rqstp)
+{
+	struct nfsd3_writeargs *argp = rqstp->rq_argp;
+	struct nfsd3_writeres *resp = rqstp->rq_resp;
+
+	if (nfsd_enable_fadvise_dontneed && resp->status == nfs_ok && resp->committed)
+		generic_fadvise(nfsd_file_file(resp->nf), argp->offset, resp->count,
+				POSIX_FADV_DONTNEED);
+	if (resp->nf)
+		nfsd_file_put(resp->nf);
+	fh_put(&resp->fh);
+}
+
 /*
  * Implement NFSv3's unchecked, guarded, and exclusive CREATE
  * semantics for regular files. Except for the created file,
@@ -748,7 +777,6 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 {
 	struct nfsd3_commitargs *argp = rqstp->rq_argp;
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
-	struct nfsd_file *nf;
 
 	dprintk("nfsd: COMMIT(3)   %s %u@%Lu\n",
 				SVCFH_fmt(&argp->fh),
@@ -757,17 +785,30 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_file_acquire_gc(rqstp, &resp->fh, NFSD_MAY_WRITE |
-					    NFSD_MAY_NOT_BREAK_LEASE, &nf);
+					    NFSD_MAY_NOT_BREAK_LEASE, &resp->nf);
 	if (resp->status)
 		goto out;
-	resp->status = nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
+	resp->status = nfsd_commit(rqstp, &resp->fh, resp->nf, argp->offset,
 				   argp->count, resp->verf);
-	nfsd_file_put(nf);
 out:
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
 }
 
+static void
+nfsd3_release_commit(struct svc_rqst *rqstp)
+{
+	struct nfsd3_commitargs *argp = rqstp->rq_argp;
+	struct nfsd3_commitres *resp = rqstp->rq_resp;
+
+	if (nfsd_enable_fadvise_dontneed && resp->status == nfs_ok)
+		generic_fadvise(nfsd_file_file(resp->nf), argp->offset, argp->count,
+				POSIX_FADV_DONTNEED);
+	if (resp->nf)
+		nfsd_file_put(resp->nf);
+	fh_put(&resp->fh);
+}
+
 
 /*
  * NFSv3 Server procedures.
@@ -864,7 +905,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_func = nfsd3_proc_read,
 		.pc_decode = nfs3svc_decode_readargs,
 		.pc_encode = nfs3svc_encode_readres,
-		.pc_release = nfs3svc_release_fhandle,
+		.pc_release = nfsd3_release_read,
 		.pc_argsize = sizeof(struct nfsd3_readargs),
 		.pc_argzero = sizeof(struct nfsd3_readargs),
 		.pc_ressize = sizeof(struct nfsd3_readres),
@@ -876,7 +917,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_func = nfsd3_proc_write,
 		.pc_decode = nfs3svc_decode_writeargs,
 		.pc_encode = nfs3svc_encode_writeres,
-		.pc_release = nfs3svc_release_fhandle,
+		.pc_release = nfsd3_release_write,
 		.pc_argsize = sizeof(struct nfsd3_writeargs),
 		.pc_argzero = sizeof(struct nfsd3_writeargs),
 		.pc_ressize = sizeof(struct nfsd3_writeres),
@@ -1039,7 +1080,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_func = nfsd3_proc_commit,
 		.pc_decode = nfs3svc_decode_commitargs,
 		.pc_encode = nfs3svc_encode_commitres,
-		.pc_release = nfs3svc_release_fhandle,
+		.pc_release = nfsd3_release_commit,
 		.pc_argsize = sizeof(struct nfsd3_commitargs),
 		.pc_argzero = sizeof(struct nfsd3_commitargs),
 		.pc_ressize = sizeof(struct nfsd3_commitres),
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2f27248fd66a8efef692a5e9a390c..288904d88b9245c03eae0aa347e867037b7c85c5 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -152,6 +152,7 @@ static inline void nfsd_debugfs_exit(void) {}
 #endif
 
 extern bool nfsd_disable_splice_read __read_mostly;
+extern bool nfsd_enable_fadvise_dontneed __read_mostly;
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8f71f5748c75b69f15bae5e63799842e0e8b3139..bb8f98adb3e31b10adc4694987f8f5036726bf7f 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -225,7 +225,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	resp->count = argp->count;
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
-				 &resp->count, &eof);
+				 &resp->count, &eof, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
@@ -258,7 +258,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
-				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
+				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ee78b6fb17098b788b07f5cd90598e678244b57e..f23eb3a07bb99dc231be9ea6db4e58b9e328a689 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+bool nfsd_enable_fadvise_dontneed __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1280,6 +1281,7 @@ bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
  * @offset: starting byte offset
  * @count: IN: requested number of bytes; OUT: number of bytes read
  * @eof: OUT: set non-zero if operation reached the end of the file
+ * @pnf: optional return pointer to pass back nfsd_file reference
  *
  * The caller must verify that there is enough space in @rqstp.rq_res
  * to perform this operation.
@@ -1290,7 +1292,8 @@ bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
  * returned.
  */
 __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		 loff_t offset, unsigned long *count, u32 *eof)
+		 loff_t offset, unsigned long *count, u32 *eof,
+		 struct nfsd_file **pnf)
 {
 	struct nfsd_file	*nf;
 	struct file *file;
@@ -1307,7 +1310,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	else
 		err = nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
 
-	nfsd_file_put(nf);
+	if (pnf && err == nfs_ok)
+		*pnf = nf;
+	else
+		nfsd_file_put(nf);
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
 	return err;
 }
@@ -1321,8 +1327,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
  * @stable: An NFS stable_how value
  * @verf: NFS WRITE verifier
+ * @pnf: optional return pointer to pass back nfsd_file reference
  *
- * Upon return, caller must invoke fh_put on @fhp.
+ * Upon return, caller must invoke fh_put() on @fhp. If it sets @pnf,
+ * then it must also call nfsd_file_put() on the returned reference.
  *
  * Return values:
  *   An nfsstat value in network byte order.
@@ -1330,7 +1338,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
-	   __be32 *verf)
+	   __be32 *verf, struct nfsd_file **pnf)
 {
 	struct nfsd_file *nf;
 	__be32 err;
@@ -1343,7 +1351,10 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 
 	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
 			     stable, verf);
-	nfsd_file_put(nf);
+	if (pnf && err == nfs_ok)
+		*pnf = nf;
+	else
+		nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
 	return err;
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index eff04959606fe55c141ab4a2eed97c7e0716a5f5..2d063ee7786f499f34c39cd3ba7e776bb7562d57 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -127,10 +127,11 @@ __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
 __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, unsigned long *count,
-				u32 *eof);
+				u32 *eof, struct nfsd_file **pnf);
 __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, const struct xdr_buf *payload,
-				unsigned long *cnt, int stable, __be32 *verf);
+				unsigned long *cnt, int stable, __be32 *verf,
+				struct nfsd_file **pnf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
 				const struct xdr_buf *payload,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 522067b7fd755930a1c2e42b826d9132ac2993be..3f4c51983003188be51a0f8c2db2e0acc9a1363b 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -146,6 +146,7 @@ struct nfsd3_readres {
 	unsigned long		count;
 	__u32			eof;
 	struct page		**pages;
+	struct nfsd_file	*nf;
 };
 
 struct nfsd3_writeres {
@@ -154,6 +155,7 @@ struct nfsd3_writeres {
 	unsigned long		count;
 	int			committed;
 	__be32			verf[2];
+	struct nfsd_file	*nf;
 };
 
 struct nfsd3_renameres {
@@ -217,6 +219,7 @@ struct nfsd3_commitres {
 	__be32			status;
 	struct svc_fh		fh;
 	__be32			verf[2];
+	struct nfsd_file	*nf;
 };
 
 struct nfsd3_getaclres {

-- 
2.50.0



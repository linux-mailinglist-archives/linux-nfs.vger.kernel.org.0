Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB79D4A1
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfHZRGk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 13:06:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36143 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfHZRGk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 13:06:40 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so39039242iom.3
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54fAf2387sjZKgIkYNhUAnrnA0nb0YUg2frmkLjkW5U=;
        b=he/3HhcRnIOqIxT4xxAKQUqpH2P2JgGxNyQj+wQ028ddEcYfv8L1c57DcGRbTMFeyn
         LuG8RnEVp/4TFVl2nCX0FrAq6mnUD3j3yFbCtVg0uzm8vtcbOdPIiuUen28+J6zkyeAE
         RyR1oQLuxN4G7BY1Y7MGpYDtQn21f5ItJaE1l3C/ra4bRL8aiIuza5aK8Nz/wXKNVonY
         UKA1NdnMiKfRcJ74Uhi4c6zbv+nAIwhLu1xjjR2um1Kx+T814ilNan2TPKTx0foxRlDf
         1QRc0s523pEqrR/q/iIHI6vw2Pj+g3LbeXBo2Yp+uEsaCUg81VziUPlTFy1HfxMq3b4w
         ckSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54fAf2387sjZKgIkYNhUAnrnA0nb0YUg2frmkLjkW5U=;
        b=sqjuKmZEKh4I37Sd8wVXon3XnbFqExfijrW6+WVJq7KzE2e5yInu3ZLJTezcLgNjO2
         Y9PDadWSWcUbakUZD/m2JCw4ynNr9oTrXkwfjEUWmXd5zy46AQ1objo4LiGSfXczMBEW
         M0W/U1syOxopvbBym58X7VwjTQYub87Bfd6DdWXltvpdo7jiPkKKlu/LhG1u4kdNzBi1
         M+a6lIYp1aRkNRz8Rkue43Mkgmb2ASHZuz8IC3rUbYggKZ++7DVs+R52up5eyN3/zuNU
         A6mQxG2O+tWPfqyNy+1kwu2Harrmy5czQ7NK0vJGAhA5WbkWU1RVo+6H03gWNYTSsrme
         N8Fw==
X-Gm-Message-State: APjAAAU2pU8mww8eqIdv2zL7VRmeF7OnkgNHVfJZwY9ByHM34mg8vDuR
        izCSy8jnd9sH5HamDe60c0ooNPGkYQ==
X-Google-Smtp-Source: APXvYqxzjGWmiOJ9+LzmwgJijTF/IbVps4rkOQYNmSl+rAyD+PVwG0RKgTB66+EI2KKUmJLl+1+hmw==
X-Received: by 2002:a5e:db47:: with SMTP id r7mr2223013iop.184.1566839199189;
        Mon, 26 Aug 2019 10:06:39 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c3sm19303643iot.42.2019.08.26.10.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 10:06:38 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfsd: Clean up nfs read eof detection
Date:   Mon, 26 Aug 2019 13:03:11 -0400
Message-Id: <20190826170311.81482-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190826170311.81482-1-trond.myklebust@hammerspace.com>
References: <20190826170311.81482-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move the code to detect eof from version specific code into the generic
nfsd read.
Do not set the eof flag if the read is short and is less than the file
size, because the short read could be due to another factor.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs3proc.c |  9 ++-------
 fs/nfsd/nfs4xdr.c  | 11 +++--------
 fs/nfsd/nfsproc.c  |  4 +++-
 fs/nfsd/vfs.c      | 37 ++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.h      | 28 ++++++----------------------
 fs/nfsd/xdr3.h     |  2 +-
 6 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 9bc32af4e2da..cea68d8411ac 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -172,13 +172,8 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	nfserr = nfsd_read(rqstp, &resp->fh,
 				  argp->offset,
 			   	  rqstp->rq_vec, argp->vlen,
-				  &resp->count);
-	if (nfserr == 0) {
-		struct inode	*inode = d_inode(resp->fh.fh_dentry);
-		resp->eof = nfsd_eof_on_read(cnt, resp->count, argp->offset,
-							inode->i_size);
-	}
-
+				  &resp->count,
+				  &resp->eof);
 	RETURN_STATUS(nfserr);
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 565d2169902c..6eb660c61b73 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3460,7 +3460,7 @@ static __be32 nfsd4_encode_splice_read(
 
 	len = maxcount;
 	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
-				  file, read->rd_offset, &maxcount);
+				  file, read->rd_offset, &maxcount, &eof);
 	read->rd_length = maxcount;
 	if (nfserr) {
 		/*
@@ -3472,9 +3472,6 @@ static __be32 nfsd4_encode_splice_read(
 		return nfserr;
 	}
 
-	eof = nfsd_eof_on_read(len, maxcount, read->rd_offset,
-				d_inode(read->rd_fhp->fh_dentry)->i_size);
-
 	*(p++) = htonl(eof);
 	*(p++) = htonl(maxcount);
 
@@ -3545,15 +3542,13 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 
 	len = maxcount;
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount);
+			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
+			    &eof);
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
 	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
 
-	eof = nfsd_eof_on_read(len, maxcount, read->rd_offset,
-				d_inode(read->rd_fhp->fh_dentry)->i_size);
-
 	tmp = htonl(eof);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
 	tmp = htonl(maxcount);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 0d20fd161225..c83ddac22f38 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -172,6 +172,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	struct nfsd_readargs *argp = rqstp->rq_argp;
 	struct nfsd_readres *resp = rqstp->rq_resp;
 	__be32	nfserr;
+	u32 eof;
 
 	dprintk("nfsd: READ    %s %d bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
@@ -195,7 +196,8 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	nfserr = nfsd_read(rqstp, fh_copy(&resp->fh, &argp->fh),
 				  argp->offset,
 			   	  rqstp->rq_vec, argp->vlen,
-				  &resp->count);
+				  &resp->count,
+				  &eof);
 
 	if (nfserr) return nfserr;
 	return fh_getattr(&resp->fh, &resp->stat);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 84e87772c2b8..5419826a70cf 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -834,12 +834,23 @@ static int nfsd_direct_splice_actor(struct pipe_inode_info *pipe,
 	return __splice_from_pipe(pipe, sd, nfsd_splice_actor);
 }
 
+static u32 nfsd_eof_on_read(struct file *file, loff_t offset, ssize_t len,
+		size_t expected)
+{
+	if (expected != 0 && len == 0)
+		return 1;
+	if (offset+len >= i_size_read(file_inode(file)))
+		return 1;
+	return 0;
+}
+
 static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       struct file *file, loff_t offset,
-			       unsigned long *count, int host_err)
+			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
 		nfsdstats.io_read += host_err;
+		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
 		trace_nfsd_read_io_done(rqstp, fhp, offset, *count);
@@ -851,7 +862,8 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 
 __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-			struct file *file, loff_t offset, unsigned long *count)
+			struct file *file, loff_t offset, unsigned long *count,
+			u32 *eof)
 {
 	struct splice_desc sd = {
 		.len		= 0,
@@ -859,25 +871,27 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.pos		= offset,
 		.u.data		= rqstp,
 	};
-	int host_err;
+	ssize_t host_err;
 
 	trace_nfsd_read_splice(rqstp, fhp, offset, *count);
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 	host_err = splice_direct_to_actor(file, &sd, nfsd_direct_splice_actor);
-	return nfsd_finish_read(rqstp, fhp, file, offset, count, host_err);
+	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
 __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct file *file, loff_t offset,
-		  struct kvec *vec, int vlen, unsigned long *count)
+		  struct kvec *vec, int vlen, unsigned long *count,
+		  u32 *eof)
 {
 	struct iov_iter iter;
-	int host_err;
+	loff_t ppos = offset;
+	ssize_t host_err;
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_kvec(&iter, READ, vec, vlen, *count);
-	host_err = vfs_iter_read(file, &iter, &offset, 0);
-	return nfsd_finish_read(rqstp, fhp, file, offset, count, host_err);
+	host_err = vfs_iter_read(file, &iter, &ppos, 0);
+	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
 /*
@@ -980,7 +994,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
  * N.B. After this call fhp needs an fh_put
  */
 __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-	loff_t offset, struct kvec *vec, int vlen, unsigned long *count)
+	loff_t offset, struct kvec *vec, int vlen, unsigned long *count,
+	u32 *eof)
 {
 	struct nfsd_file	*nf;
 	struct file *file;
@@ -993,9 +1008,9 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	file = nf->nf_file;
 	if (file->f_op->splice_read && test_bit(RQ_SPLICE_OK, &rqstp->rq_flags))
-		err = nfsd_splice_read(rqstp, fhp, file, offset, count);
+		err = nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
 	else
-		err = nfsd_readv(rqstp, fhp, file, offset, vec, vlen, count);
+		err = nfsd_readv(rqstp, fhp, file, offset, vec, vlen, count, eof);
 
 	nfsd_file_put(nf);
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e0f7792165a6..a13fd9d7e1f5 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -80,13 +80,16 @@ __be32		nfsd_open_verified(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
-				unsigned long *count);
+				unsigned long *count,
+				u32 *eof);
 __be32		nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				struct kvec *vec, int vlen,
-				unsigned long *count);
+				unsigned long *count,
+				u32 *eof);
 __be32 		nfsd_read(struct svc_rqst *, struct svc_fh *,
-				loff_t, struct kvec *, int, unsigned long *);
+				loff_t, struct kvec *, int, unsigned long *,
+				u32 *eof);
 __be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
 				struct kvec *, int, unsigned long *, int);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
@@ -149,23 +152,4 @@ static inline int nfsd_create_is_exclusive(int createmode)
 	       || createmode == NFS4_CREATE_EXCLUSIVE4_1;
 }
 
-static inline bool nfsd_eof_on_read(long requested, long read,
-				loff_t offset, loff_t size)
-{
-	/* We assume a short read means eof: */
-	if (requested > read)
-		return true;
-	/*
-	 * A non-short read might also reach end of file.  The spec
-	 * still requires us to set eof in that case.
-	 *
-	 * Further operations may have modified the file size since
-	 * the read, so the following check is not atomic with the read.
-	 * We've only seen that cause a problem for a client in the case
-	 * where the read returned a count of 0 without setting eof.
-	 * That case was fixed by the addition of the above check.
-	 */
-	return (offset + read >= size);
-}
-
 #endif /* LINUX_NFSD_VFS_H */
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 2cb29e961a76..99ff9f403ff1 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -151,7 +151,7 @@ struct nfsd3_readres {
 	__be32			status;
 	struct svc_fh		fh;
 	unsigned long		count;
-	int			eof;
+	__u32			eof;
 };
 
 struct nfsd3_writeres {
-- 
2.21.0


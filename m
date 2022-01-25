Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704CD49B76D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiAYPSC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 10:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357926AbiAYPPY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 10:15:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DF0C061772
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 07:15:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1851BB81819
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 15:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE73BC340E0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 15:15:19 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC] NFSD: COMMIT operations must not return NFS?ERR_INVAL
Date:   Tue, 25 Jan 2022 10:15:18 -0500
Message-Id:  <164312364841.2592.937810018356237855.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4634; h=from:subject:message-id; bh=lC+kXELpO0ApahkcWVRWQlhqdZfCHRkyEdHu0ffHKqg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8BQALl6CruC0+/GKZBL65M4gabV6VgsYzoh6Rnek TjzS0AaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfAUAAAKCRAzarMzb2Z/l8VuEA CyLE/4xkliYhH2biRYVwdcaET1eDdl50g92CgrCiyeL2drOdB9GGq4Po9oVlk5n/UtvsSPqfXa3dbB X70sV0mZlPqOBMfwYBC5NN2yfq2pBumu3ohf4+fiB6CtYoXqCgY2pGWQkoY5W2ay7Ev9blMSP1Yy59 PeBUlWMyT/cbDmUJh7cwqAd9769AkWEo5DQBs9n3eAlzfYH3iVQj0nvfiH5LnhEwQC0rhvGSdl6UIf IsqreUR1TCtwZANS+Ibsd+EFZ8tIlSnCg6KW6Dvl6P12mmZo8peuSv+Qk0NF0dr9pd8ymaHm4noKX8 0mjwospqUNt29IE2y6R42piEkq1ziDhUQBjpF06bN3Vf3X1CbtWFkTWCR8X/Wp9hdwedIlbpzWLQC/ DajU4mtFxUhunNNXW9uhkDJI29NQg6pcDvB1zYDTccsydnpDZHw4+nvmsidMQanYlp8S00A2t49gq3 zSPtvmVfuI+9gUzrVPc7TW3OrjAsVd8IRv1mm5h1OqjLupkzLRQX736WIoMFnA5xIxV4xVz/8gKMQL 6ZuUgp3HrtZ+bJbSgeMO0+Ktp6GzJvBL+KuMfDKh8dBAoYgtrw2+h9feO2yshRQ2wfZ334YIvGf/WJ KQdetHB2R+oA5ZnUO08khXHEmU8Wu+5yoaKb5ziLEKNaEbgRgcjMl1itt7lg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since, well, forever, the Linux NFS server's nfsd_commit() function
has returned nfserr_inval when the passed-in byte range arguments
were non-sensical.

However, according to RFC 1813 section 3.3.21, NFSv3 COMMIT requests
are permitted to return only the following non-zero status codes:

      NFS3ERR_IO
      NFS3ERR_STALE
      NFS3ERR_BADHANDLE
      NFS3ERR_SERVERFAULT

NFS3ERR_INVAL is not included in that list. Likewise, NFS4ERR_INVAL
is not listed in the COMMIT row of Table 6 in RFC 8881.

Instead of dropping or failing a COMMIT request in a byte range that
is not supported, turn it into a valid request by treating one or
both arguments as zero.

As a clean-up, I replaced the signed v. unsigned integer comparisons
because I found that logic difficult to reason about.

Reported-by: Dan Aloni <dan.aloni@vastdata.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    6 ------
 fs/nfsd/vfs.c      |   43 ++++++++++++++++++++++++++++---------------
 fs/nfsd/vfs.h      |    4 ++--
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8ef53f6726ec..8cd2953f53c7 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -651,15 +651,9 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 				argp->count,
 				(unsigned long long) argp->offset);
 
-	if (argp->offset > NFS_OFFSET_MAX) {
-		resp->status = nfserr_inval;
-		goto out;
-	}
-
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_commit(rqstp, &resp->fh, argp->offset,
 				   argp->count, resp->verf);
-out:
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 99c2b9dfbb10..384c62591f45 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1110,42 +1110,55 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 }
 
 #ifdef CONFIG_NFSD_V3
-/*
- * Commit all pending writes to stable storage.
+/**
+ * nfsd_commit - Commit pending writes to stable storage
+ * @rqstp: RPC request being processed
+ * @fhp: NFS filehandle
+ * @offset: offset from beginning of file
+ * @count: count of bytes to sync
+ * @verf: filled in with the server's current write verifier
  *
  * Note: we only guarantee that data that lies within the range specified
  * by the 'offset' and 'count' parameters will be synced.
  *
  * Unfortunately we cannot lock the file to make sure we return full WCC
  * data to the client, as locking happens lower down in the filesystem.
+ *
+ * Return values:
+ *   An nfsstat value in network byte order.
  */
 __be32
-nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
-               loff_t offset, unsigned long count, __be32 *verf)
+nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
+	    u32 count, __be32 *verf)
 {
+	u64			maxbytes;
+	loff_t			start, end;
 	struct nfsd_net		*nn;
 	struct nfsd_file	*nf;
-	loff_t			end = LLONG_MAX;
-	__be32			err = nfserr_inval;
-
-	if (offset < 0)
-		goto out;
-	if (count != 0) {
-		end = offset + (loff_t)count - 1;
-		if (end < offset)
-			goto out;
-	}
+	__be32			err;
 
 	err = nfsd_file_acquire(rqstp, fhp,
 			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
 	if (err)
 		goto out;
+
+	start = 0;
+	end = LLONG_MAX;
+	/* NB: s_maxbytes is a (signed) loff_t, thus @maxbytes always
+	 * contains a value that is less than LLONG_MAX. */
+	maxbytes = fhp->fh_dentry->d_sb->s_maxbytes;
+	if (offset < maxbytes) {
+		start = offset;
+		if (count && (offset + count - 1 < maxbytes))
+			end = offset + count - 1;
+	}
+
 	nn = net_generic(nf->nf_net, nfsd_net_id);
 	if (EX_ISSYNC(fhp->fh_export)) {
 		errseq_t since = READ_ONCE(nf->nf_file->f_wb_err);
 		int err2;
 
-		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
+		err2 = vfs_fsync_range(nf->nf_file, start, end, 0);
 		switch (err2) {
 		case 0:
 			nfsd_copy_write_verifier(verf, nn);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 9f56dcb22ff7..2c43d10e3cab 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -74,8 +74,8 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				struct svc_fh *res, int createmode,
 				u32 *verifier, bool *truncp, bool *created);
-__be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
-				loff_t, unsigned long, __be32 *verf);
+__be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
+				u64 offset, u32 count, __be32 *verf);
 #endif /* CONFIG_NFSD_V3 */
 #ifdef CONFIG_NFSD_V4
 __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5A32FDCD
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCFWbl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhCFWbI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:31:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE063650D7
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:31:07 +0000 (UTC)
Subject: [PATCH v2 19/43] NFSD: Update NFSv3 READDIR entry encoders to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:31:07 -0500
Message-ID: <161506986702.4312.1694836301565062455.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The benefit of the xdr_stream helpers is that they transparently
handle encoding an XDR data item that crosses page boundaries.
Most of the open-coded logic to do that here can be eliminated.

A sub-buffer and sub-stream are set up as a sink buffer for the
directory entry encoder. As an entry is encoded, it is added to
the end of the content in this buffer/stream. The total length of
the directory list is tracked in the buffer's @len field.

When it comes time to encode the Reply, the sub-buffer is merged
into rq_res's page array at the correct place using
xdr_write_pages().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   35 +++++++----
 fs/nfsd/nfs3xdr.c  |  166 ++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/xdr3.h     |   14 +++-
 3 files changed, 185 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index f1096aa0f47c..bc64e95a168d 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -441,18 +441,30 @@ static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 				     struct nfsd3_readdirres *resp,
 				     int count)
 {
+	struct xdr_buf *buf = &resp->dirlist;
+	struct xdr_stream *xdr = &resp->xdr;
+
 	count = min_t(u32, count, svc_max_payload(rqstp));
 
-	/* Convert byte count to number of words (i.e. >> 2),
-	 * and reserve room for the NULL ptr & eof flag (-2 words) */
-	resp->buflen = (count >> 2) - 2;
+	memset(buf, 0, sizeof(*buf));
 
-	resp->pages = rqstp->rq_next_page;
-	resp->buffer = page_address(*resp->pages);
+	/* Reserve room for the NULL ptr & eof flag (-2 words) */
+	buf->buflen = count - XDR_UNIT * 2;
+	buf->pages = rqstp->rq_next_page;
 	while (count > 0) {
 		rqstp->rq_next_page++;
 		count -= PAGE_SIZE;
 	}
+
+	/* This is xdr_init_encode(), but it assumes that
+	 * the head kvec has already been consumed. */
+	xdr_set_scratch_buffer(xdr, NULL, 0);
+	xdr->buf = buf;
+	xdr->page_ptr = buf->pages;
+	xdr->iov = NULL;
+	xdr->p = page_address(*buf->pages);
+	xdr->end = xdr->p + (PAGE_SIZE >> 2);
+	xdr->rqst = NULL;
 }
 
 /*
@@ -471,16 +483,13 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
-	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
-
-	resp->count = 0;
 	resp->common.err = nfs_ok;
+	resp->cookie_offset = 0;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
-
 	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
-				    &resp->common, nfs3svc_encode_entry);
+				    &resp->common, nfs3svc_encode_entry3);
 	memcpy(resp->verf, argp->verf, 8);
 	nfs3svc_encode_cookie3(resp, offset);
 
@@ -504,11 +513,9 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
-	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
-
-	resp->count = 0;
 	resp->common.err = nfs_ok;
+	resp->cookie_offset = 0;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
 
@@ -522,7 +529,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	}
 
 	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
-				    &resp->common, nfs3svc_encode_entry_plus);
+				    &resp->common, nfs3svc_encode_entryplus3);
 	memcpy(resp->verf, argp->verf, 8);
 	nfs3svc_encode_cookie3(resp, offset);
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 3d076d3c5c7b..f38d845ac8a0 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1139,6 +1139,7 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
+	struct xdr_buf *dirlist = &resp->dirlist;
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
 		return 0;
@@ -1148,7 +1149,7 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 			return 0;
 		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
 			return 0;
-		xdr_write_pages(xdr, resp->pages, 0, resp->count << 2);
+		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
 			return 0;
@@ -1240,21 +1241,18 @@ static __be32 *encode_entryplus_baggage(struct nfsd3_readdirres *cd, __be32 *p,
  * @resp: readdir result context
  * @offset: offset cookie to encode
  *
+ * The buffer space for the offset cookie has already been reserved
+ * by svcxdr_encode_entry3_common().
  */
 void nfs3svc_encode_cookie3(struct nfsd3_readdirres *resp, u64 offset)
 {
-	if (!resp->offset)
-		return;
+	__be64 cookie = cpu_to_be64(offset);
 
-	if (resp->offset1) {
-		/* we ended up with offset on a page boundary */
-		*resp->offset = cpu_to_be32(offset >> 32);
-		*resp->offset1 = cpu_to_be32(offset & 0xffffffff);
-		resp->offset1 = NULL;
-	} else {
-		xdr_encode_hyper(resp->offset, offset);
-	}
-	resp->offset = NULL;
+	if (!resp->cookie_offset)
+		return;
+	write_bytes_to_xdr_buf(&resp->dirlist, resp->cookie_offset, &cookie,
+			       sizeof(cookie));
+	resp->cookie_offset = 0;
 }
 
 /*
@@ -1403,6 +1401,150 @@ nfs3svc_encode_entry_plus(void *cd, const char *name,
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
 }
 
+static bool
+svcxdr_encode_entry3_common(struct nfsd3_readdirres *resp, const char *name,
+			    int namlen, loff_t offset, u64 ino)
+{
+	struct xdr_buf *dirlist = &resp->dirlist;
+	struct xdr_stream *xdr = &resp->xdr;
+
+	if (xdr_stream_encode_item_present(xdr) < 0)
+		return false;
+	/* fileid */
+	if (xdr_stream_encode_u64(xdr, ino) < 0)
+		return false;
+	/* name */
+	if (xdr_stream_encode_opaque(xdr, name, min(namlen, NFS3_MAXNAMLEN)) < 0)
+		return false;
+	/* cookie */
+	resp->cookie_offset = dirlist->len;
+	if (xdr_stream_encode_u64(xdr, NFS_OFFSET_MAX) < 0)
+		return false;
+
+	return true;
+}
+
+/**
+ * nfs3svc_encode_entry3 - encode one NFSv3 READDIR entry
+ * @data: directory context
+ * @name: name of the object to be encoded
+ * @namlen: length of that name, in bytes
+ * @offset: the offset of the previous entry
+ * @ino: the fileid of this entry
+ * @d_type: unused
+ *
+ * Return values:
+ *   %0: Entry was successfully encoded.
+ *   %-EINVAL: An encoding problem occured, secondary status code in resp->common.err
+ *
+ * On exit, the following fields are updated:
+ *   - resp->xdr
+ *   - resp->common.err
+ *   - resp->cookie_offset
+ */
+int nfs3svc_encode_entry3(void *data, const char *name, int namlen,
+			  loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct readdir_cd *ccd = data;
+	struct nfsd3_readdirres *resp = container_of(ccd,
+						     struct nfsd3_readdirres,
+						     common);
+	unsigned int starting_length = resp->dirlist.len;
+
+	/* The offset cookie for the previous entry */
+	nfs3svc_encode_cookie3(resp, offset);
+
+	if (!svcxdr_encode_entry3_common(resp, name, namlen, offset, ino))
+		goto out_toosmall;
+
+	xdr_commit_encode(&resp->xdr);
+	resp->common.err = nfs_ok;
+	return 0;
+
+out_toosmall:
+	resp->cookie_offset = 0;
+	resp->common.err = nfserr_toosmall;
+	resp->dirlist.len = starting_length;
+	return -EINVAL;
+}
+
+static bool
+svcxdr_encode_entry3_plus(struct nfsd3_readdirres *resp, const char *name,
+			  int namlen, u64 ino)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	struct svc_fh *fhp = &resp->scratch;
+	bool result;
+
+	result = false;
+	fh_init(fhp, NFS3_FHSIZE);
+	if (compose_entry_fh(resp, fhp, name, namlen, ino) != nfs_ok)
+		goto out_noattrs;
+
+	if (!svcxdr_encode_post_op_attr(resp->rqstp, xdr, fhp))
+		goto out;
+	if (!svcxdr_encode_post_op_fh3(xdr, fhp))
+		goto out;
+	result = true;
+
+out:
+	fh_put(fhp);
+	return result;
+
+out_noattrs:
+	if (xdr_stream_encode_item_absent(xdr) < 0)
+		return false;
+	if (xdr_stream_encode_item_absent(xdr) < 0)
+		return false;
+	return true;
+}
+
+/**
+ * nfs3svc_encode_entryplus3 - encode one NFSv3 READDIRPLUS entry
+ * @data: directory context
+ * @name: name of the object to be encoded
+ * @namlen: length of that name, in bytes
+ * @offset: the offset of the previous entry
+ * @ino: the fileid of this entry
+ * @d_type: unused
+ *
+ * Return values:
+ *   %0: Entry was successfully encoded.
+ *   %-EINVAL: An encoding problem occured, secondary status code in resp->common.err
+ *
+ * On exit, the following fields are updated:
+ *   - resp->xdr
+ *   - resp->common.err
+ *   - resp->cookie_offset
+ */
+int nfs3svc_encode_entryplus3(void *data, const char *name, int namlen,
+			      loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct readdir_cd *ccd = data;
+	struct nfsd3_readdirres *resp = container_of(ccd,
+						     struct nfsd3_readdirres,
+						     common);
+	unsigned int starting_length = resp->dirlist.len;
+
+	/* The offset cookie for the previous entry */
+	nfs3svc_encode_cookie3(resp, offset);
+
+	if (!svcxdr_encode_entry3_common(resp, name, namlen, offset, ino))
+		goto out_toosmall;
+	if (!svcxdr_encode_entry3_plus(resp, name, namlen, ino))
+		goto out_toosmall;
+
+	xdr_commit_encode(&resp->xdr);
+	resp->common.err = nfs_ok;
+	return 0;
+
+out_toosmall:
+	resp->cookie_offset = 0;
+	resp->common.err = nfserr_toosmall;
+	resp->dirlist.len = starting_length;
+	return -EINVAL;
+}
+
 static bool
 svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
 			   const struct nfsd3_fsstatres *resp)
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index a4cdd8ccb175..81dea78b0f17 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -169,20 +169,22 @@ struct nfsd3_linkres {
 };
 
 struct nfsd3_readdirres {
+	/* Components of the reply */
 	__be32			status;
 	struct svc_fh		fh;
-	/* Just to save kmalloc on every readdirplus entry (svc_fh is a
-	 * little large for the stack): */
-	struct svc_fh		scratch;
 	int			count;
 	__be32			verf[2];
-	struct page		**pages;
 
+	/* Used to encode the reply's entry list */
+	struct xdr_stream	xdr;
+	struct xdr_buf		dirlist;
+	struct svc_fh		scratch;
 	struct readdir_cd	common;
 	__be32 *		buffer;
 	int			buflen;
 	__be32 *		offset;
 	__be32 *		offset1;
+	unsigned int		cookie_offset;
 	struct svc_rqst *	rqstp;
 
 };
@@ -309,6 +311,10 @@ int nfs3svc_encode_entry(void *, const char *name,
 int nfs3svc_encode_entry_plus(void *, const char *name,
 				int namlen, loff_t offset, u64 ino,
 				unsigned int);
+int nfs3svc_encode_entry3(void *data, const char *name, int namlen,
+			  loff_t offset, u64 ino, unsigned int d_type);
+int nfs3svc_encode_entryplus3(void *data, const char *name, int namlen,
+			      loff_t offset, u64 ino, unsigned int d_type);
 /* Helper functions for NFSv3 ACL code */
 __be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
 				struct svc_fh *fhp);



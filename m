Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E664328233
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhCAPSt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237019AbhCAPSr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29D5B600CC
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:32 +0000 (UTC)
Subject: [PATCH v1 32/42] NFSD: Update the NFSv2 READDIR entry encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:31 -0500
Message-ID: <161461191144.8508.7559697923273139675.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |   26 ++++++++++++-----
 fs/nfsd/nfsxdr.c  |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/xdr.h     |    7 +++++
 3 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 1acff9f4aaf1..86d438fbd576 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -559,14 +559,27 @@ static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 				    struct nfsd_readdirres *resp,
 				    int count)
 {
+	struct xdr_buf *buf = &resp->dirlist;
+	struct xdr_stream *xdr = &resp->xdr;
+
 	count = min_t(u32, count, PAGE_SIZE);
 
-	/* Convert byte count to number of words (i.e. >> 2),
-	 * and reserve room for the NULL ptr & eof flag (-2 words) */
-	resp->buflen = (count >> 2) - 2;
+	memset(buf, 0, sizeof(*buf));
 
-	resp->buffer = page_address(*rqstp->rq_next_page);
+	/* Reserve room for the NULL ptr & eof flag (-2 words) */
+	buf->buflen = count - sizeof(__be32) * 2;
+	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
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
@@ -585,12 +598,11 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 
 	nfsd_init_dirlist_pages(rqstp, resp, argp->count);
 
-	resp->offset = NULL;
 	resp->common.err = nfs_ok;
-	/* Read directory and encode entries on the fly */
+	resp->cookie_offset = 0;
 	offset = argp->cookie;
 	resp->status = nfsd_readdir(rqstp, &argp->fh, &offset,
-				    &resp->common, nfssvc_encode_entry);
+				    &resp->common, nfs2svc_encode_entry);
 	nfssvc_encode_nfscookie(resp, offset);
 
 	fh_put(&argp->fh);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 9522e5c5f49d..1102d40ded03 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -576,12 +576,13 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
+	struct xdr_buf *dirlist = &resp->dirlist;
 
 	if (!svcxdr_encode_stat(xdr, resp->status))
 		return 0;
 	switch (resp->status) {
 	case nfs_ok:
-		xdr_write_pages(xdr, &resp->page, 0, resp->count << 2);
+		xdr_write_pages(xdr, dirlist->pages, 0, dirlist->len);
 		/* no more entries */
 		if (xdr_stream_encode_item_absent(xdr) < 0)
 			return 0;
@@ -623,14 +624,86 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p)
  * @resp: readdir result context
  * @offset: offset cookie to encode
  *
+ * The buffer space for the offset cookie has already been reserved
+ * by svcxdr_encode_entry_common().
  */
 void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset)
 {
-	if (!resp->offset)
+	__be32 cookie = cpu_to_be32(offset);
+
+	if (!resp->cookie_offset)
 		return;
 
-	*resp->offset = cpu_to_be32(offset);
-	resp->offset = NULL;
+	write_bytes_to_xdr_buf(&resp->dirlist, resp->cookie_offset, &cookie,
+			       sizeof(cookie));
+	resp->cookie_offset = 0;
+}
+
+static bool
+svcxdr_encode_entry_common(struct nfsd_readdirres *resp, const char *name,
+			   int namlen, loff_t offset, u64 ino)
+{
+	struct xdr_buf *dirlist = &resp->dirlist;
+	struct xdr_stream *xdr = &resp->xdr;
+
+	if (xdr_stream_encode_item_present(xdr) < 0)
+		return false;
+	/* fileid */
+	if (xdr_stream_encode_u32(xdr, (u32)ino) < 0)
+		return false;
+	/* name */
+	if (xdr_stream_encode_opaque(xdr, name, min(namlen, NFS2_MAXNAMLEN)) < 0)
+		return false;
+	/* cookie */
+	resp->cookie_offset = dirlist->len;
+	if (xdr_stream_encode_u32(xdr, ~0U) < 0)
+		return false;
+
+	return true;
+}
+
+/**
+ * nfs2svc_encode_entry - encode one NFSv2 READDIR entry
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
+int nfs2svc_encode_entry(void *data, const char *name, int namlen,
+			 loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct readdir_cd *ccd = data;
+	struct nfsd_readdirres *resp = container_of(ccd,
+						    struct nfsd_readdirres,
+						    common);
+	unsigned int starting_length = resp->dirlist.len;
+
+	/* The offset cookie for the previous entry */
+	nfssvc_encode_nfscookie(resp, offset);
+
+	if (!svcxdr_encode_entry_common(resp, name, namlen, offset, ino))
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
 }
 
 int
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 69a6efc71ecb..082f262a1bf9 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -106,15 +106,20 @@ struct nfsd_readres {
 };
 
 struct nfsd_readdirres {
+	/* Components of the reply */
 	__be32			status;
 
 	int			count;
 
+	/* Used to encode the reply's entry list */
+	struct xdr_stream	xdr;
+	struct xdr_buf		dirlist;
 	struct readdir_cd	common;
 	__be32 *		buffer;
 	int			buflen;
 	__be32 *		offset;
 	struct page		*page;
+	unsigned int		cookie_offset;
 };
 
 struct nfsd_statfsres {
@@ -159,6 +164,8 @@ int nfssvc_encode_statfsres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *);
 
 void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset);
+int nfs2svc_encode_entry(void *data, const char *name, int namlen,
+			 loff_t offset, u64 ino, unsigned int d_type);
 int nfssvc_encode_entry(void *, const char *name,
 			int namlen, loff_t offset, u64 ino, unsigned int);
 



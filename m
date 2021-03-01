Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D28328242
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhCAPT0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237173AbhCAPTT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:19:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24EA064E38
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:38 +0000 (UTC)
Subject: [PATCH v1 33/42] NFSD: Remove unused NFSv2 directory entry encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:37 -0500
Message-ID: <161461191743.8508.488440695116922054.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    2 +-
 fs/nfsd/nfsxdr.c  |   51 +++------------------------------------------------
 fs/nfsd/xdr.h     |   10 ++--------
 3 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 86d438fbd576..c2cd2984e41d 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -602,7 +602,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	resp->cookie_offset = 0;
 	offset = argp->cookie;
 	resp->status = nfsd_readdir(rqstp, &argp->fh, &offset,
-				    &resp->common, nfs2svc_encode_entry);
+				    &resp->common, nfssvc_encode_entry);
 	nfssvc_encode_nfscookie(resp, offset);
 
 	fh_put(&argp->fh);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 1102d40ded03..5df6f00d76fd 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -663,7 +663,7 @@ svcxdr_encode_entry_common(struct nfsd_readdirres *resp, const char *name,
 }
 
 /**
- * nfs2svc_encode_entry - encode one NFSv2 READDIR entry
+ * nfssvc_encode_entry - encode one NFSv2 READDIR entry
  * @data: directory context
  * @name: name of the object to be encoded
  * @namlen: length of that name, in bytes
@@ -680,8 +680,8 @@ svcxdr_encode_entry_common(struct nfsd_readdirres *resp, const char *name,
  *   - resp->common.err
  *   - resp->cookie_offset
  */
-int nfs2svc_encode_entry(void *data, const char *name, int namlen,
-			 loff_t offset, u64 ino, unsigned int d_type)
+int nfssvc_encode_entry(void *data, const char *name, int namlen,
+			loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct readdir_cd *ccd = data;
 	struct nfsd_readdirres *resp = container_of(ccd,
@@ -706,51 +706,6 @@ int nfs2svc_encode_entry(void *data, const char *name, int namlen,
 	return -EINVAL;
 }
 
-int
-nfssvc_encode_entry(void *ccdv, const char *name,
-		    int namlen, loff_t offset, u64 ino, unsigned int d_type)
-{
-	struct readdir_cd *ccd = ccdv;
-	struct nfsd_readdirres *cd = container_of(ccd, struct nfsd_readdirres, common);
-	__be32	*p = cd->buffer;
-	int	buflen, slen;
-
-	/*
-	dprintk("nfsd: entry(%.*s off %ld ino %ld)\n",
-			namlen, name, offset, ino);
-	 */
-
-	if (offset > ~((u32) 0)) {
-		cd->common.err = nfserr_fbig;
-		return -EINVAL;
-	}
-	nfssvc_encode_nfscookie(cd, offset);
-
-	/* truncate filename */
-	namlen = min(namlen, NFS2_MAXNAMLEN);
-	slen = XDR_QUADLEN(namlen);
-
-	if ((buflen = cd->buflen - slen - 4) < 0) {
-		cd->common.err = nfserr_toosmall;
-		return -EINVAL;
-	}
-	if (ino > ~((u32) 0)) {
-		cd->common.err = nfserr_fbig;
-		return -EINVAL;
-	}
-	*p++ = xdr_one;				/* mark entry present */
-	*p++ = htonl((u32) ino);		/* file id */
-	p    = xdr_encode_array(p, name, namlen);/* name length & name */
-	cd->offset = p;			/* remember pointer */
-	*p++ = htonl(~0U);		/* offset of next entry */
-
-	cd->count += p - cd->buffer;
-	cd->buflen = buflen;
-	cd->buffer = p;
-	cd->common.err = nfs_ok;
-	return 0;
-}
-
 /*
  * XDR release functions
  */
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 082f262a1bf9..bfffcb70a5f8 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -115,10 +115,6 @@ struct nfsd_readdirres {
 	struct xdr_stream	xdr;
 	struct xdr_buf		dirlist;
 	struct readdir_cd	common;
-	__be32 *		buffer;
-	int			buflen;
-	__be32 *		offset;
-	struct page		*page;
 	unsigned int		cookie_offset;
 };
 
@@ -164,10 +160,8 @@ int nfssvc_encode_statfsres(struct svc_rqst *, __be32 *);
 int nfssvc_encode_readdirres(struct svc_rqst *, __be32 *);
 
 void nfssvc_encode_nfscookie(struct nfsd_readdirres *resp, u32 offset);
-int nfs2svc_encode_entry(void *data, const char *name, int namlen,
-			 loff_t offset, u64 ino, unsigned int d_type);
-int nfssvc_encode_entry(void *, const char *name,
-			int namlen, loff_t offset, u64 ino, unsigned int);
+int nfssvc_encode_entry(void *data, const char *name, int namlen,
+			loff_t offset, u64 ino, unsigned int d_type);
 
 void nfssvc_release_attrstat(struct svc_rqst *rqstp);
 void nfssvc_release_diropres(struct svc_rqst *rqstp);



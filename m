Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FB32822C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhCAPSa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237029AbhCAPSH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D08F964E2E
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:17:25 +0000 (UTC)
Subject: [PATCH v1 21/42] NFSD: Remove unused NFSv3 directory entry encoders
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:17:25 -0500
Message-ID: <161461184506.8508.11225375008513913699.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |  190 -----------------------------------------------------
 fs/nfsd/xdr3.h    |   11 ---
 2 files changed, 201 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 9c799fec5044..a37ea9fb8214 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -148,16 +148,6 @@ svcxdr_encode_post_op_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
 	return true;
 }
 
-static __be32 *
-encode_fh(__be32 *p, struct svc_fh *fhp)
-{
-	unsigned int size = fhp->fh_handle.fh_size;
-	*p++ = htonl(size);
-	if (size) p[XDR_QUADLEN(size)-1]=0;
-	memcpy(p, &fhp->fh_handle.fh_base, size);
-	return p + XDR_QUADLEN(size);
-}
-
 static bool
 svcxdr_encode_cookieverf3(struct xdr_stream *xdr, const __be32 *verf)
 {
@@ -1164,20 +1154,6 @@ nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-static __be32 *
-encode_entry_baggage(struct nfsd3_readdirres *cd, __be32 *p, const char *name,
-	     int namlen, u64 ino)
-{
-	*p++ = xdr_one;				 /* mark entry present */
-	p    = xdr_encode_hyper(p, ino);	 /* file id */
-	p    = xdr_encode_array(p, name, namlen);/* name length & name */
-
-	cd->offset = p;				/* remember pointer */
-	p = xdr_encode_hyper(p, NFS_OFFSET_MAX);/* offset of next entry */
-
-	return p;
-}
-
 static __be32
 compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 		 const char *name, int namlen, u64 ino)
@@ -1216,26 +1192,6 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 	return rv;
 }
 
-static __be32 *encode_entryplus_baggage(struct nfsd3_readdirres *cd, __be32 *p, const char *name, int namlen, u64 ino)
-{
-	struct svc_fh	*fh = &cd->scratch;
-	__be32 err;
-
-	fh_init(fh, NFS3_FHSIZE);
-	err = compose_entry_fh(cd, fh, name, namlen, ino);
-	if (err) {
-		*p++ = 0;
-		*p++ = 0;
-		goto out;
-	}
-	p = encode_post_op_attr(cd->rqstp, p, fh);
-	*p++ = xdr_one;			/* yes, a file handle follows */
-	p = encode_fh(p, fh);
-out:
-	fh_put(fh);
-	return p;
-}
-
 /**
  * nfs3svc_encode_cookie3 - Encode a directory offset cookie
  * @resp: readdir result context
@@ -1255,152 +1211,6 @@ void nfs3svc_encode_cookie3(struct nfsd3_readdirres *resp, u64 offset)
 	resp->cookie_offset = 0;
 }
 
-/*
- * Encode a directory entry. This one works for both normal readdir
- * and readdirplus.
- * The normal readdir reply requires 2 (fileid) + 1 (stringlen)
- * + string + 2 (cookie) + 1 (next) words, i.e. 6 + strlen.
- * 
- * The readdirplus baggage is 1+21 words for post_op_attr, plus the
- * file handle.
- */
-
-#define NFS3_ENTRY_BAGGAGE	(2 + 1 + 2 + 1)
-#define NFS3_ENTRYPLUS_BAGGAGE	(1 + 21 + 1 + (NFS3_FHSIZE >> 2))
-static int
-encode_entry(struct readdir_cd *ccd, const char *name, int namlen,
-	     loff_t offset, u64 ino, unsigned int d_type, int plus)
-{
-	struct nfsd3_readdirres *cd = container_of(ccd, struct nfsd3_readdirres,
-		       					common);
-	__be32		*p = cd->buffer;
-	caddr_t		curr_page_addr = NULL;
-	struct page **	page;
-	int		slen;		/* string (name) length */
-	int		elen;		/* estimated entry length in words */
-	int		num_entry_words = 0;	/* actual number of words */
-
-	nfs3svc_encode_cookie3(cd, offset);
-
-	/*
-	dprintk("encode_entry(%.*s @%ld%s)\n",
-		namlen, name, (long) offset, plus? " plus" : "");
-	 */
-
-	/* truncate filename if too long */
-	namlen = min(namlen, NFS3_MAXNAMLEN);
-
-	slen = XDR_QUADLEN(namlen);
-	elen = slen + NFS3_ENTRY_BAGGAGE
-		+ (plus? NFS3_ENTRYPLUS_BAGGAGE : 0);
-
-	if (cd->buflen < elen) {
-		cd->common.err = nfserr_toosmall;
-		return -EINVAL;
-	}
-
-	/* determine which page in rq_respages[] we are currently filling */
-	for (page = cd->rqstp->rq_respages + 1;
-				page < cd->rqstp->rq_next_page; page++) {
-		curr_page_addr = page_address(*page);
-
-		if (((caddr_t)cd->buffer >= curr_page_addr) &&
-		    ((caddr_t)cd->buffer <  curr_page_addr + PAGE_SIZE))
-			break;
-	}
-
-	if ((caddr_t)(cd->buffer + elen) < (curr_page_addr + PAGE_SIZE)) {
-		/* encode entry in current page */
-
-		p = encode_entry_baggage(cd, p, name, namlen, ino);
-
-		if (plus)
-			p = encode_entryplus_baggage(cd, p, name, namlen, ino);
-		num_entry_words = p - cd->buffer;
-	} else if (*(page+1) != NULL) {
-		/* temporarily encode entry into next page, then move back to
-		 * current and next page in rq_respages[] */
-		__be32 *p1, *tmp;
-		int len1, len2;
-
-		/* grab next page for temporary storage of entry */
-		p1 = tmp = page_address(*(page+1));
-
-		p1 = encode_entry_baggage(cd, p1, name, namlen, ino);
-
-		if (plus)
-			p1 = encode_entryplus_baggage(cd, p1, name, namlen, ino);
-
-		/* determine entry word length and lengths to go in pages */
-		num_entry_words = p1 - tmp;
-		len1 = curr_page_addr + PAGE_SIZE - (caddr_t)cd->buffer;
-		if ((num_entry_words << 2) < len1) {
-			/* the actual number of words in the entry is less
-			 * than elen and can still fit in the current page
-			 */
-			memmove(p, tmp, num_entry_words << 2);
-			p += num_entry_words;
-
-			/* update offset */
-			cd->offset = cd->buffer + (cd->offset - tmp);
-		} else {
-			unsigned int offset_r = (cd->offset - tmp) << 2;
-
-			/* update pointer to offset location.
-			 * This is a 64bit quantity, so we need to
-			 * deal with 3 cases:
-			 *  -	entirely in first page
-			 *  -	entirely in second page
-			 *  -	4 bytes in each page
-			 */
-			if (offset_r + 8 <= len1) {
-				cd->offset = p + (cd->offset - tmp);
-			} else if (offset_r >= len1) {
-				cd->offset -= len1 >> 2;
-			} else {
-				/* sitting on the fence */
-				BUG_ON(offset_r != len1 - 4);
-				cd->offset = p + (cd->offset - tmp);
-				cd->offset1 = tmp;
-			}
-
-			len2 = (num_entry_words << 2) - len1;
-
-			/* move from temp page to current and next pages */
-			memmove(p, tmp, len1);
-			memmove(tmp, (caddr_t)tmp+len1, len2);
-
-			p = tmp + (len2 >> 2);
-		}
-	}
-	else {
-		cd->common.err = nfserr_toosmall;
-		return -EINVAL;
-	}
-
-	cd->count += num_entry_words;
-	cd->buflen -= num_entry_words;
-	cd->buffer = p;
-	cd->common.err = nfs_ok;
-	return 0;
-
-}
-
-int
-nfs3svc_encode_entry(void *cd, const char *name,
-		     int namlen, loff_t offset, u64 ino, unsigned int d_type)
-{
-	return encode_entry(cd, name, namlen, offset, ino, d_type, 0);
-}
-
-int
-nfs3svc_encode_entry_plus(void *cd, const char *name,
-			  int namlen, loff_t offset, u64 ino,
-			  unsigned int d_type)
-{
-	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
-}
-
 static bool
 svcxdr_encode_entry3_common(struct nfsd3_readdirres *resp, const char *name,
 			    int namlen, loff_t offset, u64 ino)
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 81dea78b0f17..b851458373db 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -172,7 +172,6 @@ struct nfsd3_readdirres {
 	/* Components of the reply */
 	__be32			status;
 	struct svc_fh		fh;
-	int			count;
 	__be32			verf[2];
 
 	/* Used to encode the reply's entry list */
@@ -180,10 +179,6 @@ struct nfsd3_readdirres {
 	struct xdr_buf		dirlist;
 	struct svc_fh		scratch;
 	struct readdir_cd	common;
-	__be32 *		buffer;
-	int			buflen;
-	__be32 *		offset;
-	__be32 *		offset1;
 	unsigned int		cookie_offset;
 	struct svc_rqst *	rqstp;
 
@@ -305,12 +300,6 @@ void nfs3svc_release_fhandle(struct svc_rqst *);
 void nfs3svc_release_fhandle2(struct svc_rqst *);
 
 void nfs3svc_encode_cookie3(struct nfsd3_readdirres *resp, u64 offset);
-int nfs3svc_encode_entry(void *, const char *name,
-				int namlen, loff_t offset, u64 ino,
-				unsigned int);
-int nfs3svc_encode_entry_plus(void *, const char *name,
-				int namlen, loff_t offset, u64 ino,
-				unsigned int);
 int nfs3svc_encode_entry3(void *data, const char *name, int namlen,
 			  loff_t offset, u64 ino, unsigned int d_type);
 int nfs3svc_encode_entryplus3(void *data, const char *name, int namlen,



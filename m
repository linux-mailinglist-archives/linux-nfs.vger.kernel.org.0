Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F43708725
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjERRqM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 13:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjERRqJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 13:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6510E7
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 10:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0555A65172
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 17:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2A2C4339B;
        Thu, 18 May 2023 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431964;
        bh=5cq3hHSmmvzznWlj+O2y3SpqOlSMPmQc3draLNBzshI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BvcizT4eLLf858C8I2a9Yb9zyoz3PQ5d3MFwZknw3owzzmNsAiYU557RGsgej24ZE
         sf2P4VGg9AgaP3DS4pZASQcmH/u2Hfnj4q0NEoDhbz2cXVqrAbSOwSpTgyXHHYdVrf
         uWiEKvwpeGkeyfPP42x5C7DWzYxKVJAjkicCbU6WByaa9fF9CR76xZVmnKPeWAhjAW
         +Ownk4wx8c7x5S4C1QtXE681ZRqE5h+0A5leNIIVnWVfW02Co11PC47VGw4TEXhj7d
         w6jQedWl970LTl8Fsq+OX+PW8dXlbnSBH8WQArj2U2eeYGVgsqT9HEMqUxyfTyLkNc
         xm8GOu3NfAQuw==
Subject: [PATCH v1 5/6] NFSD: Hoist rq_vec preparation into nfsd_read() [step
 two]
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, dhowells@redhat.com, jlayton@redhat.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 18 May 2023 13:46:03 -0400
Message-ID: <168443196312.516083.6031724443786862273.stgit@klimt.1015granger.net>
In-Reply-To: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
References: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Now that the preparation of an rq_vec has been removed from the
generic read path, nfsd_splice_read() no longer needs to reset
rq_next_page.

nfsd4_encode_read() calls nfsd_splice_read() directly. As far as I
can ascertain, resetting rq_next_page for NFSv4 splice reads is
unnecessary because rq_next_page is already set correctly.

Moreover, resetting it might even be incorrect if previous
operations in the COMPOUND have already consumed at least a page of
the send buffer. I would expect that the result would be encoding
the READ payload over previously-encoded results.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c          |   10 +++++-----
 fs/nfsd/vfs.c              |   13 ++++++++++++-
 include/linux/sunrpc/xdr.h |    3 +--
 net/sunrpc/xdr.c           |   26 ++++++++++++--------------
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 23dd09c4b2cd..b83954fc57e3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4104,13 +4104,13 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	__be32 zero = xdr_zero;
 	__be32 nfserr;
 
-	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
-	if (read->rd_vlen < 0)
+	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
 		return nfserr_resource;
 
-	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
-			    &read->rd_eof);
+	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
+				read->rd_offset, &maxcount,
+				xdr->buf->page_len & ~PAGE_MASK,
+				&read->rd_eof);
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 054d58d01299..13ccd385b308 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -995,6 +995,18 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 }
 
+/**
+ * nfsd_splice_read - Perform a VFS read using a splice pipe
+ * @rqstp: RPC transaction context
+ * @fhp: file handle of file to be read
+ * @file: opened struct file of file to be read
+ * @offset: starting byte offset
+ * @count: IN: requested number of bytes; OUT: number of bytes read
+ * @eof: OUT: set non-zero if operation reached the end of the file
+ *
+ * Returns nfs_ok on success, otherwise an nfserr stat value is
+ * returned.
+ */
 __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			struct file *file, loff_t offset, unsigned long *count,
 			u32 *eof)
@@ -1008,7 +1020,6 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	ssize_t host_err;
 
 	trace_nfsd_read_splice(rqstp, fhp, offset, *count);
-	rqstp->rq_next_page = rqstp->rq_respages + 1;
 	host_err = splice_direct_to_actor(file, &sd, nfsd_direct_splice_actor);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 72014c9216fc..f89ec4b5ea16 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -242,8 +242,7 @@ extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
 extern void xdr_init_encode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
 			   struct page **pages, struct rpc_rqst *rqst);
 extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
-extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec,
-		size_t nbytes);
+extern int xdr_reserve_space_vec(struct xdr_stream *xdr, size_t nbytes);
 extern void __xdr_commit_encode(struct xdr_stream *xdr);
 extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
 extern void xdr_truncate_decode(struct xdr_stream *xdr, size_t len);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 36835b2f5446..2a22e78af116 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1070,22 +1070,22 @@ __be32 * xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(xdr_reserve_space);
 
-
 /**
  * xdr_reserve_space_vec - Reserves a large amount of buffer space for sending
  * @xdr: pointer to xdr_stream
- * @vec: pointer to a kvec array
  * @nbytes: number of bytes to reserve
  *
- * Reserves enough buffer space to encode 'nbytes' of data and stores the
- * pointers in 'vec'. The size argument passed to xdr_reserve_space() is
- * determined based on the number of bytes remaining in the current page to
- * avoid invalidating iov_base pointers when xdr_commit_encode() is called.
+ * The size argument passed to xdr_reserve_space() is determined based
+ * on the number of bytes remaining in the current page to avoid
+ * invalidating iov_base pointers when xdr_commit_encode() is called.
+ *
+ * Return values:
+ *   %0: success
+ *   %-EMSGSIZE: not enough space is available in @xdr
  */
-int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec, size_t nbytes)
+int xdr_reserve_space_vec(struct xdr_stream *xdr, size_t nbytes)
 {
-	int thislen;
-	int v = 0;
+	size_t thislen;
 	__be32 *p;
 
 	/*
@@ -1097,21 +1097,19 @@ int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec, size_t nbyte
 		xdr->end = xdr->p;
 	}
 
+	/* XXX: Let's find a way to make this more efficient */
 	while (nbytes) {
 		thislen = xdr->buf->page_len % PAGE_SIZE;
 		thislen = min_t(size_t, nbytes, PAGE_SIZE - thislen);
 
 		p = xdr_reserve_space(xdr, thislen);
 		if (!p)
-			return -EIO;
+			return -EMSGSIZE;
 
-		vec[v].iov_base = p;
-		vec[v].iov_len = thislen;
-		v++;
 		nbytes -= thislen;
 	}
 
-	return v;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(xdr_reserve_space_vec);
 



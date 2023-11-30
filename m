Return-Path: <linux-nfs+bounces-213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF287FF4CE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 17:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C413CB20D77
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D154F93;
	Thu, 30 Nov 2023 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPYqmrIb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF0495C2;
	Thu, 30 Nov 2023 16:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C91C433C9;
	Thu, 30 Nov 2023 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361406;
	bh=b1h8gtZEdCTCPlCJsoCp+Gb+TSDaIrTZ2XUZRWD4otY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPYqmrIbzlEI1HQNWJMPkt8sAWIQUCdon3pC43UeQcJbmLeqvHMuh821gYkG58KZh
	 qBfqdtIOG3AarlUKkY0+Mr7/qyC6GeJYR8qSDbPvtQrkfkHv1vTV6qc5U+UkXv7gvP
	 HACEr33d6ovO0z27QMDIcyrQxzODEIj3JBEQBNz0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 002/112] NFSD: Fix checksum mismatches in the duplicate reply cache
Date: Thu, 30 Nov 2023 16:20:49 +0000
Message-ID: <20231130162140.390349216@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit bf51c52a1f3c238d72c64e14d5e7702d3a245b82 ]

nfsd_cache_csum() currently assumes that the server's RPC layer has
been advancing rq_arg.head[0].iov_base as it decodes an incoming
request, because that's the way it used to work. On entry, it
expects that buf->head[0].iov_base points to the start of the NFS
header, and excludes the already-decoded RPC header.

These days however, head[0].iov_base now points to the start of the
RPC header during all processing. It no longer points at the NFS
Call header when execution arrives at nfsd_cache_csum().

In a retransmitted RPC the XID and the NFS header are supposed to
be the same as the original message, but the contents of the
retransmitted RPC header can be different. For example, for krb5,
the GSS sequence number will be different between the two. Thus if
the RPC header is always included in the DRC checksum computation,
the checksum of the retransmitted message might not match the
checksum of the original message, even though the NFS part of these
messages is identical.

The result is that, even if a matching XID is found in the DRC,
the checksum mismatch causes the server to execute the
retransmitted RPC transaction again.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/cache.h    |    4 +--
 fs/nfsd/nfscache.c |   64 +++++++++++++++++++++++++++++++++++------------------
 fs/nfsd/nfssvc.c   |   10 +++++++-
 3 files changed, 54 insertions(+), 24 deletions(-)

--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -84,8 +84,8 @@ int	nfsd_net_reply_cache_init(struct nfs
 void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
-int	nfsd_cache_lookup(struct svc_rqst *rqstp,
-			  struct nfsd_cacherep **cacherep);
+int	nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
+			  unsigned int len, struct nfsd_cacherep **cacherep);
 void	nfsd_cache_update(struct svc_rqst *rqstp, struct nfsd_cacherep *rp,
 			  int cachetype, __be32 *statp);
 int	nfsd_reply_cache_stats_show(struct seq_file *m, void *v);
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -368,33 +368,52 @@ nfsd_reply_cache_scan(struct shrinker *s
 	return freed;
 }
 
-/*
- * Walk an xdr_buf and get a CRC for at most the first RC_CSUMLEN bytes
+/**
+ * nfsd_cache_csum - Checksum incoming NFS Call arguments
+ * @buf: buffer containing a whole RPC Call message
+ * @start: starting byte of the NFS Call header
+ * @remaining: size of the NFS Call header, in bytes
+ *
+ * Compute a weak checksum of the leading bytes of an NFS procedure
+ * call header to help verify that a retransmitted Call matches an
+ * entry in the duplicate reply cache.
+ *
+ * To avoid assumptions about how the RPC message is laid out in
+ * @buf and what else it might contain (eg, a GSS MIC suffix), the
+ * caller passes us the exact location and length of the NFS Call
+ * header.
+ *
+ * Returns a 32-bit checksum value, as defined in RFC 793.
  */
-static __wsum
-nfsd_cache_csum(struct svc_rqst *rqstp)
+static __wsum nfsd_cache_csum(struct xdr_buf *buf, unsigned int start,
+			      unsigned int remaining)
 {
+	unsigned int base, len;
+	struct xdr_buf subbuf;
+	__wsum csum = 0;
+	void *p;
 	int idx;
-	unsigned int base;
-	__wsum csum;
-	struct xdr_buf *buf = &rqstp->rq_arg;
-	const unsigned char *p = buf->head[0].iov_base;
-	size_t csum_len = min_t(size_t, buf->head[0].iov_len + buf->page_len,
-				RC_CSUMLEN);
-	size_t len = min(buf->head[0].iov_len, csum_len);
+
+	if (remaining > RC_CSUMLEN)
+		remaining = RC_CSUMLEN;
+	if (xdr_buf_subsegment(buf, &subbuf, start, remaining))
+		return csum;
 
 	/* rq_arg.head first */
-	csum = csum_partial(p, len, 0);
-	csum_len -= len;
+	if (subbuf.head[0].iov_len) {
+		len = min_t(unsigned int, subbuf.head[0].iov_len, remaining);
+		csum = csum_partial(subbuf.head[0].iov_base, len, csum);
+		remaining -= len;
+	}
 
 	/* Continue into page array */
-	idx = buf->page_base / PAGE_SIZE;
-	base = buf->page_base & ~PAGE_MASK;
-	while (csum_len) {
-		p = page_address(buf->pages[idx]) + base;
-		len = min_t(size_t, PAGE_SIZE - base, csum_len);
+	idx = subbuf.page_base / PAGE_SIZE;
+	base = subbuf.page_base & ~PAGE_MASK;
+	while (remaining) {
+		p = page_address(subbuf.pages[idx]) + base;
+		len = min_t(unsigned int, PAGE_SIZE - base, remaining);
 		csum = csum_partial(p, len, csum);
-		csum_len -= len;
+		remaining -= len;
 		base = 0;
 		++idx;
 	}
@@ -465,6 +484,8 @@ out:
 /**
  * nfsd_cache_lookup - Find an entry in the duplicate reply cache
  * @rqstp: Incoming Call to find
+ * @start: starting byte in @rqstp->rq_arg of the NFS Call header
+ * @len: size of the NFS Call header, in bytes
  * @cacherep: OUT: DRC entry for this request
  *
  * Try to find an entry matching the current call in the cache. When none
@@ -478,7 +499,8 @@ out:
  *   %RC_REPLY: Reply from cache
  *   %RC_DROPIT: Do not process the request further
  */
-int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
+int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
+		      unsigned int len, struct nfsd_cacherep **cacherep)
 {
 	struct nfsd_net		*nn;
 	struct nfsd_cacherep	*rp, *found;
@@ -494,7 +516,7 @@ int nfsd_cache_lookup(struct svc_rqst *r
 		goto out;
 	}
 
-	csum = nfsd_cache_csum(rqstp);
+	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
 
 	/*
 	 * Since the common case is a cache miss followed by an insert,
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -988,6 +988,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
 	struct nfsd_cacherep *rp;
+	unsigned int start, len;
 	__be32 *nfs_reply;
 
 	/*
@@ -996,11 +997,18 @@ int nfsd_dispatch(struct svc_rqst *rqstp
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
 
+	/*
+	 * ->pc_decode advances the argument stream past the NFS
+	 * Call header, so grab the header's starting location and
+	 * size now for the call to nfsd_cache_lookup().
+	 */
+	start = xdr_stream_pos(&rqstp->rq_arg_stream);
+	len = xdr_stream_remaining(&rqstp->rq_arg_stream);
 	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
 	rp = NULL;
-	switch (nfsd_cache_lookup(rqstp, &rp)) {
+	switch (nfsd_cache_lookup(rqstp, start, len, &rp)) {
 	case RC_DOIT:
 		break;
 	case RC_REPLY:




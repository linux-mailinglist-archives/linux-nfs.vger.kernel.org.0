Return-Path: <linux-nfs+bounces-150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAFE7FC8FF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F94B2132F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40EB481AE;
	Tue, 28 Nov 2023 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHg5Ttcd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2703481AA;
	Tue, 28 Nov 2023 22:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE73C433C9;
	Tue, 28 Nov 2023 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208897;
	bh=4mQhOD+sPkylej5Fp3soKua0SkYoCViCeDLUhtscRw4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iHg5TtcdmlEE+xn89aqmvtGGFSX1wUS0PUMsu6J1TYdiue8VY+GYx1RrpswmXfwFO
	 31VyBOsQZNnhSos4+3x8qnQmcZemB0vtZ/U/HTFBoGE3JbmrAjbmvZiBBaZAzApnjk
	 s5mPE0M0XJqI7I55zw9ncfYWcGr8M5E6FnG4JfkUKz60lc5sh3HAx6E4b9yyaeb4AD
	 NpDz5zFXyRaeV6w+cAIhvp8BzlGYCZx6l2a34Ta7rEq1OqxsvIpdd7+VHIRtvWZvUy
	 dh+IvTsLRJYxvZ42MVFyv3A1mBCs7Ergp4BdTuZEKHFP5KNv6bEo3Z175elLkKOBby
	 SLA7Fq/Y6EoUw==
Subject: [PATCH 2/2] NFSD: Fix checksum mismatches in the duplicate reply
 cache
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 17:01:36 -0500
Message-ID: 
 <170120889657.1725.7300213662876041857.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120886349.1725.10740679467794019580.stgit@klimt.1015granger.net>
References: 
 <170120886349.1725.10740679467794019580.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
---
 fs/nfsd/cache.h    |    3 ++
 fs/nfsd/nfscache.c |   65 +++++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/nfssvc.c   |   11 ++++++++-
 3 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index f21259ead64b..3c07d587ae9e 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -82,7 +82,8 @@ int	nfsd_drc_slab_create(void);
 void	nfsd_drc_slab_free(void);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
-int	nfsd_cache_lookup(struct svc_rqst *);
+int	nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
+			  unsigned int len);
 void	nfsd_cache_update(struct svc_rqst *, int, __be32 *);
 int	nfsd_reply_cache_stats_show(struct seq_file *m, void *v);
 
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 3e64a3d50a1c..f53335ae0ab2 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -311,33 +311,53 @@ nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 	return prune_cache_entries(nn);
 }
-/*
- * Walk an xdr_buf and get a CRC for at most the first RC_CSUMLEN bytes
+
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
@@ -408,6 +428,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
 /**
  * nfsd_cache_lookup - Find an entry in the duplicate reply cache
  * @rqstp: Incoming Call to find
+ * @start: starting byte in @rqstp->rq_arg of the NFS Call header
+ * @len: size of the NFS Call header, in bytes
  *
  * Try to find an entry matching the current call in the cache. When none
  * is found, we try to grab the oldest expired entry off the LRU list. If
@@ -420,7 +442,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
  *   %RC_REPLY: Reply from cache
  *   %RC_DROPIT: Do not process the request further
  */
-int nfsd_cache_lookup(struct svc_rqst *rqstp)
+int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
+		      unsigned int len)
 {
 	struct nfsd_net		*nn;
 	struct svc_cacherep	*rp, *found;
@@ -435,7 +458,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	csum = nfsd_cache_csum(rqstp);
+	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
 
 	/*
 	 * Since the common case is a cache miss followed by an insert,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ca2a9d0eefc2..f6cc99af8192 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1027,6 +1027,7 @@ nfsd(void *vrqstp)
 int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	unsigned int start, len;
 	__be32 *nfs_reply;
 
 	/*
@@ -1036,10 +1037,18 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	rqstp->rq_cachetype = proc->pc_cachetype;
 
 	svcxdr_init_decode(rqstp);
+
+	/*
+	 * ->pc_decode advances the argument stream past the NFS
+	 * Call header, so grab the header's starting location and
+	 * size now for the call to nfsd_cache_lookup().
+	 */
+	start = xdr_stream_pos(&rqstp->rq_arg_stream);
+	len = xdr_stream_remaining(&rqstp->rq_arg_stream);
 	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
-	switch (nfsd_cache_lookup(rqstp)) {
+	switch (nfsd_cache_lookup(rqstp, start, len)) {
 	case RC_DOIT:
 		break;
 	case RC_REPLY:




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8537E6B5F
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Nov 2023 14:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjKINph (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINpg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 08:45:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0E2D56
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 05:45:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B4FC433C8;
        Thu,  9 Nov 2023 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699537533;
        bh=kAgvbfvALudLDnQDDTRIqaNJjlQ1kaHev6BsePQ4yGc=;
        h=Subject:From:To:Cc:Date:From;
        b=uz4u8RJyGaYdEo9wXSyudb8Gp5qWHTIHfWSR7t7Q0zQSANQvXBcFlVL1Gda1GHb5/
         qTTB7E6uFi1b4DUqeZBDHQaX2eIS+BkFpiTykFxeujzQtqnBQqXYAnShkl/b8K5tjK
         /jk1CaQNv+L0pjU6HDpRtnwzkG1Le20MNl3MHF9q9TMMjexEoMBtxU8lGpqe1X2xRR
         jigSFxLvrKV4tPYbTQCWK30QbOlwsi1xHVNLkPsLu48Cx+k5gnLfshcc3qiRfspZlD
         g+VVEsTQpvhTFpQEn3mXJ9mUrXu/v3/DZzyXg/zkGtLQIe9kd7Y6967qBqZoTYm8HB
         W4uZbSWARzMOw==
Subject: [PATCH RFC] NFSD: Fix checksum mismatches in the duplicate reply
 cache
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 09 Nov 2023 08:45:32 -0500
Message-ID: <169953717421.7448.7269783258225907202.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

nfsd_cache_csum() currently assumes that the server's RPC layer has
been advancing rq_arg.head[0].iov_base as it decodes an incoming
request, because that's the way it used to work. On entry, it
expects that buf->head[0].iov_base points to the start of the NFS
header, and excludes the already-decoded RPC header.

Ever since the RPC layer was converted over to use xdr_stream (in
v6.3), however, head[0].iov_base now points to the start of the RPC
header during all processing. It no longer points at the NFS Call
header when execution arrives at nfsd_cache_csum().

In a retransmitted RPC the XID and the NFS header are supposed to
be the same as the original message, but the contents of the
retransmitted RPC header can be different. For example, for krb5,
the GSS sequence number will be different between the two. Thus if
the RPC header is included in the DRC checksum computation, the
checksum of the retransmitted message might not match the checksum
of the original message, even though the NFS part of these messages
is identical.

If the DRC fails to recognize a retransmit, it permits the server to
execute that RPC Call again. That breaks retransmits of idempotent
procedures such as RENAME or REMOVE -- the retransmitted RPC Call
will get a different result.

Note that I am not marking this commit with a Fixes: tag:

 o The RPC-related commits that broke the DRC are too numerous
 o The fix should not be automatically backported, as any backport
   of it needs to be thoroughly tested

However, it might be appropriate to consider applying this fix to
v6.3 and later kernels, if someone can make it fit cleanly and test
it properly. This patch applies with fuzz to v6.6, but does not
apply cleanly to earlier kernels.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/cache.h    |    4 ++--
 fs/nfsd/nfscache.c |   55 +++++++++++++++++++++++++++++++++-------------------
 fs/nfsd/nfssvc.c   |   10 +++++++++
 3 files changed, 46 insertions(+), 23 deletions(-)

This fix is kind of ugly. Looking for comments or suggestions for
improvement. Two further clean-ups occurred to me:

 - Set up a parms struct in nfsd_dispatch() that is passed to
   nfsd_cache_lookup() and nfsd_cache_update() that carries all
   of this extraneous garbage
 - Move nfsd_cache_csum to net/sunrpc/xdr.c since it assumes
   details about the how the message appears in the xdr_buf


diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 929248c6ca84..4cbe0434cbb8 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -84,8 +84,8 @@ int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
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
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index fd56a52aa5fb..761896c44e77 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -370,32 +370,44 @@ nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 }
 
 /*
- * Walk an xdr_buf and get a CRC for at most the first RC_CSUMLEN bytes
+ * Compute a weak checksum of the leading bytes of an NFS procedure
+ * call header. csum_partial() computes a TCP checksum as specified
+ * in RFC 793.
+ *
+ * To avoid assumptions about how the RPC message is laid out in
+ * @buf and what else it might contain (eg, a GSS MIC suffix), the
+ * caller passes the exact location and length of the NFS Call
+ * header.
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
@@ -466,6 +478,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
 /**
  * nfsd_cache_lookup - Find an entry in the duplicate reply cache
  * @rqstp: Incoming Call to find
+ * @start: location in @rqstp->rq_arg of the NFS Call header
+ * @len: length of NFS Call header in bytes
  * @cacherep: OUT: DRC entry for this request
  *
  * Try to find an entry matching the current call in the cache. When none
@@ -479,7 +493,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
  *   %RC_REPLY: Reply from cache
  *   %RC_DROPIT: Do not process the request further
  */
-int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
+int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
+		      unsigned int len, struct nfsd_cacherep **cacherep)
 {
 	struct nfsd_net		*nn;
 	struct nfsd_cacherep	*rp, *found;
@@ -495,7 +510,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
 		goto out;
 	}
 
-	csum = nfsd_cache_csum(rqstp);
+	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
 
 	/*
 	 * Since the common case is a cache miss followed by an insert,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ef126969a7ce..1d6e33c6c4fe 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -980,6 +980,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
 	struct nfsd_cacherep *rp;
+	unsigned int start, len;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -987,6 +988,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
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
 
@@ -1000,7 +1008,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
 
 	rp = NULL;
-	switch (nfsd_cache_lookup(rqstp, &rp)) {
+	switch (nfsd_cache_lookup(rqstp, start, len, &rp)) {
 	case RC_DOIT:
 		break;
 	case RC_REPLY:



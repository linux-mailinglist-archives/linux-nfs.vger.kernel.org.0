Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED97E83B7
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjKJU02 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 15:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjKJU01 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 15:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03E3E426
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 08:28:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE952C433C8
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699633726;
        bh=ofzckPKZQhmtghTAmb1LRnlOAEV5OMTZOC9+n7Iirg0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=YpHG93RscztVVHFaf0Jf8/EbjNqSb76JCmPCOuwdg5WeZI2smV5jhwOm6OSdaunqZ
         bV+Y+6yICoaRsI6nDsNpm68fDV+aXayRxDTBCV5DphUa+elFkoeaNk/ltzxkOlfyIt
         mrwuyoZcNKUnc9egqo39n46d0Ym2AH6jMPrMOA4FqWojve9VAKOAjK4Ok+BRkVydJm
         4Wqq78I/yWUw7fAdNZM9yxdoUsv7hTgSuovQJ+x+FIF+ZfK8vQHxqrVFrFnyiqmnPi
         7qL7b6WrWq+hPoHJrZvYq5HkGpIBV8cKfgO9Dw8sauPhHAb8EG6m2bnEMQSxDIUNYK
         KAGkV8qZ+ikZw==
Subject: [PATCH v2 3/3] NFSD: Fix checksum mismatches in the duplicate reply
 cache
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 10 Nov 2023 11:28:45 -0500
Message-ID: <169963372584.5404.2548015812135074126.stgit@bazille.1015granger.net>
In-Reply-To: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
References: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
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

It might be appropriate to consider applying this fix kernels as
early as v6.3, if someone can make it apply cleanly and test it
properly.

Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/cache.h    |    4 ++-
 fs/nfsd/nfscache.c |   64 +++++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/nfssvc.c   |   10 +++++++-
 3 files changed, 54 insertions(+), 24 deletions(-)

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
index 9046331e0e5e..d3273a396659 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -369,33 +369,52 @@ nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
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
@@ -466,6 +485,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
 /**
  * nfsd_cache_lookup - Find an entry in the duplicate reply cache
  * @rqstp: Incoming Call to find
+ * @start: starting byte in @rqstp->rq_arg of the NFS Call header
+ * @len: size of the NFS Call header, in bytes
  * @cacherep: OUT: DRC entry for this request
  *
  * Try to find an entry matching the current call in the cache. When none
@@ -479,7 +500,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
  *   %RC_REPLY: Reply from cache
  *   %RC_DROPIT: Do not process the request further
  */
-int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
+int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
+		      unsigned int len, struct nfsd_cacherep **cacherep)
 {
 	struct nfsd_net		*nn;
 	struct nfsd_cacherep	*rp, *found;
@@ -495,7 +517,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
 		goto out;
 	}
 
-	csum = nfsd_cache_csum(rqstp);
+	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
 
 	/*
 	 * Since the common case is a cache miss followed by an insert,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 60aacca2bca6..d8eeb760b5d9 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -981,6 +981,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
 	struct nfsd_cacherep *rp;
+	unsigned int start, len;
 	__be32 *nfs_reply;
 
 	/*
@@ -989,6 +990,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
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
 
@@ -1002,7 +1010,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
 
 	rp = NULL;
-	switch (nfsd_cache_lookup(rqstp, &rp)) {
+	switch (nfsd_cache_lookup(rqstp, start, len, &rp)) {
 	case RC_DOIT:
 		break;
 	case RC_REPLY:



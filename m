Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75BF49BBA3
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiAYS4d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 13:56:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55570 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiAYS4Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 13:56:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F7F6CE1A5A
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A2C340E7
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:20 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSD: De-duplicate hash bucket indexing
Date:   Tue, 25 Jan 2022 13:56:19 -0500
Message-Id:  <164313697909.3172.1031655565721726455.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164313689644.3172.6086810615126935434.stgit@bazille.1015granger.net>
References:  <164313689644.3172.6086810615126935434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404; h=from:subject:message-id; bh=6J9ieKP7V0wG46GB4sWwZg7FhGMIgJTPIszXel0ri1c=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8EfTbwCn1KxPpMD9DwjbE/v7Uf+oC8mYi0kpKdtD 5SXPol2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfBH0wAKCRAzarMzb2Z/lz0tD/ 99dUALO/bGZrc4KuA68ttr5EcZ8i2dR/r8ZgYP52owGkoXz/ZC0Q188k8XiAC3a3xP90wM3U8LP6Ft 0oQ3ZHZ7QN6DWDbk10kJd2fTVPQByUuX48T9ifxZMynp6dt4grJzsTT4Zen6cjiyUpFaFR/A9GFQ2+ SmhnGLkBix78iOPRVqkH56kyiPQkj604QO5YT0Cvu5Z5593hQdGP/QaQVXctbKKmbkY3118ynyH99G +gJhBpC4BN0J0fytGDnGBruOjTbMyZ01lMqu91zz5ZR3SxlyXzNb+5pIUt+YFKJbAvzSjmyc1k/fV2 Pds1ow7KSH7IioY+CpigY0dGgc2hKjBTXnvRNzysZVx/JRkLx1aWz2L5VY1emSTZ1RWemYc6TW034z PkZ30j1znANmN+BbLPVHVyae3IAZWlWmqsIkzOat4hsvIGYwjmPI2qNVq1fKrltJh6Q9kE0wIWNs9u G7T8xPSnbOCDKXU54PaEBAnc9MwRhekDsFzRMLRc40w4zW3uYRXp70TF5y5ohooXdIkDOde3nNtxfL 7uM79aD79vq1QZjzdUTy0SUWHXcf+cYy0TJ5OURKrPbEmpy4Cxkb7y+RQlu8RGhEuOPJs0v1DqElwm NVMXHLWuQ8V5zacHAY3UurWeCF4km031AiVw7MS5rwfO/acII/0eM2LCZENA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The details of finding the right hash bucket are exactly
the same in both nfsd_cache_lookup() and nfsd_cache_update().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index a4a69ab6ab28..f79790d36728 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -84,12 +84,6 @@ nfsd_hashsize(unsigned int limit)
 	return roundup_pow_of_two(limit / TARGET_BUCKET_SIZE);
 }
 
-static u32
-nfsd_cache_hash(__be32 xid, struct nfsd_net *nn)
-{
-	return hash_32((__force u32)xid, nn->maskbits);
-}
-
 static struct svc_cacherep *
 nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
 			struct nfsd_net *nn)
@@ -241,6 +235,14 @@ lru_put_end(struct nfsd_drc_bucket *b, struct svc_cacherep *rp)
 	list_move_tail(&rp->c_lru, &b->lru_head);
 }
 
+static noinline struct nfsd_drc_bucket *
+nfsd_cache_bucket_find(__be32 xid, struct nfsd_net *nn)
+{
+	unsigned int hash = hash_32((__force u32)xid, nn->maskbits);
+
+	return &nn->drc_hashtbl[hash];
+}
+
 static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
 			 unsigned int max)
 {
@@ -421,10 +423,8 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep	*rp, *found;
-	__be32			xid = rqstp->rq_xid;
 	__wsum			csum;
-	u32 hash = nfsd_cache_hash(xid, nn);
-	struct nfsd_drc_bucket *b = &nn->drc_hashtbl[hash];
+	struct nfsd_drc_bucket	*b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
 	int type = rqstp->rq_cachetype;
 	int rtn = RC_DOIT;
 
@@ -528,7 +528,6 @@ void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep *rp = rqstp->rq_cacherep;
 	struct kvec	*resv = &rqstp->rq_res.head[0], *cachv;
-	u32		hash;
 	struct nfsd_drc_bucket *b;
 	int		len;
 	size_t		bufsize = 0;
@@ -536,8 +535,7 @@ void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 	if (!rp)
 		return;
 
-	hash = nfsd_cache_hash(rp->c_key.k_xid, nn);
-	b = &nn->drc_hashtbl[hash];
+	b = nfsd_cache_bucket_find(rp->c_key.k_xid, nn);
 
 	len = resv->iov_len - ((char*)statp - (char*)resv->iov_base);
 	len >>= 2;


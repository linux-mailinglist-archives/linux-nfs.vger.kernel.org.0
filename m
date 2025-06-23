Return-Path: <linux-nfs+bounces-12649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E90AE400A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13AA1888E84
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D3623C4F3;
	Mon, 23 Jun 2025 12:22:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E7AD21F09B3;
	Mon, 23 Jun 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681370; cv=none; b=DVcohrgbTtEx/uzbHQOU0NuioCzQNEEVmddxw0OjOtIBKMf4kSuc9TbBFNsUzFt0CgfWN1X53YWOE/M8Z+LY0mfuLyjFnvLNNmaQTXfsuE9qFkk23hPMGaCbB8TD1uY6TlZWr/dPT7PtdQDmxjxLABeVl301QgF9A9RzgvlT+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681370; c=relaxed/simple;
	bh=KesN4i+iw9iOvPBik8PMpmEBSOySopVhrh240s9MJKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tjnwn8++J8DpxwC9XgzR3o5JBJYkj9ONzGya4iZQMH1tlLXi8fSoS6CaDZq8RZJczMwqD6LzF1QxT796nRgiuOIfE/fqB4lT3quYUgMwGH1qprsfQGcrO1TVYwIAAZ+ohpMRvhWrOEIeiGLlY1uXDXXGZCTCrYqi7cG3QPaP6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 4A98D603062FA;
	Mon, 23 Jun 2025 20:22:37 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: Using guard() to simplify nfsd_cache_lookup()
Date: Mon, 23 Jun 2025 20:22:27 +0800
Message-Id: <20250623122226.3720564-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using guard() to replace *unlock* label. guard() makes lock/unlock code
more clear. Change the order of the code to let all lock code in the
same scope. No functional changes.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/nfsd/nfscache.c | 99 ++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 51 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index ba9d326b3de6..2d92adf3e6b0 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -489,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 
 	if (type == RC_NOCACHE) {
 		nfsd_stats_rc_nocache_inc(nn);
-		goto out;
+		return rtn;
 	}
 
 	csum = nfsd_cache_csum(&rqstp->rq_arg, start, len);
@@ -500,64 +500,61 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 	 */
 	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
-		goto out;
+		return rtn;
 
 	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
-	spin_lock(&b->cache_lock);
-	found = nfsd_cache_insert(b, rp, nn);
-	if (found != rp)
-		goto found_entry;
-	*cacherep = rp;
-	rp->c_state = RC_INPROG;
-	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
-	spin_unlock(&b->cache_lock);
+	scoped_guard(spinlock, &b->cache_lock) {
+		found = nfsd_cache_insert(b, rp, nn);
+		if (found == rp) {
+			*cacherep = rp;
+			rp->c_state = RC_INPROG;
+			nfsd_prune_bucket_locked(nn, b, 3, &dispose);
+			goto out;
+		}
+		/* We found a matching entry which is either in progress or done. */
+		nfsd_reply_cache_free_locked(NULL, rp, nn);
+		nfsd_stats_rc_hits_inc(nn);
+		rtn = RC_DROPIT;
+		rp = found;
+
+		/* Request being processed */
+		if (rp->c_state == RC_INPROG)
+			goto out_trace;
+
+		/* From the hall of fame of impractical attacks:
+		 * Is this a user who tries to snoop on the cache?
+		 */
+		rtn = RC_DOIT;
+		if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
+			goto out_trace;
 
+		/* Compose RPC reply header */
+		switch (rp->c_type) {
+		case RC_NOCACHE:
+			break;
+		case RC_REPLSTAT:
+			xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
+			rtn = RC_REPLY;
+			break;
+		case RC_REPLBUFF:
+			if (!nfsd_cache_append(rqstp, &rp->c_replvec))
+				return rtn; /* should not happen */
+			rtn = RC_REPLY;
+			break;
+		default:
+			WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
+		}
+
+out_trace:
+		trace_nfsd_drc_found(nn, rqstp, rtn);
+		return rtn;
+	}
+out:
 	nfsd_cacherep_dispose(&dispose);
 
 	nfsd_stats_rc_misses_inc(nn);
 	atomic_inc(&nn->num_drc_entries);
 	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
-	goto out;
-
-found_entry:
-	/* We found a matching entry which is either in progress or done. */
-	nfsd_reply_cache_free_locked(NULL, rp, nn);
-	nfsd_stats_rc_hits_inc(nn);
-	rtn = RC_DROPIT;
-	rp = found;
-
-	/* Request being processed */
-	if (rp->c_state == RC_INPROG)
-		goto out_trace;
-
-	/* From the hall of fame of impractical attacks:
-	 * Is this a user who tries to snoop on the cache? */
-	rtn = RC_DOIT;
-	if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
-		goto out_trace;
-
-	/* Compose RPC reply header */
-	switch (rp->c_type) {
-	case RC_NOCACHE:
-		break;
-	case RC_REPLSTAT:
-		xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
-		rtn = RC_REPLY;
-		break;
-	case RC_REPLBUFF:
-		if (!nfsd_cache_append(rqstp, &rp->c_replvec))
-			goto out_unlock; /* should not happen */
-		rtn = RC_REPLY;
-		break;
-	default:
-		WARN_ONCE(1, "nfsd: bad repcache type %d\n", rp->c_type);
-	}
-
-out_trace:
-	trace_nfsd_drc_found(nn, rqstp, rtn);
-out_unlock:
-	spin_unlock(&b->cache_lock);
-out:
 	return rtn;
 }
 
-- 
2.30.2



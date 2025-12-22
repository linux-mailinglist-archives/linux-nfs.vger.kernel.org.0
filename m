Return-Path: <linux-nfs+bounces-17260-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A68CD6F9E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 20:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754603029D2A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D323358C0;
	Mon, 22 Dec 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiKsr0xM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AB303A3B
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431809; cv=none; b=OR4WdwdHbgRzzEkkvPFGuAis2YIclA2dtxlvQVTp/a/dnQGabp7Psl+y4AfiJ9lMqk+GV5H31xzNtPguBM8rfty/8/q2DyFrOH20oqejlObw2EnUwZJs5P5/yryL/b5Nvgkw1WnY/yNATqSZ0FNft8wgOn11Rbdm+6V7RBF2g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431809; c=relaxed/simple;
	bh=i6Qp04fKU6YulUWXhM1ZOD7dqAeTYLL9YJq+Uw7Ak60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO+J40bZoeVAlQ5tb3qzOQ5X2ISmmk1u0kjmNsI4qOFID7cuyFzg4KyoILY6v5VchePFW23GPTnFEXMgwQTT9jsvVVN1gaT8fE87wQb7QWi8iTcrPpFHPYUfqDH28avrdcU11VvHR8zeI1/a+foQ+4YosqGJB3mdWDvckp7o5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiKsr0xM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0B6C116D0;
	Mon, 22 Dec 2025 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431808;
	bh=i6Qp04fKU6YulUWXhM1ZOD7dqAeTYLL9YJq+Uw7Ak60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiKsr0xMomtTky3zW7GiSlAY/5sW5YtSCUFFOM1epMNDP5bV4NSJcY9qIT8BvjTTV
	 oi3q445azpzwBNQMp9SBk3+TRSiSCnRmGZ78vWUY9pgxHDzaqu1gf6Ne3VXWZFrwC4
	 wBiVWBRTa7P/i8LsRoZsS95J4ICD1SXgw/K8Z/4KKaPuLfilbZFyeRC5XGWS4Okesl
	 xLRlePZNQlxlwtc7JWgSOYfWJysZCNS5m+FyJsl/VlmzTqbhAyetwBkFkRL51N+lPt
	 Rc9C4i3ZRLQfavvdqKYLmTfe+yLNHxeRpDAq88LWeEO8+k/j5+qc0rjK9BFbaF7Q4a
	 0zFTaP8EU9VmA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Anthony Iliopoulos <ailiop@suse.com>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 1/2] nfsd: never defer requests during idmap lookup
Date: Mon, 22 Dec 2025 14:30:04 -0500
Message-ID: <20251222193005.1492196-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222193005.1492196-1-cel@kernel.org>
References: <20251222193005.1492196-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anthony Iliopoulos <ailiop@suse.com>

During v4 request compound arg decoding, some ops (e.g. SETATTR)
can trigger idmap lookup upcalls. When those upcall responses get
delayed beyond the allowed time limit, cache_check() will mark the
request for deferral and cause it to be dropped.

This prevents nfs4svc_encode_compoundres from being executed, and
thus the session slot flag NFSD4_SLOT_INUSE never gets cleared.
Subsequent client requests will fail with NFSERR_JUKEBOX, given
that the slot will be marked as in-use, making the SEQUENCE op
fail.

Fix this by making sure that the RQ_USEDEFERRAL flag is always
clear during nfs4svc_decode_compoundargs(), since no v4 request
should ever be deferred.

Fixes: 2f425878b6a7 ("nfsd: don't use the deferral service, return NFS4ERR_DELAY")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4idmap.c | 48 +++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/nfs4proc.c  |  2 --
 fs/nfsd/nfs4xdr.c   | 16 +++++++++++++++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 8cca1329f348..b5b3d45979c9 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -643,13 +643,31 @@ static __be32 encode_name_from_id(struct xdr_stream *xdr,
 	return idmap_id_to_name(xdr, rqstp, type, id);
 }
 
-__be32
-nfsd_map_name_to_uid(struct svc_rqst *rqstp, const char *name, size_t namelen,
-		kuid_t *uid)
+/**
+ * nfsd_map_name_to_uid - Map user@domain to local UID
+ * @rqstp: RPC execution context
+ * @name: user@domain name to be mapped
+ * @namelen: length of name, in bytes
+ * @uid: OUT: mapped local UID value
+ *
+ * Returns nfs_ok on success or an NFSv4 status code on failure.
+ */
+__be32 nfsd_map_name_to_uid(struct svc_rqst *rqstp, const char *name,
+			    size_t namelen, kuid_t *uid)
 {
 	__be32 status;
 	u32 id = -1;
 
+	/*
+	 * The idmap lookup below triggers an upcall that invokes
+	 * cache_check(). RQ_USEDEFERRAL must be clear to prevent
+	 * cache_check() from setting RQ_DROPME via svc_defer().
+	 * NFSv4 servers are not permitted to drop requests. Also
+	 * RQ_DROPME will force NFSv4.1 session slot processing to
+	 * be skipped.
+	 */
+	WARN_ON_ONCE(test_bit(RQ_USEDEFERRAL, &rqstp->rq_flags));
+
 	if (name == NULL || namelen == 0)
 		return nfserr_inval;
 
@@ -660,13 +678,31 @@ nfsd_map_name_to_uid(struct svc_rqst *rqstp, const char *name, size_t namelen,
 	return status;
 }
 
-__be32
-nfsd_map_name_to_gid(struct svc_rqst *rqstp, const char *name, size_t namelen,
-		kgid_t *gid)
+/**
+ * nfsd_map_name_to_gid - Map user@domain to local GID
+ * @rqstp: RPC execution context
+ * @name: user@domain name to be mapped
+ * @namelen: length of name, in bytes
+ * @gid: OUT: mapped local GID value
+ *
+ * Returns nfs_ok on success or an NFSv4 status code on failure.
+ */
+__be32 nfsd_map_name_to_gid(struct svc_rqst *rqstp, const char *name,
+			    size_t namelen, kgid_t *gid)
 {
 	__be32 status;
 	u32 id = -1;
 
+	/*
+	 * The idmap lookup below triggers an upcall that invokes
+	 * cache_check(). RQ_USEDEFERRAL must be clear to prevent
+	 * cache_check() from setting RQ_DROPME via svc_defer().
+	 * NFSv4 servers are not permitted to drop requests. Also
+	 * RQ_DROPME will force NFSv4.1 session slot processing to
+	 * be skipped.
+	 */
+	WARN_ON_ONCE(test_bit(RQ_USEDEFERRAL, &rqstp->rq_flags));
+
 	if (name == NULL || namelen == 0)
 		return nfserr_inval;
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4c708cf02849..2b805fc51262 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3013,8 +3013,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	BUG_ON(cstate->replay_owner);
 out:
 	cstate->status = status;
-	/* Reset deferral mechanism for RPC deferrals */
-	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 51ef97c25456..5065727204b9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6013,6 +6013,22 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	args->ops = args->iops;
 	args->rqstp = rqstp;
 
+	/*
+	 * NFSv4 operation decoders can invoke svc cache lookups
+	 * that trigger svc_defer() when RQ_USEDEFERRAL is set,
+	 * setting RQ_DROPME. This creates two problems:
+	 *
+	 * 1. Non-idempotency: Compounds make it too hard to avoid
+	 *    problems if a request is deferred and replayed.
+	 *
+	 * 2. Session slot leakage (NFSv4.1+): If RQ_DROPME is set
+	 *    during decode but SEQUENCE executes successfully, the
+	 *    session slot will be marked INUSE. The request is then
+	 *    dropped before encoding, so the slot is never released,
+	 *    rendering it permanently unusable by the client.
+	 */
+	clear_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
+
 	return nfsd4_decode_compound(args);
 }
 
-- 
2.52.0



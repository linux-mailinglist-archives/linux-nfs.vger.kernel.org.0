Return-Path: <linux-nfs+bounces-137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3627FC8E0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3012B212E8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593F481A9;
	Tue, 28 Nov 2023 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO+lp6Hz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE844390;
	Tue, 28 Nov 2023 21:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D08BC433C8;
	Tue, 28 Nov 2023 21:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208715;
	bh=hy9i5dVyZ4mmSypRczPB/KL0szsFppsZJxEPHSzBYvw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZO+lp6HzlC2tBNzWhPOHB3xAe7bEYMi6CExlAxrrbeZumh0zTF7E5nhZBcHiYdaVY
	 xw/xp+erolnPO/7hYcpigB9sJZ0/2y5vy7ocS7YqlOlOXUi88J3ty1Hz+rKBePicJ6
	 u8hQe5U93ylXjtWhARuFxpRWbPiRcrlHaq6lh7cD2PmIYoMZtZKwPKpTt95pvNDU88
	 naEjO9suY/q/oEmyww9iOibXe9rOyXdFFXQDRFX2kSRk5LgQpBIbPiDeSROt6F4jBJ
	 yLSf6JrrWgJoN7BnrHD/LisRL3zOc9tFqf3HHIeTvRuX2xU+eBTiahMxfjqYuRXkPL
	 vZjhzeMnRlLBg==
Subject: [PATCH 1/2] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 16:58:34 -0500
Message-ID: 
 <170120871426.1376.10151990384789497254.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120862772.1376.15036820033774301160.stgit@klimt.1015granger.net>
References: 
 <170120862772.1376.15036820033774301160.stgit@klimt.1015granger.net>
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

[ Upstream commit 1caf5f61dd8430ae5a0b4538afe4953ce7517cbb ]

The "statp + 1" pointer that is passed to nfsd_cache_update() is
supposed to point to the start of the egress NFS Reply header. In
fact, it does point there for AUTH_SYS and RPCSEC_GSS_KRB5 requests.

But both krb5i and krb5p add fields between the RPC header's
accept_stat field and the start of the NFS Reply header. In those
cases, "statp + 1" points at the extra fields instead of the Reply.
The result is that nfsd_cache_update() caches what looks to the
client like garbage.

A connection break can occur for a number of reasons, but the most
common reason when using krb5i/p is a GSS sequence number window
underrun. When an underrun is detected, the server is obliged to
drop the RPC and the connection to force a retransmit with a fresh
GSS sequence number. The client presents the same XID, it hits in
the server's DRC, and the server returns the garbage cache entry.

The "statp + 1" argument has been used since the oldest changeset
in the kernel history repo, so it has been in nfsd_dispatch()
literally since before history began. The problem arose only when
the server-side GSS implementation was added twenty years ago.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c7af1095f6b5..378ec82bd390 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -988,6 +988,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
 	struct nfsd_cacherep *rp;
+	__be32 *nfs_reply;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1008,6 +1009,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 		goto out_dropit;
 	}
 
+	nfs_reply = xdr_inline_decode(&rqstp->rq_res_stream, 0);
 	*statp = proc->pc_func(rqstp);
 	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
@@ -1015,7 +1017,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
-	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
+	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, nfs_reply);
 out_cached_reply:
 	return 1;
 




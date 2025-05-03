Return-Path: <linux-nfs+bounces-11426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5BDAA8292
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C445A5598
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DB6283FF6;
	Sat,  3 May 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrUCwc5f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002D283FF2;
	Sat,  3 May 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302398; cv=none; b=FdLyjGQWNdIM/WCmPN27fJX5UHW3U8lZH1uyjA6h91vx2Rr+UB7E1IDEWDKepQofBrDtsTZbffY2oS+S2UVr16hHXIffRY4FJLaTZLM82UV5lcV/s8Gy12xaEf9hFFQARDy74QtU4bD8Mgus5glMrHTGj5J5QoQ5krwfCeVKZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302398; c=relaxed/simple;
	bh=gdhaTlGl8svKPWDxZ3pZi8kE3ywkX/zSLudtSlstuOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZYnHabPf3trV8o0Qfea0U476cKk09Q7ilYHCLcnAS+9MO5W3w9u2x1paFMfOoWe0ZzAJWIlaiAWOxAGuLD3yFpV/qa1tCSFT5Ij/FG7/3+cKopUElTDneL+xu3fvSz4ccltirfUTdPCcLQBLfh3fGqqH4rvjy3wlqo6vBThIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrUCwc5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8717DC4CEEE;
	Sat,  3 May 2025 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302398;
	bh=gdhaTlGl8svKPWDxZ3pZi8kE3ywkX/zSLudtSlstuOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrUCwc5foghAT/DIcNqRa8pQz48O5r91IXHVzsNKBfWp22HdAE5NdiGaFzzUTMSIc
	 AUUzRn/PPLl2l0B2wT3Q5B1fWAle77L/6IaICK+iP+dTADbgUETH87HN2z8iII/y1u
	 etbJ1HKXMG9d0j5kjWlCmpWIBbMRAI4z2YSWRWvJmDxUA0pDHS7t1svRCqE8xkpLd5
	 9plv1LhNe7TrU2D9P0QgxHQxe4r2R4a3Sg4T5ABPMIkZm5DeCGkCSeRh5tkSyzR2JC
	 GhI3agbYwJBGl6EvexY8+r5tWQ+4OfgSH6FYAmKlgeKeojha1gLtRD2fMETMdba8j5
	 bJnff4ZMavsgw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 18/18] nfsd: remove legacy dprintks from GETATTR and STATFS codepaths
Date: Sat,  3 May 2025 15:59:36 -0400
Message-ID: <20250503195936.5083-19-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Observability here is now covered by static tracepoints.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 6 ------
 fs/nfsd/nfsproc.c  | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 6019ce3a8036..8902fae8c62d 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -72,9 +72,6 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 
 	trace_nfsd_vfs_getattr(rqstp, &argp->fh);
 
-	dprintk("nfsd: GETATTR(3)  %s\n",
-		SVCFH_fmt(&argp->fh));
-
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = fh_verify(rqstp, &resp->fh, 0,
 				 NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
@@ -651,9 +648,6 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: FSSTAT(3)   %s\n",
-				SVCFH_fmt(&argp->fh));
-
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
 	resp->status = nfsd3_map_status(resp->status);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index fe0f1c372f18..7c573d792252 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -57,8 +57,6 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 
 	trace_nfsd_vfs_getattr(rqstp, &argp->fh);
 
-	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
-
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = fh_verify(rqstp, &resp->fh, 0,
 				 NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
@@ -617,8 +615,6 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: STATFS   %s\n", SVCFH_fmt(&argp->fh));
-
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
 	fh_put(&argp->fh);
-- 
2.49.0



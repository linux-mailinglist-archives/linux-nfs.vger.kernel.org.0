Return-Path: <linux-nfs+bounces-11326-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4442AA9F9B3
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A363E464482
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DDD298998;
	Mon, 28 Apr 2025 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQmrRBWZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AD298997;
	Mon, 28 Apr 2025 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869038; cv=none; b=uciGtdRhRfacy/7C0/29ZHrwT+4rucBJ5JvZM7UinjqbCALG0Un71B1YfaWfU9vTQ2V1bzTOqEk81lajLUPJBnVo3EOKGyk1IkIDMdKFhf8Pk4K+5OFczUV7GX9O/N8B7CPkrMnwTleQns94eHcaAoxzpHQEEviS0sD6CRsYhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869038; c=relaxed/simple;
	bh=eSy3uDebkcleU13u7b4iblAOQTqemdRYhEloRjZ+XK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ynv2wgo1Cg/pGqh+UPldh34N+O1v4CRjkyDm3cbt8anwNUNFBdxi824qKVjbMgzslz3ZKkWIuj9EA0SCFDCzzZDP77mXpoLYJsrGRJzLnQOmAbTl/QcLmDRo0vn1OcScBuNGpPYK856wM8M1rYWXhZUfbVI/rIvtCZnRIQe2q+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQmrRBWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94119C4CEEE;
	Mon, 28 Apr 2025 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869038;
	bh=eSy3uDebkcleU13u7b4iblAOQTqemdRYhEloRjZ+XK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQmrRBWZUIU1n3zrZLqu2CKDu3zH1tyvQN2ul0BYVO1pK3lxMHPUgZ3cqeVx+KPLB
	 FfMcS/h8w5ATbdZZO9WdFb4kq15CmVRL8/8VfoIavrNBEQ/U+cbOvoV+SK0H29k2kr
	 MA1J6DKndImHmMKSEq/6vnoqtPsSeFeHadpUqHYAHg2pw/aseZ3cyNqvmiWxPAEhWb
	 tLh5bW7kFEe0TvnkHKoYpt1dUfY00AvDMX+YsTxd39Mh7XmyD0s3up6s2WnqDVwal6
	 eIk3kFIrrwdgVHqpMLtM4Sl1q58C+/DEFPlmeSoWpFenMwKrTfMWLG5hxnL3vF3vve
	 0aubgN3ttpN5w==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 12/14] NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
Date: Mon, 28 Apr 2025 15:37:00 -0400
Message-ID: <20250428193702.5186-13-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The 8192-byte maximum is a protocol-defined limit, and we already
have a symbolic constant defined whose name matches the name of
the limit defined in the protocol. Replace the duplicate.

No change in behavior is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h    | 2 --
 fs/nfsd/nfsproc.c | 4 ++--
 fs/nfsd/nfsxdr.c  | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 91d144655351..2c85b3efe977 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -47,8 +47,6 @@ bool nfsd_support_version(int vers);
  * Maximum blocksizes supported by daemon under various circumstances.
  */
 #define NFSSVC_MAXBLKSIZE       RPCSVC_MAXPAYLOAD
-/* NFSv2 is limited by the protocol specification, see RFC 1094 */
-#define NFSSVC_MAXBLKSIZE_V2    (8*1024)
 
 struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..5d842671fe6f 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -211,7 +211,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 		SVCFH_fmt(&argp->fh),
 		argp->count, argp->offset);
 
-	argp->count = min_t(u32, argp->count, NFSSVC_MAXBLKSIZE_V2);
+	argp->count = min_t(u32, argp->count, NFS_MAXDATA);
 	argp->count = min_t(u32, argp->count, rqstp->rq_res.buflen);
 
 	resp->pages = rqstp->rq_next_page;
@@ -739,7 +739,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argzero = sizeof(struct nfsd_readargs),
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
+		.pc_xdrressize = ST+AT+1+NFS_MAXDATA/4,
 		.pc_name = "READ",
 	},
 	[NFSPROC_WRITECACHE] = {
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5777f40c7353..fc262ceafca9 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -336,7 +336,7 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 	/* opaque data */
 	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
 		return false;
-	if (args->len > NFSSVC_MAXBLKSIZE_V2)
+	if (args->len > NFS_MAXDATA)
 		return false;
 
 	return xdr_stream_subsegment(xdr, &args->payload, args->len);
@@ -540,7 +540,7 @@ nfssvc_encode_statfsres(struct svc_rqst *rqstp, struct xdr_stream *xdr)
 		p = xdr_reserve_space(xdr, XDR_UNIT * 5);
 		if (!p)
 			return false;
-		*p++ = cpu_to_be32(NFSSVC_MAXBLKSIZE_V2);
+		*p++ = cpu_to_be32(NFS_MAXDATA);
 		*p++ = cpu_to_be32(stat->f_bsize);
 		*p++ = cpu_to_be32(stat->f_blocks);
 		*p++ = cpu_to_be32(stat->f_bfree);
-- 
2.49.0



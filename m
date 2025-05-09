Return-Path: <linux-nfs+bounces-11639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608AAAB1D0E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E2D1C0704E
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654FC245022;
	Fri,  9 May 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUn0mix/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D736242936;
	Fri,  9 May 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817452; cv=none; b=Vs/BT0dbQWfe+toJdz8PEE7Um1yUcqW9UHoW1CEAAeBWCbIn631tteUmr815IB0FoEBFL+D8XvO/elW1wWmg4T72p1pGfphVDGAW0xH9ovgxWkcWu8ErybWacmivBwVpU2AKeZ+eVDeP+BsxqmnaOcJBHDoFtJtO4ARMyb7NLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817452; c=relaxed/simple;
	bh=cibWHzN6OncASoWIFzE4gXCvPm2P51K18Nl1WFq+Kmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka+bHTP8uWTlS7j2bi+BsnpzksrtrBEaq2NF+YIZjiHyM4pavboetevtjSTRmCxACNLEQ+G/rDTJoZmZx6DmlGyCM237CNnsQrwkNsqhH7G3mnQVSb3Qa4gxUGMWQSPinQBUN2I2ejXuQpW+8B9PaaYgYp/0k1Wp9R2B624TpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUn0mix/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29EBC4CEE9;
	Fri,  9 May 2025 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817451;
	bh=cibWHzN6OncASoWIFzE4gXCvPm2P51K18Nl1WFq+Kmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUn0mix/rf4M3zXLko6xbpZHLlah1PucV69AfHUAb6QU+OIQsul0rOrFPTXEowDu+
	 1AJcmGe/bTKivRQx7J6JTc0lkfz7FzLeP0WKCm6k7BtZ4ozrydWviyR8zMSEPOhlEB
	 JiMCVZ3SawWEatLZ8+vo+Wxjvb1a+XKyk5oz4c5j8sR0Q3PmATZpSff/oft9q90CZI
	 BhriV72G/v+q80OU7GEWKcDqG0D8FRxIUpAFQ+Hi3DyLeQ6IebsvrqlgIvYgJLRwm5
	 ISkFQVHwefLWEgrv1znteaAkVPisdJze7fUcQu0FuexbnQauYH1ALW90uPivUSMryl
	 4JjFPTtyL9VPA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 17/19] NFSD: Remove NFSSVC_MAXBLKSIZE_V2 macro
Date: Fri,  9 May 2025 15:03:51 -0400
Message-ID: <20250509190354.5393-18-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
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

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h    | 2 --
 fs/nfsd/nfsproc.c | 4 ++--
 fs/nfsd/nfsxdr.c  | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b9ac81023c13..6428a431d765 100644
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
index 65cbe04184f3..11fc9a1d5d80 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -212,7 +212,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 		SVCFH_fmt(&argp->fh),
 		argp->count, argp->offset);
 
-	argp->count = min_t(u32, argp->count, NFSSVC_MAXBLKSIZE_V2);
+	argp->count = min_t(u32, argp->count, NFS_MAXDATA);
 	argp->count = min_t(u32, argp->count, rqstp->rq_res.buflen);
 
 	resp->pages = rqstp->rq_next_page;
@@ -707,7 +707,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
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



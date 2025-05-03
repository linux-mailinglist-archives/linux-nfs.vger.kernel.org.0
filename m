Return-Path: <linux-nfs+bounces-11407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE5AA8153
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C05716DD56
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B427E7F2;
	Sat,  3 May 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2FlJqhU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5227E7EF;
	Sat,  3 May 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285122; cv=none; b=QY3wBxIGQxJ2y9em/jSC4RXs6zHIP0cbrvcxmzus0wbMwxq/v3n23IrCquJbnm3cyW9pCN0Xh9v8sr0efFALWnh3PX13+4FrD/nIR3EKELbndDDSyAsS2hxstTuO3rBGcZ0od4DyO1xaGZ/qst/OmbynNhsnCOjjsOco+WR/noY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285122; c=relaxed/simple;
	bh=PHa//c4vqEnZ0+OPlLXjavzM0fk+wIBSvy6eTxGOhIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpMv31FkV8E3PNn1xBz5v7LK+h3mcK3FevDv5ziAL3ivK34DEITH1NpktaGz+uZOOC0/laSEYaaemRo2AYDff/ooK9HfYKvDHBtlVeTOGwu9nyG8a/TQ0r4t/m2NzIcqXJM6aFTWi8+LmrRh5HzUIH5fBuiyUhdELIoyzKBlNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2FlJqhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D960EC4CEE7;
	Sat,  3 May 2025 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285122;
	bh=PHa//c4vqEnZ0+OPlLXjavzM0fk+wIBSvy6eTxGOhIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l2FlJqhUmap0Jq0UgBLqJ+/k2eOsDHUsuuKJf+V2N86nNdzedMdRvCjhLf507wFvX
	 Q74AmADkhNm8fH1xS2bKm3YI/tYxbENu4knl1aoUu/fwtVCCq32hHZKtievggaxqrY
	 laGPdvkwPLPjNnkfPPDaLh6LNtpejcMNr6YH7Y7O25DgZQupQlqRKWikEsxhT9Y9us
	 shEon/kmaxByxrih3AdJclbUhQp33Qiynjz6XnhipbgtkbSbOBqnNMl1UrdkK58Q5d
	 dEiXxxR3CBa8wNyy5Xp8On7fxnzSPh2DNEhIvnkS5V8v6/eA2/Nj1IhK1ghIkHXJt1
	 Ozlobx4scvHrQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:33 -0400
Subject: [PATCH v3 17/17] nfsd: remove legacy dprintks from GETATTR and
 STATFS codepaths
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-17-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PHa//c4vqEnZ0+OPlLXjavzM0fk+wIBSvy6eTxGOhIk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIvBSerR3sfNO6/8qndS+coEw4nuI1CJHP+P
 +ZZTaNGRYKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLwAKCRAADmhBGVaC
 FXzTD/9W6/gR0XuUz7aCZNM5NoEkHTWJG6zFs0keGZX7qPz3TWnyKb224sakNNez6sIR6e4E24g
 UKUdGZlR4+K5I0LcVm9+UAw0djO2wZkowdMG3U24WRw6ESNEz82gKggI9E6i/4By2QX0f8LVgPA
 REEOYlXIB+AIwFd6Gn77D/SazpQroSgwAy+p2FP0OiQLxzUPvkgJ/OaZ8CdgB1IayZVOIWKFRsU
 +C56PvgIYXBtiuLcWEK2M+EOlAc2F3jucrGtiyiqZbHzfrSU1DnGs2bqoma6Fyc7G+c5o0+ql5C
 uz0CZJoV9Rb6vRbvEJXmC6AX0fZZJXnmv7HrYD8aznLrgxJJFePkpQ3oj07c5/WZJT3NDBR0iLD
 ytKra3hWjb0Sbxm0cRjuLfgzZJj3BqFaBrVGKhGfwgbqptkiUS0vmULl4PtVNYnW5OAk9O5xS+8
 VBW8Bujas4YitYxNwi5ssNd+JcGYPmR1HObKPENVpfm6wzXp3gi7WbSf2ficXW/KiSJ/ofFYaKq
 pog3aNhGcZwsEHFi7jKLN4oizfNG4FfD3lmnAODNK0gh/FpZXwOFl184iGvlAl+VUyk2nkhYVS4
 l9ImNNxDmwRHlUMGajcBZLmbHKk4Byq+Ct50nPdYHGmMcA51g/nE8r3fEFs6ciRF8hDEC3ZbRFT
 s7iGID4HN24wiMQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 6 ------
 fs/nfsd/nfsproc.c  | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 5b0b5a00e13062a5e9387431aaf5d6a1adfea50f..59b1987a1e16f5dad2efe627e8c81e654edc1413 100644
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
@@ -647,9 +644,6 @@ nfsd3_proc_fsstat(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: FSSTAT(3)   %s\n",
-				SVCFH_fmt(&argp->fh));
-
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats, 0);
 	fh_put(&argp->fh);
 	resp->status = nfsd3_map_status(resp->status);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 80f3c0c6c63d16c9324c92dca52c8814d9429bb1..1d1825cc3eda96b678dcb1fee62fbe84a144c9e2 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -57,8 +57,6 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 
 	trace_nfsd_vfs_getattr(rqstp, &argp->fh);
 
-	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
-
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = fh_verify(rqstp, &resp->fh, 0,
 				 NFSD_MAY_NOP | NFSD_MAY_BYPASS_GSS_ON_ROOT);
@@ -615,8 +613,6 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: STATFS   %s\n", SVCFH_fmt(&argp->fh));
-
 	resp->status = nfsd_statfs(rqstp, &argp->fh, &resp->stats,
 				   NFSD_MAY_BYPASS_GSS_ON_ROOT);
 	fh_put(&argp->fh);

-- 
2.49.0



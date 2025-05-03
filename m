Return-Path: <linux-nfs+bounces-11403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59FBAA8150
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C045A6BD8
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56B2797B0;
	Sat,  3 May 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT7yDgwg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7D27935B;
	Sat,  3 May 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285119; cv=none; b=j8dgqrh9D7vMmEVjzWrtVQ5h9beYD8w+vTs3WxFi//Dxq654TMCGqvxt4mI+bjDbFnCbLPYy34Pf2ocTd1wfZWowCsySaCOkuUwoDn4x8Oq+3fJ41suH8/sPUoOu8qUxC+Jf3+DrByw0FBpXTGJOyVQpXT1kjXnXra7KRc7SM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285119; c=relaxed/simple;
	bh=iCMEo2AvD1zR/WR7Vnx1UYY/Nzx3edRlxO9pfqCg+WY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9Bdo6PKEKk0meouNV5sMDGnn5Sj5fOvc4U2z2VQi53fS2jpjYzUd4Hsrac//MhUsXlK/qbV4vqVYXb1zeUbqvrYWtb8Lq1tXZJ37OYn5aaAgDBnItoKnr6zcqKIVNuLMZYwU94B87sLcJlDv6g+7a1UQSsHEXqSad13HMlehvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT7yDgwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA3AC4CEEB;
	Sat,  3 May 2025 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285118;
	bh=iCMEo2AvD1zR/WR7Vnx1UYY/Nzx3edRlxO9pfqCg+WY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iT7yDgwgduU2x6x4ncJHKFf4eXWKyVBzYCTLq3bksLCtqW2aYIaXc0nRFXDXiQtJX
	 90dc0V87I/DVv5x93geGcYAGMDsBjHOHE2H3MzMqCznYGhgOranflcHu6VJb79yqIB
	 sJFUqQjUpcd30E0M2rsN3UMvFzetLYNu4ruZqnUi5dYBiOoI39aWExm72yHk2VtFhI
	 gAFwhevs1CZHpAAJBB2uer9GYBAC91+7VGmClQZA38csDLsyUBwyHzefutccfO7qym
	 XZXBjN3EZgoNpO2CePhU0rLMVG4Vl59/pgbEfP7edS33TR8kATSDNAB1xm9x8QRknm
	 jpL9kt7qAbfWg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:29 -0400
Subject: [PATCH v3 13/17] nfsd: remove old LINK dprintks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-13-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iCMEo2AvD1zR/WR7Vnx1UYY/Nzx3edRlxO9pfqCg+WY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIuONVwhgFBlHppnIr/FBLGFaca/kSclHZIt
 dVm5pkUYy6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLgAKCRAADmhBGVaC
 FcqxD/4j0Zd0ybJC7FgJdK12Jy1Lj4G0WdPj1nhtWMDxFgWRx6I8mplXo1i/gObQ9Eyssht9MP2
 NLq8ZpUJ2Oz/OF9SgAenJfOH1AyHVHx60MQOX3ZFRlctdckc+bIfUo5o5qCdqSX22zpfTwYBWcc
 mTfcsMVUbws0do8+/EkSu4BGCX2wafZ0G/OVF41hay2qzgiM54XQlp5LU0N/BZTFFZvzQW4ko7D
 En9BcwzCUI78OaCju+DSDWMlmTbEdUZkxrviP7eSjAHjm4ASL39/quh+A/mWzkFDo25KRfKynWR
 u9lCIyzs8Wr0uOGgc/DqUml/a8TMP/aQI3aHHoyGDA04CCW7IJeOJOe9sIrNmikSRPnyitHHDXv
 +kNEuNX7wIFQ3lRdOpq8sNjTmAI+EhFT5IPN0rzc0FmsW0kPHJscuLOjszdlAq1iEqlRc/VuKTx
 FcTEZMVHYKMJ2sqLfO9hRxaVdtoLTmKUNiSLMXj7YmMNqex3OPGxzHfzMTJWLBL6+KLjYvY5ckF
 H52taNTQxZ86BFCXxiOJi3zy1hEyNMM4fpaq3R5GZZYCJwz8zdNo3MYZWSm1pXCDfsh7Rab3yEb
 nAr0qjLmZ/OfDPfsw7YF/9gVaGEQ1SNIC3Dpox8frUSdy/OA4pZ5hyKXGljgNgaGhvyscKfdm97
 dNvjEGeF8UY6zsQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 7 -------
 fs/nfsd/nfsproc.c  | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 237bd102e4ce13b0461d27dd6f72219ae3802082..7ed4932e82f330b4e382c0129ba8cff10f2d44e0 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -559,13 +559,6 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	struct nfsd3_linkargs *argp = rqstp->rq_argp;
 	struct nfsd3_linkres  *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: LINK(3)     %s ->\n",
-				SVCFH_fmt(&argp->ffh));
-	dprintk("nfsd:   -> %s %.*s\n",
-				SVCFH_fmt(&argp->tfh),
-				argp->tlen,
-				argp->tname);
-
 	fh_copy(&resp->fh,  &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_link(rqstp, &resp->tfh, argp->tname, argp->tlen,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 27c4022dd75c498cc46dc734d10d7da3736b5079..449732bb64f85283d7f208087dc47d39df3f5e68 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -481,13 +481,6 @@ nfsd_proc_link(struct svc_rqst *rqstp)
 	struct nfsd_linkargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: LINK     %s ->\n",
-		SVCFH_fmt(&argp->ffh));
-	dprintk("nfsd:    %s %.*s\n",
-		SVCFH_fmt(&argp->tfh),
-		argp->tlen,
-		argp->tname);
-
 	resp->status = nfsd_link(rqstp, &argp->tfh, argp->tname, argp->tlen,
 				 &argp->ffh);
 	fh_put(&argp->ffh);

-- 
2.49.0



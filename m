Return-Path: <linux-nfs+bounces-11405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A94AA814F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360BD17FE83
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007C27E1D6;
	Sat,  3 May 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCA0mZfG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3327D763;
	Sat,  3 May 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285121; cv=none; b=KfyxEMskm+tgsHx3zJLNX9nxSWg5wdtj6fxhLHHMvqGM6DjLqsVX8xhUFd8PYFaMeQuA/gw4GoTZoMpjPfaEmuu1b9hVduP0rAFkB9YC/Xo6A+moafPfmjNNs9hJ8ADzWFrQFa3XYEDsiqS+XqTyMkRWD8C4SIMBVZppl1IpJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285121; c=relaxed/simple;
	bh=I5ksN16z2qMg7kLeB7FdmujQ+I2owXUThNiVGSp0OqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnG1op78o8IroJioZYr93LMWmwm5QbRruiIdBUje0QltLWEmbp2zyB6ayYI8xKPHXs3sNcwOoB/XbffjIvWwcu8yLcrxdSBnfHuShymX7PytK1fznI/MIsRtNDB6oWXvUfD8qw8ANuG8UQiDkyOWGmgJfukdCKCVHoDgN8Hsq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCA0mZfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA283C4CEE7;
	Sat,  3 May 2025 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285120;
	bh=I5ksN16z2qMg7kLeB7FdmujQ+I2owXUThNiVGSp0OqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mCA0mZfGUOjv3Vlr+ctxXOo42xZ/YQGihaJY+iidCpbWWAP4SySm5dtCEgY5RA7RA
	 o++IuzNO0wt0XelVsxeiKrZnbMomnuo9yNNqF5HXzT646Lhn1q4J1e8e5QihKLUDch
	 pZYPYGo72/Wnt32M9YyRxhDTVckwEQabr6qNpu8wFP+E5FGrjrqy5gXqgFxEPAL2aE
	 Q8oyG2y1xs2mWRhRATMlb8y8735lDTVmZEif/Ie6rKAK57ymdjGcQmDIuQ+kkPF1l/
	 bKraofh+9BLTSnr08MBx6moWIZ2/+VvFln6GVfVvnfgRlQV7PSmuvW/suUEYMpPdsJ
	 K/ezBUiKCtNig==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:31 -0400
Subject: [PATCH v3 15/17] nfsd: remove dprintks for v2/3 RENAME events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-15-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=I5ksN16z2qMg7kLeB7FdmujQ+I2owXUThNiVGSp0OqU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIvcsygpD0fBNaSx3WTU3Hijv8bvcNsWVeIh
 wbCp77yl+KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLwAKCRAADmhBGVaC
 FVJxEACAdW3sk4+V/2/R+1+2AUNQlykOn47eli1o1z4Nfe7kTHfDDZy0mcYZ/VeNzynG7a/+yC0
 DdUy74DykkigeJwF0Rxef03b9IXcEaPcTD+omsXsLPCOJ3xXF3gyr2ShaP6nAuHMblbAEvUfycj
 2QStCNlMTZx03pY1ArDZgkeOL0SfDuEpM7a4N+uK8oPF3qKWYV0gtOwtHNamT3Z+MbCWqrErWg7
 BQBiq5p3PJK+6+tqUpNZT/m/OKZ0pHrsOCzrftkM+FPdd7c/nQ9pmyh9tu6Xfpzf5O5HlcFjvY8
 NM52lWVgK8mpY7tt1ed/BF+mUvUOL3hgyJzFc6ek5DXN19ai3Ay/5WBpLtDTk2TnXzf2wn+vpR4
 wlOCwHRKnXr9faM/gWH9nLevd0KkXoKDHBs0KUwYQgAqTxqBCkinwv2J27UsZR7HF3qFa9m4Gmy
 +AJUHJ2xN8vKOOq1AQuJcPyQmF7Fkc7b2Y2MJO9KarhlTfti5F5bvIpWraM0WueyTYbrgo9a+Y5
 XzO4zfT/qJAwF5BMEP7hDlwQ73bf6JOIKyFqp/KFwMLc1PXDL/bvQO54sfAWqb49huBiv/qnprg
 XFX4dskFFuTcRb4dti4J+KZcY1VtTpovDUVc4Mt36guchMRGOEy+i11zqdzFelDFQi/53w1tJ10
 NZlsDheRqi1issQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 9 ---------
 fs/nfsd/nfsproc.c  | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index fca65adc43d3b70323938ff8a595ce7eb0a7ca57..03cbd125b570ce10fb12f9192e0fcd6622112c5f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -526,15 +526,6 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 	struct nfsd3_renameargs *argp = rqstp->rq_argp;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RENAME(3)   %s %.*s ->\n",
-				SVCFH_fmt(&argp->ffh),
-				argp->flen,
-				argp->fname);
-	dprintk("nfsd: -> %s %.*s\n",
-				SVCFH_fmt(&argp->tfh),
-				argp->tlen,
-				argp->tname);
-
 	fh_copy(&resp->ffh, &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
 	resp->status = nfsd_rename(rqstp, &resp->ffh, argp->fname, argp->flen,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 41011a7f19397a300c5c6b468871a18b9f3fc210..dc6e6bdf7aadf2213322f80844e144b833bb1355 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -459,11 +459,6 @@ nfsd_proc_rename(struct svc_rqst *rqstp)
 	struct nfsd_renameargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RENAME   %s %.*s -> \n",
-		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname);
-	dprintk("nfsd:        ->  %s %.*s\n",
-		SVCFH_fmt(&argp->tfh), argp->tlen, argp->tname);
-
 	resp->status = nfsd_rename(rqstp, &argp->ffh, argp->fname, argp->flen,
 				   &argp->tfh, argp->tname, argp->tlen);
 	fh_put(&argp->ffh);

-- 
2.49.0



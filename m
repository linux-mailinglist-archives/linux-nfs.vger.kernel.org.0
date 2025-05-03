Return-Path: <linux-nfs+bounces-11406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC44AA8151
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A06463406
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DA27E7E0;
	Sat,  3 May 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6x73rTR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40F27E7D7;
	Sat,  3 May 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285122; cv=none; b=iGgZ5Fcn2QPdUL4mfHU6Q29LFTzZxinSv1QqDccLgbIqHLkDIKEM12xkBzsds3QuCPfVxYtupVbKFzkMNz+HQWYutuA0Hq4az2N7Qn2GqRhaTdoQXcqmvr8iS07f3DOhLSgTBuSkBoZOZ4OCsZWTbHZYwhJ8GRHHT2GFX0tWJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285122; c=relaxed/simple;
	bh=he+9fVXNuOtw3MdmbZXzuvwAYwDCGWIEewWZiLXQ0gA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gy216jeLd0DPviYBVQnNxTfw3pkDY8Ch4EE2mO2yxPfN/Z3ujvNdrz+ORVWQqjGKkfn85cwyXrf+vd9X2cZoqp5InWmY+O8ao25Vi5rhaPMr9dLbTGFCg8+W9QSRC0K+6MZywdxA4F+YzfiKPMQMb9p77yGv4YzBve00EOsHBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6x73rTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E2C4CEE3;
	Sat,  3 May 2025 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285121;
	bh=he+9fVXNuOtw3MdmbZXzuvwAYwDCGWIEewWZiLXQ0gA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n6x73rTRL0zR/UqTsGFEQyBdckxdhnnfAMEH47MQXpIXcAtEVP4NaBhGAwdaf/eaz
	 ROoqcQ1kNtTVSOr9a6tXq8cSuW72PboM6WAYWAQf3MI0UNF75b0dTyKzBoK/a4YDII
	 dc4ctQ4HuJAdVUWeR3bdv6vvIn+9VsX19FHM9bte+U5wAGrGylDGMEbuyeN+FP3TGu
	 FstoMH4OgF5f1cq5HA8GiXxCzgXElsRO9f6KgikovVJQbtT8MMUhmU1Bb4488aNwco
	 o48H+5ifouUkTc367pXJbR2s14j51asy8pgB10rqUAjHmy6zdf8I3s1sIi/xgkdy3g
	 T/tJbJ3pmQx7w==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:32 -0400
Subject: [PATCH v3 16/17] nfsd: remove legacy READDIR dprintks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-16-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=he+9fVXNuOtw3MdmbZXzuvwAYwDCGWIEewWZiLXQ0gA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIvGURZhy/Sp+tZWUqnA56AEM2hCWOkdZVAZ
 dWsMGCoP3CJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLwAKCRAADmhBGVaC
 FV+DEACFxqDbWiBoSgSmgDvVQekSR0gG2yJ9s1MKCQ+JXZMmsZIQruw0Lni8EkcvYhiuTHrj2QO
 F6DxVYmIl/3ZsPqi4Hdg0mHwpJWiFnVz/dWvl4KggQJsgLZkNuR0FX+KSr2qqYLHv1hH4pU6uJD
 JzWWdBTKutp8u038elqnhHnqcO0h+IkmZ+E6cB4lCQtslYFgxk4a8IxxXHkN6xWJZDgKhyI4GsV
 zt8HjkYynoRDPQfPl1eHS2mH/SKNz7rW9sXeldbsu+60qbhYmSo1IYN6Lu7059OBzXHzcLCmgnp
 AvxfaMmVX9EhBaoOZFs5NSf/5mkE7AenxbRj8ajTd4eCJ0poJAEd7rGOE+JmAq4Vp6d4+w7C3v1
 pr8976Hz0KA4594YJlo46Tr7RwyKdzFbgHXzJImMD3sv0V3RECQVDeN+fUZbLVEa1kx40dujlhs
 Wj0zSPBxpC+dzS9brXHhriSkaPsC9AGCM5OsDAjdBs+tWSVfRpEItxTTdmDazUEeV2DfeV7j3wk
 X4xe+4BpXivDR9Tf0nnnozDXD33GxSk16iQSnUj2+6YpAjXE+vHhgZ+uQ5IsjWBDKc6NmOFkRIa
 gu1M6bJoQo+QsCwwVpPosNM1SJRb1zvm6lYdty+akhGyMWqA2HxVIGCelFO+YgEWzSk/Qjyh48c
 4O//oV6G9HroYUw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 8 --------
 fs/nfsd/nfsproc.c  | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 03cbd125b570ce10fb12f9192e0fcd6622112c5f..5b0b5a00e13062a5e9387431aaf5d6a1adfea50f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -578,10 +578,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	loff_t		offset;
 
-	dprintk("nfsd: READDIR(3)  %s %d bytes at %d\n",
-				SVCFH_fmt(&argp->fh),
-				argp->count, (u32) argp->cookie);
-
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
 	fh_copy(&resp->fh, &argp->fh);
@@ -612,10 +608,6 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	loff_t	offset;
 
-	dprintk("nfsd: READDIR+(3) %s %d bytes at %d\n",
-				SVCFH_fmt(&argp->fh),
-				argp->count, (u32) argp->cookie);
-
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
 	fh_copy(&resp->fh, &argp->fh);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index dc6e6bdf7aadf2213322f80844e144b833bb1355..80f3c0c6c63d16c9324c92dca52c8814d9429bb1 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -592,10 +592,6 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	loff_t		offset;
 
-	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
-		SVCFH_fmt(&argp->fh),		
-		argp->count, argp->cookie);
-
 	nfsd_init_dirlist_pages(rqstp, resp, argp->count);
 
 	resp->common.err = nfs_ok;

-- 
2.49.0



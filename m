Return-Path: <linux-nfs+bounces-11425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016DAA828E
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84EBA1B61B18
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F244283FDB;
	Sat,  3 May 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPKurCJ4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC0283FD3;
	Sat,  3 May 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302398; cv=none; b=FBGwHVO6fCWa8rpuJArVvVM4AdllGUsrol5pO/KBm/0aDM4T+H3ncD5NhoygUKHVIQ1LdBpRWx7Irvg8r/jOK6Yu/C6kD1csNSwg1TNEr4UcZIhVQsw6tWxasprr/LJ81ENfSSfOA76H3IKiBnKrqEsaQzp2irEkI/IbU1UIj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302398; c=relaxed/simple;
	bh=rUy0ZARda46oepREydl694WcGHVvCWSzq1QMRW1Hqzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6PbbIYbQh+Y1JbcL45vLzxXhxzhyhuPrg3+X7ILV1TPc0zkwAhe3wxmltIZl5hMmDwm+IwK5sn3O3fjklatB/z6GZ8xuftKgtz6z4XXPGWe1DzuS5SAvoNfdmc1HjCJqlWe/4xxUsT3hq4qFN+YONjhpjM3UdFjHOHJizn4WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPKurCJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AEDC4CEE3;
	Sat,  3 May 2025 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302397;
	bh=rUy0ZARda46oepREydl694WcGHVvCWSzq1QMRW1Hqzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPKurCJ4iUIiZwUzoK4ssw3+lYJfclNs15qIA/tPKnVHRShzPnuRhOBil3jWCrYnt
	 nsKUpETJ8sHJ1JkcVSmGfs6+9D3TlKuNCCFYed2V2GClzv3vlZRA4Kizo8Da4K6pvw
	 MAXST8XTDTL2xyMo4GFRYYNE5A41uiIzg6+J5BpcScAvZkU6Qh2WGcD9NugiNpoe1C
	 O6Cz/l8Gl7Bo6zqToBsJ0l+hFVmQrWsCAGxCEA3vT3LlUpdkAhtQm6K8Wgx34WNXFt
	 Ure8bYkF+9X0FsZ27IDY5V2Qg2ttHINUwv8i0ddUsLNX1rHfKMUKYlpt3bYbfrzqSk
	 t4tdkr4iVgIHQ==
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
Subject: [PATCH v4 17/18] nfsd: remove legacy READDIR dprintks
Date: Sat,  3 May 2025 15:59:35 -0400
Message-ID: <20250503195936.5083-18-cel@kernel.org>
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
 fs/nfsd/nfsproc.c  | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index e394b0fb6260..6019ce3a8036 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -578,9 +578,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	loff_t		offset;
 
-	dprintk("nfsd: READDIR(3)  %s %d bytes at %d\n",
-				SVCFH_fmt(&argp->fh),
-				argp->count, (u32) argp->cookie);
 	trace_nfsd_vfs_readdir(rqstp, &argp->fh, argp->count, argp->cookie);
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
@@ -613,9 +610,6 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	loff_t	offset;
 
-	dprintk("nfsd: READDIR+(3) %s %d bytes at %d\n",
-				SVCFH_fmt(&argp->fh),
-				argp->count, (u32) argp->cookie);
 	trace_nfsd_vfs_readdir(rqstp, &argp->fh, argp->count, argp->cookie);
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 799ee95cdcd1..fe0f1c372f18 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -592,9 +592,6 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	loff_t		offset;
 
-	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
-		SVCFH_fmt(&argp->fh),		
-		argp->count, argp->cookie);
 	trace_nfsd_vfs_readdir(rqstp, &argp->fh, argp->count, argp->cookie);
 
 	nfsd_init_dirlist_pages(rqstp, resp, argp->count);
-- 
2.49.0



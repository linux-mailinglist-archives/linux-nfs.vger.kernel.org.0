Return-Path: <linux-nfs+bounces-141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0EF7FC8E9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4426B20F7E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6D42A8B;
	Tue, 28 Nov 2023 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXndDUep"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9344390;
	Tue, 28 Nov 2023 21:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F33EC433C8;
	Tue, 28 Nov 2023 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208786;
	bh=FUPDdsl/ocHoaRCJdSGZN8HogF0djTFLTb7ddFeu4Zo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cXndDUepsczTUk6qdtZWNV0zokkdIiSvWrn3P7oJ5KBGFTg7UdfF8Xx+QCH674hi6
	 INi19+gG/haAMRMbX3TInurNl2UELTGAdm0b9JmtQFhSEO1xi3t1kzTmCngIUxrEeR
	 zkzn2+Rync43TUnDm1dLjyooH4hvo+vUqW42fjznrG32aAJPlxO7f0PMbEx+IBqlmi
	 Rgvt414zXBMvx+WssrFt1jUMFDWU95rD6oYXETWCBw+KucW1JF03AhhQcpt2jbUD35
	 mxD2ehp1eeWkXLlx9zHfdTyXOfAS3ztvChF/dTFhAOzJc50O594yYNBbwdYSxU7gwN
	 P1TtBgHmSDReg==
Subject: [PATCH 2/8] NFSD: Rename nfsd_reply_cache_alloc()
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 16:59:45 -0500
Message-ID: 
 <170120878533.1515.6439967545647884997.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
References: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
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

[ Upstream commit ff0d169329768c1102b7b07eebe5a9839aa1c143 ]

For readability, rename to match the other helpers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index e197756b5454..40b8bbfc0950 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -85,8 +85,8 @@ nfsd_hashsize(unsigned int limit)
 }
 
 static struct svc_cacherep *
-nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __wsum csum,
-			struct nfsd_net *nn)
+nfsd_cacherep_alloc(struct svc_rqst *rqstp, __wsum csum,
+		    struct nfsd_net *nn)
 {
 	struct svc_cacherep	*rp;
 
@@ -458,7 +458,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * preallocate an entry.
 	 */
 	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
+	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
 




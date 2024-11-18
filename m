Return-Path: <linux-nfs+bounces-8056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BAA9D1A4E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB2FB207C1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B31C07DE;
	Mon, 18 Nov 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTRFlxyc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9DF154BF0;
	Mon, 18 Nov 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964747; cv=none; b=HzWFoPmXJmOLnxdV5lpwjQGgBty6TFZM/Gpg9Yv59V27TVvFNffONMzoTo/vL7TSY7pp2Ss+kX9+2wx/yL6qXbpU3pYgVDZ5/E8yxsJ310NQnfWV19D6J7lDyVvZff6+K1bweHPjJDP/X2eBSwNTi9AR5gCw9rjlX7Qe+dB5xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964747; c=relaxed/simple;
	bh=jfdx65p7Fv7dUHacMnQ8f9wuz98vapBGuGj22cg29NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hssGZWWGp8z3aOyfS9edBu3E2oK4BWwTVmbYZWsUw6NVNZMZqMpsQrWdFU1Zmjyf19joolMDmdgJfIwWMgVB7utV0Ux5MZNicjehTsGm2n2BBcSrra37Tva+zg8AMOblP6qp29dci5+811pv0Ioj+TFRx+d6OHHhRgivGUFEsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTRFlxyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AACC4CED9;
	Mon, 18 Nov 2024 21:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964746;
	bh=jfdx65p7Fv7dUHacMnQ8f9wuz98vapBGuGj22cg29NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTRFlxycNLBhqMhX+0pxDrKXLK0GD/XIlQ/AKyRJ+tjHDZc4ViviJSMVintUcxn87
	 ARl2ejVEWzL0SaQ+3bkcfWzcOMkZLKz3nFOKr7r5XbNwwokR/i8jSjjYrH5fsDQ9ke
	 EAY2e1x3ZdYaM4zJEg1pQsuZ6rqvfcl6hrgGXa5CjKmna/oI8qcsCppWqsFCJaHRuB
	 7eBAHjLpkyJrh/wuwwWJGWrjExin4OSu+JPFrIRG/CiS6jt8lRT9UAea+m9c3Ez6ZT
	 TeyBZ0/1cTg39ftcjauuBeRmPDiOl2LpGBsOneRHMgBwkLyVAsnY5m9hZbhQXvCbZs
	 Y6m5dtQENhG4Q==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [PATCH 6.1 1/5] NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point
Date: Mon, 18 Nov 2024 16:18:56 -0500
Message-ID: <20241118211900.3808-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118211900.3808-1-cel@kernel.org>
References: <20241118211900.3808-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit 15d1975b7279693d6f09398e0e2e31aca2310275 ]

Prepare for adding server copy trace points.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Tested-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Stable-dep-of: 9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index df9dbd93663e..50f17cee8bcf 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1768,6 +1768,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
@@ -1782,7 +1783,6 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			return status;
 	}
 
-	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-- 
2.47.0



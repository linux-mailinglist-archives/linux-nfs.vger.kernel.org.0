Return-Path: <linux-nfs+bounces-8069-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EE9D1A67
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EBF281282
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D321E882A;
	Mon, 18 Nov 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRoF3VaF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1A1E8824;
	Mon, 18 Nov 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964844; cv=none; b=SUkfo3h2CFY9jDEiS9lpXSEtqPuZGxR1ix0/+dWxpF9ThJJOZlYCHeuHHhlRa3P+viZU9VrTD2xfO7v5KgRUYzW8it44FjOF1gHBhRIDzSIdSxZN41/D3S+YYE3fMhF1sp05R4fSo7jc3HFHUPG3DKNtDjVS0JDeY8Qe12USQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964844; c=relaxed/simple;
	bh=nzbXYIlTHK/Zc//uO2pb/6uBnF1pj2Ff5bWI23JhP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6Vf+2SifUoBjyjBptk8bplQUqWQ2uTjIgJZGYWWob5F6bijuzcZVmUcSeQ/67I+lEtWGQVK2gZ+ZOi9TH4prdfGr/pde3N8MYRbT7WGws9YAnB9QkxKX9+dPVwdi1E7BSAA2j1jTUbxCDaJBnPPLSJN5T3J543PcTsMWLIQxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRoF3VaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BEDC4CECC;
	Mon, 18 Nov 2024 21:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964844;
	bh=nzbXYIlTHK/Zc//uO2pb/6uBnF1pj2Ff5bWI23JhP3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRoF3VaFY1wtbTHrJq9jhwjDAk/PKOL0XS2VPNbGbH5ZCsdgPQCrhZ6LJc37k5304
	 MjeHULhyUHYW1g4MoRrToh177YZUa5H4s1luWONySYD/femyRC0rQNx8DqPSiZovG4
	 XbtWSPvafXyELXE0J53BqWL8DmVfH4pOiClhDPT3ON3kQXA41bAVUlFSNgrqfBxcBy
	 nBOJO5le18lb9BLQE3gU2PTFT6SZBGdC1EjcxF2MlUEdT3Y6VXm+d4Ryx62ZBJ0QoX
	 DyflgRhOlYWK2QFGyyPrSztaDQwR88UMUug3Lknm2aNHs2cEBJFVGTDeiGTqFj2YTw
	 elWLuVkHcWerA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15.y 04/18] NFSD: Rename nfsd_reply_cache_alloc()
Date: Mon, 18 Nov 2024 16:20:20 -0500
Message-ID: <20241118212035.3848-9-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ff0d169329768c1102b7b07eebe5a9839aa1c143 ]

For readability, rename to match the other helpers.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index d078366fd0f8..938b37dc1679 100644
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
 
@@ -457,7 +457,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * preallocate an entry.
 	 */
 	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
+	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
 
-- 
2.45.2



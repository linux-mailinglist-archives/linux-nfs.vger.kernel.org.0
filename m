Return-Path: <linux-nfs+bounces-8160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1989D4263
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 20:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2710B253E0
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 19:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399201B85C1;
	Wed, 20 Nov 2024 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwMxZBGL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE91B3B2E;
	Wed, 20 Nov 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130000; cv=none; b=NZQ48H3FSyYZVK9NbR97PWWkySzmi09fEgAebezPy+kH5d7A0TotTiMedqu7tVFoHpiAAwhofBufGnGg8Q8c4mPBzaneis5ZvNExII/OSebkEa+3IwykB3QFW0ZLaa1i+H+DWK/9BDT8/bII+UmjBo7OiLVBPGNd+MVUWZqoGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130000; c=relaxed/simple;
	bh=xAaH516sluP+p27RS0Mw2WOm62v1bm2TiJ9WqLzPOh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTHNt+1DQwa1bOrSyFN4q2erRKECuac8AVrOOW7/DsojhLYHz2/IZFQYMdglcyfJmexCvOgYPJL89osTp4o8PjHhkX/mYPSyXA8BsV+eiAo1lk5pJZcsgq4xvSrm/KGRqgeKZMxaQ7UmM4BjNi/WCUAYtSDvP1DnTsz2FBmdmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwMxZBGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA1EC4CED3;
	Wed, 20 Nov 2024 19:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732129999;
	bh=xAaH516sluP+p27RS0Mw2WOm62v1bm2TiJ9WqLzPOh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwMxZBGL11ORSibGN4eeeWTUQWNIdgDTQaL/lw6VhdZ9d2wRkWWs2Snn8MqNO36Xs
	 SbtCVKvomIDcYYHfba1p9M93Z/gVG8t4cAPO2f1x2Rnne41TbRuf2X3YDygL1K9DUU
	 ISEOVH5z9J1IZXqwGKu69eKACGcd68CnkKS9xgAeb5+Pz2bTLUX/UZN1j4jX4Z9yj0
	 KRJbqK48usj4YOXw1JZezam7YxImOHaifAlK/Bt7xA3B82GlVJ6XW6b1WBTwtUrMov
	 BwH0MtIVGObQcgWw/Unwy+gW4GYxSvjWbIfMwLEPhhJ7kfAo0/UPZK3tgEUd7woPU2
	 UIerZMVMnEf+A==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.4] NFSD: Force all NFSv4.2 COPY requests to be synchronous
Date: Wed, 20 Nov 2024 14:13:15 -0500
Message-ID: <20241120191315.6907-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120191315.6907-1-cel@kernel.org>
References: <20241120191315.6907-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 8d915bbf39266bb66082c1e4980e123883f19830 ]

We've discovered that delivering a CB_OFFLOAD operation can be
unreliable in some pretty unremarkable situations. Examples
include:

 - The server dropped the connection because it lost a forechannel
   NFSv4 request and wishes to force the client to retransmit
 - The GSS sequence number window under-flowed
 - A network partition occurred

When that happens, all pending callback operations, including
CB_OFFLOAD, are lost. NFSD does not retransmit them.

Moreover, the Linux NFS client does not yet support sending an
OFFLOAD_STATUS operation to probe whether an asynchronous COPY
operation has finished. Thus, on Linux NFS clients, when a
CB_OFFLOAD is lost, asynchronous COPY can hang until manually
interrupted.

I've tried a couple of remedies, but so far the side-effects are
worse than the disease and they have had to be reverted. So
temporarily force COPY operations to be synchronous so that the use
of CB_OFFLOAD is avoided entirely. This is a fix that can easily be
backported to LTS kernels. I am working on client patches that
introduce an implementation of OFFLOAD_STATUS.

Note that NFSD arbitrarily limits the size of a copy_file_range
to 4MB to avoid indefinitely blocking an nfsd thread. A short
COPY result is returned in that case, and the client can present
a fresh COPY request for the remainder.

Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49974
[ cel: adjusted to apply to origin/linux-5.4.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e38f873f98a7..27e9754ad3b9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1262,6 +1262,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	/*
+	 * Currently, async COPY is not reliable. Force all COPY
+	 * requests to be synchronous to avoid client application
+	 * hangs waiting for COPY completion.
+	 */
+	copy->cp_synchronous = 1;
+
 	status = nfsd4_verify_copy(rqstp, cstate, &copy->cp_src_stateid,
 				   &copy->nf_src, &copy->cp_dst_stateid,
 				   &copy->nf_dst);
-- 
2.47.0



Return-Path: <linux-nfs+bounces-6932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E3995093
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C141C22483
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833161DF966;
	Tue,  8 Oct 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTSKjgBn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58013959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395261; cv=none; b=Koq5nHK1yTyrQI843+qoxRFkkB92T0sGpAdKb8xoDofS34NT7/MiYGI7aw+opL16wIDPJdWNIwebYEwFFJjN6QP62IH20ZlIkz93o39yJx0nr0jsCWLR17GGa8BwmBLYTn9qkiOpWz5vsrkLLWUp88OfO/tJ+1KipLFGBFk/JHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395261; c=relaxed/simple;
	bh=qG088IO4r4BEzBy7NMBh4tMUVi3+24fxaKWYm++4hng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrYWxTy+gMVY796sk/eSIgmSCNmEXDxlFEkMoJ9IDszKdIKV1IVpfv7NhnmrjUyqjk/ZdTlyTRaroi7he8IwGmuaZdPB7hDyEG2Gqdp2rCw4/4FyveZB5dUIdOeOOMPKCXUDYJhGvTZOGGbyOT/kjp63NvUuJOCqUlmDUD+L1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTSKjgBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6995BC4CED3;
	Tue,  8 Oct 2024 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395261;
	bh=qG088IO4r4BEzBy7NMBh4tMUVi3+24fxaKWYm++4hng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTSKjgBndCvpNggci1aJ/HFaFHeUlo9YvCIcxQSaIvfMzU9d+FWua69d6shr7IjG6
	 m8yz4Ge4VSmALS7vbs9u2XeKDJg83pd7tSr+s3tivAZaD/Xq0hnJHRkwVXO4hMO5kw
	 FxtVSR8qGqhGX4caqubDIiubpvZwAT50V28M+nj/Z/o3pGH5oN2WubOkrX18masrVL
	 jjUGP+Y1N9KG6JqTHjA0XxBlFGAaibX+gT9W+H+tWp/GyVly24E+2rIWqZBGh8sUyT
	 XFTb5FibXcXxaQOW4vQSms+/JIkxvQXDlD7PlbKJLeshBpZRgF2fs92vDUmkD9B3Di
	 pBTzLc4uGlUGQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/9] NFS: Fix typo in OFFLOAD_CANCEL comment
Date: Tue,  8 Oct 2024 09:47:23 -0400
Message-ID: <20241008134719.116825-15-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=546; i=chuck.lever@oracle.com; h=from:subject; bh=eJ3obtcWZiv2MzPuYhGsLc1j6s9O3yd2d/rO9u5uxcI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfyc59zOK9MZ1+rN5U9n39Z0V1TE00T1lwwp 0SQt3N0KgKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38gAKCRAzarMzb2Z/ l9xCD/9v9c6OOQpuraxaSU9jVecnFg3McQwEkxU3Te9YfNS2stX8ABbNHbdTTkOP4xUj5sdDlCM QhQpeCup8E8aGQ3YKmXvQImFJI6pnhVIudS1AvnhREzkKRU3XzfPRV6qc5u6rtT54IKcC/nIQuZ FjK0HAqsT0G84MxkwlYW/w3bXxLhu3zYnGh8rPNvsy4znNJTr9kh4eAbVqdosmYNnxD5INj3jDO gZwcp/wKAIybwevt0pCvKbuiynuV1Ls2PSx/Rwnve4BlKRtvF5S6IOmhxq+K2+7XfIkMYg+4vla 52GXId+OFZ2e36lWjeZoQ0y9iKX2Fj81ywDtYUxJlcNb1PlMac82GYIQR7oom3TwWUksXovGdw0 NQn29EJknodFCKx7OU4USdpJOcTc+6XisXMMwtIZZekL852Ie3ovouNNz9Yxqu2x99dUKhnFNuQ 61M3Oaf2RXsj4jS+89iZbhxRgXayE9ehs+Zy6VVRZkqukD9gXvM/cpOwSP4rdFINPrbj58IvlK3 ORPqRYuFwkuQumM+xtqEBf/0xiPzRSRvmBDwQWtpdqEvbP8D+waBruWlf5XUCCm0pfTIs8G9N9K BzTHBem2BafK04xESZPBbJiBkc3S1iDqpWtm9zUYpwqNtQlvGPZXsmy6mWU6okkjtTmEh8ODgN4 0Tf8cnpcjpd9Ewg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..ef5730c5e704 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -549,7 +549,7 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 }
 
 /*
- * Encode OFFLOAD_CANEL request
+ * Encode OFFLOAD_CANCEL request
  */
 static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
-- 
2.46.2



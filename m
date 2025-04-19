Return-Path: <linux-nfs+bounces-11185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A6A944D8
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D4F3BE1A3
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD11A5B93;
	Sat, 19 Apr 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHRwLKou"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B034153836
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083708; cv=none; b=t6Pb3JhM2LmH7whToD053NFfE9CkZMUkOVCuzMJxta4Re6KHkKchPvjFNzvF4nnTBq2dxw7VCAcs/8nqLWtQppfgaZQhKgitu1OPk/161IgYfcRS1UA9XPKuVTzIf6gSTwJbCpdxgjsS6y5GYa43FhdxtXC3bO8DUUW4CAsMWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083708; c=relaxed/simple;
	bh=Im6eRUWsFiq+O+1GCywnQNpC6ou8grAXRWe1qUlIYuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVtmw4FvRR/UTwfYVW2cD8ujMxc2RB8M4A3RnO7MzM+gyuI1ReKMn7bdpL9JuNnb8tN7pDWlxwMWB9cQEz9ZiJeYK2Oq39CLBDF3lZBADmAd2t0Z9sRSIuHs0zO1GBT/jnLQ0MchGSYBgC0AbvP7hpClgJ0WHGkDnzfZiXHOwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHRwLKou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C376C4CEE7;
	Sat, 19 Apr 2025 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083707;
	bh=Im6eRUWsFiq+O+1GCywnQNpC6ou8grAXRWe1qUlIYuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHRwLKou87y3iA/25zZQXt+iHhGbby1hp/Rqs1vLHv38lIBL1YQeUwfXwUfx1XI7W
	 L4w2zU+LphAsAjbs6gFNtLKX56nV/S3cTQuISTT0ezf2UmL39me9m4c12+0ianGQ9Z
	 juFKTKsHoaiHH1bBcvJbJMQW/I8W3aYh70JvmzGtMsSPFEsKWMSZFXUAKpDYjpUzQf
	 X2sFqVYvXwjgVDTNAw14rWu7j8E5mcQyEKGCElJ636W+CvtH3I6AY557ylCbHR63VC
	 kwcS+KZGCwXE7DR2E6GzgfhCgv5abve/EN9/IK+xDMG+jNSSPVa6GLZFYLyYpryGAr
	 zqOWTdqdbf+5g==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 07/10] svcrdma: Adjust the number of RDMA contexts per transport
Date: Sat, 19 Apr 2025 13:28:15 -0400
Message-ID: <20250419172818.6945-8-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The RDMA accept code requests enough RDMA contexts to read
and write one page per maximum size RPC message, plus one
context that is getting recycled for the next RPC.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index aca8bdf65d72..22687533c3e9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -467,7 +467,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	 * progress even if the client is using one rkey per page
 	 * in each Read chunk.
 	 */
-	ctxts = 3 * RPCSVC_MAXPAGES;
+	ctxts = 3 * svc_serv_maxpages(xprt->xpt_server);
 	newxprt->sc_sq_depth = rq_depth + ctxts;
 	if (newxprt->sc_sq_depth > dev->attrs.max_qp_wr)
 		newxprt->sc_sq_depth = dev->attrs.max_qp_wr;
-- 
2.49.0



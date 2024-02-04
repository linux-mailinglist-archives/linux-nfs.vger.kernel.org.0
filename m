Return-Path: <linux-nfs+bounces-1753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004E084917A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878B3B2164A
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4713D72;
	Sun,  4 Feb 2024 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC8XHjpX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE4BE58;
	Sun,  4 Feb 2024 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088606; cv=none; b=S9K+WCKfoFXsLjTgvB0sstxp1IX3LoaujRIgqECuxZ1SumQgjPWR98OJJPG12R94X4nC5f23/w4t8PaPmrAyFK5VO+p8Lv9Sr8WJ38mVOzGlFrKmhrlaRtkxn+DkdCd8OMkf97bkUUZuxkwbrw3LZ3NYv+DS3oQdVbSppO+mqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088606; c=relaxed/simple;
	bh=+gbBmId/6GSOy+HqZ3CYqeEHHRAAh5ME6lwcXFo6LdY=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKVgCdEed/j/yhiZJtLwha9aJFvFNfvirg8EW1XslysDMDQ6SegIAiNw3VXH+neSqxaZLGY0b8U/dLj4DEvGWkkbQpKiOBj28gEYNkZelk+oMZW4eftnbQRjAoh1u8/ImxsadIOJSR8P7vp+q+H7xGBigJHTZwYSkPv4DfLMMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC8XHjpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F776C433C7;
	Sun,  4 Feb 2024 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088605;
	bh=+gbBmId/6GSOy+HqZ3CYqeEHHRAAh5ME6lwcXFo6LdY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=GC8XHjpXosjQrLJIjGltbvC7QElyh8Xi0Agf2miE+g8MsZ0yLSf/5dPX3pD+ShyWA
	 daeJb46g7odeVuwIHnecFrSSYNiKKL7M+bSlxAE2NhEUx1xsCbYxJL54t0Vd0WoRqw
	 ruJWE4dgflNquTeHrpTBoTOUIlg3wJEXyhHsBlKuXWY4BVHu6Jqri/hy3gvk/eT++7
	 UahILIkeQIwZMnoBINLx2uzclwkI2Rctm1J7In+nwsGRa9958MG8Xpy7iUM6hdji+X
	 wXIxcIWOrIYNGC576A30N9Jxaxe0MRbrpQDR+LMW9TUM4XfmCUgGUtxzoEIdJURenv
	 mhxC+KKkkdXZw==
Subject: [PATCH v2 02/12] svcrdma: Report CQ depths in debugging output
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:16:44 -0500
Message-ID: 
 <170708860419.28128.11517073619616677423.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
References: 
 <170708844422.28128.2979813721958631192.stgit@bazille.1015granger.net>
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

Check that svc_rdma_accept() is allocating an appropriate number of
CQEs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 4a038c7e86f9..8be0493797cf 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -460,7 +460,8 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		qp_attr.cap.max_send_wr, qp_attr.cap.max_recv_wr);
 	dprintk("    cap.max_send_sge = %d, cap.max_recv_sge = %d\n",
 		qp_attr.cap.max_send_sge, qp_attr.cap.max_recv_sge);
-
+	dprintk("    send CQ depth = %u, recv CQ depth = %u\n",
+		newxprt->sc_sq_depth, rq_depth);
 	ret = rdma_create_qp(newxprt->sc_cm_id, newxprt->sc_pd, &qp_attr);
 	if (ret) {
 		trace_svcrdma_qp_err(newxprt, ret);




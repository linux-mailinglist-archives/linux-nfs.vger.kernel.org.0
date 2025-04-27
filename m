Return-Path: <linux-nfs+bounces-11299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518FA9E3FB
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Apr 2025 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22C73A6AFF
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Apr 2025 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B941DD525;
	Sun, 27 Apr 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+7yYrXi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8C8C1E;
	Sun, 27 Apr 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745772003; cv=none; b=u2lRNBzSbGWmEX7t/WACJIlDnHjc+lgFUN0crZxHalTKRuu9rW7gBrwaHDLjOcYNMMG6TUeA7LCYJ2xpby2afDjsaLmt7G1xal8k4l5sxTSopJtFEOXW4hL9Fr8yrUTxk2NIEObiBWpsIp/glOoyx44iNEZPfb2L38jFdBTDk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745772003; c=relaxed/simple;
	bh=6uF9Aprnm2vfpCrM7GX+0zap9WxCgy4T5+0dJjLzyc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elYMAD/IUc3fr/kEhDuFl1fzL+tGN8bhTIrF1i2VFVF3PX9Q1G+NfYTFG7epOswyU/DYA/fDEfoC0rjQW9pozIUhxQCAoKVM5qG2oUyYgvhmMDGddMA/JhsI1cpDEX1o/r9MgDuo0dbZrPZ3vec6l1kocHQRQmZhQpGnSmdvIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+7yYrXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC11C4CEE9;
	Sun, 27 Apr 2025 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745772002;
	bh=6uF9Aprnm2vfpCrM7GX+0zap9WxCgy4T5+0dJjLzyc0=;
	h=From:To:Cc:Subject:Date:From;
	b=S+7yYrXiMdywDJxp0cgoagC1i6Crd1ztfOzMPDPVVRqiUoj2yBy93WOaToJvWBHpm
	 Sl1od4d1ZOsRdO1qokiA2PVku2loCAcJGJq3EDRt9s1pMt6fucupngwxYY5DdLiGdL
	 U2rqgdF5eP//9SXkZ+xdUUqqqOJyf0bsn5ser12prKum9LwPTpWh0m+y3e3O0HnHhU
	 ssC55JMRixSCA4yVazdcWAwkfYAuNDaVUJ7rolu58MxoYbA5ZAYCEdo+ozbm8LuevD
	 Up2ZGbbY0FQpHTCY+XvDm/UWzJzswus6d8dI+1zLSKlyUUGV2NbCUPS6oThjQvhwS8
	 xMFSSd41WM2PQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] svcrdma: Unregister the device if svc_rdma_accept() fails
Date: Sun, 27 Apr 2025 12:39:59 -0400
Message-ID: <20250427163959.5126-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

To handle device removal, svc_rdma_accept() registers an interest in
the underlying device when accepting a connection. However
svc_rdma_free() is not invoked if svc_rdma_accept() fails. There
needs to be a matching "unregister" in that case; otherwise the
device cannot be removed.

Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index aca8bdf65d72..5940a56023d1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -575,6 +575,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
 		ib_destroy_qp(newxprt->sc_qp);
 	rdma_destroy_id(newxprt->sc_cm_id);
+	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
 	/* This call to put will destroy the transport */
 	svc_xprt_put(&newxprt->sc_xprt);
 	return NULL;
-- 
2.49.0



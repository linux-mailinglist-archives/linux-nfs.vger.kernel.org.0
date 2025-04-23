Return-Path: <linux-nfs+bounces-11242-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7CA99185
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83577A28A5
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF6B288C94;
	Wed, 23 Apr 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOv8lSdT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9E2853E8
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421687; cv=none; b=uc6f6vE2AZ8POou7wEoG+asGvfNQKl/68+sfUrYhziXupCB0aFQ87xKayqA+H0o+3qU2grdYpRIr/6vDjcC/XXYq/uy6xxQxu8XTRXFRVptR3IKpDJpajcbYZJN14Ba5HrVlWevVPZCu/f4dHgo8MiIAKb2lPmGCsBZ8URb1PZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421687; c=relaxed/simple;
	bh=mJGmbzmKZfLaL4jCPjCvYH1dgF/w0o6lwWKHC0EpP2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBNcQDPe3WP4hnPeIWeafh8y5iUjyqX7+jkRUWW3Ow6ewXqpRsjeWeWcqVwr+mF007yTb9066xVvAhf0AXWL1Nkf1ZkTmDobS0QzvzUaKhy+Jfv03R9qDW6L5pNpC1Jpu+oLnni1DvEajPgYA98ZJJ10HIs3Sb5lLopzF53VVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOv8lSdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35166C4CEEB;
	Wed, 23 Apr 2025 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421686;
	bh=mJGmbzmKZfLaL4jCPjCvYH1dgF/w0o6lwWKHC0EpP2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOv8lSdT7RXwrTDCmAXmbupkudHGMhxQTaK3yVargl/bhHYQ3G79l+4nD0HyWQTmT
	 23kxkjV2bNlx/QsdmxnvmPMqJ+d/niIbTjyRJO5jtaAYZOMpobMmQUB6GuqJa6aQOM
	 qtSAHAXg2c1o73XZ9jcwTrvCkiFP6uEJJ+Wx1v5gXBzEJZc3fn3hHiKt/AbIy72Nfx
	 vbcA3KNR+qziB6VJcoPu6n0XuAjH3Ft8wQSjSTXPlTgYJNfW3uMqlVTpSvItfFy1ra
	 xDpy8iB+SsKCi8gdkHQUoj9sv6tRO04gpnbuU92h7yZbvIu5VjK4TdJuZwru4wK4ES
	 CWootVZjEo1iQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 07/11] svcrdma: Adjust the number of RDMA contexts per transport
Date: Wed, 23 Apr 2025 11:21:13 -0400
Message-ID: <20250423152117.5418-8-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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



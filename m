Return-Path: <linux-nfs+bounces-488-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6680CF6C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811FA1F218C7
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D94AF86;
	Mon, 11 Dec 2023 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnmXoHCq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98C4AF83;
	Mon, 11 Dec 2023 15:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C22C433C8;
	Mon, 11 Dec 2023 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308282;
	bh=hbCI41fDxHFogMcLFo0YztlPsPbDh4I1ONF2ZseeT1s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RnmXoHCqP8e5mWqqw2J5OqLsDnOoKgRbBdjthe5Hn/ujOkulyfE2lM65OdN5EA/vv
	 bPEBFy6zFDR48AEuPrVQCPGJ5zT8YeMp4XM9ptQSEji8+0lbOoGXgp25ipRkcVRgtK
	 e31hqLAOvC3kPoE8vX+cL+paUDXjEKCdO7Qoh22nyDEiYvZGS83aIQ1UbpfgQOum5Q
	 217XBdtTCWIua0Jtqq6JqS7KjRvsmC1L3XKiDWFECRTj0aoZY9B8hjPw2UQt5SWsyF
	 RCNGw0NaWqlf6LT7KP20Mwz95HGmhT9tBcT/0vfh+wZSy0zFeCje49bHRUhBj4hR7+
	 31WrZS3z5QUPg==
Subject: [PATCH v1 6/8] svcrdma: Reserve an extra WQE for ib_drain_rq()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:40 -0500
Message-ID: 
 <170230828089.90242.3890762157877508465.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
References: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
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

Do as other ULPs already do: ensure there is an extra Receive WQE
reserved for the tear-down drain WR. I haven't heard reports of
problems but it can't hurt.

Note that rq_depth is used to compute the Send Queue depth as well,
so this fix should affect both the SQ and RQ.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 8127c711fa3b..0541aa54674c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -414,7 +414,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge)
 		newxprt->sc_max_send_sges = dev->attrs.max_send_sge;
 	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests +
-		   newxprt->sc_recv_batch;
+		   newxprt->sc_recv_batch + 1 /* drain */;
 	if (rq_depth > dev->attrs.max_qp_wr) {
 		rq_depth = dev->attrs.max_qp_wr;
 		newxprt->sc_recv_batch = 1;




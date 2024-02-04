Return-Path: <linux-nfs+bounces-1752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B767F849177
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4F28280F
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95781854;
	Sun,  4 Feb 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6OtCpCs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7ABA33;
	Sun,  4 Feb 2024 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088599; cv=none; b=lq+CJMMuae9OfvKjKOsNQA8WUFoTMGUWahwrBRqrSrioPIIBT4Zi3jdvj54XIAM60isZd76wkTQ3HgspuJ6AzyORNWzlG/mmaGsppsCWsmJxT8PhIpdbPvVITGrV9OsCouVSZ60n1A+PbhBMeKIii5PkXAtsFLqTKxkdJSHpn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088599; c=relaxed/simple;
	bh=05MA2D7vfCBiHZrUjlGcpBFOLywfR7Q9Kfb3fvxMbMQ=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhRBgQxduGpl3gEptbWEgkNsGdxBhWnUPBbPZjdxP6jLZSVcsmNPK2P6OdmApxv1Da/RchzUKwitrsrqZWUzL/hnNVdrw+di0aZ3fDbcBKudH78/FAAj1RltikaHoO5i+5KfS7OGgd3SgeiSzm5cse519RdNn7IB2zRE5TlqFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6OtCpCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C962DC433C7;
	Sun,  4 Feb 2024 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088599;
	bh=05MA2D7vfCBiHZrUjlGcpBFOLywfR7Q9Kfb3fvxMbMQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=K6OtCpCsFaPsqALCkMJSC7o8M++/WAEER1Q7LwVDrNaPDuj+W8zNHblUUYngekJGC
	 S+hUg5yHl6NHims6fjYLMk5l5KCKD5qOSeiEJPqdPeIcLwUegQqOkqtGomHtE0T6wU
	 NcKznmhU7i5FbF74Xhu0HsiuTWbbgBWSkcbnZWLvl7RnexkAk9VgoQP+7lJmqSrNh5
	 IAh/q8IMmuk6TT/XtD8Te+HRkp6POavfVQotJ+WW77sOOwFHKCw48hHf29vhaWOsPM
	 vzxKMq6nrIWiN+Pfnw9TIRSCOlYK3sOOmuUUospTQrT8b6VkMry57nE1EqZTQWVmQc
	 a+6WMlZ+XL1vw==
Subject: [PATCH v2 01/12] svcrdma: Reserve an extra WQE for ib_drain_rq()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:16:37 -0500
Message-ID: 
 <170708859782.28128.17719864297677716598.stgit@bazille.1015granger.net>
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
index 4f27325ace4a..4a038c7e86f9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -415,7 +415,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge)
 		newxprt->sc_max_send_sges = dev->attrs.max_send_sge;
 	rq_depth = newxprt->sc_max_requests + newxprt->sc_max_bc_requests +
-		   newxprt->sc_recv_batch;
+		   newxprt->sc_recv_batch + 1 /* drain */;
 	if (rq_depth > dev->attrs.max_qp_wr) {
 		rq_depth = dev->attrs.max_qp_wr;
 		newxprt->sc_recv_batch = 1;




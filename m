Return-Path: <linux-nfs+bounces-1552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF28408F0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 15:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276491F2799F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E35151CEC;
	Mon, 29 Jan 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+m2DJZ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0581272A8;
	Mon, 29 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539839; cv=none; b=ouO+20AoRRAX+ipeC0iecfl3YjDdeg8ZAz8ts74RE+CN4tGSfddnSQG9Pw4O9eNXNwhdWkLF64yGx3n5Sw4xlEeCwOBeo80IX/CuRiJDKhDo9YVcgE/2d7hKnHLYMtWvUXjJri7eYQ3yHWSblvbm/CdwMYYTHeip7WElQM50I7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539839; c=relaxed/simple;
	bh=05MA2D7vfCBiHZrUjlGcpBFOLywfR7Q9Kfb3fvxMbMQ=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPT0d2SworOz+z/XYYsO7GAViZVWWXkxbsAjBp2Yeds6DFTfvmmqZLlgKG50n9MnKoqZpkm1tsz7O1V4Mbkbs8gFHlIGLQGj/UG6CVvQG7RNPhdouc1aDf4DU+R484dKQBQSIstSSrN9EsV/lMcvj/9bs7eHdDTfGrwspY9RCaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+m2DJZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43969C433C7;
	Mon, 29 Jan 2024 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539838;
	bh=05MA2D7vfCBiHZrUjlGcpBFOLywfR7Q9Kfb3fvxMbMQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=X+m2DJZ5t1Ho/vP+Az9Zgk4qrNLyscxxOQdzrUbHgroY+Sbb3q5NYW5hythKwyUvA
	 QzpsQiF34okZA7aGpo0OXQj+02WE8EaGIM/qPI/red4mFfS78wCK5VEs52ycPRu9TG
	 cIcRlhY/Bp1psdl93i0IZm76Rytd/5UepMrPpEoRThHXBJcsX7yoWjvLRo4Oj+XGzp
	 E50A3BHjgJKbQPACjuLjOOtVY+FkDYQuJkzGcAWaL6ntaKuvroWd3dwPR/iAittAin
	 PM3blK3eNP8dB4H6+7i+x+dNMKI7BKv+4BY2An13nFzWItFSMChVdiiErDlKGgdYEr
	 /iJCqdy0zIFaA==
Subject: [PATCH v1 01/11] svcrdma: Reserve an extra WQE for ib_drain_rq()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Mon, 29 Jan 2024 09:50:37 -0500
Message-ID: 
 <170653983726.24162.15894483608296911955.stgit@manet.1015granger.net>
In-Reply-To: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
References: 
 <170653967395.24162.4661804176845293777.stgit@manet.1015granger.net>
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




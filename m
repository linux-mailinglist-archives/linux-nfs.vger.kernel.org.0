Return-Path: <linux-nfs+bounces-1754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B084917E
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 00:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D88A1C21AAE
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 23:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4398F1854;
	Sun,  4 Feb 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKbEjRhM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31AD510;
	Sun,  4 Feb 2024 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088612; cv=none; b=MIwA+qs2fubfTUn96/DsIMbp7MDukhN6MyWXSZoVegch/oRdLSIOqJebxc2DWshMg7b+aOWLAvwJlOZjuxFuYR+3c6Syn9h11Y0WCw5iXAU8LcsQ5eTMyzV+kaCPUxzOzhn3F/QQFLSeVfXgyJW5EQ5+2oFqDG8Vp1J11jcPx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088612; c=relaxed/simple;
	bh=6BFFnRKPQsFPc2U3vG/2FJmT0Fq08EU7vYWqhaAf2dw=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7vVBQNXTlm90lo5KiOGKeofLwJ2saCujOdKxq2ka22HmKcn3L6jqWPIlLJ1gQ1CowxDqPqPuDYrt9ujMUCSP73Cex01E4n4ZYcLXzccTozXO6sDdpmgrWV94lXZEWSylWcrlcmlBTTvC2y9E6Hgc7RCVNabYfcouBVUuFJRN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKbEjRhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB1FC43390;
	Sun,  4 Feb 2024 23:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707088611;
	bh=6BFFnRKPQsFPc2U3vG/2FJmT0Fq08EU7vYWqhaAf2dw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bKbEjRhM0GN46T0/8wXeWlF5/NxhtkIRyBA0cADLf38/X0LmE5Z1XoSsmZ8ltOfmf
	 Ab2AOeT11TPatLQ/AgqN85hYpBXdXyL7/gYRIKetWvXZslXsQpaTJT6OIbV2C1K87C
	 uwXPbfcURSjA9AkFBIQLm+qm0mmK05B6HBKXEFBlDcyAvN5QkMNgcb4CZIBg0Zz//k
	 DsAUZG6vSY5mphwpUBJAp5jywSCqy26saObBZ5WybHSB4bLw2x8whx8zRce9Nc42uo
	 rkpJ6LVPXzdqozMohBwt8sygDDy593g4O5DoayY2knk0RmwQSLV3zNRFJ3rgmz2EAa
	 UZVYckMjB+ohw==
Subject: [PATCH v2 03/12] svcrdma: Update max_send_sges after QP is created
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Sun, 04 Feb 2024 18:16:50 -0500
Message-ID: 
 <170708861056.28128.2372400452643006250.stgit@bazille.1015granger.net>
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

rdma_create_qp() can modify cap.max_send_sges. Copy the new value
to the svcrdma transport so it is bound by the new limit instead
of the requested one.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 8be0493797cf..839c0e80e5cd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -467,6 +467,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		trace_svcrdma_qp_err(newxprt, ret);
 		goto errout;
 	}
+	newxprt->sc_max_send_sges = qp_attr.cap.max_send_sge;
 	newxprt->sc_qp = newxprt->sc_cm_id->qp;
 
 	if (!(dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS))




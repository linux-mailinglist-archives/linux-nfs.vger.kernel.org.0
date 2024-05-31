Return-Path: <linux-nfs+bounces-3509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACE8D62BF
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37931C265EE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937C158D91;
	Fri, 31 May 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2kBmrc1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADF158D89;
	Fri, 31 May 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161371; cv=none; b=rD9hXwfZhzccJM50cW6iNSHEbXJ7yCLNzClysVb0YTj18+yeIzURgnyi8wRpOnphOOezIEIlOHdNuGLiv2BOwVqA9zZJooHRiLdOlNBTFhGH2ReE96UoNGzW0SAzhgAwhBiuONM6qdAgdYJnOPWGHNedF+3oVcVmfbEBdptokjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161371; c=relaxed/simple;
	bh=zYN86TjmgCguRxsLfye2Hp1ZzKNeRsWNS2gyamV76yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWZ16vm8P+8JmmUUa4VHujRyT1HM3xue2IrqcS4dGOadDmkE/u0vsitFd4SWyLNKlrjE7QHsvnU9UNrq5UQimBUbyVWiqoVzAnBlesYuE6IyqT2e4wAS1D3Fv+0zVr7jUlIGo9qFZQ6GtmRVymIAKOpeqKSDp/zJME1ilpriEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2kBmrc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6767AC116B1;
	Fri, 31 May 2024 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161370;
	bh=zYN86TjmgCguRxsLfye2Hp1ZzKNeRsWNS2gyamV76yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2kBmrc1V9B9XL0756gWkwVm/ryijpRzgbLONKZz+rUgAzt387QUkdyyF5z2az/+L
	 qIFqGRcDK/4DuAsvhoIciXaAc/GF6+TRC8RcM2oAlvptAkRXwhxJU93HjnmTUbNZZG
	 UDD4iY6HOYl2dtuv7c4UPDC4Rf6I0PSunJlfcHoUZDxNTzVQq3tqoLiF9azjiBlZH1
	 aLSIBuADNchQ8g9XOB7BkDogTtKoc6jZQgXc7OhJ0RLW919Fi0Wh41T8tyHqqC9cy0
	 9STHKP94htvtKf4EGIUh91Xn+JglSkOqL4jNNi9xlyqcM4v0XjoP72bHyJ59/MF/QJ
	 MlRcbnlViEwUw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/2] svcrdma: Handle ADDR_CHANGE CM event properly
Date: Fri, 31 May 2024 09:15:53 -0400
Message-ID: <20240531131550.64044-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531131550.64044-4-cel@kernel.org>
References: <20240531131550.64044-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=chuck.lever@oracle.com; h=from:subject; bh=xVkiJogTAjn56JWQPU7jR+XzOmBOEzfU4GRVcOmFucc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmWc2QjQcPIYC3816G6VAl9NywbY4b74ilpM9Tw WxS3TF72NiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZlnNkAAKCRAzarMzb2Z/ l2wZEACZbNvT1atflPBeE3HcUMERO6kXXi7JkuXOmfjJvM//WZF9aWxQJwLoRZeQ3aOIdcrwhG6 zI9qWirZDIJtlo4qMY1hWfaCo+DgATWF/JvLNC8hEK10fSfoqOnGxN4RjAsV/HDx5b229LujLHf 1/w4Y4Wp5AobwZ8JU05259ROix8OwORS39l2PrwolANmiOTbWtHxcm+SR77VrWI14qMOi4VWf8g lAcxdlxEnOJg/85pEiPBsWjd0enfDRCUGh4GbgfWo+HxKN9FZh/8/pw9Bjht8oKa/ghGl0yavZ7 hIDQdv/RXLjUGXtLcvaHAV4wngZQYDWHVOnqkdHey6q7g8rBbNV2IpwXnVridvYmWzR1U3gnnBR GMbQwZbkvfmut/yG4kbqGiiG2DCtlH1Iydijr37qKtewPY4BBKHv+VFIWyMPulp50uZ+2ODJkke bxI8ddzrr5NYIY6RC6Qfrok4aaP+atdU3m2ul4Wi3cq8BRf9JFy9LeHG3eYSzm8FyFEf2dIi3ld bRc3gVnVxZzlja18LzRfGrdI6LnIffURqI2nU0BJ/+fhuv5lgsVkldmxukN+wFp4+mEbrPCm7fs d9sb2wa8XOtOYs0yCP5K6Ysgo+1njxSeuS9mS0Ib1/ZkCLMNF+u0CKBUZQWGz9upEJgxC5T3Xh5 X0QOwz/g1BggArQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Sagi tells me that when a bonded device reports an address change,
the consumer must destroy its listener IDs and create new ones.

See commit a032e4f6d60d ("nvmet-rdma: fix bonding failover possible
NULL deref").

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index fa50b7494a0a..a003b62fb7d5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -284,17 +284,31 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
  *
  * Return values:
  *     %0: Do not destroy @cma_id
- *     %1: Destroy @cma_id (never returned here)
+ *     %1: Destroy @cma_id
  *
  * NB: There is never a DEVICE_REMOVAL event for INADDR_ANY listeners.
  */
 static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 				   struct rdma_cm_event *event)
 {
+	struct svcxprt_rdma *cma_xprt = cma_id->context;
+	struct svc_xprt *cma_rdma = &cma_xprt->sc_xprt;
+	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
+	struct rdma_cm_id *listen_id;
+
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
 		handle_connect_req(cma_id, &event->param.conn);
 		break;
+	case RDMA_CM_EVENT_ADDR_CHANGE:
+		listen_id = svc_rdma_create_listen_id(cma_rdma->xpt_net,
+						      sap, cma_xprt);
+		if (IS_ERR(listen_id)) {
+			pr_err("Listener dead, address change failed for device %s\n",
+				cma_id->device->name);
+		} else
+			cma_xprt->sc_cm_id = listen_id;
+		return 1;
 	default:
 		break;
 	}
-- 
2.45.1



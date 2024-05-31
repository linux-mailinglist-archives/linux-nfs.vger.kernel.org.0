Return-Path: <linux-nfs+bounces-3508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF2F8D62BD
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF141F279ED
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E39A158D62;
	Fri, 31 May 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgta5CRK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C74158A2E;
	Fri, 31 May 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161369; cv=none; b=gp9dmMq6l24aHtqlCbsuzreC5O2y1fhDiWNCJai/UXHMeHhj/UPZclXHS3LJy6zUuctsPrdd0k+PwTlOW8gEfqfkMfquawdpyuNQ/Yg+2W2ou39D7OENVdYMM/90KK4Fe2nAkZlRQtVwpF+9TGNciDB8p90TkcM+MYyYbsD6lhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161369; c=relaxed/simple;
	bh=BfQKLh10hQ9RZozJx4TlZCeX7KWH/jIn9tpCCrCLYvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tp1ksSYHBXnh3cDuXz2DaDL9Orhahj8RwoxJQR8HoxSc7SUU/qCjMlMNXUNjhiT2T06Vv5T5kRVDW+zKbUu7InHP6QKDFBjVx9IEXFxGi7Upx1pg1sLGb4Rgs/9uKl3ui8f9SUY2DcF5l9czPiMMhVwbGsWRwwiICECn63DTKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgta5CRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6913EC32781;
	Fri, 31 May 2024 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161368;
	bh=BfQKLh10hQ9RZozJx4TlZCeX7KWH/jIn9tpCCrCLYvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rgta5CRK0boN0mCgAJWJOgBOGxQZYP9LFfFWglsLBX6EuO0O/iBhKXey7vRePLaAg
	 RpzcvIQWxJ7AHwVQ0ocWeZ3VmHvr1uNw5L8K3XfYH1ifGHzeH//3x+Bvz1LdTrH5JR
	 yLuGyXkTSb1C4Ouh39nYiiKtdeZ/ygoAjcwXzEhP0IFiScyjB4YWyVv7Zl1CDRetEa
	 T+a0HssujvMC57Bhf+0ir8AVHoWDCltadT46pNpu/4IrGq+PFwPtKMiKklycoDAskA
	 r/m28WY2pwMkh1RzLX/oSeDqP9/aPUTFVJ89NhT8D83Oa+VxQvXvOgkiaITBJIh4uf
	 4j//Nc/B9Ng9w==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/2] svcrdma: Refactor the creation of listener CMA ID
Date: Fri, 31 May 2024 09:15:52 -0400
Message-ID: <20240531131550.64044-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531131550.64044-4-cel@kernel.org>
References: <20240531131550.64044-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3487; i=chuck.lever@oracle.com; h=from:subject; bh=2PIo1uAgvbLyhllQAw3g6B2ljsIy2S7JgWBEEMmR0CI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmWc2PRnHK74MIuy+MLxGc1MwSFDsiR2n4Fl0Hu ckp8yWHtAWJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZlnNjwAKCRAzarMzb2Z/ l2iZD/4lGeH44T39tatJ+xnkqSaBBfez9mdYzFtASScCvp0jCIQ2jWhW2DAq3BVEE3QSJ22eJAx cLPsUnIfGBU2eNN4NHylKZ10XML1h/eeFyr3TKTNI/XNrYyeB+1EmXjU0XfDNOIQ1t6Sxh99LdE CHD5TiukTSl/ZkByLJgtgdRDLrW6iotUjWIZaDA/V1CyLbsh3I6ApsOLzeW2vduRIkkJt4iKx/a 28zkcj7+1wiZ7Iq6waKVt3YM+iTN1O/+EcVogHLtNNRrdMR3+xlXERhEU0XFQO17F0sN2hrsGAK 6pNvfGso/ytfny5tYYYIGbcux6bpzCpRkEZ56tm/FKHNeWJ0Wg76cy6lUQVOt4eMIErsc8YA4+L 2Vm7E/1RAASfEWp0oKRFyc1+mtugWcm7zAF8Vd9eNCTUthEzq5izrjxdp1MPuA5hw3mblgGTfRi QyecgFBMd+d3ASnTwPBMekRW84l0HIg+0PX/wJxupH8hROwhUL+vEFwSwtDQUUBKZ6rJALmdFfc UjlJ73xcDqJk4EtTQhwoF+4eaIu162J6mphR8FuiFnWy70AMM1xanInuQbk6vzDfv/lF2XPW+Kv NK20CApZiv47astamDQg/lZr6mbkcM1PMWkHJnYgF38C0bcwWJUNr3ROLWGp1AfcRTQfsHC9Jbp Yr58fJu0EHdZwrA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In a moment, I will add a second consumer of CMA ID creation in
svcrdma. Refactor so this code can be reused.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 67 ++++++++++++++----------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 2b1c16b9547d..fa50b7494a0a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -65,6 +65,8 @@
 
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 						 struct net *net, int node);
+static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
+				   struct rdma_cm_event *event);
 static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 					struct net *net,
 					struct sockaddr *sa, int salen,
@@ -122,6 +124,41 @@ static void qp_event_handler(struct ib_event *event, void *context)
 	}
 }
 
+static struct rdma_cm_id *
+svc_rdma_create_listen_id(struct net *net, struct sockaddr *sap,
+			  void *context)
+{
+	struct rdma_cm_id *listen_id;
+	int ret;
+
+	listen_id = rdma_create_id(net, svc_rdma_listen_handler, context,
+				   RDMA_PS_TCP, IB_QPT_RC);
+	if (IS_ERR(listen_id))
+		return listen_id;
+
+	/* Allow both IPv4 and IPv6 sockets to bind a single port
+	 * at the same time.
+	 */
+#if IS_ENABLED(CONFIG_IPV6)
+	ret = rdma_set_afonly(listen_id, 1);
+	if (ret)
+		goto out_destroy;
+#endif
+	ret = rdma_bind_addr(listen_id, sap);
+	if (ret)
+		goto out_destroy;
+
+	ret = rdma_listen(listen_id, RPCRDMA_LISTEN_BACKLOG);
+	if (ret)
+		goto out_destroy;
+
+	return listen_id;
+
+out_destroy:
+	rdma_destroy_id(listen_id);
+	return ERR_PTR(ret);
+}
+
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 						 struct net *net, int node)
 {
@@ -307,7 +344,6 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 {
 	struct rdma_cm_id *listen_id;
 	struct svcxprt_rdma *cma_xprt;
-	int ret;
 
 	if (sa->sa_family != AF_INET && sa->sa_family != AF_INET6)
 		return ERR_PTR(-EAFNOSUPPORT);
@@ -317,30 +353,13 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	set_bit(XPT_LISTENER, &cma_xprt->sc_xprt.xpt_flags);
 	strcpy(cma_xprt->sc_xprt.xpt_remotebuf, "listener");
 
-	listen_id = rdma_create_id(net, svc_rdma_listen_handler, cma_xprt,
-				   RDMA_PS_TCP, IB_QPT_RC);
+	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
-		ret = PTR_ERR(listen_id);
-		goto err0;
+		kfree(cma_xprt);
+		return (struct svc_xprt *)listen_id;
 	}
-
-	/* Allow both IPv4 and IPv6 sockets to bind a single port
-	 * at the same time.
-	 */
-#if IS_ENABLED(CONFIG_IPV6)
-	ret = rdma_set_afonly(listen_id, 1);
-	if (ret)
-		goto err1;
-#endif
-	ret = rdma_bind_addr(listen_id, sa);
-	if (ret)
-		goto err1;
 	cma_xprt->sc_cm_id = listen_id;
 
-	ret = rdma_listen(listen_id, RPCRDMA_LISTEN_BACKLOG);
-	if (ret)
-		goto err1;
-
 	/*
 	 * We need to use the address from the cm_id in case the
 	 * caller specified 0 for the port number.
@@ -349,12 +368,6 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	svc_xprt_set_local(&cma_xprt->sc_xprt, sa, salen);
 
 	return &cma_xprt->sc_xprt;
-
- err1:
-	rdma_destroy_id(listen_id);
- err0:
-	kfree(cma_xprt);
-	return ERR_PTR(ret);
 }
 
 /*
-- 
2.45.1



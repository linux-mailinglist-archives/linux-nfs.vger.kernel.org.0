Return-Path: <linux-nfs+bounces-3548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3E8FBCBE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C81282D71
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91414139584;
	Tue,  4 Jun 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAQEgQoX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94C1384B3
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530362; cv=none; b=tUp7oTwpxsXwNr86tRIqZPC1u86e9LnMEWEJhf/QV4Jp2fyEu0QwvIGknSOyw+RWRhKbUSWQZnV2+sb/zpvIzap5zaWZ5HXrybG8n6EBjgAKfY4/PMp5X/gyiEb2gVhlqYDOg1GfAfbwd0E7wCkNxRAt6ecNzU9X+5bbgwKt41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530362; c=relaxed/simple;
	bh=5Ydso/zVQbeAxwgu5lw6RjuckO6TvFOED90x4PG3wLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ6FUVQ0oBezPBdvtaV+xJZ43uAv7ode+O3xXhfmdfcF+TYgR85xgFBr3Se+HUMQ5fy4J3iAjZ5kqllbX2idqTalLZm++iUh+02I+4JWNeLQ8lVoOb3lj9syCGCt+09ejEALSOehNto+Uhtmt6I04Wl6xpR8CepknC6zKEFQPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAQEgQoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBBCC2BBFC;
	Tue,  4 Jun 2024 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717530362;
	bh=5Ydso/zVQbeAxwgu5lw6RjuckO6TvFOED90x4PG3wLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAQEgQoXzqj7XIV2RUYlzmBgav76bYpNPET8YCkP2ztt6ujWVE+M93t0XrQi3BKBW
	 XGjxUYrYCSm7Lej3gdARxlQKGgoZY+SOBd15SF2lKrUMrXi+Wqpa45axJ/VIGPVYlc
	 SwDmKOSRL/96f0/jTbVPLXlFj10iqLgxv+fRMPNkJPRBQyLXETqED93gF6ziGTxdRh
	 WBHkLFHPJp6raD4CVhLJmqa0xQqAnUXW9hbKiX9vQ14emmC5rVors8D1yBxWuCFDWb
	 3TP9WNsGY2Jv8F0gPvOt9JiLukImsofPHcv4/if6NYi3F7r24DaCJ7l0/SjocdUC6Q
	 fgXIib+GarcJw==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 4/5] xprtrdma: Clean up synopsis of frwr_mr_unmap()
Date: Tue,  4 Jun 2024 15:45:26 -0400
Message-ID: <20240604194522.10390-9-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604194522.10390-6-cel@kernel.org>
References: <20240604194522.10390-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=chuck.lever@oracle.com; h=from:subject; bh=JhOZt/3I+/9WkTp79yqTIaQpm4OZ0ujPaC35ryjiaAg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmX27gchlNf6/z7MmrWuZ7OLNdacwUvY37eo3fw KnvwcPXUhmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZl9u4AAKCRAzarMzb2Z/ lxrLEACnHTY2knwjhEFAAR8khFtJH4EaDT+y0eylaiv0C0yJGbL7ez2pKCu80fxnNiM4HlvklUv /T/lqooQqHMHrXLB+Zfr+Yv1mUfPdeHI3MLO8Xv2hBt1Jo/ZgUXIoKenHUa0Svs8Ds8uIFugq5b da4/+pcF6IWobzZ5q+llDSyQGMqf7G1nWoyfNKnLDiXT9Tb03AbDXoY/MRjkB0IegL4pq886W3Y NumNQYKNTkId5Q+R/7g7HnT81pF6kvuluzrssg/ITY6ZqVsPd7R/I2faBna6jhgsCduyhb2/mnI Pss3JR9O9q20xWdiH6+GwSqYINid668Es+qN6D1//dMvoCCbOzeMxGOa7mgWHdknM2UE7hpwH6H mssZt65EE2uJuCitlg+sax1/01qqM0y68H0gEQADQpNOS9KSbE3Ks3I2NJg3oBwZc6l1jYSyTFE c+eIn0AGVoG1QwDqM309fN8/EufaJ4jfC33KIKyaSFnxq1CYkWR5VB3eaYp9cZ/YGTH6XuYHmeY vgXO/QBV1+/7RtSEpQFNN8P7orjualDy/AeyWvswiDwCpFtXjYTHeaED4VkzvicbLsiXeZDY7jp V01I10Veevd7qucmqeizg+G8E3a6tVuiTsZUB3Shu0memJXH7CX/T7F6WSBYfc4sjPYYnDA0n8H Fn0yvPSO+N8ntjw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit 7a03aeb66c41 ("xprtrdma: Micro-optimize MR DMA-unmapping")
removed the last use of the @r_xprt parameter in this function, but
neglected to remove the parameter itself.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 47f33bb7bff8..31434aeb8e29 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -54,7 +54,7 @@ static void frwr_cid_init(struct rpcrdma_ep *ep,
 	cid->ci_completion_id = mr->mr_ibmr->res.id;
 }
 
-static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
+static void frwr_mr_unmap(struct rpcrdma_mr *mr)
 {
 	if (mr->mr_device) {
 		trace_xprtrdma_mr_unmap(mr);
@@ -73,7 +73,7 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 {
 	int rc;
 
-	frwr_mr_unmap(mr->mr_xprt, mr);
+	frwr_mr_unmap(mr);
 
 	rc = ib_dereg_mr(mr->mr_ibmr);
 	if (rc)
@@ -84,7 +84,7 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 
 static void frwr_mr_put(struct rpcrdma_mr *mr)
 {
-	frwr_mr_unmap(mr->mr_xprt, mr);
+	frwr_mr_unmap(mr);
 
 	/* The MR is returned to the req's MR free list instead
 	 * of to the xprt's MR free list. No spinlock is needed.
-- 
2.45.1



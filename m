Return-Path: <linux-nfs+bounces-8688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A619F95B2
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185B816F963
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2024 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B354218EAB;
	Fri, 20 Dec 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XixpTbCp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E88218EA8
	for <linux-nfs@vger.kernel.org>; Fri, 20 Dec 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709361; cv=none; b=LXLSytrmAoCJCggOEMKb+de2SFJPc87mhO+QGeaXLtWKKx24VHtrKaCuh2D6/x+Ed81Bm1Cb1kxHuIZLFhehOrLa+9+cINK0GVEXvwCITIJW5B5iarm0ZybvO2PHFGd1F0RWhknvslJso0DbCTd3y3PSCkZ1JzXfuEpREWFinaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709361; c=relaxed/simple;
	bh=xjZby/G+1S0HtB+8hgO8Un9xUZQtgkwttk+DiH1A6IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9J9a/S1IhJMI5q1RIEEqKwAwqQHShclinC7bhXdnMQzBB3cgC4XrNOJNHI9KP3PZvc80rF2XcMdkqCcrQaxBap4MFjLZPXq9IyWn74diJZfQYoC6TDFerv/WqnxpSyAoQGfnjaBil6Hke2bxlMZ9FmwRZfAlu+58TYSgcyHax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XixpTbCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08644C4CEEB;
	Fri, 20 Dec 2024 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734709360;
	bh=xjZby/G+1S0HtB+8hgO8Un9xUZQtgkwttk+DiH1A6IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XixpTbCp3pTat/WsMLHgue+aRLupd6yZMuVgOzc+Xzi5DG0KTBxXJCoxH/dKcf66B
	 Y/yvLzVwGYi5PkPI9z6S1H4ZNeIzLgwFloXSMlSPEf3JtZU6cQbzLv9IEqmoN5yy5s
	 mKhDzCLGcEU4GOfdiQRyRuKB18tnJtDjsiYY7pJHrQTNXzQMU4DFdWLou1RMZ7M1nn
	 t5YhKLd5gEmgoVTm3xFKpYguAJyIczYXddCO9vb1qD87fYqUuYGlLG/q7S7elUevnc
	 UF74zK6EaRaLb8viktdPpu3OPYO459Yh5mIpmezE3MRlJLHt6QcuU9/5GsEgq3y00F
	 w1iXpI2Hpr5FQ==
From: cel@kernel.org
To: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/7] NFS: Fix typo in OFFLOAD_CANCEL comment
Date: Fri, 20 Dec 2024 10:42:30 -0500
Message-ID: <20241220154227.16873-11-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220154227.16873-9-cel@kernel.org>
References: <20241220154227.16873-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=546; i=chuck.lever@oracle.com; h=from:subject; bh=iMfLGnMC2GTPGqB77IBVlR2DJhMBFTN/oBgNP4k3UPU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnZZBpiihnzZWIEfy5TkDaUouIstdQzlq5dvEdo RuUqDbv3wuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2WQaQAKCRAzarMzb2Z/ l7YcEAC27zA1PGXHnL+pqThgvWnSrKnlrq3XAn5FuvqtWZym4wMwM3AodvcnwJeyqTQXAkcpVs4 cByf+hgKmISaGqllwOUS4C/QBCl8Hlda6STG1ZqBwV9tEcZTxtIWCm7L+7XhleZqT/TikXI/IM9 qfbZYTOys1Ml6bt98Y6laNabd178YBz9Ed8lc3QN6LzbWyWtV1w9sCQlycPhgLEBmZhevQZbP3M +j58HVL4NNOQTCmU/AiGVWKW8OiMLA33zyzAqmkYHAx06tjGMfhHpQyl4gv2aINYsgXSp8csUIC 9ERwpluitMkUG1YAsdOMKWORxvoB7qRqdwmvMrFvLEVH3dzHR03OgFRdi3RgYT0ZNgyc7s4R5LV cY10ZVi3ojA7jPGV6rFqf8giW7PITNwOWJxcQDj1lmlSxMSfj0G4oYSsE5qXTVdzFP/FOvooG1e 1MuTIG+tv27TiPrX9U8xhO7TrlAdaJB+IUx/yIkWebS5wzUynol1bOM/n19TpptZETjxmPEVUhD JgRdkO6hs22ATfAqYJoFlF3Kom7nBAwQfddtdusXMwCqyxvnxwWgzDhY5q02WWgzHJl0ob6+wMZ 5BWzbNJdSslJQGodGn6si8I8aWHVjs4/rk9EIdaFb4QtPOycCZb6KE9msHWxN/koyziRAjRPnh/ EnRbA50ejD40ewg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 9e3ae53e2205..ef5730c5e704 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -549,7 +549,7 @@ static void nfs4_xdr_enc_copy(struct rpc_rqst *req,
 }
 
 /*
- * Encode OFFLOAD_CANEL request
+ * Encode OFFLOAD_CANCEL request
  */
 static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
-- 
2.47.0



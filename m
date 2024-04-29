Return-Path: <linux-nfs+bounces-3061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD178B5DA6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181F41C21D4C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13282D62;
	Mon, 29 Apr 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDi/an3A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA582899;
	Mon, 29 Apr 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404345; cv=none; b=PvmUQXYQrKHiNS/Cv2buld+zFqLboXCDd3DCs2DahaSgFqjuaIs05369lUOADLQXhCXD2wnIesuoxqrwsdCD7sexIQTPy6cHlkSiouEK2tmwyfiITGf8mYlaT8iuZLQKxlsGHCm1bgh247+DzcORLcTEVVGJZzkxqrn6YWPGSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404345; c=relaxed/simple;
	bh=3chjRlWFA+CIIEOGgMd3ndkEz7Spm+a36WUbDUMnrAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKJLqfqTIQ/J08u13q8DXOBZQ34FrXDyDh8UeJ1lwm1qCsMRv1zXOZi5zRLJ0a3tZctLV9eUVEulYQFAw49gWst0MfiBNBqSNZbUw6H9/LSzh0bu80j71/fm58z+TFDYBelDc7C4BOrIxaa5K6AfZwO+iit19Z5xRR/XYq00G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDi/an3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3380CC113CD;
	Mon, 29 Apr 2024 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714404345;
	bh=3chjRlWFA+CIIEOGgMd3ndkEz7Spm+a36WUbDUMnrAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDi/an3ADW45fwNGBk1mLLU5oEgUXzD6Nwar9hxj75+6V4BVK88/w8StPhm6gXgqW
	 br1h3ti99140VWpKxFSptM4YJO1qXu+w23Am39qXBTjLZ5fXBZTFMlArHWzylvid6I
	 eED2FinnNwXCcWVG6g8iP6k5gyLo4vmLj7XkLxhrWCjnWAxYBwJdATwQACE7ltu2Mr
	 Ttl3SGuyMuX2sejRW5Q3SO7PkF7TJCEd/2GwJ8k3zbr6dJd1ozC6whUQ9PQ5K6GDGf
	 5DjpMSFqODTdQOegD0sCLSRk7/JpxKa6YzNwPyiz0yXu3oVVncpQPsYyg0ydz2l1xz
	 w42AWhL6xLTbg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/4] xprtrdma: Clean up synopsis of frwr_mr_unmap()
Date: Mon, 29 Apr 2024 11:25:40 -0400
Message-ID: <20240429152537.212958-8-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429152537.212958-6-cel@kernel.org>
References: <20240429152537.212958-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=chuck.lever@oracle.com; h=from:subject; bh=mrzVot53dktixzRfAgrCLvQUOjngZn1HCXDlSGimSQ4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7vxRhWS9cWJKwy3Nm4QTXfiKvaSXSrkDsPpo 83hTBWlFryJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+78QAKCRAzarMzb2Z/ lwarEACxMF8Ans33wi8UMWdclPVAgQqib8TPr8ILTA+W9LUHVjUY5Pq4LhdDUMKzXsFu3t29CrK Kno+wH1MkTQhFoKt9TgEfRp8Rg5lBqwu3BM+clwfaB7N3dk7EJMDrTI5uZm9Kvcf0FjtOol1Tmo bNT0yXL8oMHFsUd18ZaNRV25IPOilz+oMfAKRUhWDaN9gwbWGdUL+/sp0LqZei1by/XRAtj99dt HJuaCk12gQqGLR/Fy5yJAV/n2zjIKoF2cNeFOdjjiBcQTkIiaZ8B7uv2yn5Qrm1yOk0p472tuJL a36PcHljwEBCwi/Dx39wjzARuP699qoO3IfLt0jKeHyKz1U4PxD+j3tzXbDsLOKnzN9w0NoIitd fPfSq8qFEcScvv/RLlIEMcmTCKD7Ff9Y0mE2BeqU0QhNaYzdMIXhS6s8xWtBAlR7EdVDykRN1nI OW0ICzTMb2kGsTM0gAIaecxeq9M7bfmr8gJxbce7tdm8/mGZHcYskKf/3iw034VhSGzki2+Rf6V a/NWsOBgfNDcq2+3wDqfgZz2+Wxf7t5rCGirpLU8uc+0YK3FtEt0Y9820MWLEbdbzI50CVg6eWn pUsF907I3WvYD1RJRTNcPp4w2R14nN/mnUnxI769cloQI3ZVB9znj+5qb7aQeky3KQCbsBlk4dO Sja8gido/RYMFMQ==
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
index ffbf99894970..6e508708d06d 100644
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
2.44.0



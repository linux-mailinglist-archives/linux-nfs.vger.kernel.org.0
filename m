Return-Path: <linux-nfs+bounces-9743-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7BA21E05
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF557A31CD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95F71D90D7;
	Wed, 29 Jan 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjOHBcyj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B91D89F1;
	Wed, 29 Jan 2025 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158018; cv=none; b=OXCxmRRSYMxoqwIv5jd1mPUPn219PkTQZuaUQY2hTEB9ES74qxVHVjfiT+drhh2M8GH9NYb471tfY1lO3hDhnDqIZiuTNCocNSNrmg7FVB3XwLTnZ+ZZhKThvMYI4SDnvCIsBhHC2kHSX6J7LZXzCfYd3vupMnUuNouPsrWqOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158018; c=relaxed/simple;
	bh=oLYdEgIhLU5xlu9zPTmaGhlVwWRiDKTykVlG5qz4BvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbIEzgAD85P5TblFPDZp7AwVs7/X8RfGGCNcCBPyh2/MABdujVn4q5WKrTt5cmGXG5MxC/+NOulN0OdhPr1EHILE85Agg6I3Zszo/eFxK+g3rRr8Fi6YGEg02Soynn+yKB50hEIt5J16UmENs4fwlmyTH1+Npfj47sXjjToEb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjOHBcyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29552C4CEE5;
	Wed, 29 Jan 2025 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738158018;
	bh=oLYdEgIhLU5xlu9zPTmaGhlVwWRiDKTykVlG5qz4BvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VjOHBcyjeKuzB64dt2qKSiVUalkTQvr8Y3+kKgN0HAw+r///jns+sUO5mTkMD8Qt9
	 obm0L2yVP1i1lQB2Q7yNH7C6bmVB/zEIBehaKBVpXH/tZ6H+jlZ/amVeq1R4xgvBda
	 PPTXhYbLoihBSoCIChuGUdqYY2WpjCU5yosxPgPUM8Q3h300b123o1xXAtY+RFQ9gs
	 l2AhMtZ7cm8BKCRyPF/fhBgFhDGczIM+AhySGajJCl8RCgaWe+r+SgtIRy9OhXjGy5
	 y3B+3Mkr1VYEeDCQRy7SxKxZku0P2n22OonBtvSlgmLbIbVbJg5gaVomXnj1TXModq
	 py7V+9Ei8j2Ew==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 08:39:58 -0500
Subject: [PATCH v2 5/7] nfsd: remove unneeded forward declaration of
 nfsd4_mark_cb_fault()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v2-5-2700c92f3e44@kernel.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oLYdEgIhLU5xlu9zPTmaGhlVwWRiDKTykVlG5qz4BvQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmi+6FHOssWL+Rv+X8RIIfaNKg8kBgLqpNOb1q
 JN7dgDyzqqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5ovugAKCRAADmhBGVaC
 FfbED/99OoBzBFhx9L/A2HoP5fEO50W+/q9EeXFR1ZJZ+X1dpThGWgmKf84+ZNc12O0xPEW9YY4
 9cb0wmAjSig2tJhH7Ifqm7CxcL+F/s1TO5GHjqNgAWnkzk0SL1IFmn2jK81nlvL5iurUQlZgZau
 vwav72SAhEICZFy524OEVX3IhQ67JZzKtht+Lk6GL+7/1D8LSMv5yfua8sz8HI12BhQIXnI98Vx
 Giqu5df/LLWqOuS1LPVgsUwu9Ue7XxtN8G0E53wVEZ8pqAMYfGSKUNi2Zw65FVtNgaCRAOrC+PE
 2KBphjo9cbjh9Hi32zcZD4mVd3TC0zNUbQ1Dp83fBbPGpjI5JJ1ugYXVjbKsfFIbAN08e3Idl0S
 fLk01I5tzHqoFFJ3bHSYVpDf5lOQtVJ9eNpYw7lwWVL3rpmlq8OwR2JiAuPGzpIYtgELYJ+Jih8
 zLg7deRwP6ZyrmaZpcfyGgx7ST2zGzVFXAUQuLAwnBI/KFulju4oF2MEjhlFkEb0Y9fBAJ1VTGV
 xLyxS4mxVW2tIRwpQIEVKMI8MYcu/SylKAdQOhYwAcoGLVD5vwfKvyNK3fvA/QRE80+Z7oQXQOl
 LgYVUYA78PFjq+oACEopu/87QFqkwT4Y3pr+cy+Ul4frb6DQ6RD+t+VUlzn4ysPWTShxyEChoDB
 IkjlhTnFI9Cd5+Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This isn't needed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e70a7a03933b1f8a48d31b0ef226c3f157d14ed1..4d4e0c95a36724027a63b53487fd36260a9ab1cd 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -45,9 +45,6 @@
 #include "nfs4xdr_gen.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
-
-static void nfsd4_mark_cb_fault(struct nfs4_client *clp);
-
 #define NFSPROC4_CB_NULL 0
 #define NFSPROC4_CB_COMPOUND 1
 

-- 
2.48.1



Return-Path: <linux-nfs+bounces-1503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F39083E0DA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8B12867DB
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF37208D2;
	Fri, 26 Jan 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+A3j3s7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F72032C
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291200; cv=none; b=urXS2NZJY035mLNUMHD+MW8q9Mi56z7jUJ6njV6I5AawK1NhmA5z5/Z32KaDD/BVm7oz5MU+VjdKaM5SN+n/egTnzTnHCKuQxXQukpII8LYiAFqaGKVU80+mrjMuqb7/TtOHfpxRrc9EHGFKhETzUls/dULWjbIFKS/tiEoUAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291200; c=relaxed/simple;
	bh=1RoeyvJ3fqgbcOrczXHuZjt37m81BwC+5hWnCxC9mts=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+vW05WC47xQHEtXYye+5fsGqAoeTjonVHRZUlnSTQ/9Fa2ZuKr/h4Zu2XGQSFL1Kgtdhfn9bgoO0Yf4keeuyQgvDxB39d/6mJkLDOVYPI40a+rnlb6AJ1Yenojyr3HyJu+snYKwUNn9sL1duMQfs4d8JXtxHWQWTeqe0dnjYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+A3j3s7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3A7C433F1
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291199;
	bh=1RoeyvJ3fqgbcOrczXHuZjt37m81BwC+5hWnCxC9mts=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=k+A3j3s7dJKoTEYdCxVTtltq7oLnha3XqEkoX6IHWe5I1PoXKzGbcsZK0SYmRSO+K
	 GaGnEJA0zjmdICiTajptWcBu+KdaF3eUL44pi0RlzE6l9InBXiOBz59QsB8ePCKbI5
	 Wo9+6Rli3mp2TYCcPn5s+8NcrpYCdNdhZF6+YnYPBIAXbDK28Kb6tdKB8B+n+kM9q7
	 AbNuPBQ6VmmXXdqFmq9rOP7LKcJBVqgnU5GxvjPBtCKKVvYYxMnOSLbelkrMec7l38
	 qxIgUTt+AvK4W2yVBs1y3NgBvSx8Vy+1cwKWFN9HHIXnJPedSh9dKXImhapsA25Sk7
	 zrGkEw+A/AaOg==
Subject: [PATCH 2 14/14] NFSD: Remove redundant cb_seq_status initialization
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:46:38 -0500
Message-ID: 
 <170629119882.20612.2851346207930593641.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
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

As far as I can see, setting cb_seq_status in nfsd4_init_cb() is
superfluous because it is set again in nfsd4_cb_prepare().

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index fd6a27e20f65..32dd2fbb1f30 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1450,7 +1450,6 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_resp = cb;
 	cb->cb_ops = ops;
 	INIT_DELAYED_WORK(&cb->cb_work, nfsd4_run_cb_work);
-	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
 	cb->cb_holds_slot = false;




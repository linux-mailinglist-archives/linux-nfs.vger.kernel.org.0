Return-Path: <linux-nfs+bounces-10877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F81A70CF8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 23:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9683BB38B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DF269D1E;
	Tue, 25 Mar 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVH7pGKI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8061E1E05
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942126; cv=none; b=B8ecbA+ilfJmFbDp5oChY0/+4slhLYjisKJV575q4htWfTak4ufuXjsdEWkXcXDnCF3h+iD92vTMdqZ/PZlNvjiJfih3kQsv+MRrgfW79qvUCtwfAzFnMJ2/hMrzgMR5eqBERVdddxwE95plYz8p1cbBb5a/FqKUS64FBweo/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942126; c=relaxed/simple;
	bh=x28c1yNiQSY65vGx4rWToBi/wcjI2jTFpWStBC4tzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ4Tn+w1qcEgiWj1I6DPx7e/LtDVVCgG0CwATQ32LHpBhs8ix7NwXYKL8MYQjI+YWOAef5Gej6G4U8icDXrfjQ48l9BjVq8zgXKeWPiLdGWZ64NLiwwtQY/jubTujXSVEm13ZA17hzafnCKvI/K8hKFb3DY5Rx00y2KPUb2hrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVH7pGKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA2FC4CEE4;
	Tue, 25 Mar 2025 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942126;
	bh=x28c1yNiQSY65vGx4rWToBi/wcjI2jTFpWStBC4tzwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVH7pGKI8tAV0/sHzoD/NxAo87kUB61Ap2E4xucHKH7HDF8Ysf9cSRtyAhVJdYQWM
	 2/+GWA+WsxjewdICSZxQW1DN/hbbYOEcpTxkGIUHqohma6GEBdtUnovpHvZl5/1can
	 /PBPq6hFhWG+pBj+1DcESnrzLKl+5ru01ctofYHIUHPFX3Jh/m9XW7pS+Z7pUlqYO1
	 ACDfT6y79/vX6KQlDvpcoyfNyL/82QpTKsk3zZWsKMKhA7aZlMvOuJGlcWw2t38nn2
	 yLTsnZAbu0THIBKWotl9NHL4RU1yWlM04O4+4AZlWvU5z3nRNlqteORmbKlPnymYNl
	 UEhcq4bF3sK3Q==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 2/6] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Tue, 25 Mar 2025 18:35:19 -0400
Message-ID: <d98dbfcf9e5979e053c624acc88d73e7ed14eb05.1742941932.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The autobind setting was supposed to be determined in rpc_create(),
since commit c2866763b402 ("SUNRPC: use sockaddr + size when creating
remote transport endpoints").

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 1cfaf93ceec1..6f75862d9782 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -270,9 +270,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 	old = rcu_dereference_protected(clnt->cl_xprt,
 			lockdep_is_held(&clnt->cl_lock));
 
-	if (!xprt_bound(xprt))
-		clnt->cl_autobind = 1;
-
 	clnt->cl_timeout = timeout;
 	rcu_assign_pointer(clnt->cl_xprt, xprt);
 	spin_unlock(&clnt->cl_lock);
-- 
2.49.0



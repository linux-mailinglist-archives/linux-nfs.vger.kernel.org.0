Return-Path: <linux-nfs+bounces-10848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB115A7069F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 17:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE85A177826
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E057A25D523;
	Tue, 25 Mar 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKetCrdF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F51B392B
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919467; cv=none; b=qqCGPEUROdEWgp4vTbUC9p9ETJJUwPeM3h/z0PRqU8BHgxJC4c8TJBRQsLWpx3/rMHv80gvqzVta9+1VIfAueqjWBN+JpIyfceUJIXYh8xGTh4Q9JZYIxg75q9mQMXB5fL8RpG5GeauNZaxwMYyi3ARtspHOTvBptAzy0SbGAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919467; c=relaxed/simple;
	bh=0ipIHTqNE2uLpOqI2MNF1UddfnP4/ALLJpwTJxM299s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzbBXcQatE6t+l1CotVg0B5HQJc9MosiL15PtuGfNaU6+tHOLo30Y3PYIyC+XXk+IksjOoh9KbiH94u8JYd7CV7emZ6LEhqz4OPLaocfPaa+8EDuktK8WL6HIvwOM7kg53x78Sy8YxK0vOv8JWJa6L6HsMcc6ykozd9VF4JVPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKetCrdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B02BC4CEE4;
	Tue, 25 Mar 2025 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919466;
	bh=0ipIHTqNE2uLpOqI2MNF1UddfnP4/ALLJpwTJxM299s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKetCrdFCS+MIX5jkgRyepUd2CoO78BGR2SuNFZABuxnVFc2OkXUyk8TGzVBBKdWo
	 nlbr0iR+BRMUgxvXT6aE6/VVSLBGwh5gF7B3ZdjkNNOBLmnMDZcY1adCkaNAnWsVVH
	 R0U72mGPLbDN5uDk/z2akzbVbQ6HIc4Vw1PIUbg0j0WNV4MEMkI7WZaUL8Xz+3tK7c
	 3iCEh8qsAwlk4t41N9Gzo9JyF8MPR2T1KvgVC7iGWbtoWOEvulmDZjLvFXh00zTkPT
	 Y4Zi/oh8dTYNGCnsZKKvcrClfGLmgx3l4Y8D6Y0FM/+kaNQteJ91+Br/bXvjSZyp4N
	 47MnCqz1+MSHg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/4] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Tue, 25 Mar 2025 12:17:42 -0400
Message-ID: <f6c87857690a66e7f1ee684c755f6c97d8913d64.1742919341.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742919341.git.trond.myklebust@hammerspace.com>
References: <cover.1742919341.git.trond.myklebust@hammerspace.com>
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



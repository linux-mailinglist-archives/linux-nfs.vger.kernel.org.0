Return-Path: <linux-nfs+bounces-10788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4503A6E7BF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 01:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F903B8683
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E491862;
	Tue, 25 Mar 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deiL/14r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DAF1494CC
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863602; cv=none; b=QdIUd1CRTppDd3vqWH4UoPvndaYkQJyS85I1jTP/gPpWFXob6iXAdWx6r5oNUMmzbCz08r0PzQfXu8lWaWnU67RP5ouw2hL/DWe3xWlhOIIyvtfFHaeKDhU6WCg0ffjuKovODn6cL06rFM2J9gQaPloh1c1WLxILUFmRcFNuTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863602; c=relaxed/simple;
	bh=0ipIHTqNE2uLpOqI2MNF1UddfnP4/ALLJpwTJxM299s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNd/n7li8nxuXbj3h0iGKqLsLFtlIa8hMNOjQS6lzyElZyGmFkrMXqIQMdPetET6yqQ5Ehun8HsfVF8ZF5WGkrcYu9Ov+AlgZI2pD+a/0x1OnKVHEaMOZ3v1J/8bxSVR0z5g6KFGPytxVmA6ruYHv9QT8Cc+em58dZ3scvQLQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deiL/14r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077ADC4CEDD;
	Tue, 25 Mar 2025 00:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863602;
	bh=0ipIHTqNE2uLpOqI2MNF1UddfnP4/ALLJpwTJxM299s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deiL/14rDPdGx3nLiSmpG/rp8TCtNv66vo75jpkpHlf4L64ffUI7QUg/BBxP6Bywe
	 uMZt1jaPkAeCH+SOnEwyZekMuyki5Kd0FeRUC4EO773S/7XhMLtYXpDHigYnqbTrWM
	 uBiND7Rm2SrELPS1O9VTnvZKe6WLplWrWleDPmGankiclemCUEBYQMxgTKLsryxwDp
	 sLFA0OZrv92LY+qDJTGq8k4DTUSflNBBMYGlsm/cI8a7D9VJdlypoSxTh5Hsesw8K7
	 tEqCgKsPURY4N55EM90aOlj1kcheVQCLv8HJB7Uw9D+E3ncByCtEV77ugIS4OdMuKn
	 YKmQ21jiqAkhw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/4] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
Date: Mon, 24 Mar 2025 20:46:37 -0400
Message-ID: <f6c87857690a66e7f1ee684c755f6c97d8913d64.1742863168.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742863168.git.trond.myklebust@hammerspace.com>
References: <cover.1742863168.git.trond.myklebust@hammerspace.com>
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



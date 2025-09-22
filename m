Return-Path: <linux-nfs+bounces-14622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EFCB93628
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 23:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BF03AD6F7
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7592253F39;
	Mon, 22 Sep 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj2dU2px"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A339A23C516
	for <linux-nfs@vger.kernel.org>; Mon, 22 Sep 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577010; cv=none; b=Vglh9k8UH2700M9aawTCxo6pqdIIzWWalm38I4tG0+R5uirgY6Sa8zBCtL9anBjFbgQyl0P701z1GEcKbZqL/QFQW0xc+O8Kmzd5ev2VKinr66tUsu2RM4G+s13R57u6sgeuUfKyiG8d11nnrwpsHG33WgEI7jr3wONq+j5T6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577010; c=relaxed/simple;
	bh=j3jbpm7SRQZXUMpnk+T6Uo4R+W8/FnZusdet2oAFS70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEIGSVc4ZeTuKBsScMA7V202oaGvZYADWzkh0wAuZovZUWvdYjpHPavDfCMT2Tw6P/Z3wf1Bc9m78K3OCsishi7Rm59OrDBV0BUEkPcSFF0cX6mOMuFuipFqFMTuXTXiWcg40h8YT0+fhNwYOYNtJgsn0X04hYtxZNM1xFPPprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj2dU2px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25A6C4CEF0;
	Mon, 22 Sep 2025 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758577010;
	bh=j3jbpm7SRQZXUMpnk+T6Uo4R+W8/FnZusdet2oAFS70=;
	h=From:To:Cc:Subject:Date:From;
	b=sj2dU2px5hb/840TV0vtM7zdSOZ48XH8KDorA8HlWdgpjLed2IbDP+4/fViLZxFou
	 DDhd7PYksrQxW1sXFs0mROLrQsKpnifnotWvOXSFozqByhXohM1/nXCsE54mIfBeuI
	 jqNT80dDNUO2DhjXqKzI/n5N3yTeoVBrykdb7CbPtz+dQ626iXpUv+Yj3TwK1s68tf
	 K1eueTZNb8mkLoZEMKdaXxzZQxFNE2ZxILITHeE2oDxgiPqeYYb9K4YAG2pTcsiF+o
	 FMYSmKRBB12eGXLmGYFMT4ObncDbO26pMUU0pJJFM9ofR2gv+ocXsftSLAVhf31f9s
	 wM/CaP0bYu8eg==
From: Jeff Layton <jlayton@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] sunrpc: unexport rpc_malloc() and rpc_free()
Date: Mon, 22 Sep 2025 17:36:48 -0400
Message-ID: <20250922213648.693728-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are not used outside of sunrpc code.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 9b45fbdc90ca..016f16ca5779 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1074,7 +1074,6 @@ int rpc_malloc(struct rpc_task *task)
 	rqst->rq_rbuffer = (char *)rqst->rq_buffer + rqst->rq_callsize;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rpc_malloc);
 
 /**
  * rpc_free - free RPC buffer resources allocated via rpc_malloc
@@ -1095,7 +1094,6 @@ void rpc_free(struct rpc_task *task)
 	else
 		kfree(buf);
 }
-EXPORT_SYMBOL_GPL(rpc_free);
 
 /*
  * Creation and deletion of RPC task structures
-- 
2.51.0



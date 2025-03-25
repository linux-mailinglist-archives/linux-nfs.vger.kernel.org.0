Return-Path: <linux-nfs+bounces-10787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC435A6E7BA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 01:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716351893E95
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 00:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15713D503;
	Tue, 25 Mar 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkOE5BBo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42F1862
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863601; cv=none; b=u27+e5Vx+cx7NilWYtt/yZut3L2nb5kar2cnT7cMo7Y/DtfL3P+PlBccWrqUScoLY22FgADvEbvIXLRU1PnzlK+S9OrJeyMxhqKSlQtB/nLoQeNenynAfV3SkAnaKvkbXXVMhjCoPt9hjnsVByBw6F/hLZNDqFf4SzH9VO9aC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863601; c=relaxed/simple;
	bh=JK17KLGNOaSpdNMeCJAqxBTwpxTcr1VYwFmTm1hLze8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCJQvMDUKsPHFYG9l9yuTzMqefYD5+PMCIJOCI0w5O+4mjZpeFOjzvMRw6wPeAcuWEJF/68ntX0uu+IoztNxsONNighyLtqTz6K2wI2X2BAAajaZT826BSe4XRJm2Z66j4uYMmqpugfmX3PuULcAItwsdx7BsLbflhG4GVPTdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkOE5BBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83583C4CEE9;
	Tue, 25 Mar 2025 00:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863601;
	bh=JK17KLGNOaSpdNMeCJAqxBTwpxTcr1VYwFmTm1hLze8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkOE5BBoYCXHtvLZrHtsv3Y3e+g2vz0jZRoZYxL5QRSV4b4xQlVkVkrEt899ZLuhT
	 Yo3I20DClphWpMQo9KA/i4OF+2AJdqJw20xIHoR+6JJQrtxO2V7Cdk8oy8kyuCFR0b
	 hmax4RwW1giQb2wBim3PB3059W2EYJ7HTId/ayGgqhBduFKg0NYyV8IfEFRiOTFv6g
	 Yxt7B9TYxgHyvqF0/KRvFfASigFq/Px/9GkqpnurYPCofxO7GOoZzdVJhGSc+Fhsr7
	 Tl07QHZdvMZQZgdnTpxf5XDXJNQRdDWri1VXSSvEK8GwSaHtDfoVElHjOwUVNK6ZpH
	 UCyLXkV47r1Jg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/4] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Mon, 24 Mar 2025 20:46:36 -0400
Message-ID: <8b9a709ef321aa246b9ef00a8bcfa71a77df4245.1742863168.git.trond.myklebust@hammerspace.com>
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

If we already had a valid port number for the RPC service, then we
should not allow the rpcbind client to set it to the invalid value '0'.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/rpcb_clnt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 102c3818bc54..53bcca365fb1 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -820,9 +820,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
 	}
 
 	trace_rpcb_setport(child, map->r_status, map->r_port);
-	xprt->ops->set_port(xprt, map->r_port);
-	if (map->r_port)
+	if (map->r_port) {
+		xprt->ops->set_port(xprt, map->r_port);
 		xprt_set_bound(xprt);
+	}
 }
 
 /*
-- 
2.49.0



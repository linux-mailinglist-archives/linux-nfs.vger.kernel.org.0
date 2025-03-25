Return-Path: <linux-nfs+bounces-10846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4C6A7069B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 17:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD39A1776DC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75025D52E;
	Tue, 25 Mar 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0jZYoCI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D925D523
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919466; cv=none; b=p8sACDLG+bRUYlk9iUMTope6PxtNWMTKjfMCsjlWRTFddCwI9SRz0ZcvOv3fBW5JVKx+NLIzbrKrL+r/gZNOvQ9Kdg9W42rxQ6qwPGgKVno453Jp//N7Fs+XG/Nov+4WnJ55D+dghAZ9sP9JsfZrB0kLhFDl8lXec/2AIusWy/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919466; c=relaxed/simple;
	bh=JK17KLGNOaSpdNMeCJAqxBTwpxTcr1VYwFmTm1hLze8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJFSpxlvsR96IoF4EtCzPE8fq4jIoVKJDuwJPdXJq41PyOy8IevvLiFe1rD4uf1eGOPMv5gbPcftbAVu5Y82r4SKREeJWnBJmnx638qTGxCwg6mSub4IoT1eaSKhW1MJ7me616UuFp+YG/Dxt/L6AYLcVT5PY8OG+yIzkW45S8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0jZYoCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E567FC4CEF2;
	Tue, 25 Mar 2025 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919466;
	bh=JK17KLGNOaSpdNMeCJAqxBTwpxTcr1VYwFmTm1hLze8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0jZYoCI7MZQQ0VKX2ADtJQ3DduHsgHwoWSbdJD4IgGPPtldWCEF+bU3GDe9GKQo9
	 vw5UF1NTJ6HFCGcRe1T5LZb4fB/6ddT4gdCue3GqJ4hLf+eegLYNOVus5CRKm8YvC9
	 0VVRN2kNpsaIq6LRiarQIQ7S334RnoM+f21j1WdQoID0y8V8LhV0tifAlYxZ+gX87T
	 Tlv/TqIUQZsATOfTGY9bMv798uxN9Fxv0YHbEoRPqxH2q82hURwnsJlcwvpDwIA635
	 IDJrVW+M9IXW/0iQZhQKzGQPE2PY9qXp3T+FxxKRHl4fQgL53GoLsdBamF+FXGSnHH
	 PCpET/tPijv4Q==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/4] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Tue, 25 Mar 2025 12:17:41 -0400
Message-ID: <8b9a709ef321aa246b9ef00a8bcfa71a77df4245.1742919341.git.trond.myklebust@hammerspace.com>
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



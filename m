Return-Path: <linux-nfs+bounces-10876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C355DA70CF7
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 23:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B5E3BB3B7
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415F269CE5;
	Tue, 25 Mar 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzUR1U+R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC81E1E05
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942126; cv=none; b=Hcb+/ValJDcZ0WetMFfzImJzO/2FHiM1ZDvHb3pGMka4u7IJ6V0sIdlGblj7SvcaLO9jpFt6eI3m0dDSTVS30QEDbW5vLYZuHEUOvSAeNNQhU+jybOsbzsaIX0uPjqOeSAAxmNdWg7wk7eg/ggVEiVFVJ8sUCtUhnqb5Cv/ONKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942126; c=relaxed/simple;
	bh=CjAnADVijneURKzvaV/8cqXD7scFAqxWZDcIdaeMq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXQd58Ak6tVSu03tkHZOrlMD0lUlckM+BP9s6hOpuaXCTrJhuu5x74UO3eczg+e+4WKdx0sB2C5mQ5C/3uibzLNs3jPgRqLmX/+anSqQQNujUS6xFI04xD2tJIn/zgq+SyDSn3uNWgWRpB28/g7ww30S2NQLZqFHsoHjAelUwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzUR1U+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DDBC4CEE9;
	Tue, 25 Mar 2025 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942125;
	bh=CjAnADVijneURKzvaV/8cqXD7scFAqxWZDcIdaeMq8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzUR1U+RiPmIY8I8eSj81cdyrZZBn9DqMPDtHROoFVPzleGT9BIwrE5s1kSBRiQ9L
	 gjY2jJcHfhslFca8eRCwGTScZ/pXSiO6pOSIm4aKj90hRvACsDCLEsvtm+JVd9PsQg
	 erSTNcxecLv4/LyDNlUYrOzo6nHJpwnG1D4Ksmw6Pa00eo3l87hO7q/wMor+c0CZDw
	 8f9taE0PJbGvwQTa9vBZdkF9a9vPCMAhwBshyjyt3YFMqrX+xd73ooJGC6o6dMzgxa
	 k93b2aiv9tJnCiZu5sVVWBv9ZoN2jeM5TS0EIZ7A4iQU09+W44qZx45BOetiL+bMM3
	 xo5zJqvu8q1RQ==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 1/6] SUNRPC: rpcbind should never reset the port to the value '0'
Date: Tue, 25 Mar 2025 18:35:18 -0400
Message-ID: <b8af12ef4fb9b3f0a3b22b23d13c573df3367ee8.1742941932.git.trond.myklebust@hammerspace.com>
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

If we already had a valid port number for the RPC service, then we
should not allow the rpcbind client to set it to the invalid value '0'.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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



Return-Path: <linux-nfs+bounces-11855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA0ABFDF7
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDBE1BC48B0
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6B29CB48;
	Wed, 21 May 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWL6uu9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A729CB22;
	Wed, 21 May 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859660; cv=none; b=CfY2lHdUeiF4pc++ggS04CtPYgfVG99+ne/xyMwgIBudxRbCT8xoVoeip4cCmFnUzkvmP6WppLh4TOvAY9GluI/rVgYiPsq8KD8RXssm5JMGzqiuF1d470d1RMromBR7ggEaNLmDJOHEmSsKqglz08t3HEoTOLoa4jGBq+t1TYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859660; c=relaxed/simple;
	bh=FsxRKZR9wtUvA4RFFJDnIa/Gb2GgcAEMh5iudYXL7LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1T3Q5MUC77uCZtJMbYmKkdiNohFl+82DtdCAekTBxL55Dsh2YuYD10oydJyLFwhFhTxwnDkY6T+KbOUoWyEfCIeOfQ2N+6ijM0mjiCe9jhSPqrVep2DZKzValrp59zgugQ1rFtbMFDO0JZ9VrUtnbD+/c+MnPEwtuJnYtnVnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWL6uu9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AEDC4CEEB;
	Wed, 21 May 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747859659;
	bh=FsxRKZR9wtUvA4RFFJDnIa/Gb2GgcAEMh5iudYXL7LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWL6uu9utoctMOrAgiv2dZan8SKeqISndaBfsGWoTw4lIPULItKgyKU5OAw7LHyR9
	 N7FyKGDovdrOebsGRnYs3DP/VSKivfNKdpIrRY73AHbBDkv8JGRUkt3pZWKK4KOQQJ
	 wTeaP6CGwVA+DpoTlCdf0ItXMcI5BtTJDdaDne5egxzVqd2S+nsk3u+XDScXNd5Jvv
	 gT6PkWgmzYMqF/yOjm2CZ/E86BQq8YjlBDQ25r1oTr2nhx+8TzDphqJJIl41ob6Fj+
	 iZPDYDajhMp2KWTGYdvXcP0noi3o1fthjnAPtwoJ6AtusFnEsNePtXCxSmdAOQeQUu
	 rA+f0EuF6ZDIA==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Thomas Haynes <loghyr@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/2] SUNRPC: Remove dead code from xs_tcp_tls_setup_socket()
Date: Wed, 21 May 2025 16:34:14 -0400
Message-ID: <20250521203414.889931-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521203414.889931-1-cel@kernel.org>
References: <20250521203414.889931-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

xs_tcp_tls_finish_connecting() already marks the upper xprt
connected, so the same code in xs_tcp_tls_setup_socket() is
never executed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtsock.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 4b10ecf4c265..04ff66758fc3 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2726,18 +2726,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	if (status)
 		goto out_close;
 	xprt_release_write(lower_xprt, NULL);
-
 	trace_rpc_socket_connect(upper_xprt, upper_transport->sock, 0);
-	if (!xprt_test_and_set_connected(upper_xprt)) {
-		upper_xprt->connect_cookie++;
-		clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
-		xprt_clear_connecting(upper_xprt);
-
-		upper_xprt->stat.connect_count++;
-		upper_xprt->stat.connect_time += (long)jiffies -
-					   upper_xprt->stat.connect_start;
-		xs_run_error_worker(upper_transport, XPRT_SOCK_WAKE_PENDING);
-	}
 	rpc_shutdown_client(lower_clnt);
 
 	/* Check for ingress data that arrived before the socket's
-- 
2.49.0



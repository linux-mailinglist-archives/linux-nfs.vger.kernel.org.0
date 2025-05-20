Return-Path: <linux-nfs+bounces-11840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF1ABE435
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894671BC294B
	for <lists+linux-nfs@lfdr.de>; Tue, 20 May 2025 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8F275117;
	Tue, 20 May 2025 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU0hAitR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E921E50B;
	Tue, 20 May 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771168; cv=none; b=NkaWLC74Rq0EUpK3SFuMT4dJoKHhgaQhqL4hKCHIgs1Eyf0D+/IIpTOv1O9QwTWy29qHrBAl4BGw4I+lwfZY5jriZq53XcwutfhqnfliMbGa4pf00cD1nwmzr3KnKbkj9OWIQMUAYl78wfOBMK34cQ9ZWZZvRDdz8Ia9I+1nLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771168; c=relaxed/simple;
	bh=BOjCEaI2KG1IOPms1pqfpwuRt+5XIWMOyD/QM0CsCU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=th6km9ioR3s83oX6RR0NB7qsFwnmSkqVkT8Oum4AhmHE9ZO0t8yBWwDbxiQ6tgZQbw0Yfa8a6EnLAW6/gVUwkL9JhKOyAEJgIvQp+pta2PnAfQRxVziZoP2pbKX5MEg74qke9qaXTaWAxg7BkkwLzjQtnfmoorqSfzjW56d3vdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU0hAitR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF557C4CEE9;
	Tue, 20 May 2025 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747771167;
	bh=BOjCEaI2KG1IOPms1pqfpwuRt+5XIWMOyD/QM0CsCU0=;
	h=From:To:Cc:Subject:Date:From;
	b=WU0hAitREkJOX/9Ds3MCYYkvfOMwui/VgK+/GC8n5t4AhPOWwK55QRjcb2LTtnpu4
	 DTDUsHT/zEq38qK9NdLOMhPkYHDjigQHEOrXxxH8gVGpUWI5oQzPmN9t9Wgs1+87eC
	 Z3oCLD2M7mHy0v4vepj7yglBaHu8daAHujLh4Cukpq9X+iZLznGEQqPz49nLQytZpH
	 UgfKZtLk+k/NROiBEPJitShew3t7Ml6WKH8/6BAcd+eyaLl8k5z2vcIYLMJ4JSMUSJ
	 xc9hGYTWLrhPz2h7r81mH75uByVz2Fm6fBjiLdzLyWTVr1q/PbWBTKEUhigzqoIfKM
	 0LmuYG0y2g2Dg==
From: cel@kernel.org
To: Mike Snitzer <snitzer@kernel.org>
Cc: Thomas Haynes <loghyr@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve Sears <sjs@hammerspace.com>,
	Jakub Kacinski <kuba@kernel.org>
Subject: [PATCH v1] SUNRPC: Prevent hang on NFS mount with xprtsec=[m]tls
Date: Tue, 20 May 2025 15:59:16 -0400
Message-ID: <20250520195916.676511-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Engineers at Hammerspace noticed that sometimes mounting with
"xprtsec=tls" hangs for a minute or so, and then times out, even
when the NFS server is reachable and responsive.

kTLS shuts off data_ready callbacks if strp->msg_ready is set to
mitigate data_ready callbacks when a full TLS record is not yet
ready to be read from the socket.

Normally msg_ready is clear when the first TLS record arrives on
a socket. However, I observed that sometimes tls_setsockopt() sets
strp->msg_ready, and that prevents forward progress because
tls_data_ready() becomes a no-op.

Moreover, Jakub says: "If there's a full record queued at the time
when [tlshd] passes the socket back to the kernel, it's up to the
reader to read the already queued data out." So SunRPC cannot
expect a data_ready call when ingress data is already waiting.

Add an explicit poll after SunRPC's upper transport is set up to
pick up any data that arrived after the TLS handshake but before
transport set-up is complete.

Reported-by: Steve Sears <sjs@hammerspace.com>
Suggested-by: Jakub Kacinski <kuba@kernel.org>
Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtsock.c | 5 +++++
 1 file changed, 5 insertions(+)

Mike, can you try this out?

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 83cc095846d3..4b10ecf4c265 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2740,6 +2740,11 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	}
 	rpc_shutdown_client(lower_clnt);
 
+	/* Check for ingress data that arrived before the socket's
+	 * ->data_ready callback was set up.
+	 */
+	xs_poll_check_readable(upper_transport);
+
 out_unlock:
 	current_restore_flags(pflags, PF_MEMALLOC);
 	upper_transport->clnt = NULL;
-- 
2.49.0



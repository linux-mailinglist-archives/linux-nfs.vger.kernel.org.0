Return-Path: <linux-nfs+bounces-11854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F2FABFDF4
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FA83B2D47
	for <lists+linux-nfs@lfdr.de>; Wed, 21 May 2025 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF329CB30;
	Wed, 21 May 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbGpfakl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093029CB22;
	Wed, 21 May 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859659; cv=none; b=iiiEoZpx0gyvNAPj2YmRRQb+wG9rHXTe7QdKYCMhslH/iQDtRVnaCYDT14zjaqNUcNrtBWcBJchSwnIw50t4p4L/4CK/Luw6Nt8qpzAVpi/9ouicCsSxwybcCV5hm34Y8alsCSb3+CpQj+7oxkmZihFDXARi7XH/CJxLyS7txQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859659; c=relaxed/simple;
	bh=pj5MivjQpt8mk7u2kq1yjTeIGapv+WamWWARGOaF4fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe7it2zhd88uC4gsRT27rJ5B17YNFCg6QOQgo/gvgBQ01D9T1jb++b7Usc16/wOF1C6O7ZRTMtK/RkIpnWA3XXyEhE/7sIqKWVVql91JzUbIIGT/T3icOcWjn65skc7rVLLw2ySw5lEUzGjUlpqQe3p6n9XnB2LkElZn1zUIlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbGpfakl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A6CC4CEEA;
	Wed, 21 May 2025 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747859658;
	bh=pj5MivjQpt8mk7u2kq1yjTeIGapv+WamWWARGOaF4fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbGpfaklQ9XsjKOD+SXusKYqPUFqmVqjyfwzVeh2EOInXImvwiYGrm/ugKJoJwuTP
	 3cN1Yof+mP+/px955QU8gkodiIkhT4Zf9bcnngf4BpNcChARH+4gpGRtWS+NjmB4HS
	 5anFCwfrCc0yQLp2pLahly3Th2kXGK4xnJdQ8PliSGKwM2WtPp6xQEgUV0vJS5Flmu
	 LFfvDCy+H0Ze5d67GIzzYPQn6oDhDQ0Fi4u5+MC7tdWo8Dv2WmIMz1WfEErASx3mNI
	 w2l0i8AYrQ3SGYwGjpUqFMN/csi/kZCPdQ2dAqlEkA38s1zo/LhzqF26Av0nLBZK3H
	 uUWsoEPUiukUA==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Thomas Haynes <loghyr@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve Sears <sjs@hammerspace.com>,
	Jakub Kacinski <kuba@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] SUNRPC: Prevent hang on NFS mount with xprtsec=[m]tls
Date: Wed, 21 May 2025 16:34:13 -0400
Message-ID: <20250521203414.889931-2-cel@kernel.org>
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
Tested-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtsock.c | 5 +++++
 1 file changed, 5 insertions(+)

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



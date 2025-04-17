Return-Path: <linux-nfs+bounces-11163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC66A92B2B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 20:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F133A084A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC1257428;
	Thu, 17 Apr 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaBbzMx7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079025525C;
	Thu, 17 Apr 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916083; cv=none; b=cKHwn5BiQC0fEzKylvNeEtNzbNHTf+H5fbXJheyZCkoNyEUG+4LG98T7fC2kvZZ57Ui4pTmgS29/V3VrfW5qLuhZFOLs3rDsw5qLK3irMfBroOM7WjhYPCaT+HcDevMBi4yFlk3m5+qOUEMtYJVmAiZ2Hg1gAvabXsDyCa2wMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916083; c=relaxed/simple;
	bh=AijTzh06cU5c+nk761J4Px/pUYybx8GA+cT1GpZPBSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T11enXOoelEIDYrN1oRpPk0C1aqJp1N8CY9PJN34FDxR3GP/TgtiIyaqFYk1LIz5T1JwJ0UlXdcdBU2eX7rcyeUn/jN+3e/EJew0yfA5aqCD0B1OU8TPvypi4mVcSf8QfzgAqcalOEbB+OUT7dXwInbCUaqwJMJg8WZr42Tzpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaBbzMx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0024EC4CEE4;
	Thu, 17 Apr 2025 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744916083;
	bh=AijTzh06cU5c+nk761J4Px/pUYybx8GA+cT1GpZPBSY=;
	h=From:Date:Subject:To:Cc:From;
	b=OaBbzMx7wr81S6nw8TMu6DA1xBqopq7Lu5bV7a8NXQod/mV+y6D85/CZi0bKTAPrF
	 9WKe0NN9F8wIXRO9ssu2MMRJt/lVPeiE8i9q8j2EQ/3kT+vbMxf8YqcZIKc6kIKSDQ
	 EC9+V6jUkruJh0bv/HkxAlbkHjztGgD1Fs0kMSNiEV04qplyRXQSags/buTYAj0gsf
	 KxuzNNkZcyaGJUgj0wnfdgTxULKG5+m87I8WFbMuStCTlmHJ9Hf7csHv/aTKeJQG20
	 L3MYUi+cl8u4KpPX1l7nW8G+Fhxd17DYYVK3oef/7YArGd154ViezQzDlVOSQz5Pgy
	 OEzrJumXrvDHg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 14:54:36 -0400
Subject: [PATCH] sunrpc: allow SOMAXCONN backlogged TCP connections
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-svc-somaxconn-v1-1-ff5955cc9f45@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGtOAWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Nz3eKyZN3i/NzEiuT8vDzdJDMTQ+NkwxRjy6Q0JaCegqLUtMwKsHn
 RsbW1ALHXlXRfAAAA
X-Change-ID: 20250417-svc-somaxconn-b6413c1d39bf
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AijTzh06cU5c+nk761J4Px/pUYybx8GA+cT1GpZPBSY=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGgBTnHIABBSAm5rypWb7aJhn01WHwwYfkoPVdlpZqGzgxyTt
 okCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJoAU5xAAoJEAAOaEEZVoIVSuwQANLh
 5/I0T3sPM2G8QDNJ5UgxpbEDCcugS15Jhid359XLFBGP/3zBXnK4cfGyGMag/v9W+IMLS5VLJIR
 Jz+npdjxA4Q6Q3qqKwto7btN/TGgFhf3sXtMqdVcCNNjSWuByrk4E+kXuFA60segh4TzvoMydLK
 XgG4jlgQW2kpM/NSewn0WQ3F8yEizV3fQe1ijz/uT5FPZKNwMpMTgz3b+GiyU1wEYgS6qUHtq/e
 obrsLtCarLsQEKWSZKBRESdWAQOwMYMm/1s+J7ZNgkbC98WmwOQbkWB4jSa6mVu2DkYBa3EcCBc
 2sy/lxcisIKMMbic0jW+AHJCB5bVSUurQyJ4af7AawiLUDho1tlcqGAI4iHTAw26xFh6EoZ3c0P
 O1z4UXQihqDU7u2kjxJmmS0DIjWp9y8iVRBxcCdsq/vtH8Fe6AbeardInTVyScRJwlTO++3zDPJ
 tONtZDeZFP9ARVJtY+QNgH3Pqr85ny2tRj7oXjS+95u9L1spK5ejDqakA9PJG+zjiFPs3x0O1bU
 zIIbXaEn9r53ujnTf4MddblFib2YeQEohJBe4Xct7+2aBtCPEbbjVo7oVf22T0ZpxLKhd8x27L2
 tJqLylYdibfraQ8Xr5McsSzQh+4QUsp/n93BZ4NoGylx4N+LC7cQVr3ym2TuqQvEF00eSpFJ/fX
 VL3Y+
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The connection backlog passed to listen() denotes the number of
connections that are fully established, but that have not yet been
accept()ed. If the amount goes above that level, new connection requests
will be dropped on the floor until the value goes down. If all the knfsd
threads are bogged down in (e.g.) disk I/O, new connection attempts can
stall because of this.

For the same rationale that Trond points out in the userland patch [1],
ensure that svc_xprt sockets created by the kernel allow SOMAXCONN
(4096) backlogged connections instead of the 64 that they do today.

[1]: https://lore.kernel.org/linux-nfs/20240308180223.2965601-1-trond.myklebust@hammerspace.com/

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
The backlog was set at 5 in v2.4.0. Neil changed it to 64 in 2002, and
it's been set to that ever since.

This is particularly needed for servers that are started via the netlink
interface, so we don't regress the behavior that Trond's patch fixed
with the sockfd-passing interface.
---
 net/sunrpc/svcsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 72e5a01df3d352582a5c25e0b8081a041e3792ee..60f2883268faf15b8e01a5d12d67a5d01b278a5e 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1542,7 +1542,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 
 	if (protocol == IPPROTO_TCP) {
 		sk_net_refcnt_upgrade(sock->sk);
-		if ((error = kernel_listen(sock, 64)) < 0)
+		if ((error = kernel_listen(sock, SOMAXCONN)) < 0)
 			goto bummer;
 	}
 

---
base-commit: 01bc8a703933a0b7b76e6d6fbc58e4f1d5b64ae5
change-id: 20250417-svc-somaxconn-b6413c1d39bf

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



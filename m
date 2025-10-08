Return-Path: <linux-nfs+bounces-15056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB3BC5CEB
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C8E6350AB8
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3C2FB080;
	Wed,  8 Oct 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p10C1MX0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CD2FAC17
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938001; cv=none; b=YB+Vuf0pQB9KBpmqXYdx3YkxpvrXcjzYCd65ZO/YNC/GVYTu7fsJTUXq5XlElim3EfwkXEe9itUTSll/g5CrOLDAYI/z5sz9BwjbKSYa8GJGuwtPxVBxAzcRgwaxRr+YLSX2kzFbmzzvTL+p/s4nLdHUTl1bzu9KvktmFFsy5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938001; c=relaxed/simple;
	bh=6dRVp4JdwcnMhm0vayc9wM1LE65eHaZaON33SRXK/0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeWAjbr1GynB6vZO+DCqEeCXWruTfyCyJPozsS2IGAkpmcAJwzJEXJHoRijoRxM6wsddWM8KoZlSltJyrFqlC4ylZN56NMh18fBT8YXzKOqyylOveqPel4enmCL4ALU7vPPbrdAVWeiSZjhSXmoiLjg2r09P8ilng0H0XpHsxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p10C1MX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86951C4CEF4;
	Wed,  8 Oct 2025 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759938000;
	bh=6dRVp4JdwcnMhm0vayc9wM1LE65eHaZaON33SRXK/0o=;
	h=From:To:Cc:Subject:Date:From;
	b=p10C1MX0PQ322wmQ1iGt5YvgrCILt1mK/9fhO3cchLJddtr3McS9IcoDM71myuFNR
	 LPYUjhE26kVGCEhkRx5crzx2EEcmkuq9kyvp08ceDGNvDU19MNh8nOh9EZI1tW4Lq2
	 UdLmXf3qQMIdqoLtUXTKE2Z36wCLbc1yFnaaYgx6fUHI6iBmrLFAvuShTEEK8PND4J
	 Vvaj1B7kmemuoZv71uY4E6L8nn5uQb3zWW6WH6g9jOK2hB0kx2t3DTQkxchZdO1sRE
	 1Bh4Sg/nh98VJg0+1wPiJZP9+t2bg/0P2zIdzfIE71QGoxbcoZbk1ZjFx/wvFo0eIE
	 3dBNaCgb4Fs5A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] SUNRPC: Improve "fragment too large" warning
Date: Wed,  8 Oct 2025 11:39:56 -0400
Message-ID: <20251008153956.1648-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Including the client IP address that generated the overrun traffic
seems like it would be helpful. The message now reads:

  kernel: svc: nfsd oversized RPC fragment (1064958 octets) from 100.64.0.11:45866

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7b90abc5cf0e..0cb9c4d45745 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1062,9 +1062,10 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 	return svc_sock_reclen(svsk);
 
 err_too_large:
-	net_notice_ratelimited("svc: %s %s RPC fragment too large: %d\n",
-			       __func__, svsk->sk_xprt.xpt_server->sv_name,
-			       svc_sock_reclen(svsk));
+	net_notice_ratelimited("svc: %s oversized RPC fragment (%u octets) from %pISpc\n",
+			       svsk->sk_xprt.xpt_server->sv_name,
+			       svc_sock_reclen(svsk),
+			       (struct sockaddr *)&svsk->sk_xprt.xpt_remote);
 	svc_xprt_deferred_close(&svsk->sk_xprt);
 err_short:
 	return -EAGAIN;
-- 
2.51.0



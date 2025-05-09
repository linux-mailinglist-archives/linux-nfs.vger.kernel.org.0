Return-Path: <linux-nfs+bounces-11634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4993AB1D0C
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C3EA00C44
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F050244687;
	Fri,  9 May 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSybbZIm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC32417C4;
	Fri,  9 May 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817447; cv=none; b=ERlQ2FldD0os9HnhytjCUMRsWPI0wGMgdBgrTbwfquBriej8Nl43vc9kxdX/lJZ5HPR69/GZVS6yzCVqrrGSd18mgTe/eDwu5YgVlPI2kngH+vaN28As9VIgvqILGXdsEo9orZbH+NhRkBSj8GCzIJ4JF1YdwAaNqQesKOPC7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817447; c=relaxed/simple;
	bh=h92wsAJki04nn/PE5Coo6w+s/iTlSm0zkd+N50vND9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qktrgvpK0Ntoo4ULs6B15wgNOYKLvvIbTo0fQIDk1yd7UI1v7HVPJbzxZFPc4BfWs0TGpeATLzJyxOKSzDTbLwsh0LTAmoCiGyhVFVzpYGtSnXEqBNyHit/0Ssp3Acea7W5LS4eIRYHshD4CdLr3J3SLG5pnEimVl8eJOvbPBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSybbZIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562E1C4CEEE;
	Fri,  9 May 2025 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817447;
	bh=h92wsAJki04nn/PE5Coo6w+s/iTlSm0zkd+N50vND9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSybbZImfSz9OQmyEEllg+FVBBUycz7zRMSQrKxK4UC9aRMI8BlCA1vX5gcly2n79
	 7FH8y4KHWXxh/oBsV/XtfwbmQ6pJDjaFSXHM5UW7O64bgpTCwC3h9kwWgimtHACle8
	 YdreKDl9EkKwaK6MKEDdYK+lHM1RdlKr0K1tdhQ1nZ+LaRU7KcFfYTwOtF1ngwwyBH
	 ZIuYLIRSuj54NUajF4Iljqg5C2Y6d7pfFcW0VvQwVNudoco19kyQ/EkigxDspFQkHZ
	 vHfnGm/aVzcd7g1hqsYSZ7TSHcybQzxDpvWr215vrOG+0pIOannjt3zYq9GfVj7rtt
	 viixk+vkCoMIg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 12/19] sunrpc: Adjust size of socket's receive page array dynamically
Date: Fri,  9 May 2025 15:03:46 -0400
Message-ID: <20250509190354.5393-13-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

As a step towards making NFSD's maximum rsize and wsize variable at
run-time, make sk_pages a flexible array.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h | 4 +++-
 net/sunrpc/svcsock.c           | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index bf45d9e8492a..963bbe251e52 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -40,7 +40,9 @@ struct svc_sock {
 
 	struct completion	sk_handshake_done;
 
-	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
+	/* received data */
+	unsigned long		sk_maxpages;
+	struct page *		sk_pages[] __counted_by(sk_maxpages);
 };
 
 static inline u32 svc_sock_reclen(struct svc_sock *svsk)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d9fdc6ae8020..e1c85123b445 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1339,7 +1339,8 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		svsk->sk_marker = xdr_zero;
 		svsk->sk_tcplen = 0;
 		svsk->sk_datalen = 0;
-		memset(&svsk->sk_pages[0], 0, sizeof(svsk->sk_pages));
+		memset(&svsk->sk_pages[0], 0,
+		       svsk->sk_maxpages * sizeof(struct page *));
 
 		tcp_sock_set_nodelay(sk);
 
@@ -1378,10 +1379,13 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	struct svc_sock	*svsk;
 	struct sock	*inet;
 	int		pmap_register = !(flags & SVC_SOCK_ANONYMOUS);
+	unsigned long	pages;
 
-	svsk = kzalloc(sizeof(*svsk), GFP_KERNEL);
+	pages = svc_serv_maxpages(serv);
+	svsk = kzalloc(struct_size(svsk, sk_pages, pages), GFP_KERNEL);
 	if (!svsk)
 		return ERR_PTR(-ENOMEM);
+	svsk->sk_maxpages = pages;
 
 	inet = sock->sk;
 
-- 
2.49.0



Return-Path: <linux-nfs+bounces-11184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04FBA944D7
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A911893D08
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F31DF991;
	Sat, 19 Apr 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAPsQ2D+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5F153836
	for <linux-nfs@vger.kernel.org>; Sat, 19 Apr 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083707; cv=none; b=Jd8ZFf5wjH0nkr6oAj4zHlPkqEAhSGLv5ADMLv/dXNHK3Yxw5kXuLP6milsGUn+8wULHOJkoOSFsLkhZ49O0vIAEJ1+8AH9pZ+swjQBaaPbCwXPD4U/oIaA4vQYsqPjtZWoRqM6wktbwy0fJRJwqiFU0aRQ10HAINIPYysuXlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083707; c=relaxed/simple;
	bh=lP1vlqwhkc9CH/xbGbVKx5hJuRpczFt4dvTxkbG/HL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSl/yPIPQnDicAzHH4xMA2oi8eBKY+t8NcBhh5SI6HXXO3l6NAyZcfmieT5OGrh96Cn7lPIXlu1UGwk+OUWz+L/f0K2erLkK4/IMIQXu5JAApMIDwyewB8YTQp/eUrydT3jVpuyoQzZhUoSJND18zBMv+WSk4IJkrIn3to2Uzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAPsQ2D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351E2C4CEEC;
	Sat, 19 Apr 2025 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083706;
	bh=lP1vlqwhkc9CH/xbGbVKx5hJuRpczFt4dvTxkbG/HL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAPsQ2D+6rK4XZWS1ubLmyqGzQW4VKunMfwu8AGQGmA2b6TtLbeerQtIVq2B8St56
	 J/RMUoPpjvLgq5D8TBwI3fTdhmLsA/HhH7nkgtnFskm+Sndk5Bd20HAKEqu38PHLqE
	 nBL9X7QAemA+9r97nm2o2vtyoLwNlcN5KClBeQ3m7TBKBbnPrQYlxjGtE3jpiFVf6j
	 xGWg8eydYHNHI1n/Jfk0BfwyZ3lyl9qTuCqiF6AxwpiCnX0xncljvWnxmFTiKgJntu
	 gWqKLdXA3NYp42/tt9QqTbd6ziYnX1qzVDUVMR/qgatjbw5kPUILK1EotapGLOKI/0
	 /+9zTjM/KhlmQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 06/10] sunrpc: Adjust size of socket's receive page array dynamically
Date: Sat, 19 Apr 2025 13:28:14 -0400
Message-ID: <20250419172818.6945-7-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419172818.6945-1-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
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
index c846341bb08c..5432e4a2f858 100644
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



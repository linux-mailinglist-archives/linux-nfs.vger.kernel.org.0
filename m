Return-Path: <linux-nfs+bounces-11241-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84DAA992C9
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BFA18913B8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990C2857DB;
	Wed, 23 Apr 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbQoplft"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568E2853E8
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421686; cv=none; b=Vcg+9i+2rZs3ZGAdOjd54xMnBAz45oywGTo92c0Ga/kBdNkOazDGQF856r4tAvwFUL24bvFdWL1oGFoEN76qK6VwqtsiZa0y1wL6l83HPkm9ky5t9epHcX7hhOHtOTAy3nJ3UaQBWW6oKAtC7dqv4AUrhPtjIuhs+JzrhWY4nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421686; c=relaxed/simple;
	bh=KJ+ZLqnKT7T429LbfiWA3Kji2d+Aw0KLXtb4GB92Ckw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/nCedh0pC+VdnMee4GkmsXjq3Zq7wDDG3SXYv5a6GmGZcqc8721KywKwSYRNBRVXRKVdGXx0P3Qq7HRHJzn0Js7IsiRC5IF0jHMGMOEI4CmnyI4JqeRUF4aRgahGyh7aaGqgiLxFIHXJy/NSADPMhsyN9UjStZal31AYuxtWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbQoplft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E594C4CEE2;
	Wed, 23 Apr 2025 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421686;
	bh=KJ+ZLqnKT7T429LbfiWA3Kji2d+Aw0KLXtb4GB92Ckw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbQoplftBAygvBSGHDGlrfvtasNn0lIn5pr19S8VYFHD7+pvSvdqTUNDuHZvGZWAo
	 5bGPV624Je/5kxJSomrbJZc531KPK5vzZJrmYMIJ9AIrymvCm4c14ryPkv/wX+OFFE
	 V62Pqfa8aoQnV/T59qA/Ev/tObASdo9orzqaofae+VkTEQDLOefIPtLndCL711/gjL
	 7HIDqxXltUCMLa9ExH7LYkpGQo+errpAcxcAXYNRX2BGAFrD5w82EIBcy0OqlzJPQA
	 UFaUT5cPBaHltBQqaWehoAZUWdJ418dndrHLlXfeMpzLSM32i/yqmWvMnE6looMWZi
	 XFaRDHNspvmGA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 06/11] sunrpc: Adjust size of socket's receive page array dynamically
Date: Wed, 23 Apr 2025 11:21:12 -0400
Message-ID: <20250423152117.5418-7-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
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



Return-Path: <linux-nfs+bounces-11322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11DA9F9AD
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD515A06A4
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8F22980B6;
	Mon, 28 Apr 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/a2o7zf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E282973BA;
	Mon, 28 Apr 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869033; cv=none; b=VKz8rx9ZKAFhncokKPkPCKQcCgHLesg+hq74dSj5nkBoZtJaxGBn25S6OZ98GRcNNq+mmg6g1tkDEaVAumcaNW+NKXeGOORzHcnXT6P1KlboQDxuDlaPEeM3La8Rd8qrGGiKW+UF5oTZvwrZgznQfCdOHmbyj/sx14ceexVd3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869033; c=relaxed/simple;
	bh=HCW0j1r9vGO4/GzVmNGEYF1N29fYXFULbXzXOBBTElU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsBd51I90cG2kMOpkF9E0r49QCqqA2TjChTz8uEWpHDx3P1m/wteKCz23d15Ec4xt2m+IJYFUqUJTZ5T0pooJFWG5NsHFkSqMfuthTO4GX3qRYx75IPkaRlamiTF9E37lfkV5ZuprKaU9GuMDttEdjnCa+u3zeUF72ozkMSrmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/a2o7zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D5C4CEEE;
	Mon, 28 Apr 2025 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869033;
	bh=HCW0j1r9vGO4/GzVmNGEYF1N29fYXFULbXzXOBBTElU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/a2o7zfbD0rOZRscDHySGLcO0aeY/OUhXLB/8koXk0OzRczoOolTfE5IjZrXImOB
	 MOJUeIu+bvsypEKOy7uM+1JWeKACFmWO9iD0bfd5FuNHqbi3pb1NQA4KDJtEpGLIes
	 VdYjEnOyrIg0Ba4gtZkXXXItzkPUZKfOlY7uQ+83mMHx06hmYAfCV7Q8d8dKQbvgt9
	 z/BiLnupeToj8iXCDSBvaRJnXvqdmigEVkEqfw7ZmOz5uBXs90O03MJa7ddtv+xzPs
	 G42tvVU3lpczlRwYNIJGcLwH+AaBTqEUCRBqyDGMNCdaATQ8C3JO5OY0oC6L2BYax/
	 cXt4eJ58cRblg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 07/14] sunrpc: Adjust size of socket's receive page array dynamically
Date: Mon, 28 Apr 2025 15:36:55 -0400
Message-ID: <20250428193702.5186-8-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
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



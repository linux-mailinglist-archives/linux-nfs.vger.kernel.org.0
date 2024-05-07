Return-Path: <linux-nfs+bounces-3192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CA38BE31F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E95DB270A0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C915E5BE;
	Tue,  7 May 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8jQ894M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501D15DBC0
	for <linux-nfs@vger.kernel.org>; Tue,  7 May 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087444; cv=none; b=k+tiQO9dHo9Jy+ga2uNSkga+6eg/hY7G5abOJKo6G5zSJZR1bZCD2n32RzTZDMHyPtEYC33PQbf81I/HElq8IMsuEXM3esREWMaxlRMIA6hkhOVqEU9nTt9rkj5+q9RPMhNyxOh4xUl0KM1hJXBr5kvukFqYJlziIdyJdBZcNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087444; c=relaxed/simple;
	bh=c6jaAxYpGw666ZKt1/1g6gtnnZsXqYvO1m+mHsdK3Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbaw3jQsFUnT3NVjH/Hl6QkqCSjvN9hQnh2BwargeDarucdy7PGVL99aiWL5x8rKpyXn/jh2RnZwpBU4PumpNfPv0im7TA5eC1iz9V9sNVUw+eBzkN/zihdOFt3S21dpzRWU3HgCAKpB3IQoTIT3qb58Taa2Rq803o1dl1ipKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8jQ894M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02B7C2BBFC;
	Tue,  7 May 2024 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087444;
	bh=c6jaAxYpGw666ZKt1/1g6gtnnZsXqYvO1m+mHsdK3Ng=;
	h=From:To:Cc:Subject:Date:From;
	b=C8jQ894MIqOJAqsNWFPOp2w2XkTc7BsZjUciJemcpEPKlLKCrz0XGOLzIDtEx+l6E
	 EAZAKR+GfimKK+DL55IBN5hjS0ZLPLV3khgwIA/7/z4rgrT8kZbOoiFweGCNGo1PJh
	 kU1F16lcy9KzZNBN+XuVgK1HMad/VPYVRf0yUs4nC7OpyeyFM16vF0hAok9H4UUtrg
	 16Om2NV9WOjKbBaBAej2ziYnYUMaGt1Dmyki516IlMXGPt8HnPKd3p0DtRBOzVzbBK
	 zxNZrCn00ejcYsO6QsAE+YzK60JjxXucghcb2X4y9llH/rQrOtiuoWqdu7Reed5bmK
	 /ANPRTFhhhPDA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH v2] SUNRPC: Fix gss_free_in_token_pages()
Date: Tue,  7 May 2024 09:10:41 -0400
Message-ID: <20240507131041.9373-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Dan Carpenter says:
> Commit 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()") from Oct
> 24, 2019 (linux-next), leads to the following Smatch static checker
> warning:
>
> 	net/sunrpc/auth_gss/svcauth_gss.c:1039 gss_free_in_token_pages()
> 	warn: iterator 'i' not incremented
>
> net/sunrpc/auth_gss/svcauth_gss.c
>     1034 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
>     1035 {
>     1036         u32 inlen;
>     1037         int i;
>     1038
> --> 1039         i = 0;
>     1040         inlen = in_token->page_len;
>     1041         while (inlen) {
>     1042                 if (in_token->pages[i])
>     1043                         put_page(in_token->pages[i]);
>                                                          ^
> This puts page zero over and over.
>
>     1044                 inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
>     1045         }
>     1046
>     1047         kfree(in_token->pages);
>     1048         in_token->pages = NULL;
>     1049 }

Based on the way that the ->pages[] array is constructed in
gss_read_proxy_verf(), we know that once the loop encounters a NULL
page pointer, the remaining array elements must also be NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Fixes: 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 24de94184700..96ab50eda9c2 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1033,17 +1033,11 @@ svcauth_gss_proc_init_verf(struct cache_detail *cd, struct svc_rqst *rqstp,
 
 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
 {
-	u32 inlen;
 	int i;
 
 	i = 0;
-	inlen = in_token->page_len;
-	while (inlen) {
-		if (in_token->pages[i])
-			put_page(in_token->pages[i]);
-		inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
-	}
-
+	while (in_token->pages[i])
+		put_page(in_token->pages[i++]);
 	kfree(in_token->pages);
 	in_token->pages = NULL;
 }

base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2
-- 
2.44.0



Return-Path: <linux-nfs+bounces-3522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A968D78C6
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2024 00:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E0E1C20756
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jun 2024 22:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72017C7C;
	Sun,  2 Jun 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDqhm0GG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EBAD59
	for <linux-nfs@vger.kernel.org>; Sun,  2 Jun 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717366539; cv=none; b=Sjk9M1MQ7oAG2AnwHwu3fsIspbgPxungmDlKAqJlLrkFLtmnd4f8ivv1NgtRpcBibw3vyQFiowMwYTqF3DDa4z7JMNbJq+LzrwWSMHlJxId4OVwezzJ1sUbPRKKvkxBrykWGFyuDqZ4SyQlJxdyGuGh+eyS1B6c29wGQ58jWXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717366539; c=relaxed/simple;
	bh=/j+qYHGn9ke71IbhkO3067RhN7UMDFPyyW8QrdlIeLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BaKYpMW00k6lKNgBfZ6lsl5DX6eR4zhM94AhPMgtHfULd7pEsK/Bvi5DbTPofqm3BsKTlyHXf6qZT8vrc1FAe7/hx0Bv8lfx+hbic/rB4ar9Jby7TuA7QMluFyzWOCBmvk/hQoSPq1KZBX/4ZXtu5UzdKs1SBz2lW987t/7w8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDqhm0GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D044C2BBFC;
	Sun,  2 Jun 2024 22:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717366539;
	bh=/j+qYHGn9ke71IbhkO3067RhN7UMDFPyyW8QrdlIeLc=;
	h=From:To:Cc:Subject:Date:From;
	b=YDqhm0GGouuk9tvHE6jgu3oWojEk16sepcd6t1TKQARlv80bSYbkvlJWdEmZ4PQY9
	 hKvCRPRMEAxsTfgJuXxkaapc33BElvnVWxCj+0MAXDV9YFCetZq4N2fy0nUKaQGDeE
	 341d8HdC3r9OgLYOCJGGlqQxZsf42gl7UrWURfYioNcWp2H4TxUXKtu2DPJ2v5sx49
	 50yDhnQGF+achWePVUZIxi6wrekGdc6zKNGDkVFCLyRgynbvv/XGNzxMgCACkLDEVe
	 uzhrolhR5W6N2ZqEzylawpSZ1lcbRu5aaLpZT2Bikpn5l171hT66VySAZlexeqGwcr
	 ZV286bIvKZWQg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] SUNRPC: Fix loop termination condition in gss_free_in_token_pages()
Date: Sun,  2 Jun 2024 18:15:25 -0400
Message-ID: <20240602221525.4257-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The in_token->pages[] array is not NULL terminated. This results in
the following KASAN splat:

  KASAN: maybe wild-memory-access in range [0x04a2013400000008-0x04a201340000000f]

Fixes: bafa6b4d95d9 ("SUNRPC: Fix gss_free_in_token_pages()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 96ab50eda9c2..73a90ad873fb 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1069,7 +1069,7 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 		goto out_denied_free;
 
 	pages = DIV_ROUND_UP(inlen, PAGE_SIZE);
-	in_token->pages = kcalloc(pages, sizeof(struct page *), GFP_KERNEL);
+	in_token->pages = kcalloc(pages + 1, sizeof(struct page *), GFP_KERNEL);
 	if (!in_token->pages)
 		goto out_denied_free;
 	in_token->page_base = 0;
-- 
2.44.0



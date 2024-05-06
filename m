Return-Path: <linux-nfs+bounces-3181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF78BD68A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE161C20839
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 20:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FCA15ADBA;
	Mon,  6 May 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdMA+0bX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA8EBB
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028772; cv=none; b=E8Xq3lmlPVPiNs2WzKhyfZfQj3YjRiQdBuRXQ5nKiNNbC6PsBbBXECVkLT70t87kVQehnjlB618ghGMbiWAG7hPYDs0f5n/nXtn5Yw85Ae5lmg/6A28AZ7o3Lz9YbGqP7Nf6uphmdlxRXDK4sad8UJzzZCTO0si54vf8dqx8KaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028772; c=relaxed/simple;
	bh=QISKV4ilz6H9BdF2IyTUJN5rFYUKwq8NKlXbRxDSSlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7h7hCcHORkfSwiOZqmdSmnzbGc/VQbTip9ijExeFEDem3l+pWB1uLbJSlqH62o0jtEJJp0hf4pWawxoUWs0PE0aRxxR9D2fCYbhxh0opjsdW7oigzkjVvGfyocm6QAYd+bd/7dkXHfiU5SlbIKS56fyIBu2S3oE0XYYesOl12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdMA+0bX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC61C116B1;
	Mon,  6 May 2024 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715028772;
	bh=QISKV4ilz6H9BdF2IyTUJN5rFYUKwq8NKlXbRxDSSlo=;
	h=From:To:Cc:Subject:Date:From;
	b=pdMA+0bXZoKG8KqOU1cKx87enjvhdneIBGuKi8mpaA0jYxPQL41pIXKsMaU41DaSs
	 LhEOCsb1FZD6/ylU3i/d9sfY5hS9eVFSnx6Y/KyK01FwEGxSNSnDEiVRMbjL2ZgIjD
	 6Hv943qguvnEqNH+NGYJ0zgiFiuyijt8kyUsPKSNfsvjOiwlWzjv/vKgyQ/+ur6RsI
	 i71BFVbxfCgM/xCpi21u5zYHzyo/Uq2+PcLwp0FCP2iIq2Kfnr0e7oggB29OW7q4Im
	 SaXzz7t1jS5USaVwunknPPMuU93oiXr7e57exxm4bMVLNqjhTuWCvft2bG70cp2Sv6
	 P6Vb9cU3aUJCQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] SUNRPC: Fix gss_free_in_token_pages()
Date: Mon,  6 May 2024 16:52:45 -0400
Message-ID: <20240506205245.4455-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()") from Oct
24, 2019 (linux-next), leads to the following Smatch static checker
warning:

	net/sunrpc/auth_gss/svcauth_gss.c:1039 gss_free_in_token_pages()
	warn: iterator 'i' not incremented

net/sunrpc/auth_gss/svcauth_gss.c
    1034 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
    1035 {
    1036         u32 inlen;
    1037         int i;
    1038
--> 1039         i = 0;
    1040         inlen = in_token->page_len;
    1041         while (inlen) {
    1042                 if (in_token->pages[i])
    1043                         put_page(in_token->pages[i]);
                                                         ^
This puts page zero over and over.

    1044                 inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
    1045         }
    1046
    1047         kfree(in_token->pages);
    1048         in_token->pages = NULL;
    1049 }

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 24de94184700..bdd8273d74d3 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1040,7 +1040,7 @@ static void gss_free_in_token_pages(struct gssp_in_token *in_token)
 	inlen = in_token->page_len;
 	while (inlen) {
 		if (in_token->pages[i])
-			put_page(in_token->pages[i]);
+			put_page(in_token->pages[i++]);
 		inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
 	}
 

base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2
-- 
2.44.0



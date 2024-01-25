Return-Path: <linux-nfs+bounces-1399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7C83C807
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5771CB21FCB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388F129A7D;
	Thu, 25 Jan 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJeXNzDg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0118129A70
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200197; cv=none; b=OUT32IDhiV1cmXT9KLJ2Hg8ykXe2DpGviIJ3QWuvpFI7zn26rTpTBlvtM4ZnQejq3xM9tl4HpojSwN5Kbofb2OibuPc7ODiRjqKFamL/vQavvCI+KCUs6Kdye0dZyE/sOqcs24wJp32ghmQ9GFGWUYsAoELMCaXdDhibaVKTGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200197; c=relaxed/simple;
	bh=fCulokz3BjzzNImUyQKnWwQdKoAXzN2sH7HV8gn//l4=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3CNitWs/TLj6xVIpPJJlK/cDEb3DpaeSHGCzECsJIxaQg7SEXxHbZoU7DjrIYThfVXMAmpGyX10Z7MP7d/A5fx7EIL88Je4Yemvm4jDZUw6AUrQsISXsxFRuuSDWJKOwOn/CWOqD/mCTFd6c3h4nnwhf0yO3HPz3JTI6GV9CuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJeXNzDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68507C433F1
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200197;
	bh=fCulokz3BjzzNImUyQKnWwQdKoAXzN2sH7HV8gn//l4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MJeXNzDgl/yqC3yjexDWlTLF0gKUVvTehsvTVAED1nYOSNcwMsz6BJVQt4G9YFdsl
	 uF3PQZI7hNiMLq1Ca4qG3fVWdKw89H1QX3goBqNxiv0mdHTlKShYQnS+eoGskx7IIe
	 +/PX+eE7KuWnL0yU/SL6QsuCDW/svBOusoRKL/qiehhNYrQR+AjIt9BOU73/CNkIGr
	 xKe7vUYOxpZfOZvQOm7tgqtZxAkUKSugbSzn2cMfIXVhxibcL59uv2FhiykqefjkOW
	 ifvskCcix030cV4GqMAsPJTZOGTZDC7wnEg5dvMLIyUzGPw/hmvGIU1AoGGlrPNCRr
	 czGgFCFOx9QdA==
Subject: [PATCH RFC 12/13] SUNRPC: Remove stale comments
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:56 -0500
Message-ID: 
 <170620019647.2833.15727263058832480637.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

bc_close() and bc_destroy now do something, so the comments are
no longer correct. Commit 6221f1d9b63f ("SUNRPC: Fix backchannel
RPC soft lockups") should have removed these.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtsock.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 58f3dc8d0d71..d92c13e78a56 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2987,20 +2987,11 @@ static int bc_send_request(struct rpc_rqst *req)
 	return len;
 }
 
-/*
- * The close routine. Since this is client initiated, we do nothing
- */
-
 static void bc_close(struct rpc_xprt *xprt)
 {
 	xprt_disconnect_done(xprt);
 }
 
-/*
- * The xprt destroy routine. Again, because this connection is client
- * initiated, we do nothing
- */
-
 static void bc_destroy(struct rpc_xprt *xprt)
 {
 	dprintk("RPC:       bc_destroy xprt %p\n", xprt);




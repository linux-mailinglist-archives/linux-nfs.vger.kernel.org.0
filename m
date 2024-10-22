Return-Path: <linux-nfs+bounces-7368-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A411B9AB55F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36DE1C23747
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DE31C0DCA;
	Tue, 22 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJGXIxFE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8A1BFE17
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619043; cv=none; b=E3jQ0IIG8C7ulwze/9inMl9REGztzewn/Zdzu52Zo92WdJCiqcS4zo6G60Syc9AZngP5WlApWjPs3rim6PPt7qTGnmBuF8XC98wqCvVkc6FwMV9eEthZYJ2ba7No8iOE335Xg7ZwN15pq9XYPd9MvUvO+0buB+XCzCIJpdLlpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619043; c=relaxed/simple;
	bh=ciucI8FvbZPaW0cGf24gBODkR68749MkwTHa0yPrhho=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj24YjhlnstJ8piqxxk66cfkvskX5pC/mnTfYUxAnKy8nfp7++VAaoWP/6U7Fg+mvUUbHtnmGwk3bWgKdHVQfAlgG1xgOY+BKDmfr/wM1r/5IUV9+bIIQGj0FQhQOVnC0+ezFTyo/3FawQjiStQJUG/nU0pwpdYkHsyBeCq3ARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJGXIxFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15999C4CEC7
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619043;
	bh=ciucI8FvbZPaW0cGf24gBODkR68749MkwTHa0yPrhho=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bJGXIxFE8PA5ymfOK9m8rUAUKCLdSwTYNYR/fv0kaemQN1fWHnH5vTFPNq2saUoU5
	 JRuZS8n+2p3AW3/rSgSoWxmxE5wBL9u2kfcHM+5PLU8P2uq7b0k7fjQb51HSSqfBrn
	 P67PLV4DU6pGRA/GewNbAqus1jw9rmpUURjt08BOsCOPKKb/8T0WDKtLr+qddDNOqS
	 p/bI5cAOXjis0oS91qij+CXY0pl5OGFxpwj4XpWK0xbkkoqgg0CPiLD78Qpfd1q8uf
	 gJq28qlNSAmvz1CeshiBy29a4k6Lx05nF0Ye/IA/GeveIupa8Ahg0zv1tqpj1em0Wf
	 eWA5aOO3xGFBQ==
Subject: [PATCH 2/4] xdrgen: Remove check for "nfs_ok" in C templates
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Tue, 22 Oct 2024 13:44:01 -0400
Message-ID: 
 <172961904156.5686.14525304420262960936.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
In-Reply-To: 
 <172961889678.5686.2180145399460027810.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
References: 
 <172961889678.5686.2180145399460027810.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
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

Obviously, "nfs_ok" is defined only for NFS protocols. Other XDR
protocols won't know "nfs_ok" from Adam.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../xdrgen/templates/C/program/decoder/result.j2   |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
index 38c31b3f0589..4ce4cc9fab79 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
@@ -13,7 +13,7 @@ static int {{ program }}_xdr_dec_{{ result }}(struct rpc_rqst *req,
 
 	if (!xdrgen_decode_{{ result }}(xdr, result))
 		return -EIO;
-	if (result->stat != nfs_ok)
+	if (result->stat)
 		return {{ program }}_stat_to_errno(result->stat);
 {% endif %}
 	return 0;




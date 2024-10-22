Return-Path: <linux-nfs+bounces-7370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CD9AB561
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728241F219FA
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC8D1C0DD2;
	Tue, 22 Oct 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGNYvcwt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F81C0DCC
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619057; cv=none; b=Yjm+EI8977mZi1tgFUM0XomPSWWiMjMC04bKFVqnzs7fvuBM0RqZgRkrd9Kv242ucsIztQgrB28J2EVQ/FflXhPcwHxZ82rZwTeD+HvBbwIs40ckg11BENqkisfnh6+1t3euP9A2Sr+xXC1nUUwGCOoSsac2MXKVK4eIex2XYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619057; c=relaxed/simple;
	bh=0eazUNUpEoRED7PmgB7IN+L1GZnTWcdqEW0tFW7c6jQ=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kynWksOgtpwmL9PS7Tf+pgMe6sonqj/zoLyqmfLUPvqCBlX2dj5XFcd03+3d+oNtAK4j/HT1Pad8iI3PUSz79zdFNxbCGPvxjrgcCcvvBoEi/Tk7lzi6GWd3tpgKMdedo3U5xBio7T27MIwn6rfghbsNr9Wasju5dBcqSVFxBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGNYvcwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA27C4CEC7
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619057;
	bh=0eazUNUpEoRED7PmgB7IN+L1GZnTWcdqEW0tFW7c6jQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=TGNYvcwtFbzeQlH1cbmaien4m6swHCnFYHBvJMJcwCU/K8SUKdQcD2ZExnIXeRQJI
	 +siMil4yyASF+4/R3G25fvdpoBV7CruZ5UExBIYoaULr4Jvo4gUp8e39+/aAkmpW7G
	 5ehjakMwHwC7xPdnSNyq1X6MbSiums/pi2SeQGviOhND7dsy7sGN/035cn8yrBcfMC
	 JP1k/6F6hlUHl5agw79pJZGzVN9ezPh5RPUEGsNnflrgRIg6m/kMO7t/yRwo3Lq7X0
	 iQ/7hUrnaakg4kXAzU3sBqAZCPzPzDHmYR4h0u/ub612KtWXcmt8sXBs9e4YBB2T+2
	 W2B99QnulZKbQ==
Subject: [PATCH 4/4] xdrgen: Remove program_stat_to_errno() call sites
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Tue, 22 Oct 2024 13:44:15 -0400
Message-ID: 
 <172961905535.5686.5712413032264720344.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
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

Refactor: Translating an on-the-wire value to a local host errno is
architecturally a job for the proc function, not the XDR decoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../xdrgen/templates/C/program/decoder/result.j2   |    2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2 b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
index 4ce4cc9fab79..aa9940e322db 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/program/decoder/result.j2
@@ -13,8 +13,6 @@ static int {{ program }}_xdr_dec_{{ result }}(struct rpc_rqst *req,
 
 	if (!xdrgen_decode_{{ result }}(xdr, result))
 		return -EIO;
-	if (result->stat)
-		return {{ program }}_stat_to_errno(result->stat);
 {% endif %}
 	return 0;
 }




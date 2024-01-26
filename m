Return-Path: <linux-nfs+bounces-1502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DAB83E0D7
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA219286748
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4520B33;
	Fri, 26 Jan 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc/YrBpz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A520B22
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291194; cv=none; b=hyHUpJCizRaluDSUauf4E5aQoBX5pLY6TD0TiKF+nhsDzMwCTTLA6LvOiqzB/1rA38p5FiCS6skfBPDuLg4f2wm1fOteUkuhJbNEA4+F29RN2cVH+D1TdcU4CNEAQEF9OHYxr4wmwxmwzi2W0OrbZOIaknnbVVSRVdzRTXaVOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291194; c=relaxed/simple;
	bh=HIVpvEqymtFGgMm79OZU2Ksf1cHno1/l6P8SITVsXEM=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFfPhb+71XglqTL7CriIR3QTPcDMR8FhOCN+Jx7Qf80SKs9HNpz0409b3FmkId6jLP1+UoAPmB1MhutrAqxksf2Gkj7Eg8ubD6ydt/wvLkkseFRpYWq4GZnBG8KGXicIDecik1gUvSOEyO9dI5CUeRjiFfZXW5uxl7373rCSkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc/YrBpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB16C433F1
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291193;
	bh=HIVpvEqymtFGgMm79OZU2Ksf1cHno1/l6P8SITVsXEM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Kc/YrBpzGckh41fqCgpPqxdU43+MXVwsf/PSpxUjeyFXxk/XTs9CbeZv1lMEHspdc
	 uqlf/S3B5GcXXvtU3+RUdkZ9zaxCHXWWL6l5JET3vYJ/y21nIKj3xN2qZB4xln25Df
	 ilIXLlucIVm15LE3QtUmYYQD29IRNbwJ5cHXAUMYsT73uzMrCJBnxaedm9UWmzUynS
	 ZudjGD/+5Ul0bahBTHmuc/SH5DC0FkK5CSBS7YoPqc7rLOrguOijvTLr/0u19C5Gp7
	 yrMe5k4K81o/Wi37PZXuzXsHGjaJlVHcUDaoPO+MdLxsDz3JNiJlY5kiN3B7r0i8Lo
	 s1nxlmzaiJ1eg==
Subject: [PATCH 2 13/14] SUNRPC: Remove stale comments
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:46:32 -0500
Message-ID: 
 <170629119257.20612.7741739631969908034.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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




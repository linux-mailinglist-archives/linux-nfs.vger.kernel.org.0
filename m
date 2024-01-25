Return-Path: <linux-nfs+bounces-1395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEA683C802
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741B41F27B4B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1568129A70;
	Thu, 25 Jan 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjMcTMCH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE267762A
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200172; cv=none; b=D5OvdKT7T97Dc50dALt+43r/YRffD5nf7SeRRJ+aTQGvFE1xAjsWx932L5ery8yEh4EdpMjqLeP5cxAXDpJmSz5sFprEffat2yxVCV4WqYa/qvlNFBEfSe3O2ckNlAUzdwvd/+A5XV9218Dw38DqXdEiuaGVjpqRVXj4p+/gy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200172; c=relaxed/simple;
	bh=IVm9gC/HXqfW9zXKsDv/2CJOVlAZXs7GZ8lO/1zrY60=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbgF/ZyOpdr/clcfwX9eBXveebjXoXzJW0HtdOP37dL0hBp7/9lnI9RqvLWLEHVaWRwuMdtExlhRxh7tiS93jxVga1T/5BInX6lzqgLiBWkQUAfJkc5lsyHEm9LdxuXxvx4vqaguWMrkRnznI7o6RTZuajrY895Pot70S5h1zLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjMcTMCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E764EC433F1
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200172;
	bh=IVm9gC/HXqfW9zXKsDv/2CJOVlAZXs7GZ8lO/1zrY60=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=DjMcTMCHOvUyXGtClc3swin/Dp3hYkBATYP4WOcvr16oBb7+AxwmsIOeFGlCfUNFZ
	 Bh0ZRO8qgOpkQpMnlWSa7nybLQIUKIgiHYww9GS9e0FCHznvT0lVxqPfeLp4RHGDWZ
	 VTAGi/Uicxh0XPUAzlWkdQyuhtRTpB6TwFqoc5jVGY7U7o1aVtkWPVx2V6QcA0XfG+
	 DJ0JAosPH9ZgM3ChNT73a7AaKpqSiWNU1IznVQtCHBKhyjNvLMdBj+sC5OnT9MUXhB
	 8fi2x/40yIKKdamRQoFNFOsqwq4OVjC7mZSkn6NA9qIwC7J+BGuINp7t+Q5MRm2NMI
	 U/IbJMQ3EvWeA==
Subject: [PATCH RFC 08/13] SUNRPC: Remove EXPORT_SYMBOL_GPL for
 svc_process_bc()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:30 -0500
Message-ID: 
 <170620017090.2833.16348897334568590465.stgit@manet.1015granger.net>
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

svc_process_bc(), previously known as bc_svc_process(), was
added in commit 4d6bbb6233c9 ("nfs41: Backchannel bc_svc_process()")
but there has never been a call site outside of the sunrpc.ko
module.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index eb5856e1351d..425c1ca9a772 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1603,7 +1603,6 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	WARN_ON_ONCE(atomic_read(&task->tk_count) != 1);
 	rpc_put_task(task);
 }
-EXPORT_SYMBOL_GPL(svc_process_bc);
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 
 /**




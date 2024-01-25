Return-Path: <linux-nfs+bounces-1400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C49383C808
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA881C20932
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D5768EE;
	Thu, 25 Jan 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlK5ZxFu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF77316A
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200204; cv=none; b=dl0c+dms6IatJPMiHx0pp0e3fS+MQUX5qWREs/nVXUdMgwkYtFTZBpJF2pAY2XjQUgsxjU1Yki8PgO6yMiQ5axRVnQNs8JQL6XFf6gcU18m1Ne3ekqabh/CWpoBQaaPBwOyYSC/XuOeaSBPBsWFIP+EwRus6L4/7cL+gD3V1Af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200204; c=relaxed/simple;
	bh=7l4u3xIr3J7Fi04C0U1HFphRw43b5KA1MPBxqwGcSd0=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTEzm9LX2GX9e1qDTxfXvZm5AvO9/CLn4OC6ekvVV2sxLH0nsEOQnHSG1bVw3Ms4bb7OjBSP13vm+FtVA+mcg+6bRxFEQdQ/KE3NzGjHP2yeIVSDiSkpgPmpAUmN06xvP6drycrNoKWkEeM1noCbbu5TuGIVDOWRyMMImgdh0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlK5ZxFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7A0C433C7
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200203;
	bh=7l4u3xIr3J7Fi04C0U1HFphRw43b5KA1MPBxqwGcSd0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MlK5ZxFuuGwPC7GZxS75i6Ck3fe+bDVRsAgnZ/ADVBrEj6GVp8jffFQXfYAdSu8HC
	 pGmFatHSAuAfgnt6MTKXChb6iQeggTr7kPr0yC91H/WHs+rYQyxUpKLWkgMGQ/J678
	 GBEaY3qWusXoSHhabowf+xh4bCXNq8/2OXiFNHYDT9kKgY4nT+xJBbyWNcMP2KC7Gk
	 QLbNwhxbyXtSblXK9csxmmUwFtrtf1hGK4wlmMfYSFniHq5fvWa/gg4PMSwrJGxFSu
	 oB7RjhJOsSyR0ZUtGbR3sOystfXxdsFr6fp4UYYw+sBHUZlVYESMgF/NRD8Ngrjwck
	 555AympTEhk0g==
Subject: [PATCH RFC 13/13] NFSD: Remove redundant cb_seq_status initialization
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:30:02 -0500
Message-ID: 
 <170620020276.2833.13226851823042560273.stgit@manet.1015granger.net>
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

As far as I can see, setting cb_seq_status in nfsd4_init_cb() is
superfluous because it is set again in nfsd4_cb_prepare().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 46ecb3ec0f8f..e72a904f120b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1443,7 +1443,6 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_resp = cb;
 	cb->cb_ops = ops;
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
-	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
 	cb->cb_holds_slot = false;




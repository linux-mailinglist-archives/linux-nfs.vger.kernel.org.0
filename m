Return-Path: <linux-nfs+bounces-1498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B183E0D4
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D42FB24336
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732E20B17;
	Fri, 26 Jan 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1+dwJS6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8420B20
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291169; cv=none; b=tz5ruOejCnF3pZkdy1/nIBcmZjuN/Agi45osmJlaQWJl2zNsg06yvJsu/BtjEOohG40xSngHDcvId3YAbhxXmqGJH4iJgtvqaTtnXX3TGg5BuJyfp5wVnbDtQBT21r9FImciatcEXmRACEFs5GAHsSlPlqqNRHwbnKDXK+0TE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291169; c=relaxed/simple;
	bh=c0BGB+oDuEc2NmCcx8J2ZGunl0Ngy/MZZWAE9Z5KPEw=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYvFIyvzgNCxV9Lxwc1IpfpsGUzBF2uj3TBAiOtTQUdYxK2WNfIKTkxHiR+mix1BxilpA+ucp6wHyODacmBdGMz3Vr9UsaythwgdlE5u6qAo1PtSxw1Kfa8004mn5RAUrh+gdnm734kBAldgOS6L5wsxe/XTG+eNgvGB3zocgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1+dwJS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A45C43394
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291168;
	bh=c0BGB+oDuEc2NmCcx8J2ZGunl0Ngy/MZZWAE9Z5KPEw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=T1+dwJS6DTfCD01IVo0WWW9SE9eRCBKemDF88zB4FQDmzY4Vdp/w8oFvKaY1GqnBW
	 hUqs64C8+eEP/MmlbFJl3fl21IntBWegsZG1DuWorp41KbAQtMx1fB8soLjncD3Q8r
	 tuAoVtsv1m+5cfjvZ0u5kC/1TkXHDWgzZEHQftiVdY8R+dI47wMmJrCtnTJbGbZz0F
	 n5CQ89HHw59oMKyTex7hGF4Fb3n29U62PsnZm1DWy3secMYJhArDiHIL4/q9yZ/UcS
	 azfz2geLQlmgqJedbsTuSS3ECjBiJ05tbULSBpE4y47NQLI7gLOP3uZHq1YsX9TaSq
	 5q1RvIklxJdww==
Subject: [PATCH 2 09/14] SUNRPC: Remove EXPORT_SYMBOL_GPL for svc_process_bc()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:46:07 -0500
Message-ID: 
 <170629116747.20612.1033017631209360110.stgit@manet.1015granger.net>
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

svc_process_bc(), previously known as bc_svc_process(), was
added in commit 4d6bbb6233c9 ("nfs41: Backchannel bc_svc_process()")
but there has never been a call site outside of the sunrpc.ko
module.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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




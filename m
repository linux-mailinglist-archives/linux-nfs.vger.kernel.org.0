Return-Path: <linux-nfs+bounces-3017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F38B2F39
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF01F221C8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 03:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9996376F17;
	Fri, 26 Apr 2024 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qSBlgiLe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913EA7604D
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103284; cv=none; b=MZ0Fp/6BT4Mp+15armHQH5rka7GuYUIP82vHZdkp43dXb0JusvLFuJup6RTFf0q6ojk4Mlzg65ZtUcT1picNTELXkQlcKcb5VQq6ptwt5AjI+qXltoPpVs60Y+f3CNEg3LZmbgEafWSOLWM0atuYM4ELoVIV4XB0Wzu/myhwdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103284; c=relaxed/simple;
	bh=1QqmeQZBX2emmgDPNnk1RxbtjSyKJ8bi1nFu1IAc+2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8JDaqYDCdbRE4uwrZk4nVMFRlhQUF1ORkFq6UPfSPywlbtDcwXM3y5sJnMSm2wR5oczzOwlrSHypoVpq30jAq3noT8ngD3xdg9lan7WEfjVcxgONJFPtclB4ZWAe4xEcU90CYH4Ab9Pi8/hCl/9GarbBGc9pR5rg497oENEyMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qSBlgiLe; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714103280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gRjod2wT/z4moe5A5yIQqLtdOWaTgQSx7ihxC577sao=;
	b=qSBlgiLejrigWRAzGCKvbq/sZ/YFJCYSxq33kkP4nCbS8Mt4h8H/vqOvMrrNMUKwK9lIGV
	YDGWutA2BSUBwSmx9xVLYbtQRZAu4/tBS7L1DkB2puTrN5D49fZwwd/JV7WQiPMKdLjlD6
	gFo9xdD4Eay3VL+5GZFI65JJ0+uay/0=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Remove comment for sp_lock
Date: Fri, 26 Apr 2024 11:47:50 +0800
Message-Id: <20240426034750.26945-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It is obsolete since sp_lock was discarded in commit 580a25756a9f
("SUNRPC: discard sp_lock").

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 net/sunrpc/svc_xprt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b4a85a227bd7..ec78c277a02e 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -46,7 +46,6 @@ static LIST_HEAD(svc_xprt_class_list);
 
 /* SMP locking strategy:
  *
- *	svc_pool->sp_lock protects most of the fields of that pool.
  *	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
  *	when both need to be taken (rare), svc_serv->sv_lock is first.
  *	The "service mutex" protects svc_serv->sv_nrthread.
-- 
2.35.3



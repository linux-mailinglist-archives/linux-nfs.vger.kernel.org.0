Return-Path: <linux-nfs+bounces-8553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6A9F12F1
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECF32808FA
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3C1EC4D4;
	Fri, 13 Dec 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR755WEP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E421E4937
	for <linux-nfs@vger.kernel.org>; Fri, 13 Dec 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108736; cv=none; b=Ix2g1pskTs5ztqm9PJg8MjAYpPFjZBFGDUBJZaf/pGe0pZebKBlFkc3VVxBEf9YvsIHq2yyo7nnkdR6sQ4DHIwfhMR3KXnWLpu+1WtGXht5iHeljUhB3fowzS84sR0QPQBd1I3wJXAZ6slAosdR1J+egjKpb9GocMAhPUDnr4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108736; c=relaxed/simple;
	bh=vC4FGw2tYICIknYLaQ+yCDX3GpSfH+cqPOFGSHsiPno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KdgX7bKqrMNU1PjBp7ROzjfD3kNir5MBVe+s9By1aORZIIe1O2k3xMS4tO+fpvOLWmKwLRqLr0ytpjccFVWFjBUR+qWiQh89IqreuAeudjH9kV6ZvYdnJmB+Tnk3p+hFk3qxAMreWGndKXd6NUn1fdZ8dpyi9jdEg0CHUdw9EBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eR755WEP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734108734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWnX90ERHJcVSwr1mBltkoFFr9KDdUSJH0UmhtDyEhs=;
	b=eR755WEPjxF79ag+T+wAOPCjXYi2QRLCUW0Bo3oiCtjZHgH7w9Pe/9Wk1A0Dou5NGkWQQ1
	pb2f3zqaAWyMk+nZ67Y0m5fpwrjk248ZtTAxa/p3iO0u9Uhj/ElkLKrqVcwiGNmYhH1x7B
	MspW0iv4/33XWwCMZ4fdKT5lBzrrIow=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ewv46EzeP6CGZ0tCYDhqGw-1; Fri,
 13 Dec 2024 11:52:10 -0500
X-MC-Unique: ewv46EzeP6CGZ0tCYDhqGw-1
X-Mimecast-MFC-AGG-ID: ewv46EzeP6CGZ0tCYDhqGw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D7D1956096;
	Fri, 13 Dec 2024 16:52:09 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.26])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75384195605A;
	Fri, 13 Dec 2024 16:52:08 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH] NFSv4.2: mark OFFLOAD_CANCEL MOVEABLE
Date: Fri, 13 Dec 2024 11:52:01 -0500
Message-Id: <20241213165202.78785-2-okorniev@redhat.com>
In-Reply-To: <20241213165202.78785-1-okorniev@redhat.com>
References: <20241213165202.78785-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

OFFLOAD_CANCEL should be marked MOVEABLE for when we need to move
tasks off a non-functional transport.

Fixes: c975c2092657 ("NFS send OFFLOAD_CANCEL when COPY killed")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs42proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 82efaf8720e4..c5b72dc71d7f 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -602,7 +602,7 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 		.rpc_message = &msg,
 		.callback_ops = &nfs42_offload_cancel_ops,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_MOVEABLE,
 	};
 	int status;
 
-- 
2.43.5



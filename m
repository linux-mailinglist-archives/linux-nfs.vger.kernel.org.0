Return-Path: <linux-nfs+bounces-8554-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20949F1300
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 17:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D597188CBEF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Dec 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D91EC4D7;
	Fri, 13 Dec 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdTmBqXk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A81E4937
	for <linux-nfs@vger.kernel.org>; Fri, 13 Dec 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108738; cv=none; b=JPZVJ6ZzFCZW4/DhhAmEzRl88ByFl+TgKOzH6fgeW1Ll1Mz1DASDSIg8+lQLgbTKZBrsdRo5DYzHG1dG8cAClopnIiJ/l3pzSZkwzxqo12fHNf8GaGazxYv+2pkh6Amup3U7QjB0dWnCQUwQz06hJeZLTweq0JjiZy5ZYTfA2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108738; c=relaxed/simple;
	bh=hiKPRsKm9NH0G86aUzQfi/3wV9HgE0dYz03bpyY3UH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YO4ojJPRtO3ATY+rPqkZI2wLCgj7EIQOW9me38cG2FI15j7FcAls341xxT/uyWqruUIBvsjYiucVCnUx6EWogl7nMGIGd7nYZS5uXZ2PmUMCIeSbU9acQiQl/syodSpzciPbhMycvsPlzAZWvX40Mc4ul2IcBwIL5aHCmJsXqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdTmBqXk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734108736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZE7uN1CiJsbq4FVvKGcqfGaB2O6TSRgvhbFVG8Uxdw=;
	b=MdTmBqXkQENvbRh19avTBbAFU7hjOr2h/qUhuA+csFnxxG5Az5AWGiQZ57mSugTbrZPRry
	qFPWhxdmk2IZRcSELvgenlipEBRNah2fnf9jDheNCptWE1hTtBRMD6ep8H8JHj1zcHUwTw
	Ff2Gx3Bxtt/Lb62kFDEOY4eXQ2SkPbo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-acsBqGfuO3eAuCxQ2WgI8w-1; Fri,
 13 Dec 2024 11:52:13 -0500
X-MC-Unique: acsBqGfuO3eAuCxQ2WgI8w-1
X-Mimecast-MFC-AGG-ID: acsBqGfuO3eAuCxQ2WgI8w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8B6E1955DC3;
	Fri, 13 Dec 2024 16:52:11 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.26])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA492195605A;
	Fri, 13 Dec 2024 16:52:10 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH] NFSv4.2: make LAYOUTSTATS and LAYOUTERROR MOVEABLE
Date: Fri, 13 Dec 2024 11:52:02 -0500
Message-Id: <20241213165202.78785-3-okorniev@redhat.com>
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

LAYOUTSTATS and LAYOUTERROR should be marked MOVEABLE for when we
need to move tasks off a non-functional transport.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfs/nfs42proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index c5b72dc71d7f..49216f9cf5ad 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1028,7 +1028,7 @@ int nfs42_proc_layoutstats_generic(struct nfs_server *server,
 		.rpc_message = &msg,
 		.callback_ops = &nfs42_layoutstat_ops,
 		.callback_data = data,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_MOVEABLE,
 	};
 	struct rpc_task *task;
 
@@ -1183,7 +1183,7 @@ int nfs42_proc_layouterror(struct pnfs_layout_segment *lseg,
 	struct rpc_task_setup task_setup = {
 		.rpc_message = &msg,
 		.callback_ops = &nfs42_layouterror_ops,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_MOVEABLE,
 	};
 	unsigned int i;
 
-- 
2.43.5



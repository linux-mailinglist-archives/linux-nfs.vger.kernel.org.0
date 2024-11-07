Return-Path: <linux-nfs+bounces-7738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEC9C02DB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 11:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91554281BC3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153941EF943;
	Thu,  7 Nov 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9RoF566"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20D1D932F
	for <linux-nfs@vger.kernel.org>; Thu,  7 Nov 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976523; cv=none; b=k5ryTHOPI/EiqyCKfxN8OwXMBnc3n6Gc030biKUFFHvnBqoOWgtNYf6Kkk99Wl1Si0L36UvcfhIXC97wQ4uf+6jdUzuGDuYMayVqXR41TPFXZf69vxMfb0a3subxuhB57abKy+T7q7NNKEpLSQDlR+4B2ItYFa1/clLp+yQ22wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976523; c=relaxed/simple;
	bh=Sdy3ffOIi7k8Sjn9zIVT7VcbkCSMRxGWs0fyYz9MKkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYwIdlM412E65wsu5uLQT40ThuIQvD8it4e+F17ZY2eCJvpc2tca+po+Xm6yW7DAI4UA8NMPrSekAPlQZBFw3V/LZuJZY7VR4YF5/8sGF+AzUYTEoyw+dgWnwt0AxEeKMTRz5VtwwLgpKFpAwmD4UX4yvxJpRyEKIpt19ZCSfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9RoF566; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730976518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KFE8a5vA6V3Hg5gG1lNgnbGvgCy1xfGED61Xl0i9E8U=;
	b=i9RoF566EevHPQ7Z5ZbY3TBkMmoYawiVDMxzkPXpz/+dPFy+pn7nU1hs3G8N+Xp8jCFcat
	gfexKSDIw5p8L65qEeppbmR1DXtdHmF5OQslaWg8ePjEtqsQUDhszGLhF84j0Zor2bBZo+
	CYliTOZ2wGAqW3cv8chvmFo5TVckdfE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] nfs: Annotate struct pnfs_commit_array with __counted_by()
Date: Thu,  7 Nov 2024 11:48:20 +0100
Message-ID: <20241107104820.1620-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
buckets to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/nfs_xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 12d8e47bc5a3..559273a0f16d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1336,7 +1336,7 @@ struct pnfs_commit_array {
 	struct rcu_head rcu;
 	refcount_t refcount;
 	unsigned int nbuckets;
-	struct pnfs_commit_bucket buckets[];
+	struct pnfs_commit_bucket buckets[] __counted_by(nbuckets);
 };
 
 struct pnfs_ds_commit_info {
-- 
2.47.0



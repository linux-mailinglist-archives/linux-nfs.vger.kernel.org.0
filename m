Return-Path: <linux-nfs+bounces-7190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40299F815
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5571C21A27
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E641F818B;
	Tue, 15 Oct 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPdt0vNJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF048176228;
	Tue, 15 Oct 2024 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729024100; cv=none; b=NbO0QEq7upQaiaicVCODU85wPGbHSB/hgnkcO2CdRrYmqnZdx0/3KZm3mhMx7032oewBTE6Gy3JDCtVxRgFWNP5+EoR4WgJmU6geBnij5RgdfC0X7yngCOGTPkSo4a3pbpNwi33V8xs55+0SwLvgW9BBw0dlLrvV4L9DAGBrOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729024100; c=relaxed/simple;
	bh=Sdy3ffOIi7k8Sjn9zIVT7VcbkCSMRxGWs0fyYz9MKkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7oglDOgvEaxA9l07RsYu8bkWwC0NnWUqkivQ0jPBHRAZ4hCcCJavcZ49ThwVQoR2feXtz5NhjxuQmGFZ+M3A7YWr4flqEmC21cFSFqI3OXL+64xxjjsaGEuppDG2VLHrp2jrcC7ojT32qcYUGm8m74U/mqJl9/U3HIVZFPqusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPdt0vNJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729024096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KFE8a5vA6V3Hg5gG1lNgnbGvgCy1xfGED61Xl0i9E8U=;
	b=DPdt0vNJZKSNbkv4TgnfylArPxdK7eEEicgPqq6lJs8Y/VT+pzCx+ZGBkHWYh7sRgIXb1q
	JPdlsGweOa2edtvO1/Edy6vJ+QwJ537JkZrAbIVqopL+uVjSFLsTllzUF1hXDb/bv0eyF5
	UiH1iz4/cken6ql7w+P9PnwMfJxI6h8=
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
Date: Tue, 15 Oct 2024 22:27:31 +0200
Message-ID: <20241015202731.2638-2-thorsten.blum@linux.dev>
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



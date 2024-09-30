Return-Path: <linux-nfs+bounces-6728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1D98AB50
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 19:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3778B24356
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 17:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B4198A22;
	Mon, 30 Sep 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="swlaiiIf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF759194083
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718329; cv=none; b=cMM0b2sJNQKUszyOQ4Inpl5XOelsRbF5GaG0ujyiJw1F6052oCUk1THpckSbG1FKYPQ6PY3YnRTBdR9eOH198+LqYluAQd8GoAmi80PbmdnJPiiSKRv95DdDC7FmxiVFXR12XwWqgGRUBzX/iFlvfYXHapr1RA7zadDvVzotRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718329; c=relaxed/simple;
	bh=OW970fbTbZEClTdWgY0zip4Z6bYYxeUrLXyoiOqtzXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjzuxGjew8S09NuAzQfWr57LrtpF4Kb8G/Y4In87R1IO12lchS8m8UfLAzMllcLIqFDF6VqBXh/2fY7sazoknN+dD9L9t2aHch6cUjAJwaJd/0iyxqRZxKlmNxiGKfNiKceh7k7LMsRyq6vMyxQ/QGhzvPp+55WkBgw0HB0ZgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=swlaiiIf; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727718324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ANXDtTTV9RG9Ua0g7qN66Rxbf8kV+/6kDcxaqIEYfh4=;
	b=swlaiiIfKrln14SR7tkLuj8smc97k6Djl/tHGZqj52gRv9cDmkHg0jKWZQQ+2DyxmHcBr6
	RxZGJQeoqItybDlU5k+37Wy/Jj2xBCPC23G91iLtFVQE5mDRRADfHIOOrt+xdNxVYjumuQ
	DL2ylCHvVz84k8IKpRN3kYVCXFCfl3E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nfs: Annotate struct pnfs_commit_array with __counted_by()
Date: Mon, 30 Sep 2024 19:33:54 +0200
Message-ID: <20240930173352.136553-4-thorsten.blum@linux.dev>
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
2.46.2



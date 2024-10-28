Return-Path: <linux-nfs+bounces-7526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587019B2E9E
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A20E1C215BA
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E691DA23;
	Mon, 28 Oct 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i/F376S2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC371990AD
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114015; cv=none; b=iltH+VCEkYQBDAy1ZPIsI6uCxEhL8CZahwS5dwjSga+sX9UIJEgmAfqwJc3IcHNPz8RIApxGPIvsTsK+vpmkssC8rXiN/RDp5kXusFTfF0jVVvYNL0WfR7gAmiYWvmG6fe8bFjasy5tK/fY4YGSyNclTaP7H1WZd6VetnHkGYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114015; c=relaxed/simple;
	bh=NDaI99AhgBFWa34DzClcPAICbyApKXJLL06DCw7Bvk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GY+zzRqbj4eDY3qeFq1xCqE7jihQCButNVYAKhU6uIQsdZWY40oKoIu9iNBw2IbJHigFdAxzPLAP1G58Ngxs17U04dQBfVAjh+8x0QU0eDN/AuJFcHyLZNDBLLVJZDaMBWlUly2UXQDALn8leO6EHkm3vLOv/aDs67zEZ4KK9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i/F376S2; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730114010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzRs0q/0tQyiW8Vvg1wCm1ZdQPd1qYE7s2gqV/ibHLY=;
	b=i/F376S20eO5IHZaY+lVxqg+2yn/mriiP0DG5CSmYoOTi44u2VInsYFrWqm6UoOr5594Ga
	iJoaBy6Drrhrg3upCSVFPBFkgYJmZuvPHKo2ivzxyn/Q5e5zUC8Z3/0FlkRpBMHbcX+TLq
	2iFkUD9z7R/fqLlHkUy0g2F6pUxwqbQ=
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
Date: Mon, 28 Oct 2024 12:13:12 +0100
Message-ID: <20241028111312.2869-2-thorsten.blum@linux.dev>
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
index e0ae0a14257f..e74a87bb18a4 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1331,7 +1331,7 @@ struct pnfs_commit_array {
 	struct rcu_head rcu;
 	refcount_t refcount;
 	unsigned int nbuckets;
-	struct pnfs_commit_bucket buckets[];
+	struct pnfs_commit_bucket buckets[] __counted_by(nbuckets);
 };
 
 struct pnfs_ds_commit_info {
-- 
2.47.0



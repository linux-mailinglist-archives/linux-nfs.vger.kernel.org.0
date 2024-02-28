Return-Path: <linux-nfs+bounces-2104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482086A70D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 04:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353ABB2ABAB
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA21D53C;
	Wed, 28 Feb 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OxgEMrqf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6122107
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089978; cv=none; b=YANWDiNz5AFdDtNmQ125d6aoJIL+gqQKg49NN8RJC7cbwunQAciHd2tmODxwrXZ3ZoEFr68ttui5xN3AvFbJ0Z2XvutyTvO8xi/gBh9+1y5Mkfhg/OtW8gkLh4+4nm70povzmQpe1ViZSwObCfowp7FDfdb9YfscQ23xHMafLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089978; c=relaxed/simple;
	bh=I/eHMEcO16yx/j3JgMMPsVzPtktZD6jAemkrCGo4SZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exwg3za4Of/jKgHxpOsqYuylz0hziuo14rPCovhfD6CnaTkIYlFVfBl99Py2ILnr+YK46Eu+6PU5YCuHPFRBSKaPTPRB9MwK+aoSdIjDMhZv965xzznjP5CKR8bF6LH7cZ+VMjwjjy8gGxtmU97k3VjQKl40Ck1usiVCl/vKj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OxgEMrqf; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709089974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+CfwfwwXs35+oys4wWB8aNc/E0TpV+2eGWwsWt9upU=;
	b=OxgEMrqfMixwlftCYzgZJ2wrKqlNkNHhuZS7xYgKBnvr+QFaAbsx3OkiuJknH2SP6MMlpU
	GmShJH7h5q+Z4fm9xp9jtrV7rhLLoNycKjx8RMiugaEmRayvn3W/Jd8L2XyeeYppnHnAW7
	C9FwoK4hZO7bn7+dxtzm4q7WyTEnY2Y=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: horms@kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3] sunrpc: remove SLAB_MEM_SPREAD flag usage
Date: Wed, 28 Feb 2024 03:12:34 +0000
Message-Id: <20240228031234.3512969-1-chengming.zhou@linux.dev>
In-Reply-To: <20240227171353.GE277116@kernel.org>
References: <20240227171353.GE277116@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v3:
 - Improve the indentation, per Simon Horman.

v2:
 - Update the patch description and include the related link to
   make it clearer that SLAB_MEM_SPREAD flag is now a no-op.
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index dcc2b4f49e77..b639d8eb6080 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1490,7 +1490,7 @@ int register_rpc_pipefs(void)
 	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
 				sizeof(struct rpc_inode),
 				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+				    SLAB_ACCOUNT),
 				init_once);
 	if (!rpc_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1



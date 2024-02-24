Return-Path: <linux-nfs+bounces-2071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02C862566
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Feb 2024 14:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18F9282F13
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Feb 2024 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3C4C63F;
	Sat, 24 Feb 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c4wEiAfu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398943178
	for <linux-nfs@vger.kernel.org>; Sat, 24 Feb 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782722; cv=none; b=FWhkE4tXsSoGJN0GQN0QRRlNWWyV1v3jyPtYvjMdK2uZ/FlfGfegZJQk44RJizcXVX+uxp4OBwsaLYJHR7xuWBt9pRsiJlYeP+sv7xO25gSC7J08K+z8uba2v3dule5XllDiJ/xbPoC/szgUfcAE96MChpbgyn/jfFTOJ5MDkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782722; c=relaxed/simple;
	bh=RAwLP4FL7g3YG90XVDrkOyp/C+5D0yHVeVpnj4F3HQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pigsSeVd1A/cwjdv4C89L2YirtUwPWcG0nST3ZR6g3BbW3jwRJsMewRwVXH4mYlJVOQ3eypATOE+w6Lx5ftlA4/5sn9ArYyPGwoKNMileIKTniNQdrIefMKPjUp5EoHCadRWaojQ1YQrgiRxq5LCaFIw58vJOe4EEctN+NDk6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c4wEiAfu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nhld/q3SVJCpH9JDcDmQlpv68zE8XG9Vxq5MWHA58E0=;
	b=c4wEiAfuICV4Ka7yndl74dHwvO52WstZyEmaGai/CFGu8iC8PxlSUwq8Le+tmi08MSVfc1
	ql11aP8R3IhUZaYdevWSbV8b4f13M8gtAXz4KjpIOf8BMOmwr5mcKGxEdoTPVn+0KS7GOv
	XmKw7zrNub/1CXwxqJudUaybpNSWMZc=
From: chengming.zhou@linux.dev
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com
Cc: Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sunrpc: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:51:49 +0000
Message-Id: <20240224135149.830234-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index dcc2b4f49e77..910a5d850d04 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1490,7 +1490,7 @@ int register_rpc_pipefs(void)
 	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
 				sizeof(struct rpc_inode),
 				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 				init_once);
 	if (!rpc_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1



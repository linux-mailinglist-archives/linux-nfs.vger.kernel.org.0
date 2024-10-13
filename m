Return-Path: <linux-nfs+bounces-7117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2899BB8C
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Oct 2024 22:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6081C20F5A
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Oct 2024 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4C1A01BF;
	Sun, 13 Oct 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="HhY4jvr6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABB19D07C;
	Sun, 13 Oct 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850701; cv=none; b=R8DRHUvXVCvNCV8b5JOpE9mDeNJU/V9yu+EPuNirpI8LCR3kPga9QO+1TDn0S8n7ATs+/iOCpvSli8pzA1zuiSttBfTwC7ymY/W9LL6+yOV+AUdnxEe0Dha23PVJ36xT8kZjvPejGKYxR6sIpNkiB+B7m7jZ6MPDy7bOxtRMkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850701; c=relaxed/simple;
	bh=DrJQTO35gURIzMWDA1Xrtl/GnXXrzdIRvR4rdWuMifo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3+KzDAvIP9vnyyr0MoGbScRG0s2S+te17Ye5j2ruyvlfgNO/1yrzqyafMCypMK1v5LB0SryNDBvE7tyXEEH7Ze3B/Fmutv0BuNebvGc72ylbTZGc425tPlLsAY1eT+FiRbIxipYYGK9CpCmOr/gvAA8DI9ZygfcB8EXtlk6WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=HhY4jvr6; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sv/0c64ZMldzQnp+VPu6f+qECJKfFHacvG3dPrFNe/M=;
  b=HhY4jvr6wjh9gdw8jNn5cgYZtU5y2f+uR+Ggvyb3tU4hwYuXq24iCpCu
   v0sPMzF7Y1k0e2wTPtok4giLBGsH8VV6JAlMi1ipC9+Nba+h7x7vLmxtN
   8cdX7u9E5tGyPF20Oc89Ez/+60ix0I/Lalhj3nC/DRhZ+40/XlMGm79qO
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968287"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:18:00 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] nfsd: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:59 +0200
Message-Id: <20241013201704.49576-13-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/nfsd/nfs4state.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9a3ec916fb14..02adf1d551df 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -572,13 +572,6 @@ opaque_hashval(const void *ptr, int nbytes)
 	return x;
 }
 
-static void nfsd4_free_file_rcu(struct rcu_head *rcu)
-{
-	struct nfs4_file *fp = container_of(rcu, struct nfs4_file, fi_rcu);
-
-	kmem_cache_free(file_slab, fp);
-}
-
 void
 put_nfs4_file(struct nfs4_file *fi)
 {
@@ -586,7 +579,7 @@ put_nfs4_file(struct nfs4_file *fi)
 		nfsd4_file_hash_remove(fi);
 		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
 		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
-		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
+		kfree_rcu(fi, fi_rcu);
 	}
 }
 



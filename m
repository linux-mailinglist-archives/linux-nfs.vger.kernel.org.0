Return-Path: <linux-nfs+bounces-10336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC3A443AC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 15:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86223ADC3C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610DF21ABC9;
	Tue, 25 Feb 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEAE3Qve"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EB21ABC6;
	Tue, 25 Feb 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495169; cv=none; b=iVEz4zml19PtHqsd8o+2dNFnOcpEacp+8HaCOBdB6TdS7kAqEBZFHTfUeiqLoo3Qgre7+FEfWz0GdmfRgWHtiJ959E+1HIC6Lk9JBLCQkMe4fOfwD/SuMQUxOnMTjgBfkvGd+jqL9a0NYl9T3+UsSWXmqUJNwd3BIEWjP88JA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495169; c=relaxed/simple;
	bh=GGaYiwaYa4N9Fv/e4cYbdBiELgwBwoSdz0V5iPN1NwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BM0Hgs9ARM1ny23bU624vcxrh0gfLpZ++96jwf1IvYatqEa8Meu4azabjcsCKx+eEuwpUoY+gCQa82HRkoKgH2qH3ehyJjruA/i26+YKPwOpJe80Z93hlUA/W1y40U2mVOL7Is/ocNQr+E3giEHyE5ZPd9bQWyhKFZxKL91TUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEAE3Qve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40553C4CEDD;
	Tue, 25 Feb 2025 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495168;
	bh=GGaYiwaYa4N9Fv/e4cYbdBiELgwBwoSdz0V5iPN1NwU=;
	h=From:To:Cc:Subject:Date:From;
	b=nEAE3Qve0EZ0H0F2bLur/AK3DmCsUBfeU/CEzdAAxPpT5AKgB5Pa8zUQOmMw50gf4
	 gouJ6A+TvwwgAYZBgYYlrAIKv3u9zZDjHgJFa5D8krvLaBkGXOjsaS8QtBJNFLrDPv
	 qO6ORzvzjwIQwqj35Yaqh0dVWLiecHHScRfuVnJ3zE3t0g9EWZIyjklEC99751U1Rn
	 e2wwdmqEuovI+YZj5YMK3l1oxJRbSxn5c8BWpb28+B+N0BkPcVSTwFIUmFlgYVdp+s
	 9j4L8pzu6kHa8Pxwq9hPUz8NPmHY0t4cVaDmSeOYy1Ius0Az+wFhOOkiXJFIWdXU3d
	 0F4K6Bf15dAeA==
From: Arnd Bergmann <arnd@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	NeilBrown <neilb@suse.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Simon Horman <horms@kernel.org>,
	Yang Erkun <yangerkun@huawei.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] sunrpc: suppress warnings for unused procfs functions
Date: Tue, 25 Feb 2025 15:52:21 +0100
Message-Id: <20250225145234.1097985-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There is a warning about unused variables when building with W=1 and no procfs:

net/sunrpc/cache.c:1660:30: error: 'cache_flush_proc_ops' defined but not used [-Werror=unused-const-variable=]
 1660 | static const struct proc_ops cache_flush_proc_ops = {
      |                              ^~~~~~~~~~~~~~~~~~~~
net/sunrpc/cache.c:1622:30: error: 'content_proc_ops' defined but not used [-Werror=unused-const-variable=]
 1622 | static const struct proc_ops content_proc_ops = {
      |                              ^~~~~~~~~~~~~~~~
net/sunrpc/cache.c:1598:30: error: 'cache_channel_proc_ops' defined but not used [-Werror=unused-const-variable=]
 1598 | static const struct proc_ops cache_channel_proc_ops = {
      |                              ^~~~~~~~~~~~~~~~~~~~~~

These are used inside of an #ifdef, so replacing that with an
IS_ENABLED() check lets the compiler see how they are used while
still dropping them during dead code elimination.

Fixes: dbf847ecb631 ("knfsd: allow cache_register to return error on failure")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This patch from last year is still needed, resending without changes
---
 net/sunrpc/cache.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 6e36b1204f51..004cdb59f010 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1678,12 +1678,14 @@ static void remove_cache_proc_entries(struct cache_detail *cd)
 	}
 }
 
-#ifdef CONFIG_PROC_FS
 static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 {
 	struct proc_dir_entry *p;
 	struct sunrpc_net *sn;
 
+	if (!IS_ENABLED(CONFIG_PROC_FS))
+		return 0;
+
 	sn = net_generic(net, sunrpc_net_id);
 	cd->procfs = proc_mkdir(cd->name, sn->proc_net_rpc);
 	if (cd->procfs == NULL)
@@ -1711,12 +1713,6 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 	remove_cache_proc_entries(cd);
 	return -ENOMEM;
 }
-#else /* CONFIG_PROC_FS */
-static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
-{
-	return 0;
-}
-#endif
 
 void __init cache_initialize(void)
 {
-- 
2.39.5



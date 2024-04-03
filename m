Return-Path: <linux-nfs+bounces-2614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB289684F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 10:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9891F221E2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC412C81F;
	Wed,  3 Apr 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz7ILvZD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B326EB69;
	Wed,  3 Apr 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131826; cv=none; b=uAI5pkgGucJoTX5nNzfuQOcxWKILrj4k4kpAQsLTLfh3Qn6yy5RKrLOLNTQ4zASL+fYUSl/LZRsYhKOtQZsa6yNoXCQycWwHfVP2wS+k5lEkVhGWZj+FghdKBDa9oxZY71vwePq4UERrXJCeyCVexaWWhrHqY+y1v2mVyI0Hfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131826; c=relaxed/simple;
	bh=WiucSDfey+Rb6VSKODVbCb1E0/6xwr83CCZttDwFyxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcmutEs423l2Vin/I7nPIeQEab+Yzrxn+cAB6hAJPpDA3KxKrpI55t21tTZr+wGQEm0PmN1jAaLwdo/VjcO1X7BYwn9pYccUJ+u5p/gCcobtTvXQZHjijZqTT+QXhiQBH8CURQTuGMC7SXMH5mWOezvAHoyWn8UXFr/SRIol4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz7ILvZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85028C433C7;
	Wed,  3 Apr 2024 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131826;
	bh=WiucSDfey+Rb6VSKODVbCb1E0/6xwr83CCZttDwFyxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz7ILvZDBSKlkXfydHLWZoo0LaYg/BPPpzBh4G9ExyldItTq+LggHRx356xDCgMgs
	 iqDoFL52fC3ArfKjtL+Vn1yGtnlmb5hHMYUmXMo2xyMgRBqx6dMPka4uxyOyQMVMDs
	 SzjXYwqzpShMZxzH6dbOaqLv7vU8odUsBvkPNXvalCCxRYeuH/uFF0A9kxdWhCgXlk
	 g6wY/Pxa4Gh0HKTYvtJUC/hpHcO11BQUc9QnP1b6Ie+P6LGcX6IiRjpqdwS2UCWH+H
	 F76jLFqc3FaCDhY55Pd6zfq88o0iXYgQuXpt2qgQYQXPznmM/FwvG52D4AmIm1sAWk
	 LXB2BVTileS+A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
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
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 19/34] sunrpc: suppress warnings for unused procfs functions
Date: Wed,  3 Apr 2024 10:06:37 +0200
Message-Id: <20240403080702.3509288-20-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/sunrpc/cache.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 95ff74706104..ab3a57965dc0 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1673,12 +1673,14 @@ static void remove_cache_proc_entries(struct cache_detail *cd)
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
@@ -1706,12 +1708,6 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
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
2.39.2



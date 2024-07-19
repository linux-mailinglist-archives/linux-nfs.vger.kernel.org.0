Return-Path: <linux-nfs+bounces-4990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1279376D1
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 12:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91961C2172B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jul 2024 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB59D83A14;
	Fri, 19 Jul 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flueAhhX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2181B86D2;
	Fri, 19 Jul 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386511; cv=none; b=jXOv6n6yIUFpJu23K+sKLqeKpDo4f+jfyaRsHOSKFO5ZP3wvb+nIxMQHFwlOX/kUKgka1nizTyO9/lzXMf77Jlskzvdv3jbIjdvts50uFcEcgAfLyLB30pduwSML48aEo0f0HFivjtzG54X59EkKOmxvH7x5TvlMPwZce5Z2oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386511; c=relaxed/simple;
	bh=tRc7PjGSMh4bGnyacW2bz72PhaCQ5DgrmTAsTERyw6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzGJPtXtIgf4k1xQ1oDXzIyLrf4ZurE2RT39E+e9LNorDSkU6qXsk2NQt5PVMly2M7sDuij6J/fLCRVs584u6GQiEiMZIcNlnWJq5JHwLUuiUyVY90IJxBH34ZClWbRJXId/ZVO9s8EPTCJDYk/xEfb1OU9uyKrmUbPeotuJrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flueAhhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBB5C4AF0A;
	Fri, 19 Jul 2024 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721386511;
	bh=tRc7PjGSMh4bGnyacW2bz72PhaCQ5DgrmTAsTERyw6A=;
	h=From:To:Cc:Subject:Date:From;
	b=flueAhhX7grrBNdjpSudqvQs6irmPLufp4vbb6u8LKouIjCij1HY2iwtP+H9LnR2y
	 g0eUQO+rplGcg6AOVzbXpjRQYMwoySSkQzNCnH5G5LuMhH2JRKCsufkFNSZF/maPTf
	 5oG/jflMH7zP205h5bFnq1vVVDmnsQb8ZXsYukg9wQ7q7Lmh8mY7UKQdqp7SVMsyxi
	 ZcQS7lGkwlaAoRGHAELtl5GIkznELwynjk4CWL/YZzLZiVnzQIKy9irvbUFXyIUK6I
	 EnFifVgW8QCeUY8YinOlfgi4pssI73aXQvt1HQUb1ml6dUIJmLdG5IGFJi9qZ9hFRW
	 1FdCcoz4ISpxw==
From: Arnd Bergmann <arnd@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sunrpc: avoid -Wformat-security warning
Date: Fri, 19 Jul 2024 12:54:22 +0200
Message-Id: <20240719105504.1547187-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using a non-constant string as an sprintf-style is potentially dangerous:

net/sunrpc/svc.c: In function 'param_get_pool_mode':
net/sunrpc/svc.c:164:32: error: format not a string literal and no format arguments [-Werror=format-security]

Use a literal "%s" format instead.

Fixes: 5f71f3c32553 ("sunrpc: refactor pool_mode setting code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/sunrpc/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e03f14024e47..88a59cfa5583 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -161,7 +161,7 @@ param_get_pool_mode(char *buf, const struct kernel_param *kp)
 	str[len] = '\n';
 	str[len + 1] = '\0';
 
-	return sysfs_emit(buf, str);
+	return sysfs_emit(buf, "%s", str);
 }
 
 module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
-- 
2.39.2



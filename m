Return-Path: <linux-nfs+bounces-6588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224DE97DE3F
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2024 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC0281187
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2024 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D783A1DB;
	Sat, 21 Sep 2024 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFRddyV3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAB1367
	for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2024 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726943143; cv=none; b=U5wrhlWNGWZnauv7g9YhVP2WG4DyGTFMYflVm+FpWt2xMYrnUxelf/1rB/c8+O0NTUYPBwTv94V0Bf+9i2TcNOLxNdCNgYLBDjlpwlppYMF7K9Ubcmleko2vcdcU8kne9yaKnd2jnU5I9ObAY+FnWqCzAfT/mYxI05A1vXGEJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726943143; c=relaxed/simple;
	bh=0PeYyHnQ8iBH3iEfzZstX5FYNPCJuwp+qE1190L1+m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBu1ge9sv92HLES+m2ATXD9cyFPZ/iaO6Q6yyAeK8P+rYAR0UMqUR6dH4wtHLFaAs4XwWGL9y42PpUfMTGelxohcQDgu6ZMvoUiLVY4QsQmMH1gBpz6xIEzL461Jy811VzQNvDZ5pZo3QaOwhXE/Fvx9UI6WSFL229S2mTDYAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFRddyV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725EDC4CEC2;
	Sat, 21 Sep 2024 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726943142;
	bh=0PeYyHnQ8iBH3iEfzZstX5FYNPCJuwp+qE1190L1+m0=;
	h=From:To:Cc:Subject:Date:From;
	b=IFRddyV36dX/88qaGmaZ8TAR1il0xq2qv450+sNWUOFJYnQfdl2gBA/QLxe7XVOqb
	 dr62MEQVf+IrOwS0LFFmgyS0ZHOVzR4tOtz2AQEqU24ys6RM0tPcxYJCvx7nxqYv7B
	 BQZUwQuX7+GLmtgrsAv2gDND73Mhvd3k33U1wedzeDd1d9i7faT9DWVTR1bgTfPeq2
	 cwhnNYpou5AOKu6OPT/oC0ertdI0r5YR2/a0xbZ3Zq2ftc4QQ05LXbJQyrCX6p17o+
	 kBOnfJ8nZ57s5xZXdXmioQ36wu7lSxUenqefxyIJyrOBoI3uR1e6f/lgrPdfDXP4q0
	 VICUqvNUy1RQA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Mark filecache "down" if init fails
Date: Sat, 21 Sep 2024 14:25:37 -0400
Message-ID: <20240921182537.3899157-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NeilBrown says:
> The handling of NFSD_FILE_CACHE_UP is strange.  nfsd_file_cache_init()
> sets it, but doesn't clear it on failure.  So if nfsd_file_cache_init()
> fails for some reason, nfsd_file_cache_shutdown() would still try to
> clean up if it was called.

Reported-by: NeilBrown <neilb@suse.de>
Fixes: c7b824c3d06c ("NFSD: Replace the "init once" mechanism")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 24e8f1fbcebb..2603183305b4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -723,7 +723,7 @@ nfsd_file_cache_init(void)
 
 	ret = rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = -ENOMEM;
 	nfsd_file_slab = KMEM_CACHE(nfsd_file, 0);
@@ -775,6 +775,8 @@ nfsd_file_cache_init(void)
 
 	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
+	if (ret)
+		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
 	return ret;
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-- 
2.46.0



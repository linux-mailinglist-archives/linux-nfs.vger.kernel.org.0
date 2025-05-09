Return-Path: <linux-nfs+bounces-11640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F4AB1D11
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EE31C06F2A
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A672451C3;
	Fri,  9 May 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7zBHdpm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1924503B;
	Fri,  9 May 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817452; cv=none; b=EuLwgTzOkbcM/EZ/9EZgU/zWcXJSDF/A6RxRZhDm4Isq/OUHqW+aqV6jRXQYTvhnK7K0p1/HsXvVSWXQ2XS/juXiI3RIWJfv/gf+1KVliRDu+Z4A9dwABj/zbcDnQLrRNpI2Zr7moHdZTzeLTtUDa23fu8t+uo7wl2WAr/yzAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817452; c=relaxed/simple;
	bh=XF5XjGREKjm83XIuz4sVH4oF39uP/aGJohyO+jQxD3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e93iGUXtlQvJeHxreh3X+tuA2yfme+2i3sGaHv8CsQ0us1iDhfM2wdxkGlt38KEChR+GRd9z3BrlR5onVqFOWYjQJA4dZt5zovhJxawZobxASiNcW0NXnGeI7F5C9AjRiLUWjZ1dM/rl2wXyoqyjGNMM57oNyAiHaCTSBEnZLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7zBHdpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DD7C4CEF1;
	Fri,  9 May 2025 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817452;
	bh=XF5XjGREKjm83XIuz4sVH4oF39uP/aGJohyO+jQxD3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7zBHdpmsLULBrWKqCSRf63EUdNCPT952Bnh4Vd7W/HgjAajrgqprvWaT0cUYzoIg
	 RDNdL6OM/XOzqBK70WRVLCdHfHoKaSp+O3t7IqHp4dkUCIGRrOJEHn09+tziG80Y59
	 vpV1zSv7/SBgRtO7upuub68GTOaLFkZbNBySDDNYAMBp6MhiOcsrPt97sMM1IYok5b
	 DYDMSGVcxP/sTsSZGDm9IA89czt3VL6o63Njh0wXQG7ZEdq9a1tX08s+ypR9K5XIBT
	 90tGNgEMXuJJlYCg2g8Sy+UhJd8cjOB2N9O4tBrSSif0DToyMIrZoS5arKtasTM/Su
	 zKwdeo6HLxV8g==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 18/19] NFSD: Add a "default" block size
Date: Fri,  9 May 2025 15:03:52 -0400
Message-ID: <20250509190354.5393-19-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

We'd like to increase the maximum r/wsize that NFSD can support,
but without introducing possible regressions. So let's add a
default setting of 1MB. A subsequent patch will raise the
maximum value but leave the default alone.

No behavior change is expected.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h   | 9 +++++++--
 fs/nfsd/nfssvc.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6428a431d765..1bfd0b4e9af7 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -44,9 +44,14 @@ bool nfsd_support_version(int vers);
 #include "stats.h"
 
 /*
- * Maximum blocksizes supported by daemon under various circumstances.
+ * Default and maximum payload size (NFS READ or WRITE), in bytes.
+ * The default is historical, and the maximum is an implementation
+ * limit.
  */
-#define NFSSVC_MAXBLKSIZE       RPCSVC_MAXPAYLOAD
+enum {
+	NFSSVC_DEFBLKSIZE       = 1 * 1024 * 1024,
+	NFSSVC_MAXBLKSIZE       = RPCSVC_MAXPAYLOAD,
+};
 
 struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8ed143ef8b41..82b0111ac469 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -582,7 +582,7 @@ static int nfsd_get_default_max_blksize(void)
 	 */
 	target >>= 12;
 
-	ret = NFSSVC_MAXBLKSIZE;
+	ret = NFSSVC_DEFBLKSIZE;
 	while (ret > target && ret >= 8*1024*2)
 		ret /= 2;
 	return ret;
-- 
2.49.0



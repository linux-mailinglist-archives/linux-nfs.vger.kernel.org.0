Return-Path: <linux-nfs+bounces-3173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40FB8BD2F1
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 18:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DE32831C1
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE69156880;
	Mon,  6 May 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UchdTAYW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3A156238
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013369; cv=none; b=qVyFs1fKtaSKBodWN69LoUbubjueg7/JEuOpd1Wlkaan7jbUk7qo/nXi3Az9WVtekJ9iQFEalpeKvs7WrR/9Tj1rw9bgZMfVPnvVArjRX6/VnDbFQA8avV0XNIQJhZg46lLVDCoeK/yoPmWPd//xexrQVaK+29/36cGhK4ZFlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013369; c=relaxed/simple;
	bh=ErxdyRkAnW+mbi0QdfJgTFuHj4KhdfTdot8dT9rY2LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCVPSxYlSBDNrt1kpaxePkEe/FRti44YmqX5Qayl/M10QGdFBBFoyt4ZKdbIdr4dj+kkkI0AsHvFtmMFRgpj87/NmK8ttx24PzLJ3rAIaAfCpSDjNwrI+4dit/iwMr/1D/T20POGKKFPKUKa/JorIb/jSuxfqXm80TsCFOM96N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UchdTAYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D187DC4AF63;
	Mon,  6 May 2024 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715013369;
	bh=ErxdyRkAnW+mbi0QdfJgTFuHj4KhdfTdot8dT9rY2LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UchdTAYWEhFj5Yhm8Yq6+MlGdu9qUChV6f0Qxk9g5j9SSc/PXjGtSFbPlN1cxmA9o
	 3Zts61b06j4JJac18AEs7CpbCfWdExuVOE//ui2RxviOxokgS0PebAak3xoMZr0Zn9
	 8mPrU7CskdQzA3wKDs6tGYoA80YtOSMDEFhrzQwJRdNzBCX9qZH4HLKvsgmJIakZjw
	 j9qJLziYy4GYYQfLx4LVVpWv1ntW5MsRcTWyChk7VCIMFyxCMI0te6o9H2T5zvoey/
	 wQjfELEdDch/hsbODdjLQzRBPS+tN9JNHjz9U1pX2XEx0D05TEuOURLhANaIQiATb0
	 q9VRcShpVfe9g==
From: trondmy@kernel.org
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS/knfsd: Remove the invalid NFS error 'NFSERR_OPNOTSUPP'
Date: Mon,  6 May 2024 12:30:05 -0400
Message-ID: <20240506163005.9990-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506163005.9990-1-trondmy@kernel.org>
References: <20240506163005.9990-1-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

NFSERR_OPNOTSUPP is not described by any RFC, and should not be used.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfsd.h           | 1 -
 include/trace/misc/nfs.h | 2 --
 include/uapi/linux/nfs.h | 1 -
 3 files changed, 4 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 304e9728b929..d1e4a8f159fd 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -229,7 +229,6 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_nospc		cpu_to_be32(NFSERR_NOSPC)
 #define	nfserr_rofs		cpu_to_be32(NFSERR_ROFS)
 #define	nfserr_mlink		cpu_to_be32(NFSERR_MLINK)
-#define	nfserr_opnotsupp	cpu_to_be32(NFSERR_OPNOTSUPP)
 #define	nfserr_nametoolong	cpu_to_be32(NFSERR_NAMETOOLONG)
 #define	nfserr_notempty		cpu_to_be32(NFSERR_NOTEMPTY)
 #define	nfserr_dquot		cpu_to_be32(NFSERR_DQUOT)
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 5387eb0a6a08..d919e6e2c736 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -28,7 +28,6 @@ TRACE_DEFINE_ENUM(NFSERR_FBIG);
 TRACE_DEFINE_ENUM(NFSERR_NOSPC);
 TRACE_DEFINE_ENUM(NFSERR_ROFS);
 TRACE_DEFINE_ENUM(NFSERR_MLINK);
-TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
 TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
 TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
 TRACE_DEFINE_ENUM(NFSERR_DQUOT);
@@ -64,7 +63,6 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_NOSPC,			"NOSPC" }, \
 		{ NFSERR_ROFS,			"ROFS" }, \
 		{ NFSERR_MLINK,			"MLINK" }, \
-		{ NFSERR_OPNOTSUPP,		"OPNOTSUPP" }, \
 		{ NFSERR_NAMETOOLONG,		"NAMETOOLONG" }, \
 		{ NFSERR_NOTEMPTY,		"NOTEMPTY" }, \
 		{ NFSERR_DQUOT,			"DQUOT" }, \
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index 946cb62d64b0..f356f2ba3814 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -61,7 +61,6 @@
 	NFSERR_NOSPC = 28,		/* v2 v3 v4 */
 	NFSERR_ROFS = 30,		/* v2 v3 v4 */
 	NFSERR_MLINK = 31,		/*    v3 v4 */
-	NFSERR_OPNOTSUPP = 45,		/* v2 v3 */
 	NFSERR_NAMETOOLONG = 63,	/* v2 v3 v4 */
 	NFSERR_NOTEMPTY = 66,		/* v2 v3 v4 */
 	NFSERR_DQUOT = 69,		/* v2 v3 v4 */
-- 
2.45.0



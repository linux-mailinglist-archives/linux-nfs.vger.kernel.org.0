Return-Path: <linux-nfs+bounces-3712-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3869062FD
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F6284941
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCE7E0FC;
	Thu, 13 Jun 2024 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQzrXj4V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291C4084E
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252264; cv=none; b=Wx+DDb4ZuMDH/x0VzagSB5I++xuebu5l86FpFwYsY9RtHf/OkCSd7E4SEv8nN3ITrCgYeGlxjx9lnSgxVne9FJeLXOtmRnr0whxW/rTxpPaXNqHOWf02nVmazt9Vh98eT0GdMJ2lLXkDvTLUvPTtk2TABQ8GOAoGTB34FKJvwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252264; c=relaxed/simple;
	bh=4DpuIv/XKePEoOz/wMeCOu1qC6FKeWU8sPXC/I4ZWSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDdnfnRF1AixRutTK/M95cjwwuBJDQ+MK0YFWcniT969A+0AiGMCZS56Q0NEgy0Rr+diyjjZIVuXuKAfuGz4cw6Ci3OaBp7k0emM/EkJ/PIw3owhMjcvXKKkK817T6BQE/Sz4gnyRPtrd552jkL2Xo0Xk+E6FdY2cpmF/XZuFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQzrXj4V; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44056295c8cso2948431cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252262; x=1718857062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y54cIM5xzZkxpTVACLvhO5OLYhYLH77S4+KM+7kOVrU=;
        b=CQzrXj4VcsIQjPKeiUkvnCanvDb5vunHb4ZX/TzXRCpmQrWZI1dRAzsa9lS7Cm65tH
         MZzmNwYr5i1ID+6fSMrlcuukB9ZlMR5yWGZ9SxtZXZWjzZiB5uVCPGf5lqVHzOOqXn1Q
         okqrjf4P/gDK67g+X80KUG5lzzvCye+5TKM+fnAlUMzVT+diUj7mT+VKszoLkT/4TkbW
         11aXKCY+db1gwctYKhuDJ6sSKzTMd88xRguepjS0NE9sg2iBVRuyl/OctizeMUZ0Fkr3
         w/XRDDNX35JLepF971JN1Rhh0bkY96baTP0UrWcPQd/KWoB/i5miE6wb8dlyRiEvpjCs
         9F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252262; x=1718857062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y54cIM5xzZkxpTVACLvhO5OLYhYLH77S4+KM+7kOVrU=;
        b=lxxiaC8EuFNUjv59hfEyxBOANnpikAJFL54JTRQPWPfGqVs1Dz6sDI0LltQNKfxwKV
         fZ8pXpceskVtS05KlFqMbKvliPS/dTDGU6/HowZp3biBV0rVrCV7h510iWSFnl1IkRiS
         Huwib7Vv4XGnp8wG0pofqGfPs1+/F6SK4wMzVF0NBB229vQyr9/wpSATmgb+HbqKwQgt
         w3l/v/2hZ1G+JwPIggslSQMfJ8SwLNSZnb/JxI50pWn6wt6y6dKchMciKk6ObitirGy0
         1In9V2QCmdJK1moWkz/ROpzrTzURYDGk7dbrRVpzzizO75mvJQqFPLhqKDKqIy/kv5oL
         K4Qw==
X-Gm-Message-State: AOJu0YzIsStP0VBulixxFErQU59fCBWzCjSQ877q8oihviuBoTANdNS8
	HgsvMvmr1w1zaDLUO6vQVAfe8u4YPW71qzxGWNJ8HMGgxSp6AYlukrgN
X-Google-Smtp-Source: AGHT+IG2t9eDgBgfi4SR5+SbkzrJYmt9f/9BornQAfsyyLsD0i9xZd6EUQvqO40JZb5/I44pIt0Xtw==
X-Received: by 2002:a05:6214:2b93:b0:6b0:7f36:8ae1 with SMTP id 6a1803df08f44-6b1a731b5b9mr38278526d6.52.1718252261693;
        Wed, 12 Jun 2024 21:17:41 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:41 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 03/19] NFSv4: Add new attribute delegation definitions
Date: Thu, 13 Jun 2024 00:11:20 -0400
Message-ID: <20240613041136.506908-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-3-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Tom Haynes <loghyr@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         | 2 +-
 include/linux/nfs4.h      | 9 +++++++++
 include/uapi/linux/nfs4.h | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 639f075e01e9..ce47cf2f9301 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3852,7 +3852,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_XATTR_SUPPORT - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_TIME_DELEG_MODIFY - 1UL)
 
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index ef8d2d618d5b..bc13d7f04e8d 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -367,6 +367,8 @@ enum open_delegation_type4 {
 	NFS4_OPEN_DELEGATE_READ = 1,
 	NFS4_OPEN_DELEGATE_WRITE = 2,
 	NFS4_OPEN_DELEGATE_NONE_EXT = 3, /* 4.1 */
+	NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG = 4,
+	NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG = 5,
 };
 
 enum why_no_delegation4 { /* new to v4.1 */
@@ -507,6 +509,11 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
+enum {
+	FATTR4_TIME_DELEG_ACCESS	= 84,
+	FATTR4_TIME_DELEG_MODIFY	= 85,
+};
+
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
@@ -586,6 +593,8 @@ enum {
 #define FATTR4_WORD2_SECURITY_LABEL     BIT(FATTR4_SEC_LABEL - 64)
 #define FATTR4_WORD2_MODE_UMASK		BIT(FATTR4_MODE_UMASK - 64)
 #define FATTR4_WORD2_XATTR_SUPPORT	BIT(FATTR4_XATTR_SUPPORT - 64)
+#define FATTR4_WORD2_TIME_DELEG_ACCESS	BIT(FATTR4_TIME_DELEG_ACCESS - 64)
+#define FATTR4_WORD2_TIME_DELEG_MODIFY	BIT(FATTR4_TIME_DELEG_MODIFY - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index 1d2043708bf1..afd7e32906c3 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -69,6 +69,8 @@
 #define NFS4_SHARE_SIGNAL_DELEG_WHEN_RESRC_AVAIL	0x10000
 #define NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED		0x20000
 
+#define NFS4_SHARE_WANT_DELEG_TIMESTAMPS		0x100000
+
 #define NFS4_CDFC4_FORE	0x1
 #define NFS4_CDFC4_BACK 0x2
 #define NFS4_CDFC4_BOTH 0x3
-- 
2.45.2



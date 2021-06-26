Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1728C3B4F65
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFZQMY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZQMY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:12:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0834C061766
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:10:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g3so5639668qth.11
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oZRR1nycCqSTxhgA8SPtyeG5Jy/WZmNHUsDMZSUdJcY=;
        b=YxBSOnh25roVkB/2HzkTc/3xf3wQEMNUXETUNAJ3++k4mLYvGWpwr+IHWEfy3XUD3P
         UOGlS6uBVUcK9aSgGV+CNVpItzbSPwBcblNtPGaOp/9lLzRNmDqp2x4eRiAybxlstuep
         FsA2AJhExm6ABR2Vz5KFWMOcqi2xO+0OApRvWYK455gHn6k3WQBCqPdtNqMhc1gBk4Pq
         nFMzUjtHjhDhzUVUZBZbgJE08oYOBXJrhFMSTckdJWN/1EVd9lVXrrscVsou2I6EvRUt
         9yPJlBOSLrsvSnwbPO4EXH0nmZA8GmfeV1rwz+KkTddPjs1K3oddFy8F+dsNA1D95/OU
         DR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZRR1nycCqSTxhgA8SPtyeG5Jy/WZmNHUsDMZSUdJcY=;
        b=VyBk4nj6uAZFfLRbeF9Y5I3yOa05gky1m6QLoU49ApeC4uEYkdHH2M20ZcPkuiZbpy
         D/VOkeGO/qwnuTi0ZWhc53RPrnC1/u8Som6b/vrztYPvPBzQRzUUidtF5zvFxqDDtzg9
         Ev5gxB/myZICGV4Et622JM4Q+ZygSQyJqGAJxJ+L1pXZPPJRvj6e6FuY1eXXqohKKIFF
         +tGiyOt0RL1MEf7S0qX23eRsgWq+qTi2M5ZwujrcGOeJ5oPAXGsLtSsDG7y2Fnm/l9Sn
         QmAbfzz3kZnV4/kmBSlRivY7bpZ+QeqRZ/uaznbMdOWVePrLOPoVe8szAdxPr/Q/cfGK
         MK0A==
X-Gm-Message-State: AOAM5325q+0RjNZqxZzW81nxrSA3cPgJbiIsa9SoC7U5VIIkIR1BbdyH
        rDLgzHOwAYAtwUaMqA6JLlV6TF31i26t
X-Google-Smtp-Source: ABdhPJyrr0DUuVeeJuUXujzfjqFhMEOIXxRfvmvdzNohL3XPdcb4GgmBoI5TujT+7/OIrZAPCc5znQ==
X-Received: by 2002:ac8:7f4a:: with SMTP id g10mr14290412qtk.296.1624723799463;
        Sat, 26 Jun 2021 09:09:59 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id s8sm2995141qke.72.2021.06.26.09.09.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:09:58 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Add some support for case insensitive filesystems
Date:   Sat, 26 Jun 2021 12:09:55 -0400
Message-Id: <20210626160956.323472-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626160956.323472-1-trond.myklebust@hammerspace.com>
References: <20210626160956.323472-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Add capabilities to allow the NFS client to recognise when it is dealing
with case insensitive and case preserving filesystems.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         |  8 +++++++-
 fs/nfs/nfs4xdr.c          | 40 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  2 ++
 include/linux/nfs_xdr.h   |  2 ++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2031d2b9b6e3..b37a32cbefa6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3850,7 +3850,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		     FATTR4_WORD0_FH_EXPIRE_TYPE |
 		     FATTR4_WORD0_LINK_SUPPORT |
 		     FATTR4_WORD0_SYMLINK_SUPPORT |
-		     FATTR4_WORD0_ACLSUPPORT;
+		     FATTR4_WORD0_ACLSUPPORT |
+		     FATTR4_WORD0_CASE_INSENSITIVE |
+		     FATTR4_WORD0_CASE_PRESERVING;
 	if (minorversion)
 		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
 
@@ -3879,6 +3881,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->caps |= NFS_CAP_HARDLINKS;
 		if (res.has_symlinks != 0)
 			server->caps |= NFS_CAP_SYMLINKS;
+		if (res.case_insensitive)
+			server->caps |= NFS_CAP_CASE_INSENSITIVE;
+		if (res.case_preserving)
+			server->caps |= NFS_CAP_CASE_PRESERVING;
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
 			server->caps |= NFS_CAP_SECURITY_LABEL;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index a8cff19c6f00..3e6a4cec77f8 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3530,6 +3530,42 @@ static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	return 0;
 }
 
+static int decode_attr_case_insensitive(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
+{
+	__be32 *p;
+
+	*res = 0;
+	if (unlikely(bitmap[0] & (FATTR4_WORD0_CASE_INSENSITIVE - 1U)))
+		return -EIO;
+	if (likely(bitmap[0] & FATTR4_WORD0_CASE_INSENSITIVE)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		*res = be32_to_cpup(p);
+		bitmap[0] &= ~FATTR4_WORD0_CASE_INSENSITIVE;
+	}
+	dprintk("%s: case_insensitive=%s\n", __func__, *res == 0 ? "false" : "true");
+	return 0;
+}
+
+static int decode_attr_case_preserving(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
+{
+	__be32 *p;
+
+	*res = 0;
+	if (unlikely(bitmap[0] & (FATTR4_WORD0_CASE_PRESERVING - 1U)))
+		return -EIO;
+	if (likely(bitmap[0] & FATTR4_WORD0_CASE_PRESERVING)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		*res = be32_to_cpup(p);
+		bitmap[0] &= ~FATTR4_WORD0_CASE_PRESERVING;
+	}
+	dprintk("%s: case_preserving=%s\n", __func__, *res == 0 ? "false" : "true");
+	return 0;
+}
+
 static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
 {
 	__be32 *p;
@@ -4409,6 +4445,10 @@ static int decode_server_caps(struct xdr_stream *xdr, struct nfs4_server_caps_re
 		goto xdr_error;
 	if ((status = decode_attr_aclsupport(xdr, bitmap, &res->acl_bitmask)) != 0)
 		goto xdr_error;
+	if ((status = decode_attr_case_insensitive(xdr, bitmap, &res->case_insensitive)) != 0)
+		goto xdr_error;
+	if ((status = decode_attr_case_preserving(xdr, bitmap, &res->case_preserving)) != 0)
+		goto xdr_error;
 	if ((status = decode_attr_exclcreat_supported(xdr, bitmap,
 				res->exclcreat_bitmask)) != 0)
 		goto xdr_error;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d71a0e90faeb..14f41ab6db93 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -270,6 +270,8 @@ struct nfs_server {
 #define NFS_CAP_ACLS		(1U << 3)
 #define NFS_CAP_ATOMIC_OPEN	(1U << 4)
 #define NFS_CAP_LGOPEN		(1U << 5)
+#define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
+#define NFS_CAP_CASE_PRESERVING	(1U << 7)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
 #define NFS_CAP_STATEID_NFSV41	(1U << 16)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 717ecc87c9e7..4e0afed4e740 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1201,6 +1201,8 @@ struct nfs4_server_caps_res {
 	u32				has_links;
 	u32				has_symlinks;
 	u32				fh_expire_type;
+	u32				case_insensitive;
+	u32				case_preserving;
 };
 
 #define NFS4_PATHNAME_MAXCOMPONENTS 512
-- 
2.31.1


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672A31A6C2
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhBLVUw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhBLVUm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Feb 2021 16:20:42 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B8C061756;
        Fri, 12 Feb 2021 13:20:02 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y15so449762ilj.11;
        Fri, 12 Feb 2021 13:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZFoPlC9Ox6zK6lUP8unB6mEMSEpKmVAmcqkIvxGgLK4=;
        b=hSZZOE71IN3CjEqQK8VS+pu+X1LbA62C3V5J62sXSKRYcLrCn3Oh85hNVOm8EsdyS9
         vC8VQUXGEuGAgL6mI07S5XX2nfihYT5SVhk8xvPJ6xMbeGqU4UyfCniJH6JliaVTX0uw
         ie1ajml3LQtblOCBIIKu37P+sJhdql0jeTvID7XxGjj39i+x7IYiEWsMFBWtZDN1br6x
         bcHX1Da7Xf4aSWH36njxcQIbPWZUkie0/v2MGKW+HN9oiJ4BSOBHZ9VI3Yxv1xX7o9rn
         oykr0o2fJHXvTtx+f5wC9xaui6msMMBsa2opR+y4ReRMX46ndC8xeKlVlVQElqVJVhoS
         vnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZFoPlC9Ox6zK6lUP8unB6mEMSEpKmVAmcqkIvxGgLK4=;
        b=YM1tFcbkMNXvWRG9LwOQmZ3QCMov6EA4XucIrE5dLdbjnPURnnlx7XH+Vu2bBnWyKT
         fserhgXyOsgu8Nmzif2p8AMtTQrD5YoEzYJGjRyF1korwysPIBVGeZeY0atbBz2dCyc4
         JJieNtzDbNGNt/8N7RsELxuWFsxfwchP5+aVglALdPSiFIKvwfdgGsqvqzUnlH9f++5U
         R6ibTR2wMlwgH0+Dv8WwtgIZ/uPo73chobBz19BXaGrxGYRmZaEBZDt7hYTsCkA+XOuc
         sAXxym58viJ4Jp8dSm7Dih3BLKrFfhMcsEAGCRg/qrpetplsyIADIVd5S8sQ+y/wcRuT
         N68w==
X-Gm-Message-State: AOAM5322/DwmWWuObMHeF5N3oCPURM86wvkGOO3dgHlQMlFcNl2B9Srr
        qfWDCBrZLyM9KKT1PjxY72oTrb/pH2o7VA==
X-Google-Smtp-Source: ABdhPJzx5eE7PXldjvPvTehXqaQjzJe+J+I412FXoSM0yb9Rigf4AwDhoWZzAaty1HH0zxlA2I5VTQ==
X-Received: by 2002:a92:870d:: with SMTP id m13mr3878147ild.104.1613164801697;
        Fri, 12 Feb 2021 13:20:01 -0800 (PST)
Received: from Olgas-MBP-444.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id k11sm4685570iop.45.2021.02.12.13.20.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2021 13:20:01 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH 2/2] NFSv4 account for selinux security context when deciding to share superblock
Date:   Fri, 12 Feb 2021 16:19:55 -0500
Message-Id: <20210212211955.11239-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20210212211955.11239-1-olga.kornievskaia@gmail.com>
References: <20210212211955.11239-1-olga.kornievskaia@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Keep track of whether or not there was an selinux context mount
options during the mount. While deciding if the superblock can be
shared for the new mount, check for if we had selinux context on
the existing mount and call into selinux to tell if new passed
in selinux context is compatible with the existing mount's options.

Previously, NFS wasn't able to do the following 2mounts:
mount -o vers=4.2,sec=sys,context=system_u:object_r:root_t:s0
<serverip>:/ /mnt
mount -o vers=4.2,sec=sys,context=system_u:object_r:swapfile_t:s0
<serverip>:/scratch /scratch

2nd mount would fail with "mount.nfs: an incorrect mount option was
specified" and var log messages would have:
"SElinux: mount invalid. Same superblock, different security
settings for.."

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/fs_context.c       | 3 +++
 fs/nfs/internal.h         | 1 +
 fs/nfs/super.c            | 4 ++++
 include/linux/nfs_fs_sb.h | 1 +
 4 files changed, 9 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 06894bcdea2d..8067f055d842 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -448,6 +448,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	if (opt < 0)
 		return ctx->sloppy ? 1 : opt;
 
+	if (fc->security)
+		ctx->has_sec_mnt_opts = 1;
+
 	switch (opt) {
 	case Opt_source:
 		if (fc->source)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 62d3189745cd..08f4f34e8cf5 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -96,6 +96,7 @@ struct nfs_fs_context {
 	char			*fscache_uniq;
 	unsigned short		protofamily;
 	unsigned short		mountfamily;
+	bool			has_sec_mnt_opts;
 
 	struct {
 		union {
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4034102010f0..ea4e5252a1f0 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1058,6 +1058,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 						 &sb->s_blocksize_bits);
 
 	nfs_super_set_maxbytes(sb, server->maxfilesize);
+	server->has_sec_mnt_opts = ctx->has_sec_mnt_opts;
 }
 
 static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b,
@@ -1174,6 +1175,9 @@ static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
 		return 0;
 	if (!nfs_compare_userns(old, server))
 		return 0;
+	if ((old->has_sec_mnt_opts || fc->security) &&
+			!security_sb_do_mnt_opts_match(sb, fc->security))
+		return 0;
 	return nfs_compare_mount_options(sb, server, fc);
 }
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 38e60ec742df..3f0acada5794 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -254,6 +254,7 @@ struct nfs_server {
 
 	/* User namespace info */
 	const struct cred	*cred;
+	bool			has_sec_mnt_opts;
 };
 
 /* Server capabilities */
-- 
2.27.0


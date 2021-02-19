Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE52320155
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhBSWXR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 17:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBSWXQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 17:23:16 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E77AC06178B;
        Fri, 19 Feb 2021 14:22:36 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id s17so7282657ioj.4;
        Fri, 19 Feb 2021 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zX2Qmwu8qadQXiZiv5e82jYCoB+V6+SDLIEhvNoOKew=;
        b=f2kPdW4wVFVXe8ITiZWRfQkuGs6WVStOEV29jJ0Iwh+vOxcOQGPJuj1fa1/LcKwYGH
         a9H4+cmkQELfYW/iGoVdlN+ieUUiwlBdtW6/JYjZhj+Bk6SynpXFf3yFhxIN4hkF+Qui
         tunlfg+qJx20rCn4QA7EkmU0DC5pNXK1JsHxDJ+pQbuxP0747zvuDX3OISfhshYwBv5F
         zFCtixcRFsNKGektj338ApyCs+bjb1zclcv392/7hBbfa9QKfdNETZdWkHpXwMNcx/85
         aH67f6xaDbTM02KLsi9vF7qtuXSVbznd8CNmi7b4nB+PGQ37mfieMa11t7owEq7xYDeo
         brrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zX2Qmwu8qadQXiZiv5e82jYCoB+V6+SDLIEhvNoOKew=;
        b=EzUqeSjkeTeEvi3AO1pjDoBtp30tVsI0zYqFS3W4fjGwv0U0cPiAOMFvPPyddXgWrn
         5ADU7yZKg21SaMXVfSvt0IL320yg5Ly9fz/wLBWnk6qq/DLqtMyAlsVp4n57TVIBs0TF
         9xET44bMXoid86grHDemoc5sWw9QHebryRe8JTKIQUXUrheWXs+NkQzFGLvkpreF2yP0
         5n5ifeQT3DeF7d//c+3LoPGDKSB/xIan2TH52QIzRn75z8DvtJ25ykH4jZS1gi33ziUj
         QT5N4jgOI9X1Wv4vEIXwbXtqNDKM8t+5vfpDHDyBVo8voOqfHOaxEt+j8HXAbOeRmlYh
         4ydA==
X-Gm-Message-State: AOAM530r1uAX9G1z3cP9OFkLj/l27H70EQ3vxBuqKbXC5gYkUOmcBZw5
        +QJTRF3bRwMNTVXNHzmYEN0=
X-Google-Smtp-Source: ABdhPJyEY2sIsHPvrUl/lRyk5cAOlfHbdG0DpVyvtg9OMXuusibH81o+dnKWOE2FklzWLqJms3KO9g==
X-Received: by 2002:a5d:8617:: with SMTP id f23mr5941693iol.90.1613773354031;
        Fri, 19 Feb 2021 14:22:34 -0800 (PST)
Received: from Olgas-MBP-470.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id b19sm8456290ioj.50.2021.02.19.14.22.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2021 14:22:33 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v3 3/3] NFSv4 account for selinux security context when deciding to share superblock
Date:   Fri, 19 Feb 2021 17:22:33 -0500
Message-Id: <20210219222233.20748-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Keep track of whether or not there were LSM security context
options passed during mount (ie creation of the superblock).
Then, while deciding if the superblock can be shared for the new
mount, check if the newly passed in LSM security context options
are compatible with the existing superblock's ones by calling
security_sb_mnt_opts_compat().

Previously, with selinux enabled, NFS wasn't able to do the
following 2mounts:
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
index 59d846d7830f..686ccc04cd57 100644
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
+			security_sb_mnt_opts_compat(sb, fc->security))
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


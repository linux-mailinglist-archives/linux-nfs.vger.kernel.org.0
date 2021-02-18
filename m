Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB99F31F08B
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Feb 2021 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBRTyz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Feb 2021 14:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhBRTvb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Feb 2021 14:51:31 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A51C06178C;
        Thu, 18 Feb 2021 11:50:51 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e7so2536579ile.7;
        Thu, 18 Feb 2021 11:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6aHBRmdypFoZiI71V8Og9gbf+Km/fM8W6HWxpGfeXQ=;
        b=erQWjgXGJhU52QPR4k1WOcTSGJneg5gJIguR3V794M4+F1i3PtDtfwrMOz0cX+8cDa
         +Ml0JU67SeB548qFcxNWhWdm5TRkrzaVQvAd93FV1TLPeKrLnwxnHqn0omeIFk4pHE8h
         xI39NCps/7jI8ntQbZ7aRH2ss1wa/EatdE3Mfs6K3j5A14oaFxhpPMCI6mmLjktU/S5B
         JOlQHj+qWUuDBKDSb+g2ykqgf2xmGLj+z0Mi6A/FLobs9TgAQ9M4Ii/evvHCeY6eaOJU
         k3MN2OVccDHzk7sjD7o04tcwyhROIkOiqRrS3YQD+TZs2ivkHAYdTP/NL72WgKMQBUvx
         +CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6aHBRmdypFoZiI71V8Og9gbf+Km/fM8W6HWxpGfeXQ=;
        b=IFel2sbj6xUKJjX8oOVp4kX3ZkbRxe6llOYtHwiFnqUGExAsEhKOMRrq5KOFfydLBU
         Gq2+NiZzCau+z6BSvFM/MLLjr7mrR9AdE2RzALUUWanjzPfJ5HO66UlKR+kVz5Hdyy2+
         z4S8m6bVvcpH/RobAlOYcTfctJI44TgMxwXiLGH82RNijU/VTQfYoxMPf7/WaCU4rih0
         0y8OrfmGtIollK7BTpt1m9QVHSY6BUUeSDzg1F/9dP+Lunff3Bisg7CtKh6zFqueskqn
         epyf+J54qViDa/aS+NHBNvqQLofQQkENL5jfHObk9vPYl65/ck5RbArM5ZU3FoqOXcJY
         ULMg==
X-Gm-Message-State: AOAM530HxKy14PiucZixHpUNqYIc88E9q/khGADZnYI7iZfbB6JJfPrq
        4w5NdfbuCchaqEk7Dl7hJ6E=
X-Google-Smtp-Source: ABdhPJx8Yktb8qTCYOqHqVe4/Y4TPdE7SSLzGYbtNvnGF9Dmbi+91OYO9XOoRLr7pWgcV79nZt03Gg==
X-Received: by 2002:a05:6e02:20ca:: with SMTP id 10mr753047ilq.14.1613677851212;
        Thu, 18 Feb 2021 11:50:51 -0800 (PST)
Received: from Olgas-MBP-470.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l7sm5264557ils.48.2021.02.18.11.50.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2021 11:50:50 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v2 2/2] NFSv4 account for selinux security context when deciding to share superblock
Date:   Thu, 18 Feb 2021 14:50:46 -0500
Message-Id: <20210218195046.19280-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
References: <20210218195046.19280-1-olga.kornievskaia@gmail.com>
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
index 4034102010f0..0a2d252cf90f 100644
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


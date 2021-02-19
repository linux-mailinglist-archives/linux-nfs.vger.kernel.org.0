Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6831FD78
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 17:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSQ55 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 11:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhBSQ54 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 11:57:56 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550DC061756;
        Fri, 19 Feb 2021 08:57:16 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q77so6327651iod.2;
        Fri, 19 Feb 2021 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9OwicC1kiiCXvkO0ELTDjTDC8Mb6sIzwldFpMYmla4c=;
        b=Our7NGrfGxEaVoh0HsMI32w/Khc6K31bQ9L4fFL7tozdE7xtZAOIGVBlbM7TzT+GOh
         yUq+IlYBvLMKOzA6djfvW00K9/nYcL9ynYz61fXouB4sLjPY4O6UowLDo907PFUhycZ0
         u+zt3FVP2CDTSMQFOfbbLjBACBbj3Vv72H7W1lPD+FWBzF8PNs8/ASqOVwzEcfAUqfid
         Gy1ZwG8sukuxCQqc0683IvAutQ68HWSOxxPpWUQPVvx0XzupqN+EkJNCaab7n6cw5A47
         v9siW88SBufWSavHnkaP3/iwq97aMTg7IBVQyAfBHW6cgGcnDG2pJjiEmXKOURTmhGqv
         cwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9OwicC1kiiCXvkO0ELTDjTDC8Mb6sIzwldFpMYmla4c=;
        b=kZUpqhoZq0U/YhsiQmgTq2cjV91gPGewKpx5/7I3O35hfhuBdvA8Y2ryRu5DTKt//N
         8oOKkJMmz2/0Hagp6bOwBXNsJslKZnPcKdt/to4xauvPFv1jNNvbBzFBVORP16uJnYpX
         tHhrh49tYEy9FU0HFeqxo12rrS4gaLsBDFdG3WBlXTeIoJumQ+gKizbBVKJAhmvxYzzm
         mouxaPk3zF85FRMGade5f/AQz0nhdpImFLwn736aShXZjt9Z6DoDNtbnJiuWp5BeL3zi
         jkdvg/Q2u/Ztm/uR/5xZdxkbT+Hdo54fy++hR1EKVxMLHbqmSaMQccwQNrlvgpzeJYNH
         YFlg==
X-Gm-Message-State: AOAM531u+zp5XLDXtjhRLMMpEx2sNLnskunDOSS47zgXtGm+UL3Mb6c7
        MO3zknoJYDsgbJ9ihZ1vJJJyA2RLECGoBw==
X-Google-Smtp-Source: ABdhPJxhnHdY1403Pat9/hgG/4ww4chREO3xpJUe2Kh40HR5Iz5i+LtS4RYj0qAaj3r9j9hK4tWIvA==
X-Received: by 2002:a5d:9717:: with SMTP id h23mr4748321iol.4.1613753835641;
        Fri, 19 Feb 2021 08:57:15 -0800 (PST)
Received: from Olgas-MBP-470.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i6sm6749814ilu.70.2021.02.19.08.57.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2021 08:57:15 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v3 2/2] NFSv4 account for selinux security context when deciding to share superblock
Date:   Fri, 19 Feb 2021 11:57:15 -0500
Message-Id: <20210219165715.20324-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20210219165715.20324-1-olga.kornievskaia@gmail.com>
References: <20210219165715.20324-1-olga.kornievskaia@gmail.com>
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


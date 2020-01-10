Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141C51379C4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgAJWfI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:08 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40049 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAJWfI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:08 -0500
Received: by mail-yb1-f193.google.com with SMTP id a2so1370053ybr.7
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EX9to2JgKDzoS0UYtuWj3O69P1cekZ+X0dJX6EOInOw=;
        b=QlblZCL8QdAGwlf3j2K92tekYdfbueuiZBKJR4kLcrvi9hyrFpVWysNVThQrOtQWzN
         2Ej3uTe0/Km9CnCryqAScIMlBOgOrzeTJeVq/tKzYTcndMVjmN5iJcgycis4KKIkcJIe
         7ygPnq1DfgBzHrcwE/aZuHw4uHRAUUJfuO/uQNMyZpzSyC+u5GljIc/YxgwvgQGmloVs
         Usd5zjyENOOyRGPfzIXzn1OZcAbNX/a/wEEMdC0nMbsb0FhxSV1LjrsAuxGfKyVkmSf1
         GbS25vQijlYd0To2+abE1WcjWcmBveImYDBPcsyAwY7+z0Fp6CT4w9fqec9ta77upr5k
         Pyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EX9to2JgKDzoS0UYtuWj3O69P1cekZ+X0dJX6EOInOw=;
        b=WN/ji1b8K8bSfflH15zGtLVODRKQcEX3/Nv+TpIimA6M2rRnO61tS1KK9CA6N4ipSY
         UUmjrej6+uqIcRjqRrWXYlBSpKzFxBNaAKj/kQyTWJuEOposQymlC4Cvjn7wFCwP1EOe
         4BARAG5TyQxzPTsygjXmSvQOIydpGpjNJWDto9jlBn4Ol/eK+Ssn5UdJ8h9grXfclSbF
         3Kjf1yiHyRWEfX8/8T0dslsfmXdILSICrF7jdK6E10ZYSGuKKuQPjktGAtWCcgvi1q+y
         632W6HvlEA7pOXU7y+ysYNDbnuKXnKgPY0NJiDJkkD7EBYKB64Vfrh5LFhY1EK4Hp86V
         1cNw==
X-Gm-Message-State: APjAAAUyGY9+FfRRgbRk3jzZXnBODirE5ozCWKWIf/R47orwjum0+5Py
        Tk7F5C1zmObx5wn7PUkvdKw=
X-Google-Smtp-Source: APXvYqy3MrI3rrWEnBqHikudN+nGfTibJFgf+yFf6z/Vw+RjYYk1HzclgTSnpPgBsEsOf7OW9KZa3g==
X-Received: by 2002:a5b:782:: with SMTP id b2mr4130150ybq.25.1578695707274;
        Fri, 10 Jan 2020 14:35:07 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id e186sm1554060ywb.73.2020.01.10.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:06 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 7/7] NFS: Add a mount option for READ_PLUS
Date:   Fri, 10 Jan 2020 17:34:55 -0500
Message-Id: <20200110223455.528471-8-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
References: <20200110223455.528471-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

There are some workloads where READ_PLUS might end up hurting
performance, so let's be nice to users and provide a way to disable this
operation similar to how READDIR_PLUS can be disabled.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/fs_context.c       | 14 ++++++++++++++
 fs/nfs/nfs4client.c       |  3 +++
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 0247dcb7b316..82ba07c7c1ce 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -64,6 +64,7 @@ enum nfs_param {
 	Opt_proto,
 	Opt_rdirplus,
 	Opt_rdma,
+	Opt_readplus,
 	Opt_resvport,
 	Opt_retrans,
 	Opt_retry,
@@ -120,6 +121,7 @@ static const struct fs_parameter_spec nfs_param_specs[] = {
 	fsparam_string("proto",		Opt_proto),
 	fsparam_flag_no("rdirplus",	Opt_rdirplus),
 	fsparam_flag  ("rdma",		Opt_rdma),
+	fsparam_flag_no("readplus",	Opt_readplus),
 	fsparam_flag_no("resvport",	Opt_resvport),
 	fsparam_u32   ("retrans",	Opt_retrans),
 	fsparam_string("retry",		Opt_retry),
@@ -555,6 +557,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		else
 			ctx->options |= NFS_OPTION_MIGRATION;
 		break;
+	case Opt_readplus:
+		if (result.negated)
+			ctx->options |= NFS_OPTION_NO_READ_PLUS;
+		else
+			ctx->options &= ~NFS_OPTION_NO_READ_PLUS;
+		break;
 
 		/*
 		 * options that take numeric values
@@ -1176,6 +1184,10 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 	    (ctx->version != 4 || ctx->minorversion != 0))
 		goto out_migration_misuse;
 
+	if (ctx->options & NFS_OPTION_NO_READ_PLUS &&
+	    (ctx->version != 4 || ctx->minorversion < 2))
+		goto out_noreadplus_misuse;
+
 	/* Verify that any proto=/mountproto= options match the address
 	 * families in the addr=/mountaddr= options.
 	 */
@@ -1254,6 +1266,8 @@ static int nfs_fs_context_validate(struct fs_context *fc)
 			  ctx->version, ctx->minorversion);
 out_migration_misuse:
 	return nfs_invalf(fc, "NFS: 'Migration' not supported for this NFS version");
+out_noreadplus_misuse:
+	return nfs_invalf(fc, "NFS: 'noreadplus' not supported for this NFS version\n");
 out_version_unavailable:
 	nfs_errorf(fc, "NFS: Version unavailable");
 	return ret;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 0cd767e5c977..868dc3c36ba1 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1016,6 +1016,9 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	server->caps |= server->nfs_client->cl_mvops->init_caps;
 	if (server->flags & NFS_MOUNT_NORDIRPLUS)
 			server->caps &= ~NFS_CAP_READDIRPLUS;
+	if (server->options & NFS_OPTION_NO_READ_PLUS)
+		server->caps &= ~NFS_CAP_READ_PLUS;
+
 	/*
 	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
 	 * authentication.
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 11248c5a7b24..360e70c7bbb6 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -172,6 +172,7 @@ struct nfs_server {
 	unsigned int		clone_blksize;	/* granularity of a CLONE operation */
 #define NFS_OPTION_FSCACHE	0x00000001	/* - local caching enabled */
 #define NFS_OPTION_MIGRATION	0x00000002	/* - NFSv4 migration enabled */
+#define NFS_OPTION_NO_READ_PLUS	0x00000004	/* - NFSv4.2 READ_PLUS enabled */
 
 	struct nfs_fsid		fsid;
 	__u64			maxfilesize;	/* maximum file size */
-- 
2.24.1


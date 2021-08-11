Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27733E969B
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhHKROj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHKROj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 13:14:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96967C061765
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 10:14:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so6195474pjb.0
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80WyL1gjgPI97bt0C616YQBYukT2le+qkZWW0ooTLZA=;
        b=aOzXr9eYnvv9swJjvXTZEvt6TnYwU2f2zEE5/jJIrGDQNa/fKB9l2kJsrZuuk76yln
         7kNgJabwZB40DNO82IK7JxEK04mxTN9TpqD7nkWrCiEP39sPCMwUtvgziRQFXqQmp3m6
         RfWNORhBv+Aod4ZjxAOIdtb4ju7XszzuKU2rDx0rwRhrFQWamg2rAfQNddNJQzufW/G/
         YKR/hQMvEnhd0gmr04HOqPyFCu6ffiysQg+/5iKmKrRy9k7xP2wsJsoSeru2fGdCUqFO
         qvcVAoptvXnKO7Sg7mNVxJ8PtDWtHP6J+6Vc6CItF/YEEeGB3tfI3dLX2lAiu7uEm/xQ
         3MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80WyL1gjgPI97bt0C616YQBYukT2le+qkZWW0ooTLZA=;
        b=DLlrqhV1xmPDfGpXQH35OtfQ/5eyuf3+EuvtYR/Ds13Jb+uMMH28uS4TKJ62kipVTw
         Yaiqy5ZJFcD/bxk++7M8B74blhMJL00suCXPL/oiCzKkQqar/xrvSXRb0dZX1oFmPeal
         8BCpRdpyV3gxuvmOjkMRMvfZDgTa/IUJZJAacSpABSk95Bv6F/GGkaxEeFmTUdMOYUmd
         Ic0TYeGTGQjRFmPTvCzbadwrmu4TdnuXGfveKCsGFoEJoSxqk3wx+Y+8OlXJCdEvf7+u
         Ta1uXD8u34MajTdPl7l4lzAdjiQc04aoSvJcQoeTfLQQrkYY3vuIGj/CXfBApFsQZq0l
         zwCQ==
X-Gm-Message-State: AOAM530faZ208H7q60B760eQ/6BUMlquQSOGZgX/oLXt5H5+N6rBCc8U
        FVMLzBBtrRos2nYtNLhuDV0=
X-Google-Smtp-Source: ABdhPJwe76t3zoDB9RJ3TeQ7YfhnLSEwh2qzbrL1rPMLO1N4QvePQxLEHCHXpB8DcT8phe10w+pg9A==
X-Received: by 2002:a17:902:bd43:b029:12c:def4:588e with SMTP id b3-20020a170902bd43b029012cdef4588emr13882149plx.25.1628702055137;
        Wed, 11 Aug 2021 10:14:15 -0700 (PDT)
Received: from nyarly.redhat.com ([179.233.244.167])
        by smtp.gmail.com with ESMTPSA id j13sm32274827pgp.29.2021.08.11.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:14:14 -0700 (PDT)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH] nfs: add rasize mount option to control read ahead
Date:   Wed, 11 Aug 2021 14:14:02 -0300
Message-Id: <20210811171402.947156-1-trbecker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Limiting nfs to 128kB of read ahead is performing poorly in high volume
mounts. Add the rasize option to set the read ahead to a more suitable
value.

Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 fs/nfs/client.c                 |  3 +++
 fs/nfs/fs_context.c             | 11 ++++++++++-
 fs/nfs/internal.h               |  1 +
 fs/nfs/nfs4client.c             |  2 ++
 fs/nfs/super.c                  |  2 ++
 include/linux/nfs_fs_sb.h       |  1 +
 include/uapi/linux/nfs4_mount.h |  1 +
 include/uapi/linux/nfs_mount.h  |  1 +
 8 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 330f65727c45..042677cd82f5 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -713,6 +713,8 @@ static int nfs_init_server(struct nfs_server *server,
 		server->rsize = nfs_block_size(ctx->rsize, NULL);
 	if (ctx->wsize)
 		server->wsize = nfs_block_size(ctx->wsize, NULL);
+	if (ctx->rasize)
+		server->rasize = ctx->rasize;
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
@@ -869,6 +871,7 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 {
 	target->flags = source->flags;
 	target->rsize = source->rsize;
+	target->rasize = source->rasize;
 	target->wsize = source->wsize;
 	target->acregmin = source->acregmin;
 	target->acregmax = source->acregmax;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d95c9a39bc70..8dcf14864d22 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -65,6 +65,7 @@ enum nfs_param {
 	Opt_proto,
 	Opt_rdirplus,
 	Opt_rdma,
+	Opt_rasize,
 	Opt_resvport,
 	Opt_retrans,
 	Opt_retry,
@@ -162,6 +163,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_u32   ("port",		Opt_port),
 	fsparam_flag_no("posix",	Opt_posix),
 	fsparam_string("proto",		Opt_proto),
+	fsparam_u32   ("rasize",        Opt_rasize),
 	fsparam_flag_no("rdirplus",	Opt_rdirplus),
 	fsparam_flag  ("rdma",		Opt_rdma),
 	fsparam_flag_no("resvport",	Opt_resvport),
@@ -476,7 +478,6 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 	int ret, opt;
 
 	dfprintk(MOUNT, "NFS:   parsing nfs mount option '%s'\n", param->key);
-
 	opt = fs_parse(fc, nfs_fs_parameters, param, &result);
 	if (opt < 0)
 		return ctx->sloppy ? 1 : opt;
@@ -824,6 +825,9 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			goto out_invalid_value;
 		}
 		break;
+	case Opt_rasize:
+		ctx->rasize = result.uint_32;
+		break;
 
 		/*
 		 * Special options
@@ -1012,6 +1016,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		ctx->flags	|= extra_flags;
 		ctx->rsize	= data->rsize;
 		ctx->wsize	= data->wsize;
+		ctx->rasize     = data->rasize;
 		ctx->timeo	= data->timeo;
 		ctx->retrans	= data->retrans;
 		ctx->acregmin	= data->acregmin;
@@ -1145,6 +1150,7 @@ struct compat_nfs4_mount_data_v1 {
 	compat_int_t proto;
 	compat_int_t auth_flavourlen;
 	compat_uptr_t auth_flavours;
+	compat_int_t rasize;
 };
 
 static void nfs4_compat_mount_data_conv(struct nfs4_mount_data *data)
@@ -1169,6 +1175,7 @@ static void nfs4_compat_mount_data_conv(struct nfs4_mount_data *data)
 	data->timeo = compat->timeo;
 	data->wsize = compat->wsize;
 	data->rsize = compat->rsize;
+	data->rasize = compat->rasize;
 	data->flags = compat->flags;
 	data->version = compat->version;
 }
@@ -1247,6 +1254,7 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
 	ctx->flags	= data->flags & NFS4_MOUNT_FLAGMASK;
 	ctx->rsize	= data->rsize;
 	ctx->wsize	= data->wsize;
+	ctx->rasize     = data->rasize;
 	ctx->timeo	= data->timeo;
 	ctx->retrans	= data->retrans;
 	ctx->acregmin	= data->acregmin;
@@ -1508,6 +1516,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->flags		= nfss->flags;
 		ctx->rsize		= nfss->rsize;
 		ctx->wsize		= nfss->wsize;
+		ctx->rasize             = nfss->rasize;
 		ctx->retrans		= nfss->client->cl_timeout->to_retries;
 		ctx->selected_flavor	= nfss->client->cl_auth->au_flavor;
 		ctx->acregmin		= nfss->acregmin / HZ;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a36af04188c2..975f49a03de6 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -97,6 +97,7 @@ struct nfs_fs_context {
 	unsigned short		protofamily;
 	unsigned short		mountfamily;
 	bool			has_sec_mnt_opts;
+	unsigned int            rasize;
 
 	struct {
 		union {
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 28431acd1230..f3cb9e9ff656 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1130,6 +1130,8 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 		server->rsize = nfs_block_size(ctx->rsize, NULL);
 	if (ctx->wsize)
 		server->wsize = nfs_block_size(ctx->wsize, NULL);
+	if (ctx->rasize)
+		server->rasize = ctx->rasize;
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index fe58525cfed4..df5d27931ee6 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -456,6 +456,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",wsize=%u", nfss->wsize);
 	if (nfss->bsize != 0)
 		seq_printf(m, ",bsize=%u", nfss->bsize);
+	seq_printf(m, ",rasize=%lu", nfss->super->s_bdi->ra_pages * PAGE_SIZE);
 	seq_printf(m, ",namlen=%u", nfss->namelen);
 	if (nfss->acregmin != NFS_DEF_ACREGMIN*HZ || showdefaults)
 		seq_printf(m, ",acregmin=%u", nfss->acregmin/HZ);
@@ -1281,6 +1282,7 @@ int nfs_get_tree_common(struct fs_context *fc)
 		if (error)
 			goto error_splat_super;
 		s->s_bdi->io_pages = server->rpages;
+		s->s_bdi->ra_pages = server->rasize / PAGE_SIZE;
 		server->super = s;
 	}
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d71a0e90faeb..fe7469ce81e1 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -162,6 +162,7 @@ struct nfs_server {
 	unsigned int		rpages;		/* read size (in pages) */
 	unsigned int		wsize;		/* write size */
 	unsigned int		wpages;		/* write size (in pages) */
+	unsigned int            rasize;         /* read ahead size */
 	unsigned int		wtmult;		/* server disk block size */
 	unsigned int		dtsize;		/* readdir size */
 	unsigned short		port;		/* "port=" setting */
diff --git a/include/uapi/linux/nfs4_mount.h b/include/uapi/linux/nfs4_mount.h
index d20bb869bb99..f9799fdccf06 100644
--- a/include/uapi/linux/nfs4_mount.h
+++ b/include/uapi/linux/nfs4_mount.h
@@ -54,6 +54,7 @@ struct nfs4_mount_data {
 	/* Pseudo-flavours to use for authentication. See RFC2623 */
 	int auth_flavourlen;			/* 1 */
 	int __user *auth_flavours;		/* 1 */
+	int rasize;                             /* 1 */
 };
 
 /* bits in the flags field */
diff --git a/include/uapi/linux/nfs_mount.h b/include/uapi/linux/nfs_mount.h
index e3bcfc6aa3b0..0a5f40e986cf 100644
--- a/include/uapi/linux/nfs_mount.h
+++ b/include/uapi/linux/nfs_mount.h
@@ -44,6 +44,7 @@ struct nfs_mount_data {
 	struct nfs3_fh	root;			/* 4 */
 	int		pseudoflavor;		/* 5 */
 	char		context[NFS_MAX_CONTEXT_LEN + 1];	/* 6 */
+	int		rasize;			/* 1 */
 };
 
 /* bits in the flags field visible to user space */
-- 
2.31.1


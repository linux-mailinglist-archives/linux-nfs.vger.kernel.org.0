Return-Path: <linux-nfs+bounces-10591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3986A5F87F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 15:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393087AF2FF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D146B2686A1;
	Thu, 13 Mar 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpiX5IJn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A0267F70
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876436; cv=none; b=ttGpuqQBpF6s9kLeVnxspLW7WPuH4/NhGoDw+QLUNZfu0BqwFAHBwHI7TLr5iOj7XS6w8fIc340BkRLti/DmdNzMJK8kNL1knitURoJJL2Oq5GLYYPOfYCYDj60XAfFO+DwPnrNAUmkSCeBVmOuDlR9yC5Eez+UL8/B154/NhTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876436; c=relaxed/simple;
	bh=LIWAyhpDLcLjTQTdHO7/83JG+hYlUeveZ2KoYlXf1SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxutPbyXOEzH/gPLNU9RdqVouNHd6vhG81YgJmBfL3OBgtDTI0clmzlN4FjyFDIKjz9yh43P/SilntrXm/jyXI9aOJ4Nntt+78Ef9Vou5LpI6XKzgTUX1Ps6/6wsrjVoOOiRZ3KG1bVuLLGAexqtNyO7JTgHnW3ZFQVTohk3dtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpiX5IJn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741876433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgADok9LsDk1MTtVgl4Zmcupq7GEaDf8pywetpq6sYQ=;
	b=FpiX5IJnsO26dzb1zGvk0QHdYcUHBIV73xqQmFfWRD1+3YJTFCTdIh+CuriqlSa5Z9zbtc
	tzZbQg+P7KDA3wypzUNpryrI3QEfAyXTeAzbbclXcCXmUOZlUnrgEajoamgd2mvA1O9/QF
	jwAQYTXYc56VeiYQwFEBxGJy5lWuQ84=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-cgET3pbPPd6lejkerZCNeg-1; Thu,
 13 Mar 2025 10:33:51 -0400
X-MC-Unique: cgET3pbPPd6lejkerZCNeg-1
X-Mimecast-MFC-AGG-ID: cgET3pbPPd6lejkerZCNeg_1741876430
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39B5A1956087;
	Thu, 13 Mar 2025 14:33:50 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 898F419560AB;
	Thu, 13 Mar 2025 14:33:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFS: Extend rdirplus mount option with "force|none"
Date: Thu, 13 Mar 2025 10:33:47 -0400
Message-ID: <8538c32d6d971674d9d8a249fca8d5880697e32e.1741876108.git.bcodding@redhat.com>
In-Reply-To: <cover.1741876108.git.bcodding@redhat.com>
References: <cover.1741876108.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

There are certain users that wish to force the NFS client to choose
READDIRPLUS over READDIR for a particular mount.  Update the "rdirplus" mount
option to optionally accept values.  For "rdirplus=force", the NFS client
will always attempt to use READDDIRPLUS.  The setting of "rdirplus=none" is
aliased to the existing "nordirplus".

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c              |  2 ++
 fs/nfs/fs_context.c       | 32 ++++++++++++++++++++++++++++----
 fs/nfs/super.c            |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2b04038b0e40..c9de0e474cf5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -666,6 +666,8 @@ static bool nfs_use_readdirplus(struct inode *dir, struct dir_context *ctx,
 {
 	if (!nfs_server_capable(dir, NFS_CAP_READDIRPLUS))
 		return false;
+	if (NFS_SERVER(dir)->flags && NFS_MOUNT_FORCE_RDIRPLUS)
+		return true;
 	if (ctx->pos == 0 ||
 	    cache_hits + cache_misses > NFS_READDIR_CACHE_USAGE_THRESHOLD)
 		return true;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index b069385eea17..ad0135fcc563 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -72,6 +72,8 @@ enum nfs_param {
 	Opt_posix,
 	Opt_proto,
 	Opt_rdirplus,
+	Opt_rdirplus_none,
+	Opt_rdirplus_force,
 	Opt_rdma,
 	Opt_resvport,
 	Opt_retrans,
@@ -174,7 +176,8 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_u32   ("port",		Opt_port),
 	fsparam_flag_no("posix",	Opt_posix),
 	fsparam_string("proto",		Opt_proto),
-	fsparam_flag_no("rdirplus",	Opt_rdirplus),
+	fsparam_flag_no("rdirplus", Opt_rdirplus), // rdirplus|nordirplus
+	fsparam_string("rdirplus",  Opt_rdirplus), // rdirplus=...
 	fsparam_flag  ("rdma",		Opt_rdma),
 	fsparam_flag_no("resvport",	Opt_resvport),
 	fsparam_u32   ("retrans",	Opt_retrans),
@@ -288,6 +291,12 @@ static const struct constant_table nfs_xprtsec_policies[] = {
 	{}
 };
 
+static const struct constant_table nfs_rdirplus_tokens[] = {
+	{ "none",	Opt_rdirplus_none },
+	{ "force",	Opt_rdirplus_force },
+	{}
+};
+
 /*
  * Sanity-check a server address provided by the mount command.
  *
@@ -636,10 +645,25 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			ctx->flags &= ~NFS_MOUNT_NOACL;
 		break;
 	case Opt_rdirplus:
-		if (result.negated)
+		if (result.negated) {
+			ctx->flags &= ~NFS_MOUNT_FORCE_RDIRPLUS;
 			ctx->flags |= NFS_MOUNT_NORDIRPLUS;
-		else
-			ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
+		} else if (!param->string) {
+			ctx->flags &= ~(NFS_MOUNT_NORDIRPLUS || NFS_MOUNT_FORCE_RDIRPLUS);
+		} else {
+			switch (lookup_constant(nfs_rdirplus_tokens, param->string, -1)) {
+			case Opt_rdirplus_none:
+				ctx->flags &= ~NFS_MOUNT_FORCE_RDIRPLUS;
+				ctx->flags |= NFS_MOUNT_NORDIRPLUS;
+				break;
+			case Opt_rdirplus_force:
+				ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
+				ctx->flags |= NFS_MOUNT_FORCE_RDIRPLUS;
+				break;
+			default:
+				goto out_invalid_value;
+			}
+		}
 		break;
 	case Opt_sharecache:
 		if (result.negated)
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index aeb715b4a690..9a747b224a9d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -456,6 +456,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_NORDIRPLUS, ",nordirplus", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_FORCE_RDIRPLUS, ",rdirplus=force", "" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index f00bfcee7120..3774b2235a1e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -167,6 +167,7 @@ struct nfs_server {
 #define NFS_MOUNT_TRUNK_DISCOVERY	0x04000000
 #define NFS_MOUNT_SHUTDOWN			0x08000000
 #define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
+#define NFS_MOUNT_FORCE_RDIRPLUS	0x20000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.47.0



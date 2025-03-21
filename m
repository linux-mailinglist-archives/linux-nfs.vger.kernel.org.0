Return-Path: <linux-nfs+bounces-10746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54705A6BE48
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2797819C07B1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Mar 2025 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B81DB356;
	Fri, 21 Mar 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svh3M8o8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E451DE4CE
	for <linux-nfs@vger.kernel.org>; Fri, 21 Mar 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570467; cv=none; b=LWHsPj+6z8f76wlnPGTK6cV+jbZyyZTkTgr6F9TY6yCQAjTuK+F4a5x8+gMzhVZenSBf1ekWGSPKv3JPxnsE5tDt6ezggELTAFSfIptSwaOG5D3Or0VuLto9LQGmSoaiOGqE/7EtXSc7LYmsJW8eqAMKAffG1U5SUaNBv9mf6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570467; c=relaxed/simple;
	bh=A7pnfRBRxM0CrgzFYSRmbFQfzwXWvbO1UEqtLJzuziM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gt/5A40O5rpWKOToP3A0LstNNG4dAo5E7f5LZWXx8ZtF3PYC1PKRIL7gUlBlH6c8FRT5Ymt5nnw5PvSe+phm1v3h00F4lnWGAydV8+C1sU44Liv02yvSyb5spU8YEE/VEWo9vhvvn6vKTmrupjFDEbqwk1HvQLqm/qvDt2MXPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svh3M8o8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449D5C4CEE9;
	Fri, 21 Mar 2025 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742570466;
	bh=A7pnfRBRxM0CrgzFYSRmbFQfzwXWvbO1UEqtLJzuziM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Svh3M8o8QPcZgJ491e4NJeEZr6vPROOlmWLfOJIjf61jWcAgdi1PjwH0eLsVlAG61
	 NLnF/ZtUy86THX4slFiUleb6Tx3B4x8GRaUjbCLJE27uao51ZbcpewXWxlzFxzaxy8
	 281okKg1G4sKtwg5XCCvPjW9UyIaknOC40LUS9c/QWUiaB3TVoe6UwhqkW9+R7BV12
	 cOPFW312FfXChIf/U7bfUEPHvJbrAT+0i9yHCItgjxO4NlFCcTrk5pOSXfsaGBEwuI
	 I9INDmDDE0jK/XY9wTQhXKGoARd5wMP7KllJmlsds4eF3zpCo9iIwC7eNf4QwZLFpN
	 5iP76w8+ElN3Q==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 1/4] NFS: Add a mount option to make ENETUNREACH errors fatal
Date: Fri, 21 Mar 2025 11:21:01 -0400
Message-ID: <d973ccfb67dbfc43e0f82ce95a36a1ae954d9135.1742570192.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742570192.git.trond.myklebust@hammerspace.com>
References: <cover.1742570192.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the NFS client was initially created in a container, and that
container is torn down, there is usually no possibity to go back and
destroy any NFS clients that are hung because their virtual network
devices have been unlinked.

Add a flag that tells the NFS client that in these circumstances, it
should treat ENETDOWN and ENETUNREACH errors as fatal to the NFS client.

The option defaults to being on when the mount happens from inside a net
namespace that is not "init_net".

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/fs_context.c       | 39 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/super.c            |  3 +++
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 43 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 1cabba1231d6..13f71ca8c974 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -50,6 +50,7 @@ enum nfs_param {
 	Opt_clientaddr,
 	Opt_cto,
 	Opt_alignwrite,
+	Opt_fatal_neterrors,
 	Opt_fg,
 	Opt_fscache,
 	Opt_fscache_flag,
@@ -97,6 +98,20 @@ enum nfs_param {
 	Opt_xprtsec,
 };
 
+enum {
+	Opt_fatal_neterrors_default,
+	Opt_fatal_neterrors_enetunreach,
+	Opt_fatal_neterrors_none,
+};
+
+static const struct constant_table nfs_param_enums_fatal_neterrors[] = {
+	{ "default",			Opt_fatal_neterrors_default },
+	{ "ENETDOWN:ENETUNREACH",	Opt_fatal_neterrors_enetunreach },
+	{ "ENETUNREACH:ENETDOWN",	Opt_fatal_neterrors_enetunreach },
+	{ "none",			Opt_fatal_neterrors_none },
+	{}
+};
+
 enum {
 	Opt_local_lock_all,
 	Opt_local_lock_flock,
@@ -153,6 +168,8 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_string("clientaddr",	Opt_clientaddr),
 	fsparam_flag_no("cto",		Opt_cto),
 	fsparam_flag_no("alignwrite",	Opt_alignwrite),
+	fsparam_enum("fatal_neterrors", Opt_fatal_neterrors,
+		     nfs_param_enums_fatal_neterrors),
 	fsparam_flag  ("fg",		Opt_fg),
 	fsparam_flag_no("fsc",		Opt_fscache_flag),
 	fsparam_string("fsc",		Opt_fscache),
@@ -896,6 +913,25 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			goto out_of_bounds;
 		ctx->nfs_server.max_connect = result.uint_32;
 		break;
+	case Opt_fatal_neterrors:
+		trace_nfs_mount_assign(param->key, param->string);
+		switch (result.uint_32) {
+		case Opt_fatal_neterrors_default:
+			if (fc->net_ns != &init_net)
+				ctx->flags |= NFS_MOUNT_NETUNREACH_FATAL;
+			else
+				ctx->flags &= ~NFS_MOUNT_NETUNREACH_FATAL;
+			break;
+		case Opt_fatal_neterrors_enetunreach:
+			ctx->flags |= NFS_MOUNT_NETUNREACH_FATAL;
+			break;
+		case Opt_fatal_neterrors_none:
+			ctx->flags &= ~NFS_MOUNT_NETUNREACH_FATAL;
+			break;
+		default:
+			goto out_invalid_value;
+		}
+		break;
 	case Opt_lookupcache:
 		trace_nfs_mount_assign(param->key, param->string);
 		switch (result.uint_32) {
@@ -1675,6 +1711,9 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->xprtsec.cert_serial	= TLS_NO_CERT;
 		ctx->xprtsec.privkey_serial	= TLS_NO_PRIVKEY;
 
+		if (fc->net_ns != &init_net)
+			ctx->flags |= NFS_MOUNT_NETUNREACH_FATAL;
+
 		fc->s_iflags		|= SB_I_STABLE_WRITES;
 	}
 	fc->fs_private = ctx;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 96de658a7886..9eea9e62afc9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -457,6 +457,9 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 		{ NFS_MOUNT_FORCE_RDIRPLUS, ",rdirplus=force", "" },
 		{ NFS_MOUNT_UNSHARED, ",nosharecache", "" },
 		{ NFS_MOUNT_NORESVPORT, ",noresvport", "" },
+		{ NFS_MOUNT_NETUNREACH_FATAL,
+		  ",fatal_neterrors=ENETDOWN:ENETUNREACH",
+		  ",fatal_neterrors=none" },
 		{ 0, NULL, NULL }
 	};
 	const struct proc_nfs_info *nfs_infop;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index b83d16a42afc..a6ce8590eaaf 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -168,6 +168,7 @@ struct nfs_server {
 #define NFS_MOUNT_SHUTDOWN			0x08000000
 #define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
 #define NFS_MOUNT_FORCE_RDIRPLUS	0x20000000
+#define NFS_MOUNT_NETUNREACH_FATAL	0x40000000
 
 	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
-- 
2.49.0



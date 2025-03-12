Return-Path: <linux-nfs+bounces-10567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840BDA5E4B7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 20:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071A43AA792
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCED1DE4CE;
	Wed, 12 Mar 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZ7vzSB2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDC800
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808782; cv=none; b=bBSeTntyt6ylg0Yg+momsS4fNehD9XnGMtQntHKJDX7eCCcF7PykWeufu/SVZPcPRO1ErH4srMIahJDAejAaE2bckVSCaF4jCOYj4GbZtRJMOBk/hlp2YG09r8KTwoHxwYa1VZCpbi5mTjk7E4we/RxZNk6jRAwcQ7Tlkqer3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808782; c=relaxed/simple;
	bh=4xlQmf+vUNzNOlo6qOTdoTK+kT+GE0nZWjzzuGMoSk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDaH6ck/lrv1POQ1JUW9vtFMIOUMWjMlxtQ7PUfmYqE2HDnFEpx1vJ5/N08MoQ02X4cmLUOmlxGN4FSPo8PNezWXjkOFRewgUhBrNkXRG6RYFdcL+67RMqdr9KyLI2CTIVtaCo0JSKciZ9txVREFtjy8H38P8bzU4VAuQTl3lgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZ7vzSB2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741808779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=femDNU3RI9ljgacPyCty6wXT4NcEZe1Zy8iHSWfCh+U=;
	b=JZ7vzSB2etg1A96stZivQCLQog754zJZVDX+IVDxjBQmx/lrxuFuGQ1cYMhIsaH5Tri0n+
	BI28aYKziEd3nUD83KCauO1LYP1sLu0EvmLzrglGgu+iU0BctGXzBiw/Ki2cnhG4ItCnA5
	VMqY0Tslk3RoPwxLH+Jca9RCtInJ2lE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-6yDpmx8GNIOTVvXXfzEitA-1; Wed,
 12 Mar 2025 15:46:17 -0400
X-MC-Unique: 6yDpmx8GNIOTVvXXfzEitA-1
X-Mimecast-MFC-AGG-ID: 6yDpmx8GNIOTVvXXfzEitA_1741808777
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00535195609E;
	Wed, 12 Mar 2025 19:46:17 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28B7018001F6;
	Wed, 12 Mar 2025 19:46:16 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFS: New mount option force_rdirplus
Date: Wed, 12 Mar 2025 15:46:13 -0400
Message-ID: <4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding@redhat.com>
In-Reply-To: <cover.1741806879.git.bcodding@redhat.com>
References: <cover.1741806879.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There are certain users that wish to force the NFS client to choose
READDIRPLUS over READDIR for a particular mount.  Add a new kernel mount
option "force_rdirplus" to carry that intent.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c              |  2 ++
 fs/nfs/fs_context.c       | 14 ++++++++++++--
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

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
index b069385eea17..3ba44b444031 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -72,6 +72,7 @@ enum nfs_param {
 	Opt_posix,
 	Opt_proto,
 	Opt_rdirplus,
+	Opt_force_rdirplus,
 	Opt_rdma,
 	Opt_resvport,
 	Opt_retrans,
@@ -175,6 +176,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_flag_no("posix",	Opt_posix),
 	fsparam_string("proto",		Opt_proto),
 	fsparam_flag_no("rdirplus",	Opt_rdirplus),
+	fsparam_flag  ("force_rdirplus", Opt_force_rdirplus),
 	fsparam_flag  ("rdma",		Opt_rdma),
 	fsparam_flag_no("resvport",	Opt_resvport),
 	fsparam_u32   ("retrans",	Opt_retrans),
@@ -636,10 +638,18 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			ctx->flags &= ~NFS_MOUNT_NOACL;
 		break;
 	case Opt_rdirplus:
-		if (result.negated)
+		if (result.negated) {
+			if (ctx->flags && NFS_MOUNT_FORCE_RDIRPLUS)
+				return nfs_invalf(fc, "NFS: Cannot both force and disable READDIR PLUS");
 			ctx->flags |= NFS_MOUNT_NORDIRPLUS;
-		else
+		} else {
 			ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
+		}
+		break;
+	case Opt_force_rdirplus:
+		if (ctx->flags && NFS_MOUNT_NORDIRPLUS)
+			return nfs_invalf(fc, "NFS: Cannot both force and disable READDIR PLUS");
+		ctx->flags |= NFS_MOUNT_FORCE_RDIRPLUS;
 		break;
 	case Opt_sharecache:
 		if (result.negated)
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



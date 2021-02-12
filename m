Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C009031A718
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBLVui (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhBLVug (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 16:50:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 736E964E8D;
        Fri, 12 Feb 2021 21:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613166595;
        bh=qJuFeeAcnlXPKGSJA0Yl43HBriEos2VfMxdKc4eyybY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lz7ow4NDHJCwrhN1yTa6i/nCXlumTENIyMFYHv+WINhV4XRxdviC9kIbhqcWt/8ec
         UPs0UAIL343EfOwUDlACnGzrdNKIn5u7O9EWrPqcwtmMpjO9BrJvM6CYkbU2GfDdHa
         H6/8LRNuNX4r8oRcL8polYQufjAsCkRpNitsxW7Jc5BA1TJsuemO28LnKEG5z3pEoy
         icFZpai5ToqM9dH9amxa43UIA4fq4YE1uEP8qJl7Hpg7B18I9lswIa7LTWj5UNaQ8c
         bDqoq5QWWTKh/8KQnnkIKYWl0YXsvP7obuGGX2obiimodhvTu6ZoD1TGhAGk7g21wY
         M9/92v5oUpriQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Add mount options supporting eager writes
Date:   Fri, 12 Feb 2021 16:49:49 -0500
Message-Id: <20210212214949.4408-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212214949.4408-3-trondmy@kernel.org>
References: <20210212214949.4408-1-trondmy@kernel.org>
 <20210212214949.4408-2-trondmy@kernel.org>
 <20210212214949.4408-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/fs_context.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 06894bcdea2d..b6be02aa79f0 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -82,6 +82,7 @@ enum nfs_param {
 	Opt_v,
 	Opt_vers,
 	Opt_wsize,
+	Opt_write,
 };
 
 enum {
@@ -113,6 +114,19 @@ static const struct constant_table nfs_param_enums_lookupcache[] = {
 	{}
 };
 
+enum {
+	Opt_write_lazy,
+	Opt_write_eager,
+	Opt_write_wait,
+};
+
+static const struct constant_table nfs_param_enums_write[] = {
+	{ "lazy",		Opt_write_lazy },
+	{ "eager",		Opt_write_eager },
+	{ "wait",		Opt_write_wait },
+	{}
+};
+
 static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_flag_no("ac",		Opt_ac),
 	fsparam_u32   ("acdirmax",	Opt_acdirmax),
@@ -171,6 +185,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_flag  ("v4.1",		Opt_v),
 	fsparam_flag  ("v4.2",		Opt_v),
 	fsparam_string("vers",		Opt_vers),
+	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
 	{}
 };
@@ -770,6 +785,24 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 			goto out_invalid_value;
 		}
 		break;
+	case Opt_write:
+		switch (result.uint_32) {
+		case Opt_write_lazy:
+			ctx->flags &=
+				~(NFS_MOUNT_WRITE_EAGER | NFS_MOUNT_WRITE_WAIT);
+			break;
+		case Opt_write_eager:
+			ctx->flags |= NFS_MOUNT_WRITE_EAGER;
+			ctx->flags &= ~NFS_MOUNT_WRITE_WAIT;
+			break;
+		case Opt_write_wait:
+			ctx->flags |=
+				NFS_MOUNT_WRITE_EAGER | NFS_MOUNT_WRITE_WAIT;
+			break;
+		default:
+			goto out_invalid_value;
+		}
+		break;
 
 		/*
 		 * Special options
-- 
2.29.2


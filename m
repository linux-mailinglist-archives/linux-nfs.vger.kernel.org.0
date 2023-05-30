Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE55D716315
	for <lists+linux-nfs@lfdr.de>; Tue, 30 May 2023 16:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjE3OF5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 May 2023 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjE3OFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 May 2023 10:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D510A
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 07:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D35C962461
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 14:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97DBC433D2;
        Tue, 30 May 2023 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455548;
        bh=k0Q/ahGF0o430xNI/stJcQcOEnDzyH5ZV74UxoXnvOw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SNIWdVia1PguX26p7HlwDbCt+ngyd/MYrJeTgDAO+5PH+nrXYSO7jLdpuk+ae8oiv
         UhBe4HIT+UTp794O3BmI0gSlonaUpgjC5BUwHVldVALWbwjCLY1OwxcOnIoC7gDrQs
         AwFmOJc2PjRqwrhOBh6KeBS20dkmjEy3FbyXYmGOGZHUiTlwW+ulUzujIJFL1duChL
         9NnGMxax2fJ9RgFoUbYy8nkXV5HwDU+TMudcqeP9LC1pXVSMf5jOWTqkW+nnsJY0av
         VdgViboKaoGBGb8VwPPu8DhOu8DRSey03+z5eipUtmuNu2M5DgpLk5YvUtGocHjhSy
         4giZt3M/IcqCQ==
Subject: [PATCH v3 01/11] NFS: Improvements for fs_context-related tracepoints
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 30 May 2023 10:05:36 -0400
Message-ID: <168545552661.1917.15372563404722059237.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
References: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add some missing observability to the fs_context tracepoints
added by commit 33ce83ef0bb0 ("NFS: Replace fs_context-related
dprintk() call sites with tracepoints").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/fs_context.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9bcd53d5c7d4..5626d358ee2e 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -791,16 +791,19 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		ctx->mount_server.addrlen = len;
 		break;
 	case Opt_nconnect:
+		trace_nfs_mount_assign(param->key, param->string);
 		if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_CONNECTIONS)
 			goto out_of_bounds;
 		ctx->nfs_server.nconnect = result.uint_32;
 		break;
 	case Opt_max_connect:
+		trace_nfs_mount_assign(param->key, param->string);
 		if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_TRANSPORTS)
 			goto out_of_bounds;
 		ctx->nfs_server.max_connect = result.uint_32;
 		break;
 	case Opt_lookupcache:
+		trace_nfs_mount_assign(param->key, param->string);
 		switch (result.uint_32) {
 		case Opt_lookupcache_all:
 			ctx->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
@@ -817,6 +820,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		}
 		break;
 	case Opt_local_lock:
+		trace_nfs_mount_assign(param->key, param->string);
 		switch (result.uint_32) {
 		case Opt_local_lock_all:
 			ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
@@ -837,6 +841,7 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		}
 		break;
 	case Opt_write:
+		trace_nfs_mount_assign(param->key, param->string);
 		switch (result.uint_32) {
 		case Opt_write_lazy:
 			ctx->flags &=



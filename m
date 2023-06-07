Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BC7261C6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jun 2023 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjFGN47 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jun 2023 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbjFGN45 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jun 2023 09:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE71BE6
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 06:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD6160A7C
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jun 2023 13:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6840C4339B;
        Wed,  7 Jun 2023 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686146215;
        bh=k0Q/ahGF0o430xNI/stJcQcOEnDzyH5ZV74UxoXnvOw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f+eKWF2JlDkiQRjfp0ZREvftg0KJrRHMUdu/CZIEps+dVFypvggvA6O4FIHoAvw9G
         R5Y/18YPJ6cmVsb2oDOL22dD55iibT5rHO3m+MXvrgXgg7Va82vsv18Sg0DzUhQvf7
         qaN2WpTY8TTDC9YYxtZiUn2f3CIwr5CoYlEfpqORXXGYLImCirWnBDdwMrX7TGWD43
         OQx47OvG62xdmuqgp8p85BwBF5qLYLnf5nTleX9QqV4iKAJYUzNDBcHL8KT7mFSUFK
         QzezdJGuR8vAL9w+h+Fppqed1zYTgCbgXVRN2KGWuLOLROrgtJQk22ZABn32VEen2G
         bwMVRN6bJr/Ug==
Subject: [PATCH v4 1/9] NFS: Improvements for fs_context-related tracepoints
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 07 Jun 2023 09:56:43 -0400
Message-ID: <168614619340.2082.8418780838244577147.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168614594328.2082.13408337606138447754.stgit@oracle-102.nfsv4bat.org>
References: <168614594328.2082.13408337606138447754.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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



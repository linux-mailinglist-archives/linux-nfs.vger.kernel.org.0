Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9927570DF34
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjEWOaZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 10:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjEWOaW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 10:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CC1A7
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 07:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0565063324
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 14:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6601C433EF;
        Tue, 23 May 2023 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852215;
        bh=k0Q/ahGF0o430xNI/stJcQcOEnDzyH5ZV74UxoXnvOw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YebWGvGl3fzKouucSZyLY5hC+Yxhji8P4qo1h/7gC0OEn0guGpNHCbLXNilNIVroZ
         ZaxP9cdhNe6ycoXw07HrcDgJzuqLG1j3GNGPgjrcWUMw7tgiyi26Q3o2M1h0lkS9D9
         ZlyDU64XaDT2LGy1XKRzfF1fzJITg7sQr6IoVgwMeAiTASy3oMBw5aDTO+PwfCpfU+
         LH/rkboXi0H3pYby/A44nwvuVaPiVsTURX3dn9SOc37cKItd3tHrGmR3WQWwJFXtRn
         59sALSVsjF/J4nfyApwYHjCvZfqevydMV0MPCTb+7wmKajtXGBHpVBN2QLPk6VaMqD
         RQLOjaCECpfzw==
Subject: [PATCH v2 01/11] NFS: Improvements for fs_context-related tracepoints
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 23 May 2023 10:30:03 -0400
Message-ID: <168485219383.6613.12610314083054138247.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
References: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
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



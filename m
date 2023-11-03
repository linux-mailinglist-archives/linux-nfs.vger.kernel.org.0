Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812997E0152
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbjKCKLB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347735AbjKCKLB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 06:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A0BD;
        Fri,  3 Nov 2023 03:10:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99F7C433CC;
        Fri,  3 Nov 2023 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699006258;
        bh=aEwR2a88wWo7zxzWtx4+bapNUSG0wCpCSwkXs01II2I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IgcIEcpsl/8hIBYRrJwoF0KrW3rX5hGwRRjs3cUQrghLZ9d3rozwe96iGrVrzkG6F
         3CJBZKLKD7xF4icfvj1C6sIoNmBclFxrkkNJQTTRrbyCrB2YRH6Z51NXbRz2Px6o5z
         6jwuKg0h59YeHBb5VOIisTUMqX2Xld4Dv1wK+czVE3QCIQ3uY+Ppvox7ftiFa0oMXN
         xlRccMkAxHRE96QZ4s8hU2Ahtjhue/kUGqCNRvu64frbB7lbA01ZnIEN+QF/G8cWNL
         qQI+nokl0meS0DQXgT/4epg843ZQq2ej+rt7ggYaFO/wjuIm8pp6vCux100SnU1Q8+
         JC5zHvT0aUx2A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 03 Nov 2023 06:10:50 -0400
Subject: [PATCH 2/3] nfs: rename the nfs_async_rename_done tracepoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-nfs-6-8-v1-2-a2aa9021dc1d@kernel.org>
References: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
In-Reply-To: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aEwR2a88wWo7zxzWtx4+bapNUSG0wCpCSwkXs01II2I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlRMcwit8w99fq4KjPsRSUpqRRz5GxUAP6idpx0
 s2gLu5iRICJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZUTHMAAKCRAADmhBGVaC
 FYdHEAC+e+8cdamQyLjy+g//UDgf2TbbzrbnvEeJavqTIHrXLTlAi8WVc3Wx04MfEa+EM44sB2p
 n538F49kpSdYyDjP/C4zF44mHT0mP9/yi96cC8TsGAVu5floDO8NC4n2eoI7nykRGcBH266+5TK
 IwhrfxkcfXg8RzrrnmaCIMNl9168HCDShYVgYZf3fEXjdEWVscdIC25xSRSW5T6+R2WPG4Tl7+Z
 0v0EWkfTOBvG0P+D4KZDY4Z9GWVoJ97jQ1V74yGfgtODphNI1+a6+5SgCieY3pHa3guzbMJUUoU
 TlqdderWkpUfc5TRPjsA8yR73QnhisYhMkfqKsVWuMiBBz6u2LkU0bN6m3tBh35XWrLYXTUqoSc
 Dy7Z16x/2oKFrw4A4xxd/ZJwCGiPoZmJjyjPIOYcH0rd6RA4hwjUj1eyl0txDTgm81kmGGsFoDH
 dz7J80oZzAE/KO0XvDBx8s7X7nC4b+H+hJdk03tpMJMaIbsRkmzZzWUhhfYRKC+ex+q2cpB3PxG
 dSVMPbn7tYM5lgnNnzNVyHtxyqFDGWq+9zBslV4tjb2yo2hnQpIdD0cKUkLc9QlFHxP0Sc7sQv5
 4TNrw4N/Oq6vT81mhQHXwBTmLSr46vswmH5pwu3Uj6X7eS3UEaxxobzvOTw8PqqcWj61E/j2kEg
 DBNZFQAbwUiIhdg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We do async renames in other cases besides sillyrenames now. This
tracepoint name is now misleading.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h | 2 +-
 fs/nfs/unlink.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4e90ca531176..8ad1bed09295 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -893,7 +893,7 @@ DECLARE_EVENT_CLASS(nfs_rename_event_done,
 DEFINE_NFS_RENAME_EVENT(nfs_rename_enter);
 DEFINE_NFS_RENAME_EVENT_DONE(nfs_rename_exit);
 
-DEFINE_NFS_RENAME_EVENT_DONE(nfs_sillyrename_rename);
+DEFINE_NFS_RENAME_EVENT_DONE(nfs_async_rename_done);
 
 TRACE_EVENT(nfs_sillyrename_unlink,
 		TP_PROTO(
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 150a953a8be9..0110299643a2 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -267,7 +267,7 @@ static void nfs_async_rename_done(struct rpc_task *task, void *calldata)
 	struct inode *new_dir = data->new_dir;
 	struct dentry *old_dentry = data->old_dentry;
 
-	trace_nfs_sillyrename_rename(old_dir, old_dentry,
+	trace_nfs_async_rename_done(old_dir, old_dentry,
 			new_dir, data->new_dentry, task->tk_status);
 	if (!NFS_PROTO(old_dir)->rename_done(task, old_dir, new_dir)) {
 		rpc_restart_call_prepare(task);

-- 
2.41.0


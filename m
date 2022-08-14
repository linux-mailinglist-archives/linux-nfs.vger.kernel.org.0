Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16FE592111
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Aug 2022 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiHNPd1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Aug 2022 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbiHNPcx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Aug 2022 11:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC491C106
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 08:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 048BB60C05
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 15:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCB4C43470
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491005;
        bh=80yXD1lv8ELOvZ3mMXWW4OcUeUDp36eizqrwtCT95A4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rEJVlSDdJV1YXdjqPRRLnZMJom1DpSHjEycV6i74IFpGLepVBH8N+AUn338birnIR
         rSKu6AWcFDQxMUzYTnatwennQQs5cCHyEaytzdLyxiWFzKLiZ4ZsylOEPxuGTfF/7v
         g0TASipjO8BF/qWCsiCyEe5lagVYYUKqJkBxMiof8PoQUzqmS3IRZNnlls56z5BTxJ
         Qmbrj1RncPxieYDowSW/UVCZIVIsMwssTW82E+lSavCAEgeekHFLn50i8CS7cCwla5
         jHW5X440R0y93Q5u36sXjp449K+AyFcBg+XERM1PIazdFI+JYShroXXXFMGgRhqv/g
         K8xFGdY/DNY0A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Cleanup to remove unused flag NFS_CONTEXT_RESEND_WRITES
Date:   Sun, 14 Aug 2022 11:23:17 -0400
Message-Id: <20220814152317.30985-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220814152317.30985-2-trondmy@kernel.org>
References: <20220814152317.30985-1-trondmy@kernel.org>
 <20220814152317.30985-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/nfs_fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f08e581f0161..7931fa472561 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -83,7 +83,6 @@ struct nfs_open_context {
 	fmode_t mode;
 
 	unsigned long flags;
-#define NFS_CONTEXT_RESEND_WRITES	(1)
 #define NFS_CONTEXT_BAD			(2)
 #define NFS_CONTEXT_UNLOCK	(3)
 #define NFS_CONTEXT_FILE_OPEN		(4)
-- 
2.37.1


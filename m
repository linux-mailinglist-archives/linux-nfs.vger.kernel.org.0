Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B799D698786
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 22:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBOVt2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 16:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBOVt1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 16:49:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9A38B55
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 13:49:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B234B823DA
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73118C433EF;
        Wed, 15 Feb 2023 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676497763;
        bh=KA2RMzoepIR8eNFh4rwT5DvlWa7LHrSLGhB9WL6lGmo=;
        h=From:To:Cc:Subject:Date:From;
        b=XVDgtX3k6ODoarS9uKumnTWULjS1cv9VFvHnZuvOA0IFbLQut8JpqBPEQTju4hJVb
         7Zr9Dpc9YqMHdickohncQvGQuA8xBL9qrd+2R4rY4L/JSbnRJtRZ+JeQmrfcxqZ/Xb
         3KimwmBum2cexTie9uXq+u76mCCvXw6vMgcKhpA0gKUSUQta1L5sO7LBvajgCtDfNX
         Q9QYRvSAH7HTSwwqbLu1gnsDo8PnyafuOk6BvHXYQcbp0HvLNloXF+jfmrpyj3+c8p
         ijfGl7zu/NcTufTzs8bHpwb6WvpjeeehzGRvhtISMowP4MkVLVQ/NDkfSqfg0Fw6mg
         KKUuAPMgDaWXw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH] Revert "NFSv4.2: Change the default KConfig value for READ_PLUS"
Date:   Wed, 15 Feb 2023 16:49:22 -0500
Message-Id: <20230215214922.1811502-1-anna@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This reverts commit 7fd461c47c6cfab4ca4d003790ec276209e52978.

Unfortunately, it has come to our attention that there is still a bug
somewhere in the READ_PLUS code that can result in nfsroot systems on
ARM to crash during boot.

Let's do the right thing and revert this change so we don't break
people's nfsroot setups.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 1ead5bd740c2..14a72224b657 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -209,8 +209,8 @@ config NFS_DISABLE_UDP_SUPPORT
 config NFS_V4_2_READ_PLUS
 	bool "NFS: Enable support for the NFSv4.2 READ_PLUS operation"
 	depends on NFS_V4_2
-	default y
+	default n
 	help
-	 Choose Y here to enable the use of READ_PLUS over NFS v4.2. READ_PLUS
-	 attempts to improve read performance by compressing out sparse holes
-	 in the file contents.
+	 This is intended for developers only. The READ_PLUS operation has
+	 been shown to have issues under specific conditions and should not
+	 be used in production.
-- 
2.39.1


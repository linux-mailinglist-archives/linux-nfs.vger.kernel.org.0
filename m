Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254C963DCF1
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Nov 2022 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiK3SS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Nov 2022 13:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiK3SSA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Nov 2022 13:18:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB398961
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 10:15:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B806261D53
        for <linux-nfs@vger.kernel.org>; Wed, 30 Nov 2022 18:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2187C43470;
        Wed, 30 Nov 2022 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832130;
        bh=QPnelCYv5jKDf48ucN5jAht76+esA73F3wLbZi27lDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sflsTx5diB9qRXPLH7gs4L6Aptaih79lezHIhIHwv1oyu1Ij2rrcCILckfYV05OLR
         Pg8xCDfE05cZsgKsWn57b3OSM4ihv140VdMVWBBHnx5jissYzCq7rYaTN/79fEAJBl
         Pt+2s3/hIK2Xv9R0d6PKZvgj6/YBO9LUtTWyQqwsm1r5QHJUZuJYm0LTb+kuQGkmoG
         hSCQ0t7dNYJI3t6QiZLFUu5l+qKjoWF1mpzhwP+qqpSbv21VgU9GhwSRgjPn4ItkJD
         SSlOjqPSpHWsO68MNenUOgPFAHldRwYUVKUt5xaBHEphkpfVQZxuIjtABzPkVBfv58
         9ZznpV5oZwtPw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 3/3] NFSv4.2: Change the default KConfig value for READ_PLUS
Date:   Wed, 30 Nov 2022 13:15:27 -0500
Message-Id: <20221130181527.766485-3-anna@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130181527.766485-1-anna@kernel.org>
References: <20221130181527.766485-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Now that we've worked out performance issues and have a server patch
addressing the failed xfstests, we can safely enable this feature by
default.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..1ead5bd740c2 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -209,8 +209,8 @@ config NFS_DISABLE_UDP_SUPPORT
 config NFS_V4_2_READ_PLUS
 	bool "NFS: Enable support for the NFSv4.2 READ_PLUS operation"
 	depends on NFS_V4_2
-	default n
+	default y
 	help
-	 This is intended for developers only. The READ_PLUS operation has
-	 been shown to have issues under specific conditions and should not
-	 be used in production.
+	 Choose Y here to enable the use of READ_PLUS over NFS v4.2. READ_PLUS
+	 attempts to improve read performance by compressing out sparse holes
+	 in the file contents.
-- 
2.38.1


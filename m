Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397184AE38B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381347AbiBHWXA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387067AbiBHVwi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 16:52:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FCC0612BC;
        Tue,  8 Feb 2022 13:52:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A891461639;
        Tue,  8 Feb 2022 21:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDBDC004E1;
        Tue,  8 Feb 2022 21:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644357157;
        bh=BAtgUU3U8csDNJrdRd0bqKFRltZJKOy72p0vv/ao5ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vg4oLPConeciJzGtLQ8aVB4RaWswVkWuFoDcOH10QF/hFF3zGwZK5Ogx6c/XLWinT
         5y2SG8NHqotuKAb5y394sOGumJxDvkiZTo9Zj3CgLzdiduk7kFKjKeagKdrX7/GlJr
         9Q51ZUtNUjoU7wDY60t0Iqx3AnQk16cAQ1E+vqCbAVxabduUQXQ/O9R5jUc6klSoxn
         WcpZugxpdAB4fx2Atz3HYhG5rm/NWtCQbs2CXOq1600om5WbN9RPk14n1ZssbSm+QO
         2tz7EbDaCfqzEPMQsLDAA/aP3v0Lx8ZxC01zKC+B5GJYWpO5RF4bhuAP8FdyDVKxcL
         YrZbpR3pkq79Q==
From:   Anna Schumaker <anna@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] generic/633: Check if idmapped mounts are supported before running
Date:   Tue,  8 Feb 2022 16:52:32 -0500
Message-Id: <20220208215232.491780-5-anna@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208215232.491780-1-anna@kernel.org>
References: <20220208215232.491780-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This appears to have been missed when the test was added.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 tests/generic/633 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/633 b/tests/generic/633
index 382806471223..6750117735f7 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -15,6 +15,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 # real QA test starts here
 
 _supported_fs generic
+_require_idmapped_mounts
 _require_test
 
 echo "Silence is golden"
-- 
2.35.1


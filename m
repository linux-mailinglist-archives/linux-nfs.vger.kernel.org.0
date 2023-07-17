Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F51756E9A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGQUx1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGQUxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 16:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DC10DC
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 13:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 661816127D
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 20:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A886C433CA;
        Mon, 17 Jul 2023 20:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689627163;
        bh=8rk4YsBhatHs6nw4dwWS9Cf8lXaWPzEbw/xq2Wsz6to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSqr9uxOwTeBiCqdDYB9dS4JQoQrTCWjnvC02wjmQd3+ugwE6+AL75ezLHM4iaHTm
         2Fr+ar0tHyfV7jrkaHSKPg7Sw8tWAOnfFvrCMOh0oihYDutCbv1fxSO0+mbcCHPoRP
         LeqxripUHwAd1VbQ91nZFgzs5lKsz7M+3yYZdVno20MY5kFYgR1mTCXJKqlu/mme/Q
         NxraHiuhWD03vxbTUs91NPu6hlQxAATjEGjhg77tOsXjdGLJ5dE8A2+T+olch2AFfb
         Pf8W66lEfi0tSJ8MQobHknc6oDqaIoT2y6tCJfNkXqcpC+RKcWj5Pos8/Q7wEt8yip
         JMAzXl5f1EplA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v5 5/5] NFS: Enable the READ_PLUS operation by default
Date:   Mon, 17 Jul 2023 16:52:39 -0400
Message-ID: <20230717205239.921002-6-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717205239.921002-1-anna@kernel.org>
References: <20230717205239.921002-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Now that the remaining issues have been worked out, including some
unexpected 32 bit issues, we can safely enable the feature by default.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index b6fc169be1b1..7df2503cef6c 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -209,8 +209,6 @@ config NFS_DISABLE_UDP_SUPPORT
 config NFS_V4_2_READ_PLUS
 	bool "NFS: Enable support for the NFSv4.2 READ_PLUS operation"
 	depends on NFS_V4_2
-	default n
+	default y
 	help
-	 This is intended for developers only. The READ_PLUS operation has
-	 been shown to have issues under specific conditions and should not
-	 be used in production.
+	 Choose Y here to enable use of the NFS v4.2 READ_PLUS operation.
-- 
2.41.0


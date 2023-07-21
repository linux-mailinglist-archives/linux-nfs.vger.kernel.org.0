Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B175D5D6
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 22:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGUUkA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGUUj7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 16:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5641701
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 13:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 485D861B24
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 20:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E00C433CC;
        Fri, 21 Jul 2023 20:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689971997;
        bh=8rk4YsBhatHs6nw4dwWS9Cf8lXaWPzEbw/xq2Wsz6to=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ss6UCV0sONuQl+21zcHz2JGxZM9tC80w2AwoX0LYFd16xFCHE5fEKdktOnTGkYnRH
         j6zr0UM44jmDkm4XnioYQt8O5ZCO0qqDHbDvSZBkuCD1ZempZ4DRG2U8IuRk3DbBH8
         x+/DPsOEe4lPs5zl9BBXZZw1Bp2XY5kzpKiI+pYhD2tR9A9JiC8MoEU4XZ58BSqcod
         aH9ISCQxTo9qx2qL7udkjGsbc1AFeRKVEEJ+jlEYpa9XKPc3exwnxFv9Ji8eoscyI0
         uA2Sdqz26001jzulvFpKD3+fiXINJHn7oneddj+M67+t4skDeehLiXLMRabQ7r++ob
         BGJz0MtNTfShQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v6 5/5] NFS: Enable the READ_PLUS operation by default
Date:   Fri, 21 Jul 2023 16:39:53 -0400
Message-ID: <20230721203953.315706-6-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721203953.315706-1-anna@kernel.org>
References: <20230721203953.315706-1-anna@kernel.org>
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


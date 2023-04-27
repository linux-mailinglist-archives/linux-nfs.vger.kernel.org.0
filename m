Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0426F0A90
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Apr 2023 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbjD0RO5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Apr 2023 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbjD0RO5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Apr 2023 13:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F5D2D5F;
        Thu, 27 Apr 2023 10:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421CC60A3D;
        Thu, 27 Apr 2023 17:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB43C4339B;
        Thu, 27 Apr 2023 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682615694;
        bh=YFdlPAagU57g5PVVlBC6wpVOtjfrCy0Kaqyslksz8v4=;
        h=Subject:From:To:Cc:Date:From;
        b=ifDR7F1ddKjHimZW4Kkj+VOS+z6Kyr0hrM6yikH6HOF4FyqebdHz7Z9DIybEFROQb
         tphe5j84iGylOjKJJr31QPTEzQYY5Df17sI8w4Ol9GierO6FIe+EtMhODbhI7WuZ08
         1gwvuHUFvUBs2oO8NlOqIdCDcxm2WSustNHU6sw3Oc0AfxrQ3B+atAwfyxiYpNWQo9
         00+ZI2h8sjfl7cn4jXE74Vqp/h4VRchlTUosCkgMZmHTQJqHE2906pr7QRYDSLpbnm
         WvTAfixRE/DeA+jRlocGljkPaGOnQIoAm8dj3yzlTdOb5LEVqcQR/F2V2FMcJPOArG
         kli3qpuNjpPrA==
Subject: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
From:   Chuck Lever <cel@kernel.org>
To:     BMT@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 27 Apr 2023 13:14:43 -0400
Message-ID: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Bernard Metzler <bmt@zurich.ibm.com>

Tunnel devices have zero GIDs, so skip the zero GID check when
setting up soft iWARP over a tunnel device.

Suggested-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cache.c      |    4 +++-
 drivers/infiniband/sw/siw/siw_main.c |    1 +
 include/rdma/iw_cm.h                 |    9 ++++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 2e91d8879326..2493ca4f2739 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -41,6 +41,7 @@
 #include <net/addrconf.h>
 
 #include <rdma/ib_cache.h>
+#include <rdma/iw_cm.h>
 
 #include "core_priv.h"
 
@@ -441,7 +442,8 @@ static int add_modify_gid(struct ib_gid_table *table,
 	 * leave other unused entries as the zero GID. Convert zero GIDs to
 	 * empty table entries instead of storing them.
 	 */
-	if (rdma_is_zero_gid(&attr->gid))
+	if (rdma_is_zero_gid(&attr->gid) &&
+	   !(attr->device->iw_driver_flags & IW_F_STORE_0GID))
 		return 0;
 
 	entry = alloc_gid_entry(attr);
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index dacc174604bf..842a039fa457 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -359,6 +359,7 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 
 	/* Disable TCP port mapping */
 	base_dev->iw_driver_flags = IW_F_NO_PORT_MAP;
+	base_dev->iw_driver_flags = IW_F_STORE_0GID;
 
 	sdev->attrs.max_qp = SIW_MAX_QP;
 	sdev->attrs.max_qp_wr = SIW_MAX_QP_WR;
diff --git a/include/rdma/iw_cm.h b/include/rdma/iw_cm.h
index 03abd30e6c8c..c48f2cbe37b5 100644
--- a/include/rdma/iw_cm.h
+++ b/include/rdma/iw_cm.h
@@ -90,7 +90,14 @@ enum iw_flags {
 	 * reserve the port.  This is required for soft iwarp
 	 * to play in the port mapped iwarp space.
 	 */
-	IW_F_NO_PORT_MAP = (1 << 0),
+	IW_F_NO_PORT_MAP = BIT(0),
+
+	/*
+	 * This flag allows the insertion of zero GIDs into the
+	 * stored GID table. That is needed to enable soft iWARP
+	 * on tunnel devices.
+	 */
+	IW_F_STORE_0GID = BIT(1),
 };
 
 /**



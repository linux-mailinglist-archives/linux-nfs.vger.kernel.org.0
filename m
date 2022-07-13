Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE07573CF8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiGMTJB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiGMTI4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C61EEEA
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0335661DC3
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C22C341C8;
        Wed, 13 Jul 2022 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739334;
        bh=rxJymRpSJyjY69EEzUSxiQJHV9orLh80D7Kr0qkSBIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFIMJC5T/8PEizxCEXvq0m/SxFSnclKFlTdSnLxMk1nMkMoqE7Qx7/SkkqRUeW1Ch
         VSX/Sq73ZkWkSRcstZbkKg2Ax2wR3UuwP6U4Kq4LI5QjL0hLitkpct+7lMud3cv+jK
         io7hpRou+sr08XIkK0/mF8bI31dNKLo5su9oY84v83vHAYJKGMDeve13XrdVWQH0rf
         7n1BdB1G8eDy1mmPobSlcfs4D02Jihvn3CYzh/tv8sj1wW+8b4ZeO1G8p4dkfDlTDq
         ojYYHvtHJQ7biziatE21paPFMzLOhKryLqrKEgq813XcWy9zjUCPdXZezEkOpX+eYm
         34p98+5/5c/Cw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v2 5/5] NFS: Remove the CONFIG_NFS_V4_2_READ_PLUS Kconfig option
Date:   Wed, 13 Jul 2022 15:08:49 -0400
Message-Id: <20220713190849.615778-6-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713190849.615778-1-anna@kernel.org>
References: <20220713190849.615778-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/Kconfig    | 9 ---------
 fs/nfs/nfs4proc.c | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..5dcd84ce1c0c 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -205,12 +205,3 @@ config NFS_DISABLE_UDP_SUPPORT
 	 Choose Y here to disable the use of NFS over UDP. NFS over UDP
 	 on modern networks (1Gb+) can lead to data corruption caused by
 	 fragmentation during high loads.
-
-config NFS_V4_2_READ_PLUS
-	bool "NFS: Enable support for the NFSv4.2 READ_PLUS operation"
-	depends on NFS_V4_2
-	default n
-	help
-	 This is intended for developers only. The READ_PLUS operation has
-	 been shown to have issues under specific conditions and should not
-	 be used in production.
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bb0e84a46d61..fdd6e22a06ed 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5446,7 +5446,7 @@ static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 				    nfs4_read_done_cb(task, hdr);
 }
 
-#if defined CONFIG_NFS_V4_2 && defined CONFIG_NFS_V4_2_READ_PLUS
+#if defined CONFIG_NFS_V4_2
 static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 				    struct rpc_message *msg)
 {
-- 
2.37.0


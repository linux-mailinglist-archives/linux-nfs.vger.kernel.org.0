Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D204D7722
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiCMRNW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiCMRNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C93013A1D8
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B9461228
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FF2C340F3
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191530;
        bh=ejgalJnlUB3KmMw+rFLeJV/y/rcOd8SfGOkfOcqCQ5o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XuSWLTaSyUyBvLM2I0eIRZKrRlnjgAL2qbRSjtpIUQ0SgqcTIoI9MSSWtl0TVjsZ4
         qyWWWWYLSrz/MjwAhDwq0p3GHOEMpsVpmG7xGaddVEhwsrpOhW95Hfot1jGdkeDDKB
         FPbmnjoGSTzW9c/Yg0H9BU9dm+5loi2Tq6T9K4xSzZ7hF/Wnz+R7ybvNIpW2z4QaVl
         hvZ9ZF8sgiveh663uC3h7YUrc6MXGeuVHulRRZb0WUyUvKE3zzsuLq7nPthJgZ3ar+
         k8xnxedenZTAYUiDNHrsUMlmEjfvy1pKdkmtR7FY4dgwf8QBFe93NGeLb42vW6V8CU
         MHZ2A54BAZWKw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 17/26] NFS: Readdirplus can't help lookup for case insensitive filesystems
Date:   Sun, 13 Mar 2022 13:05:48 -0400
Message-Id: <20220313170557.5940-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-17-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
 <20220313170557.5940-10-trondmy@kernel.org>
 <20220313170557.5940-11-trondmy@kernel.org>
 <20220313170557.5940-12-trondmy@kernel.org>
 <20220313170557.5940-13-trondmy@kernel.org>
 <20220313170557.5940-14-trondmy@kernel.org>
 <20220313170557.5940-15-trondmy@kernel.org>
 <20220313170557.5940-16-trondmy@kernel.org>
 <20220313170557.5940-17-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the filesystem is case insensitive, then readdirplus can't help with
cache misses, since it won't return case folded variants of the filename.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 098fc1bdaac8..dcfc44411787 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -696,6 +696,8 @@ void nfs_readdir_record_entry_cache_miss(struct inode *dir)
 
 static void nfs_lookup_advise_force_readdirplus(struct inode *dir)
 {
+	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+		return;
 	nfs_readdir_record_entry_cache_miss(dir);
 }
 
-- 
2.35.1


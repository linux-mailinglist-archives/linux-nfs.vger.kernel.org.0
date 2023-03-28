Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC26CB7F4
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1H0I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 03:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1H0H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 03:26:07 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D7C1
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 00:26:05 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id djS22900B1C8whw01jS2wD; Tue, 28 Mar 2023 09:26:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ph3hm-00F2J5-HC;
        Tue, 28 Mar 2023 09:26:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ph3iU-004B34-0N;
        Tue, 28 Mar 2023 09:26:02 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Subject: [PATCH] NFSv4: Fix NFS_V4 select RPCSEC_GSS_KRB5
Date:   Tue, 28 Mar 2023 09:25:57 +0200
Message-Id: <42751e1fef65485a5441618bc39735f8b62b3a46.1679988298.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If CONFIG_CRYPTO=n (e.g. arm/shmobile_defconfig):

    WARNING: unmet direct dependencies detected for RPCSEC_GSS_KRB5
      Depends on [n]: NETWORK_FILESYSTEMS [=y] && SUNRPC [=y] && CRYPTO [=n]
      Selected by [y]:
      - NFS_V4 [=y] && NETWORK_FILESYSTEMS [=y] && NFS_FS [=y]

As NFSv4 can work without crypto enabled, fix this by making the
selection of RPCSEC_GSS_KRB5 conditional on CRYPTO.

Fixes: e57d065277387980 ("NFS & NFSD: Update GSS dependencies")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303241307.f6NeW9gZ-lkp@intel.com/
Reported-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Link: https://lore.kernel.org/r/ZCG6tIoz0VN6d+oy@sleipner.dyn.berto.se
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Nfsroot ("root=/dev/nfs rw nfsroot=aaa.bbb.ccc.ddd:/path/to/fs,tcp,v4")
works fine without CRYPTO and RPCSEC_GSS_KRB5.
CONFIG_NFSD_V4 selects CRYPTO, so was not affected by the similar change.
---
 fs/nfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 450d6c3bc05e27dd..f05c13ce0155bd69 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -75,7 +75,7 @@ config NFS_V3_ACL
 config NFS_V4
 	tristate "NFS client support for NFS version 4"
 	depends on NFS_FS
-	select RPCSEC_GSS_KRB5
+	select RPCSEC_GSS_KRB5 if CRYPTO
 	select KEYS
 	help
 	  This option enables support for version 4 of the NFS protocol
-- 
2.34.1


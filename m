Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF4F4B577A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 17:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiBNQyy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 11:54:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356738AbiBNQyx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 11:54:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4457A65152;
        Mon, 14 Feb 2022 08:54:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E64614D7;
        Mon, 14 Feb 2022 16:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF90EC340E9;
        Mon, 14 Feb 2022 16:54:37 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arch: Remove references to CONFIG_NFSD_V3 in the default configs
Date:   Mon, 14 Feb 2022 11:54:37 -0500
Message-Id:  <164485767676.1118.17504841111506078451.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164485766205.1118.1655547082513057717.stgit@klimt.1015granger.net>
References:  <164485766205.1118.1655547082513057717.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=23348; h=from:subject:message-id; bh=Z+P4CkS+EuJTfFtSsmiUG5bljwf0srMQVf2PdL+ncIU=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiColMY1Oz+RZvDubuYTXwJkHKUWZGWP1ERTZnLClP 8wON6+OJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYgqJTAAKCRAzarMzb2Z/lxrGEA CYIh+MD9Dy1akEw/ZMRbcaSK0dPES/vIif0WB5G9iNzHvzVkSdk80A4ENjJqOpZlNBF8cgdR0QV6Sx HtnbxyKgR7qNDKnheg8mGSdCJftdOONwjtGwYPPaJfQIMVkANzozrR3eYvHb7bg4pq9cizH070sqit oop37RHhWIqEHGWaNPUoDEycrhARSJKKA1jsR2GBfddw4lGZBdBJbAm84hElQBcYEEc/AlytqilxGr dFoFE3F7z3BUCoA+4+utXOWWZbmSpJR0I5VdgGL3QPcqSJNnnjukI1yGd3QsFM1qrmQHwiz5o3oyMq eABPBlEnmvKF3MOYPMTn7TXilBsTanbOSQqSG1qkcIMluVGqavhw8LY8sg62woLHwPXnZezX6YnoZp x+JoZPq0VOKgTGkBId2Q2ySZNCjDoqm6AbqylY767rLIK3RWvnCxVyCS/w0bHMhE/sQjvZrB8odkHF KdEKxIUeNEdk5mA1vS8Si0ayaGtTjXUpfJJzQXboObcX52yjuJfcWUrSzWXdb0qQJQFi/kg58VAfJE Njb+XNMyApTp+ELVNFMYodYaGSk+LL0kmh/FVe1oibfpIPo6pYK3LEqImZoKG/6pxz5/fKWxeEylAN zSEjvVcfcjI+sex5sVNn//yVz5w1m6pJajCEA7M7cFfI4JJNUGmbhDZ4qsKw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

CONFIG_NFSD_V3 has been removed. NFSD support for NFSv3 can no
longer be disabled.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 arch/alpha/configs/defconfig                |    1 -
 arch/arm/configs/davinci_all_defconfig      |    1 -
 arch/arm/configs/ezx_defconfig              |    1 -
 arch/arm/configs/imote2_defconfig           |    1 -
 arch/arm/configs/integrator_defconfig       |    1 -
 arch/arm/configs/iop32x_defconfig           |    1 -
 arch/arm/configs/keystone_defconfig         |    1 -
 arch/arm/configs/lart_defconfig             |    1 -
 arch/arm/configs/netwinder_defconfig        |    1 -
 arch/arm/configs/versatile_defconfig        |    1 -
 arch/arm/configs/viper_defconfig            |    1 -
 arch/arm/configs/zeus_defconfig             |    1 -
 arch/ia64/configs/zx1_defconfig             |    1 -
 arch/m68k/configs/amiga_defconfig           |    1 -
 arch/m68k/configs/apollo_defconfig          |    1 -
 arch/m68k/configs/atari_defconfig           |    1 -
 arch/m68k/configs/bvme6000_defconfig        |    1 -
 arch/m68k/configs/hp300_defconfig           |    1 -
 arch/m68k/configs/mac_defconfig             |    1 -
 arch/m68k/configs/multi_defconfig           |    1 -
 arch/m68k/configs/mvme147_defconfig         |    1 -
 arch/m68k/configs/mvme16x_defconfig         |    1 -
 arch/m68k/configs/q40_defconfig             |    1 -
 arch/m68k/configs/sun3_defconfig            |    1 -
 arch/m68k/configs/sun3x_defconfig           |    1 -
 arch/mips/configs/cobalt_defconfig          |    1 -
 arch/mips/configs/decstation_64_defconfig   |    1 -
 arch/mips/configs/decstation_defconfig      |    1 -
 arch/mips/configs/decstation_r4k_defconfig  |    1 -
 arch/mips/configs/ip22_defconfig            |    1 -
 arch/mips/configs/ip32_defconfig            |    1 -
 arch/mips/configs/jazz_defconfig            |    1 -
 arch/mips/configs/malta_defconfig           |    1 -
 arch/mips/configs/malta_kvm_defconfig       |    1 -
 arch/mips/configs/maltaup_xpa_defconfig     |    1 -
 arch/mips/configs/rm200_defconfig           |    1 -
 arch/mips/configs/tb0219_defconfig          |    1 -
 arch/mips/configs/tb0226_defconfig          |    1 -
 arch/mips/configs/tb0287_defconfig          |    1 -
 arch/mips/configs/workpad_defconfig         |    1 -
 arch/parisc/configs/generic-32bit_defconfig |    1 -
 arch/powerpc/configs/linkstation_defconfig  |    1 -
 arch/powerpc/configs/mvme5100_defconfig     |    1 -
 arch/sh/configs/ap325rxa_defconfig          |    1 -
 arch/sh/configs/ecovec24_defconfig          |    1 -
 arch/sh/configs/landisk_defconfig           |    1 -
 arch/sh/configs/sdk7780_defconfig           |    1 -
 arch/sh/configs/se7724_defconfig            |    1 -
 arch/sh/configs/sh03_defconfig              |    1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig   |    1 -
 arch/sh/configs/titan_defconfig             |    1 -
 51 files changed, 51 deletions(-)

diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
index 7f1ca30b115b..7e9336930880 100644
--- a/arch/alpha/configs/defconfig
+++ b/arch/alpha/configs/defconfig
@@ -62,7 +62,6 @@ CONFIG_TMPFS=y
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index e849367c0566..b58d45a03607 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -258,7 +258,6 @@ CONFIG_MINIX_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index ec84d80096b1..0788a892e160 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -309,7 +309,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_SMB_FS=m
 CONFIG_CIFS=m
diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index 6db871d4e077..015b7ef237de 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -283,7 +283,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_SMB_FS=m
 CONFIG_CIFS=m
diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 4dfe321a79f6..5b485722ccf9 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -79,7 +79,6 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index 18a21faa834c..de2cc6759cae 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -94,7 +94,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 33c917df7b32..b1bcb858216b 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -213,7 +213,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index b6ddb9884326..2dfa33d7dca3 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -59,7 +59,6 @@ CONFIG_CRAMFS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index 2e3b20ef0db1..c3c171cec91b 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -71,7 +71,6 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_SMB_FS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index d06aa64e05a1..c2d79a67f81f 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -86,7 +86,6 @@ CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 989599ce5300..c28539bfd128 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -145,7 +145,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index d3b98c4d225b..25bb6995f105 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -160,7 +160,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index 629cb9cdf723..851d8594cdb8 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -106,7 +106,6 @@ CONFIG_HUGETLBFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_737=y
 CONFIG_NLS_CODEPAGE_775=y
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index bc9952f8be66..894ab9d20cac 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -500,7 +500,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index a77269c6e5ba..11e7d58ff8f4 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -457,7 +457,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 7a74efa6b9a1..dd033659d319 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -478,7 +478,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index a5323bf2eb33..326092e3adc6 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -450,7 +450,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 5e80aa0869d5..7583a2d75023 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -459,7 +459,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index e84326a3f62d..fac22f70c8cb 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -480,7 +480,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 337552f43339..ee430aa473bb 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -565,7 +565,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 7b688f7d272a..c26e9d196094 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -449,7 +449,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 7c2cb31d63dd..f00a1e3060ed 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -450,7 +450,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index ca43897af26d..e054e81dde59 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -467,7 +467,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index e3d515f37144..62678b037d0d 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -452,7 +452,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index d601606c969b..113f4c60caf7 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -451,7 +451,6 @@ CONFIG_NFS_V4=m
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 # CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
diff --git a/arch/mips/configs/cobalt_defconfig b/arch/mips/configs/cobalt_defconfig
index c6a652ad34f7..e835730ea7fa 100644
--- a/arch/mips/configs/cobalt_defconfig
+++ b/arch/mips/configs/cobalt_defconfig
@@ -69,6 +69,5 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_LIBCRC32C=y
diff --git a/arch/mips/configs/decstation_64_defconfig b/arch/mips/configs/decstation_64_defconfig
index e2ed105f8c97..0021427a1bbe 100644
--- a/arch/mips/configs/decstation_64_defconfig
+++ b/arch/mips/configs/decstation_64_defconfig
@@ -159,7 +159,6 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 CONFIG_NLS_ISO8859_8=m
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 7e987d6f5e34..7a97a0818ce4 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -154,7 +154,6 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 CONFIG_NLS_ISO8859_8=m
diff --git a/arch/mips/configs/decstation_r4k_defconfig b/arch/mips/configs/decstation_r4k_defconfig
index 6df5f6f2ac8e..a0643363526d 100644
--- a/arch/mips/configs/decstation_r4k_defconfig
+++ b/arch/mips/configs/decstation_r4k_defconfig
@@ -154,7 +154,6 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_SWAP=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 CONFIG_NLS_ISO8859_8=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 21a1168ae301..70a4ba90f491 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -269,7 +269,6 @@ CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_CIFS=m
 CONFIG_CIFS_UPCALL=y
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 1ae48f7d9ddd..74020aa3440b 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -112,7 +112,6 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defconfig
index 8c223035921f..843f360da5f2 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -92,5 +92,4 @@ CONFIG_TMPFS=y
 CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 3321bb576944..1c220d152a50 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -363,7 +363,6 @@ CONFIG_UFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 009b30372226..b5ba08d7ab57 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -371,7 +371,6 @@ CONFIG_UFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index e214e136101c..8d58653f1b4e 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -370,7 +370,6 @@ CONFIG_UFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
 CONFIG_NLS_CODEPAGE_775=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 3dc2da2bee0d..7d6f235e8ccb 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -354,7 +354,6 @@ CONFIG_SYSV_FS=m
 CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 CONFIG_CODA_FS=m
 CONFIG_AFS_FS=m
diff --git a/arch/mips/configs/tb0219_defconfig b/arch/mips/configs/tb0219_defconfig
index 6547f84750b5..c56d8ab14ba6 100644
--- a/arch/mips/configs/tb0219_defconfig
+++ b/arch/mips/configs/tb0219_defconfig
@@ -72,6 +72,5 @@ CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
diff --git a/arch/mips/configs/tb0226_defconfig b/arch/mips/configs/tb0226_defconfig
index 7e099f7c2286..6e1423428f02 100644
--- a/arch/mips/configs/tb0226_defconfig
+++ b/arch/mips/configs/tb0226_defconfig
@@ -67,6 +67,5 @@ CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="cca=3 mem=32M console=ttyVR0,115200"
diff --git a/arch/mips/configs/tb0287_defconfig b/arch/mips/configs/tb0287_defconfig
index 0d881dd862c0..cf65a0879ece 100644
--- a/arch/mips/configs/tb0287_defconfig
+++ b/arch/mips/configs/tb0287_defconfig
@@ -77,7 +77,6 @@ CONFIG_ROMFS_FS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
index 4798dc86c9ce..7e16da0bde8c 100644
--- a/arch/mips/configs/workpad_defconfig
+++ b/arch/mips/configs/workpad_defconfig
@@ -63,6 +63,5 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_NFS_FS=m
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyVR0,19200 ide0=0x170,0x376,49 mem=16M"
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 53061cb2cf7f..a5fee10d76ee 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -210,7 +210,6 @@ CONFIG_TMPFS_XATTR=y
 CONFIG_NFS_FS=m
 # CONFIG_NFS_V2 is not set
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 CONFIG_CIFS_XATTR=y
 CONFIG_CIFS_POSIX=y
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index d4be64f190ff..fa707de761be 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -120,7 +120,6 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_932=m
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 1fed6be95d53..d1c7fd5bf34b 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -101,7 +101,6 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 5193b3e099b9..4d83576b89c6 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -93,7 +93,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 03cb916819fa..d90d29d44469 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -123,7 +123,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index e6c5ddf070c0..492a0a2e0e36 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -108,7 +108,6 @@ CONFIG_UFS_FS=m
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_SMB_FS=m
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index 6c719ab4332a..7d6d32359848 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -120,7 +120,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index a26f7f1841c7..d817df7cc4a7 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -122,7 +122,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index ff502683132e..9fcf68b22dba 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -75,7 +75,6 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_737=m
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 5c725c75fcef..7eb3c10f28ad 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -129,7 +129,6 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
-CONFIG_NFSD_V3=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index cd5c58916c65..73a0d68b0de6 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -239,7 +239,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
-CONFIG_NFSD_V3=y
 CONFIG_SMB_FS=m
 CONFIG_CIFS=m
 CONFIG_PARTITION_ADVANCED=y


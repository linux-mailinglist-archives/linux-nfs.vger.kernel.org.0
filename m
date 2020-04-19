Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1A1AF893
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2020 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSIBh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 04:01:37 -0400
Received: from orion.archlinux.org ([88.198.91.70]:44886 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDSIBh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 04:01:37 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 04:01:36 EDT
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 379041B1692ED7;
        Sun, 19 Apr 2020 07:52:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on orion.archlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=ALL_TRUSTED=-1,BAYES_00=-1,
        DKIMWL_WL_HIGH=-0.001,DKIM_SIGNED=0.1,DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1,T_DMARC_POLICY_NONE=0.01 autolearn=ham
        autolearn_force=no version=3.4.4
X-Spam-BL-Results: 
Received: from didactylos.attlocal.net (unknown [IPv6:2600:1700:57f0:ca20:763a:c795:fcf6:91ea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: eschwartz)
        by orion.archlinux.org (Postfix) with ESMTPSA id 786D01B1692EC8;
        Sun, 19 Apr 2020 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archlinux.org;
        s=orion; t=1587282742;
        bh=WVfGD3PKZobGqjA25U/wkz9n5sLv1UH9/4Glx1+gt2g=;
        h=From:To:Cc:Subject:Date;
        b=SOrwC+Vm8czx699tuYfmIy/WpUV03V8ZMPj5f04c06WJ5FP+vs9nxQseXA+ZZlJ/E
         FHRo2dnoQtVVeoaCkE+hZMal9XCNYfgoSojTohZEe/y5ynfesqx1RE04pwD5Wls2+Q
         x/GUlBKjuAviyBChZbwnJuNUruN26cx5lcHXuBOPk/+0D2hqfgLs+6YKkNrvRH3ja/
         CdarDC07Q9PX7ON0luq+wOEjegMkTtw+VebSn016BMpNk7Si6evN1EPwLMpr9Un1xT
         ejMLIPLQaaOe1NK8cn2YUskMmtipnzQwiGt1Ben/R/Ipub8+jpyjR0YKwZKHnkjfwk
         /3fC45Jg23w2AwW5hGq9NFRbUgaRTSuYZ5NdFmH3HGzQ3T63gHCTNNwH46Hlxe+Qz8
         ojrICQcOILxSBs4dLHse1ISkolBR3BTQ1kYUV1zNC4l9ZlG7wXlyzuwlCqhQQG514x
         T9YvQfsiVWPEVLYY+TRepfSZhQBuEkDMj3EQ7SaL+XLpp65RkfHRNcC/A2oZaC0leC
         yKluwzAwPKFqEYswoOQfaQrM7UEspge8fmPAn2cp5innCpHvhRdlddh8eK+GevBUvb
         pZFeX1tOhEd3jlABUZUEPiScyxquX0kiKxT97XYolRoqBTYHaHxwnq7FRQHvc21V/B
         n1saeQ6wrmCyNaE1KkNUpNcM=
From:   Eli Schwartz <eschwartz@archlinux.org>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] pkg-config: use the correct replacements for libdir/includedir
Date:   Sun, 19 Apr 2020 03:52:01 -0400
Message-Id: <20200419075201.1161001-1-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

They are defined pkg-config variables for a reason, let's reuse them as
is the intended usage of pkg-config. This ensures various pkg-config
features continue to work as expected.

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---
 libtirpc.pc.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libtirpc.pc.in b/libtirpc.pc.in
index 38034c5..863950f 100644
--- a/libtirpc.pc.in
+++ b/libtirpc.pc.in
@@ -9,4 +9,4 @@ Requires:
 Version: @PACKAGE_VERSION@
 Libs: -L@libdir@ -ltirpc
 Libs.private: -lpthread
-Cflags: -I@includedir@/tirpc
+Cflags: -I${includedir}/tirpc
-- 
2.26.0

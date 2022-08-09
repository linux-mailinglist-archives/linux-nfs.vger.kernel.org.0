Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894D58E33A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Aug 2022 00:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiHIWdN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 18:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHIWdM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 18:33:12 -0400
Received: from smtpcmd04135.aruba.it (smtpcmd04135.aruba.it [62.149.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7653D65645
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 15:33:11 -0700 (PDT)
Received: from localhost.localdomain ([86.32.63.136])
        by Aruba Outgoing Smtp  with ESMTPSA
        id LXmfon3hTVH2DLXmgo1l3i; Wed, 10 Aug 2022 00:33:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660084390; bh=t0LqrTpTKZ+tAMorEWrtcYOweL+1cUK7/imJDcRMZ1M=;
        h=From:To:Subject:Date:MIME-Version;
        b=e0DzvhG95wZc9PyBnYn9J1aNUUqgN6qHqH/VbsBF4IqFwyUjmAAYUEYPY5N+ZHTUu
         9bCZOctDiu0GLF1MCmsHVWI9i2q3M8PBr/3HgNuyexS6Jvf+eM8ITj4ihwhBfrLvBB
         BI1D6IkKvyXS1wyeZzggYPG8thIcBmbUtbYpHDaW1k6WRD/876ZQnoyQhSn+GR2Drv
         iiHNUjMY+3x9hL4UvmfJ6qUNTG1nXxn3AKyEDDrJdqGieQh80+2lC+1q55Z99qLAsh
         rEyDVR2Ghk2/ymIbobPX4Q2L3tCfXXGExSnPad0snT+AArYDnYjozO0gOEDbxgkyxs
         NB+EI8wCc2ruA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2] nfsrahead: fix linking while static linking
Date:   Wed, 10 Aug 2022 00:33:08 +0200
Message-Id: <20220809223308.1421081-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809221252.772891-1-giulio.benetti@benettiengineering.com>
References: <20220809221252.772891-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMO8Oh82DZP45DJxO5vZK/aihpeHhI/OwFEbjPCQMs0QHSN9awa/pwWnoGKZPWP5niTDdOZemT2tcWna8C6O1DYoaSOeAnN6DvkocoF+GBia4h39PNC0
 Y3pjlyxs/gW4rqIEwfsRjS8S0fA8+7rdehPVZ27TCUswXLj3t/YHbBYmzwcK7TsncFoTpyv/cqwZoEsf6y78JSPXSStJerGJAOiuY0QWh/4ajRxDgpwLYcPq
 6Vc2Pnllj7gfwJuD50nhyz9ocZFY7v8WBjINIowuJe/BpmZSGV1TcajwuKfAu9PW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-lmount must preceed -lblkid and to obtain this let's add:
`pkg-config --libs mount`
in place of:
`-lmount`
This ways the library order will always be correct.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* modify pkg-conf to pkg-config
---
 tools/nfsrahead/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index 845ea0d5..280a2eb4 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,6 +1,6 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
-nfsrahead_LDFLAGS= -lmount
+nfsrahead_LDFLAGS= `pkg-config --libs mount`
 nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
 
 man5_MANS = nfsrahead.man
-- 
2.34.1


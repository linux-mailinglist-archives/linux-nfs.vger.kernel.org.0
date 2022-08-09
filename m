Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747D758E2C5
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Aug 2022 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiHIWOf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiHIWN7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 18:13:59 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Aug 2022 15:13:56 PDT
Received: from smtpcmd04135.aruba.it (smtpcmd04135.aruba.it [62.149.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D17601EEEB
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 15:13:56 -0700 (PDT)
Received: from localhost.localdomain ([86.32.63.136])
        by Aruba Outgoing Smtp  with ESMTPSA
        id LXT3omiD7VH2DLXT4o1cRk; Wed, 10 Aug 2022 00:12:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660083174; bh=dfKwYIvFa+K2cOZIy5Edi3j/9b0XUmmrcPlaCMPk+7k=;
        h=From:To:Subject:Date:MIME-Version;
        b=HZtqDSHHwZ34GsFMlcc6syOzPZ/L0i5vQp0uRVbEXHBVsJre8kJA61OHVBCPp9TpZ
         US59p9xW28uVtHL6nmd+9du8Z4dmzSt1OCxx03Lir2MisZjRDc2s7LjojRxNsj0W1H
         o09gyAuBJs34ngpMrrh/s6KrnSRMCEMQEFfANH4Fyzkj4oCsR4gr35CKlbm186Apox
         l981DBECSTtf5zycrVk7NJlmxj2SnXu6iXOCySUVLU2z/VyEmlaF1JXg2dEnwpF+nE
         BJhZIAPhLiJQ2haz2J/Z3n5WRrEUN/FOPABeozp2jKNbTs2wcn94qM7LLS0DV7rGDq
         G8V0v1GDrq2jA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] nfsrahead: fix linking while static linking
Date:   Wed, 10 Aug 2022 00:12:52 +0200
Message-Id: <20220809221252.772891-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMdr3k9/5vmNmmWYQBzVu/eGVWIJ97DUo11UaBgrN/n4bAC169j7oFuNbLkC32TbrWcy4zHblP3t0AyiEnNgJL2Eo3P/0ELsNc2nyKQg0U5Afh/th8VE
 oM4tX4cXmcCkh/1ZI+o2n4+WHRj+bBwJK5K3J9cG/snTjrjHPYof58X5iI44jTDfZ2/8qXtAa0p3jNlidDqbgdvykxmF5LAmGr5jed72yHBSf6vDgHMNjV+z
 TcjxyTDNPLFaoZQ/UsgiZNmuzxe7aEJ3CanGYKXjmiC58BBTVPAjsebVi/JmuLV9
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
`pkg-conf --libs mount`
in place of:
`-lmount`
This ways the library order will always be correct.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/nfsrahead/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index 845ea0d5..74fc344f 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,6 +1,6 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
-nfsrahead_LDFLAGS= -lmount
+nfsrahead_LDFLAGS= `pkg-conf --libs mount`
 nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
 
 man5_MANS = nfsrahead.man
-- 
2.34.1


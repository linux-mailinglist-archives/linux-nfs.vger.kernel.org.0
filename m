Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA358F3E9
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Aug 2022 23:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHJVqE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Aug 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHJVqD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Aug 2022 17:46:03 -0400
Received: from smtpcmd01-ws.aruba.it (smtpcmd01-ws.aruba.it [62.149.158.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 561A450185
        for <linux-nfs@vger.kernel.org>; Wed, 10 Aug 2022 14:45:57 -0700 (PDT)
Received: from localhost.localdomain ([86.32.63.136])
        by Aruba Outgoing Smtp  with ESMTPSA
        id LtWVonv9or8wyLtWWoBOdr; Wed, 10 Aug 2022 23:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660167956; bh=UAoNYouwoS+1+8VIqxJalEPvbD9bakxlPHxlUdkDve0=;
        h=From:To:Subject:Date:MIME-Version;
        b=jgCP+R3s1XKbifA4Bs6B6N75dYhot5Ebqg45D8bYZZOqG5oN3p34pRzMUAgmOtosy
         GYIizS9Y4yN1nevgAmHZ3u3wZPlX9YXqm2E6N1mKn3f3HCNsOUIldD9XHZy+CYX6TH
         XFxuuUMeCnks24L+AQWXoY+hy1iQH2NIeniXJexAU9oPb7wy3MLkAAjPMZIJWJt6Sa
         8AMcaeCCTOsQ3wbrQtZSUBbKyF3I26sxuFK+V8hNCTvnWKKn3oZiLw1auMTngPOCSv
         qy7refLb6xsqbrvl0rpf5dIAcvxV9H6lRSe0L4xGQ6G+jOfl6d8qQBqfRO7u2sClsD
         QYrv1/SzfJvTw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v3] nfsrahead: fix linking while static linking
Date:   Wed, 10 Aug 2022 23:45:54 +0200
Message-Id: <20220810214554.107094-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809223308.1421081-1-giulio.benetti@benettiengineering.com>
References: <20220809223308.1421081-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMVFUVYZ0/KjKbP/g72z2BJcG4NtHsn2/LCkviEoNDFgu4e1waj+nJAstJkO8HvBa3Snm6qz3tcWwSbUd79J9uH+F+3FN/DhznaCkPLvROvQTq7jdHBy
 0Q47HvEzN4fWcZesIRAYAiXRQrPh7siJD0TuT2Kz/+ax9xdxwweaDJ0LPqVz3YFlLo0adXCM10mRjNTIn9lRJj5X3KCmiDwxbewP47YPj+0lvUAGTdR9oLYs
 NZygUXJQdx9JWgVgrEmwfDfHUC8ybiZMjCPEENUk0PpGAt9IZmzWFPiYLVaJyB4Z
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-lmount must preceed -lblkid and to obtain this let's add in configure.ac:
PKG_CHECK_MODULES([LIBMOUNT], [mount])
and in tools/nfsrahead/Makefile.am let's substitute explicit `-lmount`
with:
$(LIBMOUNT_LIBS)
This way all the required libraries will be present and in the right order
when static linking.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* modify pkg-conf to pkg-config
V2->V3:
* use the correct way for using pkg-config with Autotools
---
 configure.ac                | 3 +++
 tools/nfsrahead/Makefile.am | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f1c46c5c..ff85200b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -273,6 +273,9 @@ AC_LIBCAP
 dnl Check for -lxml2
 AC_LIBXML2
 
+dnl Check for -lmount
+PKG_CHECK_MODULES([LIBMOUNT], [mount])
+
 # Check whether user wants TCP wrappers support
 AC_TCP_WRAPPERS
 
diff --git a/tools/nfsrahead/Makefile.am b/tools/nfsrahead/Makefile.am
index 845ea0d5..7e08233a 100644
--- a/tools/nfsrahead/Makefile.am
+++ b/tools/nfsrahead/Makefile.am
@@ -1,6 +1,6 @@
 libexec_PROGRAMS = nfsrahead
 nfsrahead_SOURCES = main.c
-nfsrahead_LDFLAGS= -lmount
+nfsrahead_LDFLAGS= $(LIBMOUNT_LIBS)
 nfsrahead_LDADD = ../../support/nfs/libnfsconf.la
 
 man5_MANS = nfsrahead.man
-- 
2.34.1


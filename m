Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941375BD72A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 00:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiISWUO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiISWT7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 18:19:59 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Sep 2022 15:19:40 PDT
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95D3512094
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 15:19:37 -0700 (PDT)
Received: from localhost.localdomain ([146.241.95.233])
        by Aruba Outgoing Smtp  with ESMTPSA
        id aP61oP3ZllHojaP62on5xT; Tue, 20 Sep 2022 00:18:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1663625914; bh=pRVdN80+VvQPalmDCsRoZYzxuxjYwNVXj8z2LyBYW0E=;
        h=From:To:Subject:Date:MIME-Version;
        b=fDuNrrfxXVfatJ1NCjMRC1S1x5H3GW3cx9jO4Vmu+TLPNpqogMvkxxmApnxpynMCz
         FUB+x6qwShD9Di/QLuX3b0Uqw/BB+dqhTnLm6r4b12gpSR7KlZWpWYjUsHbSxON2rG
         4Y4lh6CCsu2YqBsjFqxfRfJDglry7nk+gdP7rmKA33tGcra7mo2+MVatSpoT3MkaXG
         kCsw2qkK5soagluYH+5Xr42li7LEpnvPOeYs+K2fsr9GCMiLwXyg41WxoHPXaQ6Qz2
         fr6fXM3KBjwrv63DX3Yj7VJMpuOMTN3wb+3nYp0pIXU2SQImU2zgVOb6/D+rmptZ2r
         0OGuhlJt1aDig==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] configure.ac: allow to disable nfsrahead tool
Date:   Tue, 20 Sep 2022 00:18:32 +0200
Message-Id: <20220919221832.2234294-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFso3Wbqys8S8WFNSuMDkt0EhXRR4wDuiFp4nxVn8ZB/fiIYXlSpwhe0a6ohXf7VL3+RDvVq4HIVmXHODbwI3brQPShS8+IajhtLvjECLHlWuSpXhIFj
 L3l+TXhFtfKAumrdomfXnvAmP4DYF4fukeXe6vt/dlTVCIxaRFgqiGo70GMjXa6cAMj8NBygWd2gSLQQaqRX/B4ToAwL4nBvaDc0h0fdqfLDk1RWE3lhlVUx
 2YZ32+WGZjE7fiLr7MmgqrBnpnW/vGZ9NoxLu83VUm5bt6UoIf/HukOwqzql1zHS9M+5zQOtA4K+1aZR95QfkGowZceg/Hsdq+ROB33Z5/0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This allows to make libmount not mandatory but depending on nfsrahead
since it only requires it. This is useful when cross-compiling because
in that case we need rpcgen only built for host but not nfsrahead that
also require libmount. So this reduces the dependencies for host
building.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 configure.ac      | 13 ++++++++++---
 tools/Makefile.am |  6 +++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index ff85200b..5d9cbf31 100644
--- a/configure.ac
+++ b/configure.ac
@@ -249,6 +249,16 @@ AC_ARG_ENABLE(nfsdcld,
 	enable_nfsdcld=$enableval,
 	enable_nfsdcld="yes")
 
+AC_ARG_ENABLE(nfsrahead,
+	[AS_HELP_STRING([--disable-nfsrahead],[disable nfsrahead command @<:@default=no@:>@])],
+	enable_nfsrahead=$enableval,
+	enable_nfsrahead="yes")
+	AM_CONDITIONAL(CONFIG_NFSRAHEAD, [test "$enable_nfsrahead" = "yes" ])
+	if test "$enable_nfsrahead" = yes; then
+		dnl Check for -lmount
+		PKG_CHECK_MODULES([LIBMOUNT], [mount])
+	fi
+
 AC_ARG_ENABLE(nfsdcltrack,
 	[AS_HELP_STRING([--disable-nfsdcltrack],[disable NFSv4 clientid tracking programs @<:@default=no@:>@])],
 	enable_nfsdcltrack=$enableval,
@@ -273,9 +283,6 @@ AC_LIBCAP
 dnl Check for -lxml2
 AC_LIBXML2
 
-dnl Check for -lmount
-PKG_CHECK_MODULES([LIBMOUNT], [mount])
-
 # Check whether user wants TCP wrappers support
 AC_TCP_WRAPPERS
 
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 40c17c37..48fd0cdf 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,10 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts nfsrahead $(OPTDIRS)
+if CONFIG_NFSRAHEAD
+OPTDIRS += nfsrahead
+endif
+
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
-- 
2.34.1


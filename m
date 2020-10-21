Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D321E294B40
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Oct 2020 12:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438788AbgJUK3A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Oct 2020 06:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410025AbgJUK27 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Oct 2020 06:28:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FE0C0613CE
        for <linux-nfs@vger.kernel.org>; Wed, 21 Oct 2020 03:28:58 -0700 (PDT)
Received: from erbse.hi.pengutronix.de ([2001:67c:670:100:9e5c:8eff:fece:cdfe] helo=erbse.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1kVBMX-00064Q-7j; Wed, 21 Oct 2020 12:28:57 +0200
From:   Bastian Krause <bst@pengutronix.de>
To:     linux-nfs@vger.kernel.org
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Steve Dickson <steved@redhat.com>, kernel@pengutronix.de,
        Bastian Krause <bst@pengutronix.de>
Subject: [nfs-utils PATCH] tools: rpcgen: use host instead of cross compiler
Date:   Wed, 21 Oct 2020 12:28:52 +0200
Message-Id: <20201021102852.26186-1-bst@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:9e5c:8eff:fece:cdfe
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When cross compiling rpcgen is compiled with the cross compiler although
it is executed during compile time only. This leads to errors like:

  ../../tools/rpcgen/rpcgen -l -o mount_clnt.c mount.x
  ../../tools/rpcgen/rpcgen -c -i 0 -o mount_xdr.c mount.x
  ../../tools/rpcgen/rpcgen -h -o mount.h mount.x
  /lib/ld-linux-armhf.so.3: No such file or directory
  /lib/ld-linux-armhf.so.3: No such file or directory
  /lib/ld-linux-armhf.so.3: No such file or directory

Since e61775d1 ("rpcgen: bump to latest version") rpcgen is compiled
with the target compiler, prior to that it was correctly compiled with
the host compiler. Fix that by using $(CC_FOR_BUILD) as CC explicitly as
it was before.

buildroot works around this by compiling a host version first, then a
target version --with-rpcgen=$(HOST_DIR)/bin/rpcgen [1]. That does not
look like it is intended by nfs-utils.

[1] https://git.busybox.net/buildroot/tree/package/nfs-utils/nfs-utils.mk#n25

Signed-off-by: Bastian Krause <bst@pengutronix.de>
---
 tools/rpcgen/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
index 457cd507..f122cd9d 100644
--- a/tools/rpcgen/Makefile.am
+++ b/tools/rpcgen/Makefile.am
@@ -1,5 +1,7 @@
 CLEANFILES = *~
 
+CC=$(CC_FOR_BUILD)
+
 bin_PROGRAMS = rpcgen
 man_MANS = rpcgen.1
 
-- 
2.20.1


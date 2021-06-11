Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F303A4200
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhFKMaL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Jun 2021 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFKMaK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Jun 2021 08:30:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33880C061574
        for <linux-nfs@vger.kernel.org>; Fri, 11 Jun 2021 05:28:13 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1lrgGg-0007Xs-1t; Fri, 11 Jun 2021 14:28:10 +0200
From:   Bastian Krause <bst@pengutronix.de>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>,
        Bastian Krause <bst@pengutronix.de>
Subject: [PATCH rpcbind] autotools/systemd: call rpcbind with -w only on enabled warm starts
Date:   Fri, 11 Jun 2021 14:28:03 +0200
Message-Id: <20210611122803.24747-1-bst@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If rpcbind is configured with --disable-warmstarts it responds on -w
with its usage string. This is not helpful in a systemd service, so pass
-w conditionally.

Signed-off-by: Bastian Krause <bst@pengutronix.de>
---
 configure.ac               | 6 ++++++
 systemd/rpcbind.service.in | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index c0ef896..c2069a2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,6 +20,12 @@ AM_CONDITIONAL(LIBSETDEBUG, test x$lib_setdebug = xyes)
 AC_ARG_ENABLE([warmstarts],
   AS_HELP_STRING([--enable-warmstarts], [Enables Warm Starts @<:@default=no@:>@]))
 AM_CONDITIONAL(WARMSTART, test x$enable_warmstarts = xyes)
+AS_IF([test x$enable_warmstarts = xyes], [
+	warmstarts_opt=-w
+], [
+	warmstarts_opt=
+])
+AC_SUBST([warmstarts_opt], [$warmstarts_opt])
 
 AC_ARG_ENABLE([rmtcalls],
   AS_HELP_STRING([--enable-rmtcalls], [Enables Remote Calls @<:@default=no@:>@]))
diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
index 7b1c74b..c892ca8 100644
--- a/systemd/rpcbind.service.in
+++ b/systemd/rpcbind.service.in
@@ -12,7 +12,7 @@ Wants=rpcbind.target
 [Service]
 Type=notify
 # distro can provide a drop-in adding EnvironmentFile=-/??? if needed.
-ExecStart=@_sbindir@/rpcbind $RPCBIND_OPTIONS -w -f
+ExecStart=@_sbindir@/rpcbind $RPCBIND_OPTIONS @warmstarts_opt@ -f
 
 [Install]
 WantedBy=multi-user.target
-- 
2.29.2


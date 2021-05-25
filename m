Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152CF38FFEC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEYL3Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhEYL3Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 07:29:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C80C061756
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 04:27:46 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1llVDs-0002HE-TC; Tue, 25 May 2021 13:27:44 +0200
Received: from rhi by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <rhi@pengutronix.de>)
        id 1llVDs-0007e0-Gg; Tue, 25 May 2021 13:27:44 +0200
From:   Roland Hieber <rhi@pengutronix.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Roland Hieber <rhi@pengutronix.de>
Subject: [PATCH nfs-utils 1/2] README: update git repository URL
Date:   Tue, 25 May 2021 13:27:28 +0200
Message-Id: <20210525112729.29062-1-rhi@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The old URL is no longer available. Update to the new URL that is
mentioned on https://linux-nfs.org.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 7034c0091d49..663b667437dc 100644
--- a/README
+++ b/README
@@ -34,7 +34,7 @@ To install binaries and documenation, run this command:
 
 Getting nfs-utils for the first time:
 
-	git clone git://linux-nfs.org/nfs-utils
+	git clone git://git.linux-nfs.org/projects/steved/nfs-utils.git
 
 Updating to the latest head after you've already got it.
 
-- 
2.29.2


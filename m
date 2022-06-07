Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958153F808
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiFGITm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiFGITm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 04:19:42 -0400
X-Greylist: delayed 52647 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 01:19:39 PDT
Received: from mail.linux-ng.de (srv.linux-ng.de [IPv6:2a01:4f8:160:92e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E70152CE04
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 01:19:39 -0700 (PDT)
Received: from rpi4.linux-ng.de (unknown [192.168.1.79])
        by mail.linux-ng.de (Postfix) with ESMTPS id A7FED83DE6D4;
        Tue,  7 Jun 2022 10:19:38 +0200 (CEST)
Received: by rpi4.linux-ng.de (Postfix, from userid 1000)
        id 7262BBBEC0; Tue,  7 Jun 2022 10:19:38 +0200 (CEST)
From:   marcel@linux-ng.de
To:     linux-nfs@vger.kernel.org
Cc:     Marcel Ritter <marcel@linux-ng.de>
Subject: [PATCH 2/3] cifs-utils/svcgssd: Display principal if set
Date:   Tue,  7 Jun 2022 10:19:08 +0200
Message-Id: <20220607081909.1216287-2-marcel@linux-ng.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607081909.1216287-1-marcel@linux-ng.de>
References: <20220607081909.1216287-1-marcel@linux-ng.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Marcel Ritter <marcel@linux-ng.de>

It's a little irritating to only see the template "<...>@<...>" if you
set a specific principal name. So let's show it (if set).

---
 utils/gssd/svcgssd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
index a242b789..ce78d8f7 100644
--- a/utils/gssd/svcgssd.c
+++ b/utils/gssd/svcgssd.c
@@ -295,9 +295,9 @@ main(int argc, char *argv[])
 				(const gss_OID)GSS_C_NT_HOSTBASED_SERVICE);
 		if (status == FALSE) {
 			printerr(0, "unable to obtain root (machine) credentials\n");
-			printerr(0, "do you have a keytab entry for "
-				"nfs/<your.host>@<YOUR.REALM> in "
-				"/etc/krb5.keytab?\n");
+			printerr(0, "do you have a keytab entry for %s in"
+				"/etc/krb5.keytab?\n",
+				principal ? principal : "nfs/<your.host>@<YOUR.REALM>");
 			exit(1);
 		}
 	} else {
-- 
2.34.1


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3E5F48BA
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJDRlC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJDRke (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 13:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525814F3B3
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664905218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SCR9mlk85jb8kDj17yDLyneP5x5BC2d4THb6IR+XW7g=;
        b=aSOFcaVauB+b9suC2Rk61aUHlrZbf9Ueh6qQSEVzZ2IJLWYS2uplGnvSAKMfa3ogb1S17s
        whDPNvV9LflNRyAtix0Xk+9A4SQVa44fLW2Hqma5SxKcVUhVXMUDPhYcQEQkK0lPnuwKSS
        ILSkdaHuKSXs6L47VMmXYIAh0x+aozU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-2B0znjqHPJ29ypNMYpT46w-1; Tue, 04 Oct 2022 13:40:17 -0400
X-MC-Unique: 2B0znjqHPJ29ypNMYpT46w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E24480C8C1
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 17:40:17 +0000 (UTC)
Received: from bearskin.sorenson.redhat.com (unknown [10.2.17.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1537F4099B57;
        Tue,  4 Oct 2022 17:40:17 +0000 (UTC)
From:   Frank Sorenson <sorenson@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com
Subject: [PATCH nfs-utils] Allow 'debug' configuration option to accept '0' and '1'
Date:   Tue,  4 Oct 2022 12:40:15 -0500
Message-Id: <20221004174015.1362841-1-sorenson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the example /etc/nfs.conf file, most sections include
a commented-out 'debug = 0' line, suggesting that '0' is
the default.  In addition, the manpages for some of the
utilities state that debugging can be enabled by setting
'debug = 1' in the nfs.conf file.

However, neither '0' nor '1' is accepted as a valid option
for 'debug' while parsing the nfs.conf file.

Add '0' and '1' to the valid strings when parsing 'debug',
with '0' not changing any debugging settings, and '1'
enabling all debugging.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 support/nfs/xlog.c   | 7 +++++--
 systemd/nfs.conf.man | 6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/support/nfs/xlog.c b/support/nfs/xlog.c
index e5861b9d..fa125cef 100644
--- a/support/nfs/xlog.c
+++ b/support/nfs/xlog.c
@@ -46,11 +46,13 @@ int export_errno = 0;
 
 static void	xlog_toggle(int sig);
 static struct xlog_debugfac	debugnames[] = {
+	{ "0",		0, },
 	{ "general",	D_GENERAL, },
 	{ "call",	D_CALL, },
 	{ "auth",	D_AUTH, },
 	{ "parse",	D_PARSE, },
 	{ "all",	D_ALL, },
+	{ "1",		D_ALL, },
 	{ NULL,		0, },
 };
 
@@ -119,13 +121,14 @@ xlog_sconfig(char *kind, int on)
 {
 	struct xlog_debugfac	*tbl = debugnames;
 
-	while (tbl->df_name != NULL && strcasecmp(tbl->df_name, kind)) 
+	while (tbl->df_name != NULL && strcasecmp(tbl->df_name, kind))
 		tbl++;
 	if (!tbl->df_name) {
 		xlog (L_WARNING, "Invalid debug facility: %s\n", kind);
 		return;
 	}
-	xlog_config(tbl->df_fac, on);
+	if (tbl->df_fac)
+		xlog_config(tbl->df_fac, on);
 }
 
 void
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index e74083e9..b95c05a6 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -98,6 +98,12 @@ value, which can be one or more from the list
 .BR parse ,
 .BR all .
 When a list is given, the members should be comma-separated.
+The values
+.BR 0
+and
+.BR 1
+are also accepted, with '0' making no changes to the debug level, and '1' equivalent to specifying 'all'.
+
 .TP
 .B general
 Recognized values:
-- 
2.37.2


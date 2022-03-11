Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3714D68E6
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 20:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbiCKTH7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 14:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351030AbiCKTHw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 14:07:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F9091AE650
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PX82FmfUjpzWNaKubKpmm2Pr9P/DWkk8799evqvgPWk=;
        b=P0GqGqwawdFUfuOnuxGV7hhBzyuYuTxF6oiBmYGwdsaFNXprhTjnq/5UZCQlT/YyD0lpxP
        I5Ilk0a+gBjUC9gQNfA4SwOZtCPS6XoEyZAuF52PYe8KUjvW+kMUOPJt8JlujuildtUFRj
        eWLgPtoGFV5FVl0C8Kxq4/YVqI16RKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-OALZsrckPFOJNxXfwHTk3w-1; Fri, 11 Mar 2022 14:06:45 -0500
X-MC-Unique: OALZsrckPFOJNxXfwHTk3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B07C1006AA6;
        Fri, 11 Mar 2022 19:06:44 +0000 (UTC)
Received: from nyarly.rlyeh.local (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A72260BF4;
        Fri, 11 Mar 2022 19:06:39 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [RFC v2 PATCH 3/7] readahead: create logging facility
Date:   Fri, 11 Mar 2022 16:06:13 -0300
Message-Id: <20220311190617.3294919-4-tbecker@redhat.com>
In-Reply-To: <20220311190617.3294919-1-tbecker@redhat.com>
References: <20220311190617.3294919-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Create logs for nfs-readahead-udev, logging to syslog.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfs-readahead-udev/Makefile.am |  2 +-
 tools/nfs-readahead-udev/log.h       | 16 ++++++++++
 tools/nfs-readahead-udev/main.c      |  8 +++++
 tools/nfs-readahead-udev/syslog.c    | 47 ++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfs-readahead-udev/log.h
 create mode 100644 tools/nfs-readahead-udev/syslog.c

diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
index 873cc175..5078db9a 100644
--- a/tools/nfs-readahead-udev/Makefile.am
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -1,5 +1,5 @@
 libexec_PROGRAMS = nfs-readahead-udev
-nfs_readahead_udev_SOURCES = main.c
+nfs_readahead_udev_SOURCES = main.c syslog.c
 
 udev_rulesdir = /etc/udev/rules.d
 udev_rules_DATA = 99-nfs_bdi.rules
diff --git a/tools/nfs-readahead-udev/log.h b/tools/nfs-readahead-udev/log.h
new file mode 100644
index 00000000..2a14e552
--- /dev/null
+++ b/tools/nfs-readahead-udev/log.h
@@ -0,0 +1,16 @@
+#ifndef __ra_log_h__
+#define __ra_log_h__
+#include <stdarg.h>
+
+extern void log_open(void);
+extern void log_close(void);
+
+extern void debug(const char *, ...);
+extern void info(const char *, ...);
+extern void notice(const char *, ...);
+extern void warn(const char *, ...);
+extern void err(const char *, ...);
+extern void crit(const char *, ...);
+extern void alert(const char *, ...);
+extern void emerg(const char *, ...);
+#endif
diff --git a/tools/nfs-readahead-udev/main.c b/tools/nfs-readahead-udev/main.c
index e454108e..dd2c9f8c 100644
--- a/tools/nfs-readahead-udev/main.c
+++ b/tools/nfs-readahead-udev/main.c
@@ -1,7 +1,15 @@
 #include <stdio.h>
 
+#include "log.h"
+
 int main(int argc, char **argv, char **envp)
 {
 	unsigned int readahead = 128;
+
+	log_open();
+
+	info("Setting the readahead to 128\n");
+
+	log_close();
 	printf("%d\n", readahead);
 }
diff --git a/tools/nfs-readahead-udev/syslog.c b/tools/nfs-readahead-udev/syslog.c
new file mode 100644
index 00000000..5eeb2579
--- /dev/null
+++ b/tools/nfs-readahead-udev/syslog.c
@@ -0,0 +1,47 @@
+#include <syslog.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "log.h"
+
+#define MSG_SIZE (1024 * sizeof(char))
+
+void log_open(void)
+{
+	openlog("nfs_readahead", LOG_CONS | LOG_PID | LOG_NDELAY, LOG_LOCAL1);
+	setlogmask(LOG_UPTO(LOG_DEBUG));
+}
+
+void log_close(void)
+{
+	closelog();
+}
+
+static void vlog(int level, const char *fmt, va_list *args)
+{
+	char *msg = malloc(MSG_SIZE);
+	if (!msg)
+		return;
+
+	vsnprintf(msg, MSG_SIZE, fmt, *args);
+	syslog(level, "%s", msg);
+
+	free(msg);
+}
+
+#define GENERATE_LOGGER(name, level)		\
+	void name(const char *fmt, ...) {	\
+	va_list args;				\
+	va_start(args, fmt);			\
+	vlog(LOG_##level, fmt, &args);		\
+	va_end(args);				\
+}
+
+GENERATE_LOGGER(debug, DEBUG);
+GENERATE_LOGGER(info, INFO);
+GENERATE_LOGGER(notice, NOTICE);
+GENERATE_LOGGER(warn, WARNING);
+GENERATE_LOGGER(err, ERR);
+GENERATE_LOGGER(crit, CRIT);
+GENERATE_LOGGER(alert, ALERT);
+GENERATE_LOGGER(emerg, EMERG);
-- 
2.35.1


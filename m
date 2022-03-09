Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2A04D38C7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiCIS2a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiCIS23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:29 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A330F4F
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:29 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso2375037otp.4
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROjYm8CHtJGrhQ+3dI8nO/McT7Gr9+8gLzauzM5HDqs=;
        b=dwkT8QGCCpHXnzOAFex54+VdX2U80W44fP09CXZHL23Ugwu6YZKuJ0fwOP+9Wgsjaq
         SJRtsx1QsamVGGAhh5+ky1WrL5Z7TwbuylVMCczU5iZeXxtkXoHhh+WIyAljF+LfTDK2
         73SCvNNEN5nd03ygf+wAH3eYhILYOdckcmouhBl+zBzB1acLUbdecVwoYhoUJp2Yq9+h
         e602XSHkHciKpteZlpgxmGY95TBZ2tRBMqJRcnpjE+pd4uX5oWPSnIL01OUtGQlL7WZJ
         i9ZqmrRZEmsErYtPlLuF0r/5jXu6b+NjXtTPERna98i8xFV7p+5cFVGDQpebCXJ8jISt
         /Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROjYm8CHtJGrhQ+3dI8nO/McT7Gr9+8gLzauzM5HDqs=;
        b=by9vEdb5PUAJ+Je6qccxsFc58j4PB02SYW++kuKOl5uYo0ZVifm2nQVFTMjU3XWa4N
         +NKW22gurkjTSeUHQHFoYEtD52KvubvlCERNO0KdFXbU34AWnCmVNf9OraKAd/LzTZFY
         WF/pqfMpxwduOOeMxY8KNaCqFHELI7P5qRTiXTRtLgxxJ8Y3dFU1KuZO544QJyq0FtSI
         RWuYMUHsAu9DD9gZGRd85aFx0BAPO2lgknhXtS7UmY//Zgp/9UQPslS87Hu8AhB8uo1C
         Eh5rHTzuk+l9Jb+0JAQk98LLiqc48FRsXoXIHgHUW7PHfGsc0KNaD74vzP5hlzHbT4Fh
         +Q3A==
X-Gm-Message-State: AOAM532kdErc+WmzjJqY8Fw78I8AJPjBv4Jh2Y8xf4jUYzL2qugP2ysX
        YH3coPXwcin14O5sXPr+ClEOnI1s8aA=
X-Google-Smtp-Source: ABdhPJzDUmRuma3QynD7Bi+QQ+gGRkexbMuRLek/6GAh8fBxYJdj2mkNAdMCfho8INa1AMeATsKHEA==
X-Received: by 2002:a05:6830:13d8:b0:5af:6e79:560c with SMTP id e24-20020a05683013d800b005af6e79560cmr575142otq.188.1646850448840;
        Wed, 09 Mar 2022 10:27:28 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:28 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 3/7] readahead: create logging facility
Date:   Wed,  9 Mar 2022 15:26:49 -0300
Message-Id: <20220309182653.1885252-4-trbecker@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309182653.1885252-1-trbecker@gmail.com>
References: <20220309182653.1885252-1-trbecker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Create logs for nfs-readahead-udev, logging to syslog.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
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


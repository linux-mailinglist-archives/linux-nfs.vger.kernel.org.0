Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB143E869
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 20:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJ1SiA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhJ1Sh6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 14:37:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35059C061570
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:31 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bj31so6809797qkb.2
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0p3tzqQxt2fr7aUhoLp6NI6pwaVwRH7jkeCkX9uX9DA=;
        b=WQsJM2ka8QEdRyKJYgz+p3ymmycPTo+oAFCOqpYeXP7oNskIYh3/8TptkMM8EGd4B7
         HbbF9GwjHZ3GYNlVwCmnxSbKkwRpWQi+BFIKpq5xtJtfxnFz4c+EBJO946GLJHgRZouV
         XfYQMIFLb3G4wTtwW9vlLfRPTM7AGre4xvxpExxoqDSV4N1Z+cx60qEFEp2I1jIfxzgC
         Y67slyJ/Xh33gYYMPBRNo0P9WlOxRZeqOWiiC4QquaDt3hpxhoZmVUkYjNWmQlSu0L0G
         KbLNcBgE0I9ay/N1mdpqWJspB/e6UgvL/y6QY8Iwan7UV39MwDSKGXY8unomAT4u7q0W
         wWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0p3tzqQxt2fr7aUhoLp6NI6pwaVwRH7jkeCkX9uX9DA=;
        b=xwbVNPSsBodLPpLfDGUJ2zvh0bqhXOo9elZ9iiL0eY/kSgyZDJZvB8xgx9uFLOHfQv
         9Zc6ZUrkSiTdpwUTt9ogWbvkX4qiJHB7Zr1dy23CK4jle7GMZzwSe/5x1c/T48dVSTS9
         B6YWwaq+iW921ll0mpX1pbN84Hr0wlamrmdWJewEPItx5e6FcLwplwJheB6/W9pH+kFt
         AiUdTgkw5dESgeo4cL0PTxDxPOOKjNm9wxbAcZNLaOvH3ZbrZKlPj2yqwCY1F9inl0V3
         eZYPHTmG9RQZ0YGB2et3EuenrfDa5n1t99OXdoEg6aJdJSPp59W7jgV3B0KViHcd4w8v
         UQpQ==
X-Gm-Message-State: AOAM533koLGf/JyHRyiDQxK3nWYwAdoQB+uX8eHq2T/4x6ksSNeCQHYy
        1HGOLA7VM++nw7sES1tjgTZ7UCMI9BA=
X-Google-Smtp-Source: ABdhPJzmX0+b0m8uRSk5og2LSBqROp3IhBGfxN4YYeIs0yjrWjbvvqPM23eqFZPZ7+29LC1qWU95DQ==
X-Received: by 2002:a05:620a:bc1:: with SMTP id s1mr5187073qki.49.1635446129852;
        Thu, 28 Oct 2021 11:35:29 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id q13sm2556476qkl.7.2021.10.28.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:29 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 9/9] rpcctl: Add installation to the Makefile
Date:   Thu, 28 Oct 2021 14:35:19 -0400
Message-Id: <20211028183519.160772-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
References: <20211028183519.160772-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

And create a shell script that launches the python program from the
$(libdir)

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 configure.ac             |  1 +
 tools/Makefile.am        |  2 +-
 tools/rpcctl/Makefile.am | 20 ++++++++++++++++++++
 tools/rpcctl/rpcctl      |  5 +++++
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tools/rpcctl/Makefile.am
 create mode 100644 tools/rpcctl/rpcctl

diff --git a/configure.ac b/configure.ac
index 93626d62be40..dcd3be0c8a8b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -737,6 +737,7 @@ AC_CONFIG_FILES([
 	tools/rpcgen/Makefile
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
+	tools/rpcctl/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
 	tools/nfsdclddb/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 9b4b0803db39..c3feabbec681 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts $(OPTDIRS)
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/rpcctl/Makefile.am b/tools/rpcctl/Makefile.am
new file mode 100644
index 000000000000..f4237dbc89e5
--- /dev/null
+++ b/tools/rpcctl/Makefile.am
@@ -0,0 +1,20 @@
+## Process this file with automake to produce Makefile.in
+PYTHON_FILES =  rpcctl.py client.py switch.py sysfs.py xprt.py
+tooldir = $(DESTDIR)$(libdir)/rpcctl
+
+man8_MANS = rpcctl.man
+
+all-local: $(PYTHON_FILES)
+
+install-data-hook:
+	mkdir -p $(tooldir)
+	for f in $(PYTHON_FILES) ; do \
+		$(INSTALL) -m 644 $$f $(tooldir)/$$f ; \
+	done
+	chmod +x $(tooldir)/rpcctl.py
+	$(INSTALL) -m 755 rpcctl $(DESTDIR)$(sbindir)/rpcctl
+	sed -i "s|LIBDIR=.|LIBDIR=$(tooldir)|" $(DESTDIR)$(sbindir)/rpcctl
+
+
+
+MAINTAINERCLEANFILES=Makefile.in
diff --git a/tools/rpcctl/rpcctl b/tools/rpcctl/rpcctl
new file mode 100644
index 000000000000..4cc35e1ea3f9
--- /dev/null
+++ b/tools/rpcctl/rpcctl
@@ -0,0 +1,5 @@
+#!/bin/bash
+LIBDIR=.
+PYTHON3=/usr/bin/python
+
+exec $PYTHON3 $LIBDIR/rpcctl.py $*
-- 
2.33.1


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4842B3E3042
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 22:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbhHFUSI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbhHFUSH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 16:18:07 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF0C0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Aug 2021 13:17:50 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t68so11232458qkf.8
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFBJIiIFqOp4+YJS9R9V1hb6TIWJoltGU8MdMLrg43k=;
        b=W/hani07GpkVw6+trp2AE4F9DbYfxlnh9rldwvBjNLUPTGt2qz39CibiYf5AtGuRuP
         As5FkZB/fNzdr0ncyfIV2OpZW8xuThauIz7Bny7RFCYtkhk1HEyWVlISluTn1M7QbxQ2
         exI02o4vmW0ULkdpQhmHL/EgksMju/Ed66BwHjrcwrpu5gxM04glTFGuqWW84g4rdsxa
         sKDqFjDv/MttCF2ahPWB9WxjmTUcpNb8InTJO2uZD1ncDlrHXWEem3+dEB3pdcPyT4X1
         0nAPOvwlsv/f2vNsaCrEIqC4M902ay1/QKEr4GLSv6xZeFx/oQoQeIGtr55S9l+fUtWt
         gfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zFBJIiIFqOp4+YJS9R9V1hb6TIWJoltGU8MdMLrg43k=;
        b=TRGg+kmgiPAOhPfk3cv1XCPaXVg/2gbVs4krmbN6AnjYevZ28aRrvOzoYs0ileLkdl
         CfXa/hrErMWNp/nsNyGQ0Nu4ltS8fK7aXGF8hDlQyIxVGy5QDI8dZU1WyUud1Ef3pyrq
         UX/3ojO1t8067dDQdotrGss0S7GO9yFyiIsjKDlhIKeR153QhiHrQ4yFEak8CG6XaS1T
         kA4dcB25FEwZz4HZCDRirXb+L21rSeU206DSuOzaWeD67DVJoID+kEWPwqj/sFHewUV3
         Ier7gu8VuuP9WV0YYVlzPAnK2JtWK3dOeyp+HV188Z4yzMR7OmmUryrkKnq0xtLAImO+
         pA0A==
X-Gm-Message-State: AOAM531m3FonsT14l9TIis4PL9LSnaa0s3d4jI2YXntXKz3coVjag2/N
        1pcx2rgmh552X0QqdczOkTE=
X-Google-Smtp-Source: ABdhPJwrJUb1Rj6B8LBdbeVrf+ft+c+TMfOfjj6QAlejERaqCJkUObYcZsNhZKtX0IMgKLklKKNgjw==
X-Received: by 2002:a05:620a:127b:: with SMTP id b27mr11977279qkl.122.1628281070085;
        Fri, 06 Aug 2021 13:17:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g11sm3705720qtk.91.2021.08.06.13.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:17:49 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 9/9] nfs-sysfs: Add installation to the Makefile
Date:   Fri,  6 Aug 2021 16:17:39 -0400
Message-Id: <20210806201739.472806-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com>
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
 configure.ac                |  1 +
 tools/Makefile.am           |  2 +-
 tools/nfs-sysfs/Makefile.am | 20 ++++++++++++++++++++
 tools/nfs-sysfs/nfs-sysfs   |  5 +++++
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfs-sysfs/Makefile.am
 create mode 100644 tools/nfs-sysfs/nfs-sysfs

diff --git a/configure.ac b/configure.ac
index bc2d0f02979c..092e230551f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -731,6 +731,7 @@ AC_CONFIG_FILES([
 	tools/rpcgen/Makefile
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
+	tools/nfs-sysfs/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
 	tools/nfsdclddb/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index 9b4b0803db39..1c89d66be744 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts $(OPTDIRS)
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfs-sysfs nfsdclnts $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/nfs-sysfs/Makefile.am b/tools/nfs-sysfs/Makefile.am
new file mode 100644
index 000000000000..bdfc7454a7a1
--- /dev/null
+++ b/tools/nfs-sysfs/Makefile.am
@@ -0,0 +1,20 @@
+## Process this file with automake to produce Makefile.in
+PYTHON_FILES =  nfs-sysfs.py client.py switch.py sysfs.py xprt.py
+tooldir = $(DESTDIR)$(libdir)/nfs-sysfs
+
+man8_MANS = nfs-sysfs.man
+
+all-local: $(PYTHON_FILES)
+
+install-data-hook:
+	mkdir -p $(tooldir)
+	for f in $(PYTHON_FILES) ; do \
+		$(INSTALL) -m 644 $$f $(tooldir)/$$f ; \
+	done
+	chmod +x $(tooldir)/nfs-sysfs.py
+	$(INSTALL) -m 755 nfs-sysfs $(DESTDIR)$(sbindir)/nfs-sysfs
+	sed -i "s|LIBDIR=.|LIBDIR=$(tooldir)|" $(DESTDIR)$(sbindir)/nfs-sysfs
+
+
+
+MAINTAINERCLEANFILES=Makefile.in
diff --git a/tools/nfs-sysfs/nfs-sysfs b/tools/nfs-sysfs/nfs-sysfs
new file mode 100644
index 000000000000..f7ce621eff57
--- /dev/null
+++ b/tools/nfs-sysfs/nfs-sysfs
@@ -0,0 +1,5 @@
+#!/bin/bash
+LIBDIR=.
+PYTHON3=/usr/bin/python
+
+exec $PYTHON3 $LIBDIR/nfs-sysfs.py $*
-- 
2.32.0


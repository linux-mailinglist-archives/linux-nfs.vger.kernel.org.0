Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB291307D3
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2020 13:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgAEMFL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Jan 2020 07:05:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33197 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgAEMFL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Jan 2020 07:05:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so10034412wmd.0
        for <linux-nfs@vger.kernel.org>; Sun, 05 Jan 2020 04:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0G0iJzkJ8klxZWaS6ghVK3mXCjkNs1onCrHWJCiz9E8=;
        b=vR/zfCDOLRGMEk85zdnH8v6QmpKrkg1Qfh0r2goeuj91IiWRSnyXn2rvI6OhpwEgh7
         DM+MoQBWKw3kxUKwrwparBQwhUJBp+E/OCKMCpy3cq2v0+foIEMVDMPAm6U9gEYWIdxM
         XjY7bDa31Btb3jdEuCyq4RJNhtMdNFXx0tG1tuDkRvfXLv00D0BZWA1WasnSLGwN/yXv
         5oFH45TWh4FyIteAyEJUkNM80Bf4O+XEz9w4aCBF3jO9oJ3//1+oowZ2qzQhK2G+gwDm
         1RxVc/M+PjbvpUNT+MQEAs+YxCoL08SZlL7Q0qpRmv3VwbxemvEy7oLNUK5JPSWRhc7x
         06iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0G0iJzkJ8klxZWaS6ghVK3mXCjkNs1onCrHWJCiz9E8=;
        b=gcxBLuMckTJIb+vc8XamYniAOGuB2eUlGCBVDoZpIRCNQ5J9ERo9fgyEyk5b99jHaQ
         SeHEj/N2CgfHZjVECEet/qdRRZfcYVGqJkJLjqx/EnMUTpkcrdetecsxmCJNYAKkWmSb
         rUDVCccAMgi2huW9+vGpoJmFTyCQEfghLyNgMbGzwB7kSZz848TFXRqIW5zLkvuZ7UUn
         So7+gtWj0vyzxtWA8i88m7vhbFsuh6qqzUeRSHtyDjgSh8IaFEx2usmZbGovNkUhFXyt
         sXIjxR6BoXb+Z43iBryRhDQNMz7EjQhBCUxWX8BRQVhcmZ1wLPRIxF+uEkM1Noeo3sPY
         8U6w==
X-Gm-Message-State: APjAAAVk9uA8YUuwzggIYdj/7FLMU+MueXqj5YAQFLPStPkINPyxzJDM
        n84KW0GpUM00usptq1iiQAp1K4+b
X-Google-Smtp-Source: APXvYqxpbb5lw/JVyr0CMSxExN70j03wp7PtGExLiQLduttugFgId0PXWitcm7a/orewtXzrQnYJPw==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr29449897wmm.24.1578225909829;
        Sun, 05 Jan 2020 04:05:09 -0800 (PST)
Received: from localhost.localdomain ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id p18sm19173731wmg.4.2020.01.05.04.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 04:05:09 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Mike Frysinger <vapier@gentoo.org>,
        Steve Dickson <steved@redhat.com>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [nfs-utils RESENT PATCH 1/1] locktes/rpcgen: tweak how we override compiler settings
Date:   Sun,  5 Jan 2020 13:05:02 +0100
Message-Id: <20200105120502.765426-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Mike Frysinger <vapier@gentoo.org>

Newer autotools will use both CFLAGS and <target>_CFLAGS when compiling
the <target>.  Adding the build settings to the target-specific flags no
longer works as a way to compile build-time tools.

Instead, clobber the global flags.  This triggers an automake warning,
but the end result actually works (unlike the existing code).

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi Steve,

this patch was sent by Mike in 2013 [1]. You had some objections about
warnings it causes [2]. Although I understand it, I'd like it was merged,
because it's needed (taken by distros: gentoo [3], buildroot [4]) and
IMHO it cannot be implemented other way.

Also not sure, what should be changed in automake to avoid this tweek
(I might ask upstream).

Kind regards,
Petr

[1] https://marc.info/?l=linux-nfs&m=136416341629788&w=2
[2] https://marc.info/?l=linux-nfs&m=136423027217638&w=2
[3] https://gitweb.gentoo.org/repo/gentoo.git/tree/net-fs/nfs-utils/files/nfs-utils-1.2.8-cross-build.patch
[4] https://git.busybox.net/buildroot/tree/package/nfs-utils/0001-Patch-taken-from-Gentoo.patch

 tools/locktest/Makefile.am | 7 +++----
 tools/rpcgen/Makefile.am   | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
index 3156815d..efe6fcdb 100644
--- a/tools/locktest/Makefile.am
+++ b/tools/locktest/Makefile.am
@@ -1,12 +1,11 @@
 ## Process this file with automake to produce Makefile.in
 
 CC=$(CC_FOR_BUILD)
-LIBTOOL = @LIBTOOL@ --tag=CC
+CFLAGS=$(CFLAGS_FOR_BUILD)
+CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
+LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 noinst_PROGRAMS = testlk
 testlk_SOURCES = testlk.c
-testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
-testlk_CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
-testlk_LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/rpcgen/Makefile.am b/tools/rpcgen/Makefile.am
index 8a9ec89c..3adeec15 100644
--- a/tools/rpcgen/Makefile.am
+++ b/tools/rpcgen/Makefile.am
@@ -1,7 +1,9 @@
 ## Process this file with automake to produce Makefile.in
 
 CC=$(CC_FOR_BUILD)
-LIBTOOL = @LIBTOOL@ --tag=CC
+CFLAGS=$(CFLAGS_FOR_BUILD)
+CPPFLAGS=$(CPPFLAGS_FOR_BUILD)
+LDFLAGS=$(LDFLAGS_FOR_BUILD)
 
 noinst_PROGRAMS = rpcgen
 rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
@@ -9,9 +11,6 @@ rpcgen_SOURCES = rpc_clntout.c rpc_cout.c rpc_hout.c rpc_main.c \
 		 rpc_util.c rpc_sample.c rpc_output.h rpc_parse.h \
 		 rpc_scan.h rpc_util.h
 
-rpcgen_CFLAGS=$(CFLAGS_FOR_BUILD)
-rpcgen_CPPLAGS=$(CPPFLAGS_FOR_BUILD)
-rpcgen_LDFLAGS=$(LDFLAGS_FOR_BUILD)
 rpcgen_LDADD=$(LIBTIRPC)
 
 MAINTAINERCLEANFILES = Makefile.in
-- 
2.24.0


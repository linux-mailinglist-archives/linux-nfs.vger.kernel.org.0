Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8351B4D38CA
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiCIS2Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCIS2Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:25 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D0957B04
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:24 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so3902504ooh.8
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5MME4KpDziBTxxufAkFOBkSULAPSK1XcRbM0uCC95g=;
        b=YotN5tXzf+jVHlwTTFLgl4/WKT7Tjqi4XomzYukiJCuoNGzUj5kRRuvUuy5Vgfzbih
         aH7MCaKY/F+FnErit2c5ZatzQpkttv3E0fIMRS1fPx7fCzHJELSlkmF1/g9ldxe3yIxH
         f51J6R6ZKYnT8rt8O0YX6ftylWRRugqi5eFc+tIIb1cdj/AbooyHisuCDeIfnV8kolCl
         gaRz5ZmABCAukWl+M6d0tw07yDLP23edcLvQinlpTIJ2G/DoIiAwLEPCTv+qki7MnHyP
         sK5APbQLxXKb4n4MR4Yt9XF5NUKVWmghgMOC4Udt28cuU9E0lwMyFeMrILJKzgI8yofG
         Av8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5MME4KpDziBTxxufAkFOBkSULAPSK1XcRbM0uCC95g=;
        b=Nx6ub7saXR+ziMLM4ZZoH+ZRBhbU+UbVdRNjMXnNpcPuYPnde/97pdTFntw9wn4K38
         NfbfKbVTuIuUMDsu2NkT4HfDw/6Hv65r3rwJeGzYmGaTw1YHWJ9XByDAVA0D3hhwPrxW
         ZDUNtTCMwK0zawMuficTyFQDkkpyo6i/HX2mG2D074nuujFFx/3gWQlGAOAE7Er5w2FH
         1GAjExwboM0MYKNqf69Gb3MkhzVhJgqq6oU16UMyqsoIOy2akzSZIIhVL3H2NcRCX6jd
         2j3pS9HRn/aLz1qzSiGw2dab5YyDwdceguxbBcJt8c8rV7A3hwHwV1e8hYmF6N+O6jML
         r1jg==
X-Gm-Message-State: AOAM531KkFKJ5Z7ysvLDua2dWuQMA4Q7aUFE0qi6g7IIxDf3fVD3MZi0
        I1NClqApxMRzQregXUm6brRDdbQwt+g=
X-Google-Smtp-Source: ABdhPJwe6nP6aHS68JrKGp6EsVn5+ayJrzyEIYMuMWWO2Xq8s9nYaFcQFho3gelqsl2a1HC8bUBXlw==
X-Received: by 2002:a4a:141:0:b0:31d:8eb3:b2c0 with SMTP id 62-20020a4a0141000000b0031d8eb3b2c0mr495461oor.4.1646850443920;
        Wed, 09 Mar 2022 10:27:23 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:23 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 1/7] Create nfs-readahead-udev
Date:   Wed,  9 Mar 2022 15:26:47 -0300
Message-Id: <20220309182653.1885252-2-trbecker@gmail.com>
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

This tool is invoked by udev to find and set the readahead value to NFS
mounts.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 .gitignore                           | 1 +
 configure.ac                         | 1 +
 tools/Makefile.am                    | 2 +-
 tools/nfs-readahead-udev/Makefile.am | 3 +++
 tools/nfs-readahead-udev/main.c      | 7 +++++++
 5 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/nfs-readahead-udev/Makefile.am
 create mode 100644 tools/nfs-readahead-udev/main.c

diff --git a/.gitignore b/.gitignore
index c89d1cd2..c99269a4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,6 +61,7 @@ utils/statd/statd
 tools/locktest/testlk
 tools/getiversion/getiversion
 tools/nfsconf/nfsconf
+tools/nfs-readahead-udev/nfs-readahead-udev
 support/export/mount.h
 support/export/mount_clnt.c
 support/export/mount_xdr.c
diff --git a/configure.ac b/configure.ac
index e0f5a930..7e5ba5d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -737,6 +737,7 @@ AC_CONFIG_FILES([
 	tools/rpcgen/Makefile
 	tools/mountstats/Makefile
 	tools/nfs-iostat/Makefile
+	tools/nfs-readahead-udev/Makefile
 	tools/rpcctl/Makefile
 	tools/nfsdclnts/Makefile
 	tools/nfsconf/Makefile
diff --git a/tools/Makefile.am b/tools/Makefile.am
index c3feabbe..621cde03 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
 OPTDIRS += nfsdclddb
 endif
 
-SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts $(OPTDIRS)
+SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat rpcctl nfsdclnts nfs-readahead-udev $(OPTDIRS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
new file mode 100644
index 00000000..5455e954
--- /dev/null
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -0,0 +1,3 @@
+libexec_PROGRAMS = nfs-readahead-udev
+nfs_readahead_udev_SOURCES = main.c
+
diff --git a/tools/nfs-readahead-udev/main.c b/tools/nfs-readahead-udev/main.c
new file mode 100644
index 00000000..e454108e
--- /dev/null
+++ b/tools/nfs-readahead-udev/main.c
@@ -0,0 +1,7 @@
+#include <stdio.h>
+
+int main(int argc, char **argv, char **envp)
+{
+	unsigned int readahead = 128;
+	printf("%d\n", readahead);
+}
-- 
2.35.1


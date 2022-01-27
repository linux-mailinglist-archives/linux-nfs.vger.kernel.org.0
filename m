Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02F49EB59
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245709AbiA0TuB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 14:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbiA0TuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 14:50:01 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D384C06173B
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:50:01 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id g12so3394912qto.13
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jan 2022 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6WLT/XpN/uII4dNmxdDBi+IqyZ9s4x0Pp0CrgatD9A=;
        b=l1SGTFJxwYaZSdmrjdsiy4Vtmf72xgyo7EznJt0H8dV/tUR2nuD04M9wce60hGu4oM
         9ZbYBQdgn8OiDgcN1nQSupJ+OnLFrHhLoYYUthtaITHvZV6uY1q+YrzhYI9KOHHkaUhX
         ikv1dfHUNBQZiUPYqMW5EZmXRJuinaXM/db/HmtfXnLv9h0S0wEjzzxhaB6e9Tjo0xRK
         v98wmBCAEiRlb62Ykpxh+is8u4PTQLQ9SeXKAkGtMsE9/P34fA/hWcMUHWcza/VpEV1T
         oWV6kk/XGylICXP3vQMfV+hkTFFYPe82rdjrcG0OV5ub0c75kL/5IL4eB2vBVUXNxA6S
         YpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=T6WLT/XpN/uII4dNmxdDBi+IqyZ9s4x0Pp0CrgatD9A=;
        b=7mfQ0PWFh2n62dENDD8eLibQ+7NsX4GmAvPEi8xdymOdb4nJnDVnbSRVxup/STedfo
         XXrcDWBB8LEiHzDZDDG1ivTgDmD6AwtLxzhzEcUM252N6vuqBqSRPP5GP8Zp59Q3yaqF
         gWXw/j9coJKMLLxVpXWtYm17OmHBXrxB5N1S1/O2aBLgBuSJgm4lYsdOUpmWYoL23lTc
         3Kj3oYIi2tUttQrZW0AGKSeBs70pNo8qOatNmG7x/EuFJVgRvyQr7jdb0e40Fz8TnQX9
         yXzGAUWSapEtSLXjUu1mBlxyEE9fAf1RmHQnKee6JPPRp5+E36iOPF3uUUTE1N0Gv2U0
         nA8w==
X-Gm-Message-State: AOAM532uM3UQbTrSgiL23HfjeT497LqDJ3dU08s/rKAa+g/caA1STNHE
        adZpGCBUib/q9PeTE+MrQyU=
X-Google-Smtp-Source: ABdhPJz7Bv1zOZq93sj1dHb6bpdpdifu1cJa8e2cqNO+xSxTGuT7vaqNnkkKNilEScA2/ia1zxb01g==
X-Received: by 2002:a05:622a:1a90:: with SMTP id s16mr4009729qtc.586.1643313000295;
        Thu, 27 Jan 2022 11:50:00 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id g7sm1836483qkc.104.2022.01.27.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:49:59 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v7 9/9] rpcctl: Add installation to the Makefile
Date:   Thu, 27 Jan 2022 14:49:52 -0500
Message-Id: <20220127194952.63033-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
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
 tools/rpcctl/Makefile.am | 13 +++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 tools/rpcctl/Makefile.am

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
index 000000000000..33fb431fe7d4
--- /dev/null
+++ b/tools/rpcctl/Makefile.am
@@ -0,0 +1,13 @@
+## Process this file with automake to produce Makefile.in
+PYTHON_FILES =  rpcctl.py
+
+man8_MANS = rpcctl.man
+
+EXTRA_DIST = $(man8_MANS) $(PYTHON_FILES)
+
+all-local: $(PYTHON_FILES)
+
+install-data-hook:
+	$(INSTALL) -m 755 rpcctl.py $(DESTDIR)$(sbindir)/rpcctl
+
+MAINTAINERCLEANFILES=Makefile.in
-- 
2.35.0


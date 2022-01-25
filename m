Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC149BBD1
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiAYTJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiAYTJ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:09:56 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE2C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:56 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id s6so19083342qvv.11
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZQBiAFLbs2VhJ1f3T2tO0THO1pm036aexkSZmTc8zE=;
        b=mRixsWEtbcn13onoKBaGFPQZdl0WWFEO/Y3MZcXbaxhGswKqriN9CpjiJvUlVxt8BW
         HfYRncRf7vWOv2M9MsIGdPP3Ey7RnOwimmLgYXwR93YRXXMLmG/acinRoGm8TAT4pH4r
         fU4Tt052N/KsnkephGdgJ44dhtOrWbLTec1GNiUWn0mDbDuaQMUrows/RlzFm6ZgNscr
         54ZBCBkUT69TaFQjnP3YP37k4zjRwuHd4kI7W9pXJLItX1QJBnsy5r3nTJVPWERfaD2o
         Loa/7yu/c7b+hNeHPBBFnr653hfRc4sgTONTgW5iksqOA6Y05nlyl6zAxPz0/QLLtRPV
         /igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pZQBiAFLbs2VhJ1f3T2tO0THO1pm036aexkSZmTc8zE=;
        b=K8rfitw65s6hbxvAuEFPQoqRU6L6ryMjteVe5gKZg6tY+qLwwBWKdGeSSFSOaJYFB0
         cQYydjLH98ddve8KCGIAaHosdbzhCt5XWH3TUapXZrXdWfOkhnE3M7mLnSBRlJpx4DU+
         BgpsT2hz9uyyRKoYttSUthLGFwyGGICkOnS2GMi/S8bXS9GYV5QCKQDsyA9Rwh0hQXyH
         nM5I/u54iHtihumtNC9aotDiNUb86VQqaNdinbQQSlq9dRh6uE6irSZKwnIaiWV6SfPb
         uEgpHbUhbzwmas1fW77MdUR0N1p8NHx3WQFeDMJSWIC1y0lGQbh0C+gbtifLAhdv0u2k
         NH1A==
X-Gm-Message-State: AOAM530ZNLsAgodKhHggl/Uxxie4KXttjCrEhSx0+Dv5F2nYTisYTJuu
        wotxlk4xvCrwdhM3R8Mn/KY=
X-Google-Smtp-Source: ABdhPJwZA2EuxS7R8WtwE51iDm3buSmRIif63R3OefMrbmvHXJSLsuu7HDDdmI8Vr+3QU+S2amhvuA==
X-Received: by 2002:a05:6214:1c8a:: with SMTP id ib10mr21050967qvb.12.1643137795625;
        Tue, 25 Jan 2022 11:09:55 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id n6sm34802qtx.23.2022.01.25.11.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:09:55 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v6 9/9] rpcctl: Add installation to the Makefile
Date:   Tue, 25 Jan 2022 14:09:46 -0500
Message-Id: <20220125190946.23586-10-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
References: <20220125190946.23586-1-Anna.Schumaker@Netapp.com>
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
v6: Fix up the Makefile to account for this being a single file tool now
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
2.34.1


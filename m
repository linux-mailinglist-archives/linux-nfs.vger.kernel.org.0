Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056FF1075D3
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 17:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVQcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 11:32:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVQcE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 11:32:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so9354835wru.3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Nov 2019 08:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYwzWI076JpHxEwQLjtnvsbQv7Zpoy0jge73W/ddfJg=;
        b=W/dvwFHdUB4fXeiVXom5qt3j7It8Qt45Jx57B6Kq00oG3N/HJY3pV/kJU3S8NToB+o
         EQMWNQNPFRQl/VrwAdqSZlLRt5QqUuU+zHP1j6u2n8qwbFwfDnssbz+HceTBPy0MrvMt
         415/F4Sk82AahJJIqnVsjuLLz4NvOg3pwhaq9b//xKYq1jF8R5gIBSe/O1xPJ57rjV7T
         7/rniVQmu3aEvqE7R8GJyL0YKGyjXBiGjk4euZMpGwYmEjVqzAsx6hEhTSoiOlHcIktV
         SupG4niaMTmlZFsxu/HtLKQHLrDAsSahDiYqrP/dZ/VZJ4HI1fMS6sa1JAXRDW160g7A
         5RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYwzWI076JpHxEwQLjtnvsbQv7Zpoy0jge73W/ddfJg=;
        b=JvZdlM6q6jmB4oBiloFJ+INyUAiImC50XppNO+mdEwSHzsIAVaEwTCa1bu++dNDqsN
         7ByZroCXFS/bby0KwDqwJiuHX6tkBauiMl1o2K10AXCfCUtfvPjZREQuB6wE8I4+aFNf
         ftT6cSq+tFAGPrFuVDHAV5oh8m+Rr8RqgxKiBAqifdnoaGzfAr8+2aCzTJrUrDpq9QJe
         rCP5+pNYZ8cz5iM12+8hI8idrlZ6Q+cSe95t/E2Vn4IZByrNLdfe55ewMhN99MRpQiLx
         ftSeStZS/7zCakoKV9vtWUh16JjCJWdiRAlQmY7qOUjM8liTbPX8SD5NxRWUSdjWsA7m
         Dy4Q==
X-Gm-Message-State: APjAAAV1QKrj3rK8IzsEfhHU/bv/vU935+N5Xnpqr3iqd2kB5mZOTLgM
        z7nN1WsGV5GcWsUGXTYZEoEyZNxq
X-Google-Smtp-Source: APXvYqwDNRG2pA10oH+CPrxWBW/xFqsvOP6EUjONkQnnMhBgLFGFKImX23Wz20S0URnwtuwbrHm3Cw==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr18501192wre.11.1574440322266;
        Fri, 22 Nov 2019 08:32:02 -0800 (PST)
Received: from dell5510.arch.suse.de ([178.21.189.11])
        by smtp.gmail.com with ESMTPSA id a8sm3904080wme.11.2019.11.22.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:32:00 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Frederik Pasch <fpasch@googlemail.com>,
        Steve Dickson <steved@redhat.com>,
        Gustavo Zacarias <gustavo@zacarias.com.ar>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [nfs-utils PATCH 1/1] Switch legacy index() in favour of strchr()
Date:   Fri, 22 Nov 2019 17:31:55 +0100
Message-Id: <20191122163155.6971-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Frederik Pasch <fpasch@googlemail.com>

[ gustavo: rebased to 1.2.6 ]
Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
[ pvorel: taken from Buildroot distribution, rebased ]
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Signed-off-by: Frederik Pasch <fpasch@googlemail.com>
---
 support/nfs/nfs_mntent.c | 6 +++---
 utils/mount/error.c      | 2 +-
 utils/mountd/fsloc.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/support/nfs/nfs_mntent.c b/support/nfs/nfs_mntent.c
index 05a4c687..25e5944a 100644
--- a/support/nfs/nfs_mntent.c
+++ b/support/nfs/nfs_mntent.c
@@ -9,7 +9,7 @@
  */
 
 #include <stdio.h>
-#include <string.h>		/* for index */
+#include <string.h>		/* for strchr */
 #include <ctype.h>		/* for isdigit */
 #include <sys/stat.h>		/* for umask */
 #include <unistd.h>		/* for ftruncate */
@@ -176,7 +176,7 @@ nfs_getmntent (mntFILE *mfp) {
 			return NULL;
 
 		mfp->mntent_lineno++;
-		s = index (buf, '\n');
+		s = strchr (buf, '\n');
 		if (s == NULL) {
 			/* Missing final newline?  Otherwise extremely */
 			/* long line - assume file was corrupted */
@@ -184,7 +184,7 @@ nfs_getmntent (mntFILE *mfp) {
 				fprintf(stderr, _("[mntent]: warning: no final "
 					"newline at the end of %s\n"),
 					mfp->mntent_file);
-				s = index (buf, 0);
+				s = strchr (buf, 0);
 			} else {
 				mfp->mntent_errs = 1;
 				goto err;
diff --git a/utils/mount/error.c b/utils/mount/error.c
index 562f312e..986f0660 100644
--- a/utils/mount/error.c
+++ b/utils/mount/error.c
@@ -62,7 +62,7 @@ static int rpc_strerror(int spos)
 	char *tmp;
 
 	if (estr) {
-		if ((ptr = index(estr, ':')))
+		if ((ptr = strchr(estr, ':')))
 			estr = ++ptr;
 
 		tmp = &errbuf[spos];
diff --git a/utils/mountd/fsloc.c b/utils/mountd/fsloc.c
index cf42944f..1b869b60 100644
--- a/utils/mountd/fsloc.c
+++ b/utils/mountd/fsloc.c
@@ -128,7 +128,7 @@ static struct servers *method_list(char *data)
 	bool v6esc = false;
 
 	xlog(L_NOTICE, "method_list(%s)", data);
-	for (ptr--, listsize=1; ptr; ptr=index(ptr, ':'), listsize++)
+	for (ptr--, listsize=1; ptr; ptr=strchr(ptr, ':'), listsize++)
 		ptr++;
 	list = malloc(listsize * sizeof(char *));
 	copy = strdup(data);
-- 
2.24.0


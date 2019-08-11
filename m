Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C62894A0
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2019 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHKWKx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Aug 2019 18:10:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33592 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKWKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Aug 2019 18:10:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so47040276plo.0
        for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2019 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0HLReDwVapvA2oWE+2Vqxzu1PwSLTB9rNZL5Lm44ko=;
        b=I8jkgSLn4np++EUqIuR97ZBcA98ahLBESvX4z1WoSYRLKGKyUykXZu6jvQhkMocvXr
         VXsD1kLn5id9fOzyCIO8WRHOgj0xOIAMT817sUydFfNzD03aBzUAHNBkRPBjPfdZhmvW
         Kt8ylbVPOc6dib5GqkqL2E7XgetKALXybIwPTXwFh9USwNpSW+OrHZpAyXsL4MLnd8x2
         fwk+IiXe14/+Vqxnb9ajATM3HCakcmnMiPoIwm2XrddAEUVC8FmZwvtxPpRUgGZaGqiZ
         ffn5P2SV0Pj/eVqk0G1YtGYgF4D6T/IG8GZcj8gI3VvLjZg/ruemGvN+EK9Uu4rCl1l6
         u60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0HLReDwVapvA2oWE+2Vqxzu1PwSLTB9rNZL5Lm44ko=;
        b=Pa3QdgvCR5+ooKEmyNu4ILDA89fl1ufKuaidzP8SgsLKpmS/up7Q/3Ocv8BY6oV/KB
         xCLnA+sTBr0RehYMRmFHgWhn9LitaGh4YSTT6RnWIjMu0AU0s9yOyWCdFurSdrwjPTJ1
         0eSd7FcAzVNtHiHmbFJhVpiExDKBcckTazld3yWj9h/CTWoRqXyFAEvIXRGg8YcZ/OGw
         VeJpws2zFSyv90uxMRZbVZN+cganBFUN3jFtp2KX2qVSmgfMWn6T7sr+2sfmIGP2I76o
         ZWNAgCP69qWCrNltXyqw6wBbn+XDzW+FqZBsFDSRW53QN53zuGhkh72jhEsd74ed4B7u
         2B9w==
X-Gm-Message-State: APjAAAXKQgUC8GhsQXG3G6Ez2S8AgVQ6yUX0xM7R28WbT+Umb5zejVJ6
        47/yRVk6QjYnuGZbYkTn6NejGuaX
X-Google-Smtp-Source: APXvYqxP64xlrcSacqfgFfTxeo+eyl+ZKaaVp+p0KSGKFa4YpvfiKi9MBgbCrBoTj0EqwvxZSs3VfQ==
X-Received: by 2002:a17:902:d894:: with SMTP id b20mr24598953plz.134.1565561452493;
        Sun, 11 Aug 2019 15:10:52 -0700 (PDT)
Received: from localhost ([108.161.26.224])
        by smtp.gmail.com with ESMTPSA id l17sm29428357pgj.44.2019.08.11.15.10.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 15:10:51 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Matt Turner <mattst88@gmail.com>
Subject: [PATCH nfs-utils] gssd: Look in lib32 for gss libs aswell.
Date:   Sun, 11 Aug 2019 15:10:44 -0700
Message-Id: <20190811221044.13777-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Akin to commit da999b81b058 ("Look in lib64 for gss libs aswell.")

mips/n32 systems have libraries in lib32 (but not lib or lib64). Without
checking lib32, configure fails with

checking for Kerberos v5... configure: error: Kerberos v5 with GSS
         support not found: consider --disable-gss or --with-krb5=

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 aclocal/kerberos5.m4 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/aclocal/kerberos5.m4 b/aclocal/kerberos5.m4
index 8a0f3e4c..faa58049 100644
--- a/aclocal/kerberos5.m4
+++ b/aclocal/kerberos5.m4
@@ -38,9 +38,11 @@ AC_DEFUN([AC_KERBEROS_V5],[
       AC_DEFINE_UNQUOTED(KRB5_VERSION, $K5VERS, [Define this as the Kerberos version number])
       if test -f $dir/include/gssapi/gssapi_krb5.h -a \
                 \( -f $dir/lib/libgssapi_krb5.a -o \
+                   -f $dir/lib/libgssapi_krb5.so -o \
+                   -f $dir/lib32/libgssapi_krb5.a -o \
+                   -f $dir/lib32/libgssapi_krb5.so -o \
                    -f $dir/lib64/libgssapi_krb5.a -o \
-                   -f $dir/lib64/libgssapi_krb5.so -o \
-                   -f $dir/lib/libgssapi_krb5.so \) ; then
+                   -f $dir/lib64/libgssapi_krb5.so \) ; then
          AC_DEFINE(HAVE_KRB5, 1, [Define this if you have MIT Kerberos libraries])
          KRBDIR="$dir"
          gssapi_lib=gssapi_krb5
-- 
2.21.0


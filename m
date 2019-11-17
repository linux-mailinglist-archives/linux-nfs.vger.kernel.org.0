Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603FFFFB5E
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Nov 2019 19:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfKQSam (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Nov 2019 13:30:42 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52116 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfKQSam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Nov 2019 13:30:42 -0500
Received: by mail-wm1-f54.google.com with SMTP id q70so15024001wme.1
        for <linux-nfs@vger.kernel.org>; Sun, 17 Nov 2019 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AI5PjNNVo+nWuGHXuUR9Z81f2NSybgwLdP4c6Dg9K18=;
        b=jYUjBUmFq8f+DhhSBI8/YYMIxqMJ3DMsR1aNf2ayL4doKJVDgLNU7qL4hRU3vbGe4G
         sA+TCHhxuPpL4Ws0Zxo8++tN73m3wBvHHYHPeKScpaKNkOSQrxfiU+lopV2SkSQK5gwX
         n5LrpJGr9yo/1A1N4yHzHZb+uCg6N79pgmNGJs6/jSEUGbxSDve9TyQttT+xwXJtfm9B
         ugn1W0HaPMwH884H3XmfZ8eGvLj/DpOB4dan8zQ2h4nmdUA+8PQGD4quiyyFebGJI9pK
         1FGYrSi0sJMGebsFZ34dKL4lc5TnEV0DThvtRhWuniDiOEQo2CeLDpYMy3vkhT5KGBhU
         4zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AI5PjNNVo+nWuGHXuUR9Z81f2NSybgwLdP4c6Dg9K18=;
        b=Ku+8o48DuI48OMoKaw5en2IW9RVzfxcYJSOMFQX2LxbGSN6JXpaUjy/Uh3o0VemDav
         Awh47o3vYXY3u7qi5lJEzEl3fUaqLCsDpy8mUm5YrldB4INSE6sevwRxeUdMjoIGlpo8
         PwrH0IYz5TctUobqMIDWXiaCxlwPxeJvR85IU9g25jOTDnF81ih20nluds6Yy2H7dr0J
         jpFxqpRIvIeenLI5m8IgbmqhPfJHHaIGcMtUMNqeFQBf8aqi6I0Nq+CxF/SXxxsbyqnA
         xHl+pLJzLzWU45rW/pmnKP4Dotw7yIVoJwIY11MYb55pY6UhQsr7+BZey0q3v80FqJNy
         se7A==
X-Gm-Message-State: APjAAAU3ZZluokL0jvwNuP0fpp9JXXHDU8efvWUxz+VAajA/ThnoKki+
        gc/Zts0cm2cXtZNQHHS0ZvcLhygd
X-Google-Smtp-Source: APXvYqy1seZ+UKteyygeRKeqwWhA9693+9AFr6gELI2o7BFzLuGYBYLBSb8/afNSeUj4KncRW64LFQ==
X-Received: by 2002:a1c:453:: with SMTP id 80mr25892464wme.5.1574015440255;
        Sun, 17 Nov 2019 10:30:40 -0800 (PST)
Received: from localhost.localdomain ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id o81sm18137949wmb.38.2019.11.17.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 10:30:39 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>
Subject: [nfs-utils PATCH 1/1] autoconf: Add Debian paths for Kerberos v5 with GSS
Date:   Sun, 17 Nov 2019 19:30:33 +0100
Message-Id: <20191117183033.11382-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Debian stores it's shared libraries in
/usr/lib/$(uname -m)-linux-gnu

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 aclocal/kerberos5.m4 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/aclocal/kerberos5.m4 b/aclocal/kerberos5.m4
index faa58049..bf0e88bc 100644
--- a/aclocal/kerberos5.m4
+++ b/aclocal/kerberos5.m4
@@ -42,7 +42,9 @@ AC_DEFUN([AC_KERBEROS_V5],[
                    -f $dir/lib32/libgssapi_krb5.a -o \
                    -f $dir/lib32/libgssapi_krb5.so -o \
                    -f $dir/lib64/libgssapi_krb5.a -o \
-                   -f $dir/lib64/libgssapi_krb5.so \) ; then
+                   -f $dir/lib64/libgssapi_krb5.so -o \
+                   -f $dir/lib/$(uname -m)-linux-gnu/libgssapi_krb5.a -o \
+                   -f $dir/lib/$(uname -m)-linux-gnu/libgssapi_krb5.so \) ; then
          AC_DEFINE(HAVE_KRB5, 1, [Define this if you have MIT Kerberos libraries])
          KRBDIR="$dir"
          gssapi_lib=gssapi_krb5
-- 
2.24.0


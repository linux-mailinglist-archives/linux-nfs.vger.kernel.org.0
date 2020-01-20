Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3A1423D1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2020 07:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgATGtm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jan 2020 01:49:42 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37367 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgATGtl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jan 2020 01:49:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so6690320pjb.2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Jan 2020 22:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cNh/lULg8tHapS3+LHqA/9nuVyvhOKvLIiv6PMf6Jto=;
        b=MgcqXoQeD4Wfh7r6LoM3hLZFRlwLZx0BeWf4mBZaU9YlnKnekVOPzdvwDuEzKRN4n0
         1m79kDBQg7SjY7ZIMVPGqH8C5Xq3KSZQuLuMcMeTmfsFOtBVK4pNm/Zr/33Hpq4SPvIH
         YbJKS5mZbarMFahYjToOLwXRusb2ZB3Xvxs93ZxpBwVwk0H5I3vBsJ2eKd2wP7gxfKly
         Ta7kcacbqp+MD7E1uVbSGaWc0nrvn2m8ivBt5SEeey2QQwk+U61ljbFXbghtqYG0ehYF
         Oh3bhdPOl/HC7kTcrj378a73hxA3DvwKD8+qSV/cgfGfqUQAt49Jc176nU8sEoGzMyvU
         /hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cNh/lULg8tHapS3+LHqA/9nuVyvhOKvLIiv6PMf6Jto=;
        b=pyMW1FVhqlHCRLRdG73lZe5sKk2a8q8AAzpXxXbyPhet2gXAy/zjKJy3P1dvOF1AZe
         CYZWZquBLl7bKgu0US0UdXgh4/RVy4CNN8K6nt2kD1vAg7vTLaJQVPKGyJalTfwEQDgM
         LRYpgEeuhqwVwWFOlh7WNYY58CaWVBbSRRUehdOcg0WPF1H6qVd1eG6DWs+5ys6DhWZ1
         KPIEblHB2y3sQ3xPgpvioCy1w3f/ZHDa/dkRwvGUw5dYzoK9oFKEti1dsvHl/atxxP/Q
         KwZVh/9XK0KRmnA0cWtBuxWi/zjY75ZpCfJ0cHriM7BjzUxapJVc+13C5/yyqmCnWvcD
         kwDQ==
X-Gm-Message-State: APjAAAXP226ymYhGIEzjKADYiH0caafl9hFhGzGyXoNg9F3Vh7d2Tbbo
        2zhww6FfCFksoLIkYa2Oa+J8YG9w
X-Google-Smtp-Source: APXvYqz8LZD54II+zGR/g5VjUW4ohzdYGU8XV4AQ0KqmKLZumnZWoOJ3YgRYIoIPWTsBWhNCEQk1dA==
X-Received: by 2002:a17:902:7006:: with SMTP id y6mr13780931plk.84.1579502981094;
        Sun, 19 Jan 2020 22:49:41 -0800 (PST)
Received: from localhost.localdomain ([69.42.0.214])
        by smtp.gmail.com with ESMTPSA id r28sm35489479pgk.39.2020.01.19.22.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 22:49:40 -0800 (PST)
From:   Rosen Penev <rosenp@gmail.com>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] xdr_float: do not include bits/endian.h
Date:   Sun, 19 Jan 2020 22:49:37 -0800
Message-Id: <20200120064937.1867256-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

bits/endian.h is an internal header. endian.h should be included.

Fixes compilation with recent musl.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 src/xdr_float.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/xdr_float.c b/src/xdr_float.c
index 26bc865..349d48f 100644
--- a/src/xdr_float.c
+++ b/src/xdr_float.c
@@ -83,7 +83,7 @@ static struct sgl_limits {
 };
 #else
 
-#include <bits/endian.h>
+#include <endian.h>
 #define IEEEFP
 
 #endif /* vax */
-- 
2.24.1

